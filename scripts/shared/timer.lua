--#region 中心計時器的實現
local jass = require 'jass.common'
local PERIOD, INSTRUCTION_COUNT = 0.001, 10

---這裡利用 ENV 類似全局變量的特性, 來儲存中心計時器
---不然 hotfix 可能會重置中心計時器
if not ENV._TIMER then
    ENV._TIMER = jass.CreateTimer()
    ENV._TIMER_QUEUE = {}
    ENV._TIMER_FRAME = 1
end

local timer_queue = ENV._TIMER_QUEUE
local current_frame = ENV._TIMER_FRAME
local ExecuteOrder, ProcessOrder, Insert, Delete, Frame

---啟動一個中心計時器
local function Start()
    jass.TimerStart(ENV._TIMER, PERIOD * INSTRUCTION_COUNT, true,function()
        -- NOTE: 捨棄end_frame。原來會用到是因為Moe master是用while做，while執行速度比較慢，
        --       因此我採用for去處理，這就不需要end_frame了。 - 2020-02-26
        -- NOTE: 反正只是要循環10次，不用特別用current_frame和end_frame，反而麻煩。 - 2020-02-26
        for i = 1, INSTRUCTION_COUNT do
            ExecuteOrder()

            -- NOTE: 如果掉幀，則frame就不會+1，而order_queue_index還保留最後做完的索引，
            --       很自然就達到補幀的效果。 - 2020-02-26
            current_frame = current_frame + 1
        end

        -- NOTE: 將當前幀數存回全局變量，以便 hotfix 重置計時器時能夠繼續計時。 - 2022-10-19
        ENV._TIMER_FRAME = current_frame
    end)
end

---抓取當前時間戳對應的動作隊列並執行，執行完畢後刪除
ExecuteOrder = function()
    local order_queue = timer_queue[current_frame]
    if not order_queue then
        return false
    end

    -- NOTE: 由於pairs會跳過value=nil的索引，因此只要每次完成都設定為nil，掉幀時就能從有值的索引開始。 - 2020-02-26
    for i, order in pairs(order_queue) do
        if order then
            ProcessOrder(order)
        end

        order_queue[i] = nil
    end

    -- 必須所有引用都清除，lua才會釋放記憶體
    timer_queue[current_frame] = nil
    order_queue = nil
end

---執行動作
ProcessOrder = function(order)
    -- 記錄已執行次數，方便計算總執行時間
    -- NOTE: 放在執行函數前面是因為函數裡讀取runtime才會正確；放在執行函數後面，runtime會少掉這次執行的時間。
    order.runtime_ = order.runtime_ + (order.remaining_ > 0 and order.remaining_ or order.timeout_)

    order:run()

    -- 如果執行run時，order將自身所有資料刪除，這裡直接跳出避免報錯
    if not order.count_ then
        return false
    end

    -- 如果count_是-1，表示無窮迴圈，因此不用遞減
    if order.count_ > 0 then
        order.count_ = order.count_ - 1
    end

    if order.count_ == 0 then
        order:remove()
        return false
    end

    -- 處理指令暫停的情況
    if order.remaining_ > 0 then
        return false
    end

    Insert(order, order.timeout_)
end

---新增一個動作函數
---NOTE: 不直接使用 order.frame_ 的原因是恢復計時器的動作中，插入的 frame 是剩餘時間。
---@param order function - 動作函數
---@param t number - 時間
Insert = function(order, t)
    if order.count_ == 0 then
        return false
    end

    local end_stamp = current_frame + Frame(t)
    order.end_stamp_ = end_stamp * PERIOD

    if not timer_queue[end_stamp] then
        timer_queue[end_stamp] = {} -- 這裡不能用弱引用表，不然會丟失
        setmetatable(timer_queue[end_stamp], timer_queue[end_stamp])
    end

    -- 使用變數提高插入指令的程式碼的閱讀性
    local order_queue = timer_queue[end_stamp]
    order_queue[#order_queue + 1] = order
end

---刪除一個動作函數
Delete = function(order)
    local order_queue = timer_queue[Frame(order.end_stamp_)]
    if not order_queue then
        return false
    end

    -- NOTE: 使用table.remove才能完整刪除，
    --       只設定為nil反而會讓數組中斷。
    -- NOTE: 由於table.remove會將空位補滿，導致order_queue_index跳過補空位的那個動作。
    --       例如我刪掉第6個，第7個會補到第6個的位置，結果order_queue_index跳到了7，就造成掉幀的現象。
    --       ExecuteOrder改採pairs遍歷，它會跳過值=nil的索引，這樣就保留原本for迴圈要達到的功能。 - 2020-02-26
    for k, v in ipairs(order_queue) do
        if v == order then
            order_queue[k] = nil
            return true
        end
    end
end

---時間轉成幀數
---@param time number - 時間
---@return number - 幀數
Frame = function(time)
    local math = math
    return math.max(math.floor(time / PERIOD), 1)
end

---當前的幀數
---@return number - 幀數
local function Now()
    return current_frame * PERIOD
end

-- 只會執行一次
Start()

--#endregion

--#region 給外部調用的接口
---@class Timer
---Timer is an enhanced extension of jass timer.
---
---@field timeout_ number - 持續時間（秒）。
---@field count_ number - 循環次數。循環次數必須>0，-1定義為永久，0定義為結束。
---@field remaining_ number - 恢復時會用到的剩餘時間（秒）。
---@field end_stamp_ number - 提前結束會用的結束時間戳。
---@field runtime_ number - 執行時間（秒）。
---@field run function - 動作函數。
---@field args table - 外部參數列表。
local Timer = Import('std.class')('Timer')
local math = math
local ComputeRemaining

---創建一個新的動作函數丟進中心計時器
---@param timeout number - 循環週期 / 時間
---@param count number - 循環次數。如果次數有限，必須 >0；如果無窮次數，要設定為 -1。
---@param action function - 動作函數
---@return Timer - 計時器物件
function Timer:_new(timeout, count, action)
    return {
        timeout_ = timeout,
        count_ = math.ceil(count), -- 循環次數必須>0，-1定義為永久，0定義為結束
        end_stamp_ = 0, -- 提前結束會用到結束點
        remaining_ = 0, -- 恢復時會需要剩餘時間
        runtime_ = 0,
        run = action,
        args = nil -- 儲存外部參數
    }
end

---啟動計時器
---* 實際上是把計時器物件丟進中心計時器
---@param self Timer - 計時器物件
---@vararg any - 想被傳遞到動作函數裡的參數
---@return Timer - 計時器物件，用於鏈式調用
function Timer:start(...)
    self.args = { ... }
    Insert(self, self.timeout_)
    return self
end

---停止計時器
---* 實際上是從中心計時器刪除計時器物件
---@param self Timer - 計時器物件
function Timer:stop()
    -- 外部停止需要把計時器從隊列中刪除
    Delete(self)
    self:remove()
end

---暫停計時器
---* 實際上是從中心計時器刪除計時器物件，並記錄暫停時間。等到恢復時會重新加入中心計時器。
---@param self Timer - 計時器物件
---@return Timer - 計時器物件，用於鏈式調用
function Timer:pause()
    if not self.remaining_ then
        return self
    end

    -- 處在正常狀態才能執行以下動作
    if self.remaining_ == 0 then
        ComputeRemaining(self)

        -- 外部暫停需要把計時器從隊列中刪除
        Delete(self)
    end

    return self
end

---計算剩餘時間
---@param self Timer - 計時器物件
ComputeRemaining = function(self)
    -- Solve end_stamp in lua timer will be negative
    self.remaining_ = math.max(0, self.end_stamp_ - Now())

    -- NOTE: (循環計時器) 如果 remaining=0 表示pause是計時器動作內部調用的，
    --       這樣的含意即下一次執行要暫停，因此要計算下一次的時間戳記。
    if self.remaining_ == 0 and (self.count_ == -1 or self.count_ - 1 > 0) then
        self.remaining_ = self.timeout_
    end
end

---恢復計時器
---* 實際上是把計時器物件丟進中心計時器，並記錄恢復時間。等到恢復時會重新加入中心計時器。
---@param self Timer - 計時器物件
---@return Timer - 計時器物件，用於鏈式調用
function Timer:resume()
    local remaining = self.remaining_ or 0
    -- pause_frame要歸零，不然中心計時器會認為還在暫停中而不會將命令插到下個時序
    self.remaining_ = 0

    if remaining > 0 then
        Insert(self, remaining)
    end

    return self
end

return Timer

--#endregion
