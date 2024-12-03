-- Sequence是子節點調用success才會執行下一個節點，如果子節點調用fail則會回到root
local cls = require 'framework.behavior.node.composite'("Not")

function cls:_new()
    return self:super():new()
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
