---@class C-Sequence : BTComposite
---如果子節點調用 success 會執行下一個節點；反之，調用 fail 則回到父節點。
---類似 AND 的邏輯。
local cls = Import('shared.behavior-tree.composite').inherit("C-Sequence")

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
