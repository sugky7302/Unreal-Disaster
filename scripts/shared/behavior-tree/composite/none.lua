local require = require
local Wait = require 'framework.behavior.node'("None")

function Wait:_new(t)
    return self:super():new()
end

function Wait:run()
    if self.parent_:getName() == "Selector" then
        self:fail()
    else
        self:success()
    end
end

return Wait