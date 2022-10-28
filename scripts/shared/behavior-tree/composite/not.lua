---@class C-Not : BTComposite
---執行反向的節點。如果節點調用 success 則調用 fail；如果調用 fail 則調用 success。
local cls = Import('shared.behavior-tree.composite').inherit("C-Not")

function cls:_new()
    return self:super():new()
end

function cls:success()
    self:super().fail(self)
    self:super():super().fail(self)
end

function cls:fail()
    self:super().success(self)
    self:super():super().success(self)
end

return cls
