local string = string
local math = math
local type = type

return {
    encode = function(num)
    if not num then
        return ""
    end

    if type(num) == 'string' then
        return num
    end

    local len = math.floor(math.log(num) / math.log(256))
    local chars = {}

    for i = 0, len do
        chars[len + 1 - i] = num % 256
        num = math.floor(num / 256)
    end

    return string.char(table.unpack(chars))
end,

decode = function(str)
    if not str then
        return 0
    end

    if type(str) == 'number' then
        return str
    end

    local sum = 0
    local len = string.len(str)

    for i = 1, len do
        sum = sum + (string.byte(str, i) or 0) * 256 ^ (len - i)
    end

    return sum
end
}
