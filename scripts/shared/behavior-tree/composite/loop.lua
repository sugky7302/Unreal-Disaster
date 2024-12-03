-- Sequence是子節點調用success才會執行下一個節點，如果子節點調用fail則會回到root
local cls = require 'framework.behavior.node.composite'("Loop")

function cls:_new(args)
    local this = self:super():new(args)
    this._count_ = 0
    this._max_ = args[1]
    return this
end

function cls:start()
    if not self._is_child_running_ then
        self._count_ = 0
        self._index_ = 1
    end
end

function cls:success()
    self:super().success(self)  -- 調用子節點的finish函數

    self._index_ = self._index_ + 1
    if self._index_ <= #self._children_ then
        self:run()
    else
        self._count_ = self._count_ + 1
        if self._max_ == -1 or self._count_ <= self._max_ then
            self._index_ = 1
            self:run()
        else
            self:super():super().success(self)
        end
    end
end

function cls:fail()
    self:success()
end

function cls:Break()
    self:super().success(self)  -- 調用子節點的finish函數
    self:super():super().success(self)
end

function cls:continue()
    self._count_ = self._count_ + 1
    self._index_ = 0  -- 因為success裡面有 index++
    self:success()
end

return cls
