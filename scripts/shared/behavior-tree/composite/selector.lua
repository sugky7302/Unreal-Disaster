---@class C-Selector : BTComposite
---如果子節點調用 fail 會執行下一個節點；反之，調用 success 則回到父節點。
---類似 OR 的邏輯。
local cls = Import('shared.behavior-tree.composite').inherit("C-Selector")

function cls:_new()
    return self:super():new()
end

function cls:success()
    self:super().success(self)
    self:super():super().success(self)
end

function cls:fail()
    -- 調用子節點的完成函數
    self:super().fail(self)

    self._index = self._index + 1
    if self._index <= #self._children then
        self:run()
    else
        self:super():super().fail(self)
    end
end

return cls
