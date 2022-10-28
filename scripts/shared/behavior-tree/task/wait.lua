---@class T-Wait : BTNode
---等待固定時間的節點
---@field _timer Timer - 計時器
local cls = Import('shared.behavior-tree.node')("T-Wait")

---constructor
---@param time number - 參數
function cls:_new(time)
    local this = self:super():new()
    this._timer = Import('shared.timer'):new(time, 1, function(t)
        if t.args[1].parent:getName() == "C-Selector" then
            t.args[1]:fail()
        else
            t.args[1]:success()
        end
    end)

    return this
end

---執行時調用計時器
function cls:run()
    self._timer:start(self)
end

return cls