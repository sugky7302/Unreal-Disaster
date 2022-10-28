---@class C-If : BTComposite
---內部只儲存3個節點，第一個為 if 節點，第二個為 then 節點，第三個為 else 節點。
---如果條件節點調用 success 則會調用 then 節點；如果調用 fail 則調用 else 節點。
---此外，Condition無視running狀態，確保能隨時切換狀態。
local cls = Import('shared.behavior-tree.composite').inherit("C-If")

function cls:_new()
    return self:super():new()
end

---設定節點狀態為成功，並且通知父節點執行完成函數。
---然後再調用 then 節點的執行函數。
---@override BTComposite:success()
function cls:success()
    -- 調用子節點的 finish 函數
    self:super().success(self)

    -- 調用 then 節點
    if self._index == 1 then
        self._index = 2
        self:run()
    else
        -- 回到父節點
        self:super():super().success(self)
    end
end

---設定節點狀態為失敗，並且通知父節點執行完成函數。
---然後再調用 else 節點的執行函數。
---@override BTComposite:fail()
function cls:fail()
    self:super().fail(self)

    if self._index == 1 then
        self._index = 3
        self:run()
    else
        self:super():super().fail(self)
    end
end

---設定節點狀態為運行中。
---因為一定要檢查條件，所以必須每次都把 index 設回 1。
---@override BTComposite:running()
function cls:running()
    self._is_child_running = false

    -- 重置索引
    self._index = 1

    self:super():super().running(self)
end

return cls
