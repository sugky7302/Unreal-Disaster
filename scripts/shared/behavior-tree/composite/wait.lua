local require = require
local Wait = require 'framework.behavior.node'("等待")

function Wait:_new(args)
    local this = self:super():new()
    this._wait_ = require 'framework.timer':new(args[1], 1, function(t)
        if t.args[1].parent_:getName() == "Selector" then
            t.args[1]:fail()
        else
            t.args[1]:success()
        end
    end)

    return this
end

function Wait:run()
    self._wait_:start(self)
end

return Wait