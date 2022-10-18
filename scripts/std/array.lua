-- 生成一個連續但移除中間元素後，順序會開始混亂的類vector結構

local Array = require 'std.class'('Array')

-- default
local DefaultCompasion
Array._end_ = 1 -- ex: for i = _begin_, _end_ - 1(要記得扣，不然空array也會執行一次迴圈) do

function Array:__tostring()
    local print_tb = {'['}

    for i = 1, self._end_ - 1 do
        print_tb[#print_tb + 1] = type(self[i]) == 'table' and 'table' or self[i]
    end

    print_tb[#print_tb + 1] = ']'

    return table.concat(print_tb, ' ')
end

-- 獲取私有成員變量
function Array:isEmpty()
    return self._end_ == 1
end

function Array:iterator()
    return function(t, i)
        i = i + 1

        if i >= t._end_ then
            return nil
        end

        return i, t[i]
    end, self, 0
end

function Array:reverseIterator()
    return function(t, i)
        i = i + 1

        if i >= t._end_ then
            return nil
        end

        return i, t[t._end_ - i]
    end, self, 0
end

-- 操作元素
function Array:append(data)
    if not data then
        return false
    end

    -- 先添加資料再調整索引才不會錯誤
    self[self._end_] = data

    self._end_ = self._end_ + 1
end

function Array:clear()
    for i = 1, self:size() do
        self[i] = nil
    end

    self._end_ = 1
end

function Array:delete(i)
    if i == self:size() then
        self[i] = nil
    else
        self[i] = self[self:size()]
    end

    self._end_ = self._end_ - 1
end

-- 刪除所有"資料 = data"的空間
function Array:erase(data, comparison)
    if not data then
        return false
    end

    if not comparison then
        comparison = DefaultCompasion
    end

    for i = self:size(), 1, -1 do
        if comparison(self[i], data) then
            -- 將最後一個元素覆蓋至現在位置
            self[i] = self[self:size()]
            self[self:size()] = nil

            -- 調整索引
            self._end_ = self._end_ - 1

            -- 因為最後一個元素調到現在的位置，所以要重新檢查
            i = i + 1
        end
    end
end

-- 存在的話會回傳索引
-- 只找第一筆資料
function Array:exist(data, comparison)
    if not data then
        return false
    end

    if not comparison then
        comparison = DefaultCompasion
    end

    for i = 1, self:size() do
        if comparison(self[i], data) then
            return i, self[i]
        end
    end

    return false
end

function Array:size()
    return self._end_ - 1
end

DefaultCompasion = function(a, b)
    return a == b
end

return Array
