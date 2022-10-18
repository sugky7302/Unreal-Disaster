local PriorityQueue = require 'std.class'("PriorityQueue")
local Swim, Sink, IsPrior

function PriorityQueue:_new(sort_type)
    return {
        _sort_type_ = sort_type or "max",
    }
end

function PriorityQueue:size()
    return #self
end

function PriorityQueue:isEmpty()
    return #self == 0
end

function PriorityQueue:iterator()
    return function(t, i)
        i = i + 1

        if i > #self then
            return nil
        end

        return i, t[i]
    end, self, 0
end

function PriorityQueue:push(priority, value)
    self[#self + 1] = {priority, value}
    Swim(self)
    return self
end

Swim = function(self)
    local floor = math.floor
    local i, parent = #self

    while floor(i / 2) > 0 do
        -- 交換父子節點
        parent = floor(i / 2)
        if IsPrior(self, i, parent) then
            self[i], self[parent] = self[parent], self[i]
        end

        -- 交換兄弟節點
        if i % 2 == 1 and IsPrior(self, i, i - 1) then
            self[i], self[i - 1] = self[i - 1], self[i]
        end

        i = parent
    end
end

function PriorityQueue:pop()
    local value = self[1]

    -- 將最後一個補到第一個
    self[1] = self[#self]
    table.remove(self, #self)

    Sink(self)
    return value
end

Sink = function(self)
    local i, child = 1

    while 2 * i <= #self do
        -- 交換父子節點
        child = 2 * i
        if IsPrior(self, child, i) then
            self[i], self[child] = self[child], self[i]
        end

        -- 交換兄弟節點
        if child < #self and IsPrior(self, child + 1, child) then
            self[child], self[child + 1] = self[child + 1], self[child]
            child = child + 1
        end

        i = child
    end
end

IsPrior = function(self, i, j)
    if self._sort_type_ == "min" then
        return self[i][1] < self[j][1]
    end

    return self[i][1] > self[j][1]
end

return PriorityQueue