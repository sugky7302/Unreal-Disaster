------
-- Vector is used to calculate with matrix
------

local require = require
local Math = require 'std.math'
local cls = require 'std.class'("Vector")

local ScalarMultiple, VectorMultiple, MatrixMultiple

function cls.zeros(size)
    local new = {}
    for i = 1, size do
        new[i] = 0
    end

    return cls:new(new)
end

function cls.ones(size)
    local new = {}
    for i = 1, size do
        new[i] = 1
    end

    return cls:new(new)
end

function cls:_new(...)
    -- NOTE: 直接使用...，其實只會讀取第一個值，
    --       因此 type(...) 其實只是檢查第一個值的類型
    if type(...) == 'table' then
        return ...
    else
        return {...}
    end
end

--- 縮寫
function cls:__call(...)
    return self:new(...)
end

function cls:size()
    return #self
end

function cls:__tostring()
    local str = {}
    for i, v in ipairs(self) do
        str[i] = v
    end

    local concat = table.concat
    return concat{"<", concat(str, ", "), ">"}
end

function cls:__unm()
    local new = {}
    for i, v in ipairs(self) do
        new[i] = -v
    end

    return cls:new(new)
end

function cls:__eq(v)
    assert(#self == #v, "the size of two vectors is different.")
    local norm1, norm2 = self:norm(), v:norm()
    for i, val in ipairs(self) do
        if val / norm1 ~= v[i] / norm2 then
            return false
        end
    end

    return true
end

function cls:__lt(v)
    assert(#self == #v, "the size of two vectors is different.")
    return self:norm() < v:norm()
end

function cls:__le(v)
    assert(#self == #v, "the size of two vectors is different.")
    return self:norm() <= v:norm()
end

function cls:__add(v)
    assert(#self == #v, "the size of two vectors is different.")
    local new = {}
    for i, val in ipairs(self) do
        new[i] = val + v[i]
    end

    return cls:new(new)
end

function cls:__sub(v)
    assert(#self == #v, "the size of two vectors is different.")
    local new = {}
    for i, val in ipairs(self) do
        new[i] = val - v[i]
    end

    return cls:new(new)
end

function cls:__mul(m)
    if type(m) == 'number' then
        return ScalarMultiple(self,m)
    elseif m:isType("Vector") then
        return VectorMultiple(self, m)
    elseif m:isType("Matrix") then
        return MatrixMultiple(self, m)
    end
end

ScalarMultiple = function(self, n)
    local new = {}
    for i, val in ipairs(self) do
        new[i] = val * n
    end

    return cls:new(new)
end

VectorMultiple = function(self, v)
    assert(#self == #v, "the size of two vectors is different.")
    local sum = 0
    for i, val in ipairs(self) do
        sum = sum + val * v[i]
    end

    return sum
end

MatrixMultiple = function(self, m)
    assert(#self == m:row(), "the size of between the vector and the matrix is different.")

    local new = {}
    for i, j, v in m:iterator() do
        if not new[j] then
            new[j] = 0
        end

        new[j] = new[j] + self[i] * v
    end

    return cls:new(new)
end

function cls:unit()
    return self / self:norm()
end

function cls:__div(n)
    assert(n ~= 0, "division can't be 0.")
    local new = {}
    for i, val in ipairs(self) do
        new[i] = val / n
    end

    return cls:new(new)
end

function cls:norm()
    local sum = 0

    for _, v in ipairs(self) do
        sum = sum + v^2
    end

    return Math.sqrt(sum)
end

return cls