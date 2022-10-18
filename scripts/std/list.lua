-- 在lua上建構c++的泛型list，提供插入/移除任意類型元素

-- 葉節點
local Node = {
    new = function(self, data)
        local instance = {
            __index = self,
            _data_ = data,
            prev_ = nil,
            next_ = nil
        }

        return setmetatable(instance, instance)
    end,
    remove = function(self)
        for k in pairs(self) do
            self[k] = nil
        end

        self = nil
    end,
    getData = function(self)
        return self._data_
    end
}

-- package
local require = require
local IsNil = require 'std.table'.isNil
local List = require 'std.class'('List')

List._VERSION = '1.2.0'

local DeleteBeginNode, DeleteEndNode, DeleteMidNode, DeleteSingleNode, DeleteNode
local InsertNodeToBegin, InsertNodeToEmptyList, InsertNodeToEnd, InsertNodeFrontOfThePosition

function List:_new()
    return {
        _begin_ = nil,
        _end_ = nil,
        _size_ = 0
    }
end

-- 獲取私有成員變量
function List:isEmpty()
    return self._size_ == 0
end

function List:size()
    return self._size_
end

function List:getBegin()
    return self._begin_
end

function List:getEnd()
    return self._end_
end

function List:front()
    return self._begin_:getData()
end

function List:back()
    return self._end_:getData()
end

function List:__tostring()
    local print_str = {'['}

    for _, node in self:iterator() do
        print_str[#print_str + 1] = node:getData()
    end

    print_str[#print_str + 1] = ']'

    return table.concat(print_str, ' ')
end

function List:clear()
    self:_delete()

    self._begin_ = nil
    self._end_ = nil
    self._size_ = 0
end

-- O(self._size_)的方法
function List:_remove()
    for _, node in self:reverseIterator() do
        self:delete(node)
    end
end

function List:erase(data)
    for _, node in self:reverseIterator() do
        if node:getData() == data then
            self:delete(node)
        end
    end
end

-- O(self._size_)的迭代器方法
function List:reverseIterator()
    local i = 0
    local node = nil
    return function()
        i = i + 1

        if self._size_ == 0 then
            return nil
        end

        node = IsNil(node) and self._end_ or node.prev_

        -- 檢查是否到最末端
        if IsNil(node) then
            return nil
        end

        return i, node
    end
end

function List:pop_front()
    self:delete(self._begin_)
end

function List:pop_back()
    self:delete(self._end_)
end

function List:delete(node)
    if not node then
        return false
    end

    if self:isEmpty() then
        return true
    end

    if self._size_ == 1 then
        DeleteSingleNode(self, node)
    elseif node == self._begin_ then
        DeleteBeginNode(self, node)
    elseif node == self._end_ then
        DeleteEndNode(self, node)
    else
        DeleteMidNode(self, node)
    end

    return true
end

DeleteSingleNode = function(self, node)
    DeleteNode(self, node)

    -- list沒節點了，重置成員變數
    self._begin_ = nil
    self._end_ = nil
end

DeleteBeginNode = function(self, node)
    -- 把node的next_指標設定成新的first節點
    node.next_.prev_ = nil
    self._begin_ = node.next_

    DeleteNode(self, node)
end

DeleteEndNode = function(self, node)
    -- 把node的prev_指標設定成新的last節點
    node.prev_.next_ = nil
    self._end_ = node.prev_

    DeleteNode(self, node)
end

DeleteMidNode = function(self, node)
    -- 處理刪除中間節點的情況
    -- 先把node的上個節點和下個節點相互指向對方
    node.prev_.next_ = node.next_
    node.next_.prev_ = node.prev_

    DeleteNode(self, node)
end

DeleteNode = function(self, node)
    node:remove()
    self._size_ = self._size_ - 1
end

-- 只找第一筆資料
function List:find(data)
    for i, node in self:iterator() do
        if node:getData() == data then
            return i, node
        end
    end

    return false
end

function List:merge(other_list)
    for _, node in other_list:iterator() do
        self:push_back(node:getData())
    end

    other_list:remove()
end

-- O(self._size_)的迭代器方法
-- HACK: 使用閉包的寫法會比無狀態的迭代器多開銷
-- NOTE: 簡化閉包的寫法。以目前的寫法，如果使用insert會搜尋不到新插入的元素，原因是新元素是插在node.prev_，node.next_還是原本後面那一個 - 2020-02-04
function List:iterator()
    local i = 0
    local node = nil
    return function()
        i = i + 1

        if self._size_ == 0 then
            return nil
        end

        node = IsNil(node) and self._begin_ or node.next_

        -- 檢查是否到最末端
        -- NOTE: 第一個回傳值不是nil，迭代器不會停止，可以參考 docs/無狀態的迭代器寫法.lua
        if IsNil(node) then
            return nil
        end

        return i, node
    end
end

function List:push_back(data)
    self:insert(nil, data)
end

function List:push_front(data)
    self:insert(self._begin_, data)
end

-- node 等於 nil，視作插在 list 的最末端
-- 插入位置為node原本的位置，而node會後退一位
function List:insert(node, data)
    if not data then
        return false
    end

    local new_node = Node:new(data)

    if self:isEmpty() then
        InsertNodeToEmptyList(self, new_node)
    elseif node == self._begin_ then
        InsertNodeToBegin(self, new_node)
    elseif not node then
        InsertNodeToEnd(self, new_node)
    else
        InsertNodeFrontOfThePosition(new_node, node)
    end

    self._size_ = self._size_ + 1

    return true
end

InsertNodeToEmptyList = function(self, new_node)
    self._begin_ = new_node
    self._end_ = new_node
end

InsertNodeToBegin = function(self, new_node)
    -- 只需把頂端的prev_指標指向新節點
    self._begin_.prev_ = new_node
    new_node.next_ = self._begin_

    -- 頂端指向新的節點
    self._begin_ = new_node
end

InsertNodeToEnd = function(self, new_node)
    -- 只需把last的next_指標指向新節點
    self._end_.next_ = new_node
    new_node.prev_ = self._end_

    -- 末端指向新的節點
    self._end_ = new_node
end

InsertNodeFrontOfThePosition = function(new_node, node)
    -- 處理插在中間節點的情況
    -- 先把node的prev_指標指向新節點
    new_node.prev_ = node.prev_
    node.prev_.next_ = new_node

    -- 再把新節點的next_指標指向node
    new_node.next_ = node
    node.prev_ = new_node
end

return List
