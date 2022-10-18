-- 在lua上重構c++的泛型queue(隊列)，只能從後面插入元素，前面移除元素。
-- 依賴
--   class

local Queue = require 'std.class'('Queue')

-- default
Queue._begin_ = 1
Queue._end_ = 1

function Queue:__tostring()
    local print_str = {'['}

    for i = self._begin_, self._end_ - 1 do
        print_str[#print_str + 1] = self[i]
    end

    print_str[#print_str + 1] = ']'
    return table.concat(print_str, ' ')
end

function Queue:push_back(data)
    if not data then
        return false
    end

    self[self._end_] = data

    -- 放出新的空間
    self._end_ = self._end_ + 1
end

function Queue:pop_front()
    -- 釋放空間
    self[self._begin_] = nil

    -- 調整首端索引
    self._begin_ = self._begin_ + 1
end

-- O(length)的方法
function Queue:clear()
    for i = self._begin_, self._end_ - 1 do
        self[i] = nil
    end

    self._begin_ = 1
    self._end_ = 1
end

-- 獲取私有成員變量
function Queue:isEmpty()
    return self:size() == 0
end

function Queue:size()
    return self._end_ - self._begin_
end

function Queue:begin()
    return self._begin_
end

function Queue:end_()
    return self._end_
end

function Queue:front()
    return self[self._begin_]
end

function Queue:back()
    return self[self._end_ - 1]
end

return Queue
