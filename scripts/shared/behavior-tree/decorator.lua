---@class BTDecorator
---@field _name string - 裝飾節點名稱
---@field _func function(BTNode) => BTNode - 裝飾函數
local cls = Import('std.class')("BTDecorator")

---constructor
---
---@param name string - 裝飾節點名稱
---@param func function - 裝飾函數
---@return BTDecorator - 實例
function cls:_new(name, func)
    local this = {
        _name = name,
        _func = func,
    }

    -- 加進 Module 統一管理
    Import('shared.behavior-tree.module'):import(name, this)
    
    return this
end

---回傳裝飾節點名稱
---@return string - 裝飾節點名稱
function cls:getName()
    return self._name
end

---執行裝飾函數
---@param node BTNode - 節點
---@return BTNode - 節點
function cls:decorate(node)
    return self._func(node)
end

return cls