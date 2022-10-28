---@class C-Loop : BTComposite
---會不斷循環執行所有子節點，直到次數用完為止。
---子節點只有成功或運行中兩種狀態。
---@field _count number - 當前執行次數
---@field _max number - 最大執行次數。-1 為無限循環。
local cls = Import('shared.behavior-tree.composite').inherit("C-Loop")

---constructor
---@param count number - 循環次數
---@param args table<string, any> - 參數
---@return C-Loop - 實例
function cls:_new(count, args)
    local this = self:super():new(args)
    this._count = 0
    this._max = count
    return this
end

function cls:start()
    if not self._is_child_running then
        self._count = 0
        self._index = 1
    end
end

function cls:success()
    -- 調用子節點的finish函數
    self:super().success(self)

    self._index = self._index + 1
    if self._index <= #self._children then
        self:run()
    else
        self._count = self._count + 1
        if self._max == -1 or self._count <= self._max then
            self._index = 1
            self:run()
        else
            self:super():super().success(self)
        end
    end
end

---因為子節點只有成功或運行中兩種狀態，所以不需要實現 fail 函數。
function cls:fail()
    self:success()
end

---跳出循環
---@override BTComposite:escape()
function cls:escape()
    -- 調用子節點的finish函數
    self:super().success(self)
    self:super():super().success(self)
end

---立即執行下一次循環
---* 因為success裡面有 index++，所以這邊的 index = 0。
---@override BTComposite:continue()
function cls:continue()
    self._count = self._count + 1
    self._index = 0  
    self:success()
end

return cls
