--[[
Matrix is a math tool to trackle Multi-Dimension calculation.

Function:
    static identity(size) - create an size x size identity matrix
        size - matrix size

    static zeros(size) - create an size x size zero matrix
        size - matrix size

    static ones(size) - create an size x size one matrix
        size - matrix size

    new(self,t) - create a matrix instance
        self - Class Matrix
        t - a matrix represented by a double table

    __call(self, t) - the function is the same as above function.

    print(self) - show the matrix formated
        self - matrix instance

    +(self, m) - plus two same size matrices to a new matrix
        self - matrix instance
        m - another matrix

    -(self, m) - minus two same size matrices to a new matrix
        self - matrix instance
        m - another matrix

    *(self, m) - multiple a matrix and a scale or two same size matrices to a new matrix
        self - matrix instance
        m - a scale or a matrix

    /(self, n) -  the matrix divide to a scale to a new matrix
        self - matrix instance
        n - a scale

    =(self, m) - compare whether two matrices are equal
        self - matrix instance
        m - another matrix

    transpose(self) - get a new matrix is the transpose of the matrix
        self - matrix instance

    inverse(self) - get a new matrix is the inverse of the matrix
        self - matrix instance
]]

local require = require
local Math = require 'std.math'
local cls = require 'std.class'("Matrix")

local CreateSquareMatrix, ScalarMultiple, MatrixMultiple, VectorMultiple

function cls.identity(size)
    return cls:new(CreateSquareMatrix(size, function(i)
        if (i == 1) or ((i - 1) % (size + 1) == 0) then
            return 1
        end

        return 0
    end))
end

function cls.zeros(size)
    return cls:new(CreateSquareMatrix(size, function()
        return 0
    end))
end

function cls.ones(size)
    return cls:new(CreateSquareMatrix(size, function()
        return 1
    end))
end

CreateSquareMatrix = function(size, rule)
    local m = {}

    for i = 1, size*size do
        m[i] = rule(i)
    end

    return m
end

function cls:_new(t)
    return t
end

function cls:__call(t)
    return self:new(t)
end

function cls:size()
    return {self:row(), self:col()}
end

function cls:row()
    return #self
end

function cls:col()
    return #self[1]
end

function cls:iterator()
    local j = 0
    local iter = function(m, i)
        j = j + 1

        if j > m:col() then
            j = 1
            i = i + 1
        end

        -- 因為第一個回傳值是迭代器用來判斷要不要中止迴圈的條件，
        -- 所以當 i 超出大小時，回傳 nil 讓迴圈終止。
        if i > m:row() then
            return nil
        end

        return i, j, m[i][j]
    end

    return iter, self, 1
end

function cls:__tostring()
    local concat = table.concat
    local str, substr = {}, {}
    for i, j, v in self:iterator() do
        substr[j] = v

        if j == self:col() then
            str[i] = concat(substr, ", ")
            substr = {}
        end
    end

    return concat{"[", concat(str, "; "), "]"}
end

function cls:__unm()
    local m = {}
    for i, j, v in self:iterator() do
        if j == 1 then
            m[i] = {}
        end

        m[i][j] = -v
    end

    return cls:new(m)
end

function cls:__eq(m)
    assert(self:row() == m:row() and self:col() == m:col(), "the size of two matrices is different.")
    for i, j, v in self:iterator() do
        if v ~= m[i][j] then
            return false
        end
    end

    return true
end

function cls:__add(m)
    assert(self:row() == m:row() and self:col() == m:col(), "the size of two matrices is different.")
    local new = {}
    for i, j, v in self:iterator() do
        if j == 1 then
            new[i] = {}
        end

        new[i][j] = v + m[i][j]
    end

    return cls:new(new)
end

function cls:__sub(m)
    assert(self:row() == m:row() and self:col() == m:col(), "the size of two matrices is different.")
    local new = {}
    for i, j, v in self:iterator() do
        if j == 1 then
            new[i] = {}
        end

        new[i][j] = v - m[i][j]
    end

    return cls:new(new)
end

function cls:__mul(m)
    if type(m) == 'number' then
        return ScalarMultiple(self, m)
    elseif m:isType("Vector") then
        return VectorMultiple(self, m)
    elseif m:isType("Matrix") then
        return MatrixMultiple(self, m)
    end
end

ScalarMultiple = function(self, n)
    local new = {}
    for i, j, v in self:iterator() do
        if j == 1 then
            new[i] = {}
        end

        new[i][j] = v * n
    end

    return cls:new(new)
end

VectorMultiple = function(self, v)
    assert(self:col() == #v, "the size of between the vector and the matrix is different.")

    local new = {}
    for i, j, val in self:iterator() do
        if not new[i] then
            new[i] = 0
        end

        new[i] = new[i] + val * v[j]
    end

    return require 'std.vector':new(new)
end

MatrixMultiple = function(self, m)
    assert(self:col() == m:row(), "the size of two matrices is different.")
    local new, sum = {}, 0

    for i = 1, self:row() do
        for j = 1, m:col() do
            if not new[i] then
                new[i] = {}
            end

            sum = 0
            for k = 1, self:col() do
                sum = sum + self[i][k] * m[k][j]
            end

            new[i][j] = sum
        end
    end

    return cls:new(new)
end

function cls:__div(n)
    assert(n ~= 0, "division can't be 0.")
    local new = {}
    for i, j, v in self:iterator() do
        if j == 1 then
            new[i] = {}
        end

        new[i][j] = v / n
    end

    return cls:new(new)
end

function cls:det()
end

function cls:transpose()
    local new = {}
    for i, j in self:iterator() do
        if not new[j] then
            new[j] = {}
        end

        new[j][i] = self[i][j]
    end

    return cls:new(new)
end

function cls:inverse()
end

return cls