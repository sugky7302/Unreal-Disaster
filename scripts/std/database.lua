--[[
  Database is an simple database for Lua. It's suitable for small data. Maybe 1000 records.
 
  Member:
    _primary_key_(int) - the column number for the keyword, query method can use it
    _associate_keys_(table) - a table which records the association beteween the keyword and the index
    _column_(int) - record the column counts
 
  Function:
    new(self, column_count) - create a database which assigns the column count
      self - class Database
      column_count - the database max column count
 
    read(self, key) - search for datas corresponding to the key
      self - Database instance
      key - index or the data in the primary column
      return - data or nil
 
    update(self, key, ...) - search datas corresponding to the key
      self - Database instance
      key -  index or the data in the primary column
      ... - datas
 
    delete(self, key) - delete datas corresponding to the key
      self - Database instance
      key - index or the data in the primary column
--]]

local require = require
local cls = require 'std.class'("Database", require 'std.red_black_tree')
local FixKey

function cls:_new()
    return self:super():new()
end

function cls:update(key, ...)
    key = FixKey(key)

    local data = {...}

    -- 如果有相同主鍵就覆蓋資料
    local node = self:find(key)
    if node then
        node.data_ = data
    else
        self:insert(key, data)
    end

    return self
end

function cls:read(key)
    local node = self:find(FixKey(key))
    return node and node.data_ or nil
end

function cls:delete(key)
    return self:super().delete(self, FixKey(key))
end

FixKey = function(key)
    -- 把鍵全部換成字串才能比較
    if type(key) == 'number' then
        key = key .. ""
    end

    return key
end

return cls
