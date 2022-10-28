---@class C-Rand
---子節點調用 success 會隨機執行一個節點，然後返回父節點。
---用來實現隨機效果。
local cls = Import('shared.behavior-tree.composite').inherit("C-Rand")

function cls:_new()
    return self:super():new()
end

---初始化時會隨機選取子節點
function cls:start()
    if not self._is_child_running then
        self._index = require('std.math').rand(1, #self._children)
    end
end

function cls:success()
    self:super().success(self)
    self:super():super().success(self)
end

function cls:fail()
    self:super().fail(self)
    self:super():super().fail(self)
end

return cls
