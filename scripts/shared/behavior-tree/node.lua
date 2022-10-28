local class = Import('std.class')

---@class BTNode
--- Behavior Tree Node
---
---@field _args table<string, any> - 參數
---@field _name string - 節點名稱
---@field _decorator BTDecorator - 裝飾節點
---@field parent BTNode - 父節點
---@field tree BehaviorTree - 行為樹
local cls = class('BTNode')

---創建一個子類別，並綁定在 BTModule 上。
---@param name string - 子類別名稱
function cls.inherit(name)
    -- 生成子類別
    local mt = class('BT' .. name, cls)

    -- 綁定在 BTModule 上
    Import('shared.behavior-tree.module'):import(name)

    return mt
end

---constructor
---@param args table<string, any> - 參數
---@return BTNode - 實例
function cls:_new(args)
    return {
        _args = args,
        _name = nil,
        _decorator = {},
        parent = nil,
        tree = nil,
    }
end

---獲得節點名稱
---@return string - 節點名稱
function cls:getName()
    return self._name
end

---添加裝飾節點
---@param decorator BTDecorator - 裝飾節點
---@return BTNode - 實例
function cls:addDecorator(decorator)
    table.insert(self._decorator, decorator)
    return self
end

---有無裝飾節點
---這個方法是為了方便在行為樹中判斷節點是否有裝飾節點
---
---@param name string - 裝飾節點名稱
---@return boolean - 是否有裝飾節點
function cls:hasDecorator(name)
    for _, v in ipairs(self._decorator) do
        if v:getName() == name then
            return true
        end
    end
    return false
end

---空白的啟動函數，只會在第一次執行。子類別可以覆寫。
function cls:start()
end

---空白的執行函數。子類別可以覆寫。
function cls:run()
end

---空白的完成函數。子類別可以覆寫。
function cls:finish()
end

---設定節點狀態為成功，並且通知父節點。
function cls:success()
    if self.parent then
        self.parent:success()
    end
end

---設定節點狀態為失敗，並且通知父節點。
function cls:fail()
    if self.parent then
        self.parent:fail()
    end
end

---設定節點狀態為正在執行，並且通知父節點。
function cls:running()
    if self.parent then
        self.parent:running()
    end
end

---設定節點狀態為跳出，並且通知父節點。
---* 通常用於迴圈節點。
function cls:escape()
    if self.parent then
        self.parent:escape()
    end
end

---設定節點狀態為繼續，並且通知父節點。
---* 通常用於迴圈節點。
function cls:continue()
    if self.parent then
        self.parent:continue()
    end
end

return cls
