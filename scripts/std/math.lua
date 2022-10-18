-- 補充lua沒有的數學庫
local math = math
local Math = {
    __index = math,
    e = math.exp(1)
}
setmetatable(Math, Math)

function Math.round(num)
    if num >= 0 then
        return math.floor(num + 0.5)
    else
        return math.ceil(num - 0.5)
    end
end

-- 無參數 產生(0, 1)的隨機整數
-- 只有參數n 產生[1, n]的隨機整數
-- 兩個參數 產生[n, m]的隨機整數
-- n, m 非整數會報錯
math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 6)))
function Math.rand(n, m)
    local modf = math.modf
    if not n then
        return math.random()
    end

    if not m then
        n = modf(n)
        return math.random(n)
    end

    n = modf(n)
    m = modf(m)
    return math.random(n, m)
end

-- 確認值是否超出最大或最小值
function Math.bound(value_min, value, value_max)
    -- 沒有上下限，直接回傳值
    if not (value_min or value_max) then
        return value
    end

    if not value_min then
        return math.min(value_max, value)
    end

    if not value_max then
        return math.max(value_min, value)
    end

    return math.min(value_max, math.max(value_min, value))
end

-- 此函數計算最大公因數(GreatestCommonFactor)
-- 遞歸比起for會慢很多，這裡把較大的數當作迴圈次數，才不會出現迴圈結束卻還沒得到結果的問題
function Math.gcf(num1, num2)
    local big_num, small_num
    if num1 > num2 then
        big_num = num1
        small_num = num2
    else
        big_num = num2
        small_num = num1
    end

    for i = 1, big_num do
        big_num = big_num % small_num
        if big_num == 0 then
            return small_num
        end

        -- 保證big_num > small_num
        big_num, small_num = small_num, big_num
    end
end

function Math.angle(s_x, s_y, t_x, t_y)
    local theta  = math.atan(t_y - s_y, t_x - s_x)
    return theta < 0 and 2 * math.pi + theta or theta
end

function Math.inRange(x, lower, higher)
    return (x >= lower) and x <= higher
end

-- 以p為起點，向右作一條射線，看射線跟邊相交的點的數量是奇還偶
function Math.inPolygon(p, points)
    local in_poly = false  -- 奇數次表示在裡面，偶數次表示在外面
    local next, x
    for i, pt in ipairs(points) do
        next = points[i == #points and 1 or i+1]

        -- 點在頂點上
        if (p.x == pt.x and p.y == pt.y) or (p.x ==next.x and p.y == next.y) then
            return true
        end

        -- 點經過水平的邊不算
        -- 點的y座標比兩端點都低或都高，都代表碰不到邊
        -- 如果經過頂點，會把頂點歸類在射線的上側
        if p.y > math.min(pt.y, next.y) and
           p.y <= math.max(pt.y, next.y) then
            -- 射線與線段相交的x
            x = pt.x + (p.y - pt.y) * (next.x - pt.x) / (next.y - pt.y)

            -- 點在線上
            if x == p.x then
                return true
            end

            -- 透過判斷射線起始點在預期的x的左右邊，可以知道它有無跨過線段
            if x > p.x then
                in_poly = not in_poly
            end
        end
    end

    return in_poly
end

return Math
