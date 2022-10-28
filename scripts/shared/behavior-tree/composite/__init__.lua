---@class BTComposite : BTNode
---處理流程的特殊節點，可以包含多個子節點。
---
---@field _children BTNode[] - 子節點
---@field _index number - 當前執行的子節點索引
---@field _is_child_running boolean - 是否有子節點正在執行
local cls = Import('std.class')("BTComposite", Import('shared.behavior-tree.node'))

---創建一個子類別，並綁定在 BTModule 上。
---@param name string - 子類別名稱
function cls.inherit(name)
    -- 生成子類別
    local mt = Import('std.class')('BT' .. name, cls)

    -- 綁定在 BTModule 上
    Import('shared.behavior-tree.module'):import(name)

    return mt
end

---constructor
---@param args table<string, any> - 參數
---@return BTComposite - 實例
function cls:_new(args)
    local this = self:super():new(args)

    this._children = {}
    this._index = 1
    this._is_child_running = false

    return this
end

---deconstructor
function cls:_remove()
    for i, node in ipairs(self._children) do
        node:remove()
        self._children[i] = nil
    end
end

---新增子節點
---@param child BTNode - 節點
---@return BTComposite - 實例
function cls:append(child)
    if child then
        self._children[#self._children+1] = child
        child.parent = self
    end

    return self
end

---第一次執行會調用的初始化函數
---這裡會把索引歸零，以防重複使用時出錯。
---
---@override BTNode:start()
---@return boolean - 是否成功
function cls:start()
    if not self._is_child_running then
        self._index = 1
    end

    return true
end

---節點的執行函數
---這裡會依序執行子節點，直到有子節點返回成功或失敗。
---所以不要用 return，不然棧會堆太多。
---@override BTNode:run()
function cls:run()
    if self._index > #self._children then
        return true
    end

    -- 技能樹收到暫停命令
    if self.tree and self.tree._is_pause then
        return false
    end

    if not self._is_child_running then
        self._children[self._index]:start()
    end

    self._children[self._index]:run()
end

---設定節點為成功，並調用完成函數
---@override BTNode:success()
function cls:success()
    self._is_child_running = false

    if self._index <= #self._children then
        self._children[self._index]:finish()
    end
end

---設定節點為失敗，並調用完成函數
---@override BTNode:fail()
function cls:fail()
    self._is_child_running = false

    if self._index <= #self._children then
        self._children[self._index]:finish()
    end
end

---設定節點為執行中，並通知父節點
---@override BTNode:running()
function cls:running()
    self._is_child_running = true
    self:super():running()
end

return cls
