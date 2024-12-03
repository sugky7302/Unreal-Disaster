-- Random是子節點調用success才會隨機執行一個節點，如果子節點調用fail則會回到root
local require = require
local cls = require 'framework.behavior.node.composite'("Random")

function cls:_new()
    return self:super():new()
end

function cls:start()
    if not self._is_child_running_ then
        self._index_ = require('std.math').rand(1, #self._children_)
    end
end

function cls:success()
    self:super().success(self)

    self._index_ = self._index_ + 1
    if self._index_ <= #self._children_ then
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
