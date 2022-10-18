local string = string

local String = {__index = string}
setmetatable(String, String)

function String.split(str, pattern)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pattern
    local last_end = 1
    local first, last, cap = str:find(fpat, 1)

    -- 切割字串
    while first do
       if first ~= 1 or cap ~= "" then
          t[#t+1] = cap
       end
       last_end = last+1
       first, last, cap = str:find(fpat, last_end)
    end

    -- 將剩餘的字串放入table裡
    if last_end <= #str then
       cap = str:sub(last_end)
       t[#t+1] = cap
    end
    return t
end

return String