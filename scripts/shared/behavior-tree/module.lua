---@class BTModule
---記錄節點模版或行為樹模版，重複使用降低記憶體使用量。
---透過別的模組載入或匯入模版來匯總。
local cls = {}

---匯入模版
---@param name string - 模版名稱
---@param template table<string, any> - 模版
---@return BTModule
function cls:import(name, template)
    assert(not cls[name], "請不要輸入重複的名稱")

    cls[name] = template

    if type(template) == 'table' and template.type == 'BTNode' then
        template._name = name
    end

    return self
end

---匯出模版
---@param name string - 模版名稱
---@return table<string, any> - 模版
function cls:export(name)
    return cls[name]
end

return cls