local table, pairs, setmetatable = table, pairs, setmetatable

local Table = {
    __index = table
}
setmetatable(Table, Table)

function Table.copy(object)
    local duplicate = {}

    for k, v in pairs(object) do
        duplicate[k] = v
    end

    return duplicate
end

function Table.deepCopy(object)
    local function Recursiving(child)
        if type(child) ~= 'table' then
            return child
        end

        local duplicate = {}

        for k, v in pairs(child) do
            duplicate[Recursiving(k)] = Recursiving(v)
        end

        return setmetatable(duplicate, getmetatable(child))
    end

    return Recursiving(object)
end

function Table.merge(tb1, tb2)
    local type = type

    for k, v in pairs(tb2) do
        if type(k) == 'number' then
            tb1[#tb1 + 1] = v
        end

        -- 如果tb1[k]有值，就把tb2[k]塞到tb1末端
        if type(k) == 'string' then
            if tb1[k] then
                tb1[#tb1 + 1] = v
            else
                tb1[k] = v
            end
        end
    end

    return tb1
end

function Table.isNil(tb)
    return tb == nil or next(tb) == nil
end

function Table.hasSameElements(tb1, tb2)
    for k, v in pairs(tb1) do
        if v ~= tb2[k] then
            return false
        end
    end

    return true
end

return Table
