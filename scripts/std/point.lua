-- 創建一個3維的點類別及提供基礎功能
-- 依賴
--   class

local Point = require 'std.class'('Point')

function Point:_new(x, y, z)
    return {
        x = x or 0,
        y = y or 0,
        z = z or 0
    }
end

function Point:__tostring()
    return table.concat({'(', self.x, ', ', self.y, ', ', self.z, ')'})
end

function Point:__add(p)
    return Point:new(self.x + p.x, self.y + p.y, self.z + p.z)
end

function Point:__sub(p)
    return Point:new(self.x - p.x, self.y - p.y, self.z - p.z)
end

function Point.__mul(m, n)
    local type, p, scale = type

    if type(m) == 'table' then
        p = m
        scale = n
    else
        p = n
        scale = m
    end

    return Point:new(p.x * scale, p.y * scale, p.z * scale)
end

function Point:__div(scale)
    return Point:new(self.x / scale, self.y / scale, self.z / scale)
end

function Point:__eq(p)
    return self.x == p.x and self.y == p.y and self.z == p.z
end

function Point:copy()
    return Point:new(self.x, self.y, self.z)
end

-- assert
local math = math

-- 假定極點為(0, 0)
-- 只會旋轉平面座標
function Point:rotate(deg)
    local angle, length = math.rad(deg), math.sqrt(self.x ^ 2 + self.y ^ 2)
    self.x, self.y = length * math.cos(angle), length * math.sin(angle)
    return self
end

-- 只會計算平面夾角
function Point.deg(p1, p2)
    return math.deg(Point.rad(p1, p2))
end

-- 範圍為[0, 2 * pi]
-- 只會計算平面夾角
function Point.rad(p1, p2)
    local rad = math.atan(p2.y - p1.y, p2.x - p1.x)

    if rad < 0 then
        rad = rad + 2 * math.pi
    end

    return rad
end

function Point.slope(p1, p2)
    return (p2.y - p1.y) / (p2.x - p1.x), (p2.z - p1.z) / Point.distance(p1, p2, 2)
end

function Point.distance(p1, p2, dimension)
    if dimension == 1 then
        return math.abs(p1.x - p2.x)
    elseif dimension == 2 then
        return math.sqrt((p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2)
    elseif dimension == 3 then
        return math.sqrt((p1.x - p2.x) ^ 2 + (p1.y - p2.y) ^ 2 + (p1.z - p2.z) ^ 2)
    end
end

return Point
