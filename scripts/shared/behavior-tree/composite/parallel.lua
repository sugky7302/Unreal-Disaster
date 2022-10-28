---@class C-Parallel : BTComposite
---不管子節點調用success或fail都會執行下一個節點，遍歷後回到root
local cls = Import('shared.behavior-tree.composite').inherit("C-Parallel")

function cls:_new()
    return self:super():new()
end

function cls:success()
    self:super().success(self)

    self._index = self._index + 1
    if self._index <= #self._children then
        self:run()
    else
        self:super():super().success(self)
    end
end

function cls:fail()
    self:super().fail(self)
    self:super():super().fail(self)
end

return cls
