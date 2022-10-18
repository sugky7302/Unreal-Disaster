--[[ 
  Version : 1.4.0
    自定義類型 類別，使用javascript的方式--對象關聯或稱委託。
    新的類別能夠很好區分類別和實例的差別，不會像以往子類實際上也只是父類的一個實例。

    功能有new、__index、remove。鑒於Lua的特性，若有需要可直接重寫方法。
    保留setInstance、getInstance關鍵字，用來處理實例與類別的綁定。
    私有函數_new、_remove提供使用者自定義在建構和解構時想要執行的功能。
    table、string、number、boolean:當前類別搜索不到會去搜尋原型鏈，找到的話就返回值，沒有就返回nil。不會複製一份給自己。
    function:同樣會搜尋原型鏈，但是是將實例委託該函數處理。不會複製函數引用給自己。
    盡量在class設定預設值，不要用_new為每個實例創建值，等要用的時候再建就好，除非是一定會用到的、每個實例都不同的值。
    刪除set/get/delete instance/subclass的功能 - 2020-01-19
    新增設值裝飾符(setter)及取值裝飾符(getter) - 2020-04-13
    新增isType函數，能夠檢查物件是不是屬於該類別以及所有原型鏈上的類別。 - 2021-10-08
--]]
local function Class(name, ...)
    local setmetatable, pairs, getmetatable, type = setmetatable, pairs, getmetatable, type

    local object = {
        _sets = {},
        _gets = {},

        -- 原型，也就是委託的對象，只要該對象有你需要的東西，都可以填進去。排在最前面的原型為第一委託者。
        _prototype = {...},

        -- 因為type(object)都會返回table，無法對不同類別的實例作比較，所以儲存類別的名字，在比較時才能區別。
        type = name,

        -- NOTE: 根據參數data的類型，支援3種建構方式:
        --       - 無參數 : class()
        --       - 有參數但非創建實例 : class(var1, var2, ...)
        --       - 直接創建實例 : class{...}
        -- NOTE: 改成先設定好實例的參數再綁定，解決容量重設的問題。
        --       預設的_new函數也改成返回一個table - 2019-05-04
        -- NOTE: 把__call改成new，這樣可以直接使用require 'xxx':new創建實例，
        --       不像之前需要先require'xxx'，再xxx:__call - 2019-06-28
        -- NOTE: 當前類別支援單例模式 - 2019-11-10
        new = function(self, ...)
            return setmetatable(self:_new(...), self)
        end,
        -- 使用者自訂的建構函數
        -- NOTE: 如果沒有寫的話，會提供一個預設的建構函數 - 2021-10-17
        _new = function(self, ...)
            if self:super() then
                return self:super():new(...)
            end
            
            if not ... then
                return {}
            end

            return type(...) == 'table' and ... or {...}
        end,
        -- 在self[key]找不到值時調用，如果沒有設定的話，self[key]是直接回傳nil。
        -- 搜索原型鏈，將對象委託給原型處理(function)或是返回原型的值(table、string、number、boolean)
        -- 根據原型鏈的排列順序決定優先度
        -- 不使用rawget的原因是需要搜索整個原型鏈，而不是只有當前原型鏈
        -- table會傳入呼叫此函式的對象，而不是getmetatable(對象)
        __index = function(table, key)
            -- 如果是實例，會獲取類別；如果是類別，會獲取自己
            local class = getmetatable(table)

            -- 只搜尋指定table有沒有key，不會一直搜索導致stack flow
            local value = rawget(class, key)

            if value then
                -- 如果類別有number、string、boolean、或table，賦值給實例
                -- NOTE: 考慮要不要用這個功能，或是單純的委託 - 2019-01-26
                -- if type(value) ~= "function" then
                --     rawset(table, key, value)
                -- end

                return value
            end

            -- NOTE: 檢查getter是否有key - 2020-04-13
            if class._gets[key] then
                return class._gets[key](table)
            end

            for i = 1, #class._prototype do
                -- 這也會執行__index，只是table不同，直到原型鏈的頂端
                value = class._prototype[i][key]

                if value ~= nil then
                    return value
                end
            end

            return nil
        end,
        -- __newindex是在對不存在的索引賦值時調用，我們不會拿來賦值，因為self[key] = value就會直接賦值了，
        -- __newindex存在則編譯器會調用它，而不會調用賦值。如果__newindex是一個table，則會賦值在table裡。
        -- 如果內部用self[key] = value，它又會因為對不存在的索引賦值而調用__newindex，導致無限循環因而報錯。
        __newindex = function(table, key, value)
            -- 如果是實例，會獲取類別；如果是類別，會獲取自己
            local class = getmetatable(table)

            -- NOTE: 處理設值裝飾符 - 2020-04-13
            if class._sets[key] then
                return class._sets[key](table, value)
            end

            rawset(table, key, value)
        end,

        remove = function(self)
            -- 使用者自訂的解構函數
            self:_remove()

            for key in pairs(self) do
                self[key] = nil
            end

            self = nil
        end,
        -- 使用者自訂的解構函數
        _remove = function(self)
        end,
        -- 因應第三種建構方式，instance會把data複製一份給自己
        _copy = function(self, data)
            if data and type(data) == 'table' then
                for key, value in pairs(data) do
                    self[key] = value
                end
            end

            return self
        end,
        -- 根據原型鏈向上搜尋委託對象
        super = function(self, super_name)
            if #self._prototype == 0 then
                return nil
            end

            if not super_name then
                return self._prototype[1]
            end

            for i = 1, #self._prototype do
                if self._prototype[i].type == super_name then
                    return self._prototype[i]
                end
            end
        end,
        -- 判斷物件是不是屬於此類別。這裡除了會檢查自己之外，還會檢查父類。
        isType = function(self, type_name)
            if type_name == self.type then return true end

            for _, parent in ipairs(self._prototype) do
                if type_name == parent.type then return true end
            end

            return false
        end,
        -- 註冊設值裝飾符
        setter = function(self, key, func)
            self[key] = nil
            getmetatable(self)._sets[key] = func
            return self
        end,
        -- 註冊取值裝飾符
        getter = function(self, key, func)
            getmetatable(self)._gets[key] = func
            return self
        end
    }

    setmetatable(object, object)

    return object
end

return Class
