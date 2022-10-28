local assert = assert
local Module = Import('shared.behavitor-tree.module')
local Node = Import('shared.behavior-tree.node')

---@class BehaviorTree : BTNode
---BehaviorTree is a powerful framework to run the process of specified behavior. It has similiar structures of programming language.
---Thus, we can expand, modify and reuse easily.
---
---@field _root BTNode - 根節點
---@field object table - 對象
---@field _params table - 樹裡面所有節點共享的參數列表
---@field _is_pause boolean - 是否處於暫停
---@field _is_running boolean - 是否正在執行
local cls = Import('std.class')('BehaviorTree', Node)
local Parse, Print

---constructor
---@param obj table - 對象
---@param script table<string, string | BTNode> - 腳本
---@return BehaviorTree
function cls:_new(obj, script)
    local this = self:super():new()

    this._root = Parse(this, script, {})
    this.object = obj
    this._params = {}
    this._is_pause = false
    this._is_running = false

    return this
end

---解析腳本
---因為腳本支援 ${key = 1, ...} 這種變數，所以需要先解析腳本，再將變數替換成對應的值。
---
---@param self BehaviorTree
---@param data table<string, BTNode> - 腳本
---@param parent_args table<string, any> - 父節點的參數
---@return BTNode
Parse = function(self, data, parent_args)
    assert(type(data) == "table", "腳本內容錯誤，請重新檢查。")

    -- 匯入指定腳本
    if data.import then
        data = Module.export(data.import)
    end

    -- 如果節點的參數是以「$ + 數字」組成，系統會讀取父類參數於該索引的值。
    -- NOTE: 數字必須從 1 開始。
    if data.args then
        local match, type = string.match, type
        local n
        for i, v in ipairs(data.args) do
            if type(v) == 'string' and match(v, '$(%d+)') then
                n = tonumber(match(v, '$(%d+)'))
                assert(#parent_args >= n, "此索引超出父類參數的數量，請重新檢查。")
                data.args[i] = parent_args[n]
            end
        end
    end

    local parent = Module.export(data.id) and Module.export(data.id):new(data.args) or Module.export("C-Sequence"):new(data.args)
    parent.tree = self
    
    -- 如果只有單一節點表示沒有底下沒有節點了
    if parent.type == "BTTask" then
        return parent
    end

    -- 只有多節點的情況下才繼續
    -- local node
    for _, child in pairs(data.nodes or data) do
        parent:append(Parse(self, child, data.args))
    end

    return parent
end

---刪除函數
function cls:_remove()
    self._root:remove()

    for k in pairs(self._params) do
        self._params_[k] = nil
    end

    self._params_ = nil
end

---輸出行為樹的結構
local rep, concat = string.rep, table.concat
function cls:__tostring()
    if not self._root then
        return ""
    end

    return concat(Print({}, self._root, 0), "\n")
end

---列印行為樹的結構
---@param str string[] - 字串組
---@param node BTNode - 節點
---@param depth number - 樹的深度
---@return string[] - 原本的字串組
Print = function(str, node, depth)
    local s = {}
    for i = 1, depth do
        s[#s+1] = (i < depth) and "|   " or "|-- "
    end
    s[#s+1] = node:getName()
    str[#str+1] = concat(s)

    if node._children then
        for _, child in ipairs(node._children) do
            Print(str, child, depth + 1)
        end
    end

    return str
end

---遍歷行為樹
function cls:iterator()
    local index = Import("std.stack"):new()
    local node = self._root
    while node._children do
        node = node._children[1]
        index:push(1)
    end
    return function()
        if index:isEmpty() then
            index:remove()
            return nil
        end

        local pos = {}
        for i = 1, index:size() do
            pos[#pos+1] = index[i]
        end

        local ret = node
        local i = index:top() + 1
        index:pop()
        if i > #node.parent._children then
            node = node.parent
        else
            index:push(i)
            node = node.parent._children[i]

            while node._children do
                node = node._children[1]
                index:push(1)
            end
        end
        return table.concat(pos, "-"), ret
    end
end

---行為樹是否正在執行
---@return boolean - T：執行中，F：未執行
function cls:isRunning()
    return self._is_running
end

---設定共享參數
---* 方便使用鏈式語法 - 2021-10-22
---@param key string - 參數名稱
---@param value any - 參數值
---@return BehaviorTree
function cls:setParam(key, value)
    self._params[key] = value
    return self
end

---讀取共享變數
---* 方便使用鏈式語法 - 2021-10-22
---@param key string - 參數名稱
---@return any - 參數值
function cls:getParam(key)
    return self._params[key]
end

---執行行為樹
---@return BehaviorTree
function cls:run()
    if not self._root or self._is_running then
        return self
    end

    self._is_running = true
    self._root.parent = self
    self._root:start()
    self._root:run()
    return self
end

---獲取行為樹某個位置的節點
---@param pos string - 節點位置
---@return BTNode - 節點
function cls:get(pos)
    if not self._root then
        return self
    end

    local node, v = self._root
    for s in string.gmatch(pos, "%d+") do
        v = tonumber(s)
        if node._children and v <= #node._children then
            node = node._children[v]
        else break
        end
    end

    return node
end

---在行為樹某個位置插入節點
---@param pos string - 節點位置
---@param node BTNode - 節點
---@return BehaviorTree
function cls:insert(pos, new_node)
    if not self._root then
        return self
    end

    local t = {}
    for s in string.gmatch(pos, "%d+") do
        t[#t+1] = tonumber(s)
    end

    local node = self._root
    for i, v in ipairs(t) do
        if i == #t then
            table.insert(node._children, v, new_node)
            new_node.parent = node
            new_node.tree = self
        elseif node._children and v <= #node._children then
            node = node._children[v]
        -- NOTE: 中途發現找不到節點就停止
        else
            break
        end
    end

    return self
end

---暫停行為樹的動作
---@return BehaviorTree
function cls:pause()
    self._is_pause = true
    return self
end

---恢復行為樹的動作
---@return BehaviorTree
function cls:restore()
    self._is_pause = false
    return self
end

---設定行為樹的狀態為成功
---@return BehaviorTree
function cls:success()
    self._is_running = false
    return self
end

---設定行為樹的狀態為失敗
---@return BehaviorTree
function cls:fail()
    self._is_running = false
    return self
end

---設定行為樹的狀態為執行中
---@return BehaviorTree
function cls:running()
    self._is_running = false
    return self
end

return cls