--[[
    Condition內部只儲存3個節點，第一個為條件節點，第二個為then節點，第三個為else節點。
    如果條件節點調用success則會調用then節點；如果調用fail則調用else節點。
    此外，Condition無視running狀態，確保能隨時切換狀態。
--]]

local cls = require 'framework.behavior.node.composite'("Condition")

function cls:_new()
    return self:super():new()
end

function cls:success()
    self:super().success(self)  -- 調用子節點的finish函數

    if self._index_ == 1 then
        self._index_ = 2
        self:run()
    else
        self:super():super().success(self)  -- 回到父節點
    end
end

function cls:fail()
    self:super().fail(self)

    if self._index_ == 1 then
        self._index_ = 3
        self:run()
    else
        self:super():super().fail(self)
    end
end

function cls:running()
    self._is_child_running_ = false
    self._index_ = 1  -- 一定要檢查條件，所以必須每次都把index設回1。
    self:super():super().running(self)
end

return cls
