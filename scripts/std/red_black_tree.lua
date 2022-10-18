--[[
  Red-black tree is an important data structure of computer science. It is often used on building the database.

  Member:
    _size_ - record the size of the tree
    _root_ - the root node of the tree

  Function:
    new(self) - create a new instance
      self - class

    size(self) - the number of nodes in the tree
      self - instance
      return - the size
    
    iterator(self) - traverse the tree
      self - instance
      return - the index of the node, the value of the node

    insert(self, index, data) - insert the data into the index-th position of the tree
      self - instance
      index - key
      data - value

    delete(self, index) - delete the data in the index-th position of the tree
      self - instance
      index - key

    find(self, index) - find the value in the index-th position of the tree
      self - instance
      index - key
--]]

-- 葉節點
local Node = {
    new = function(self, index, data, color)
        local instance = {
            __index = self,
            _index_ = index,
            data_ = data,
            color_ = color or 0, -- 0: 紅色、1: 黑色
            parent_ = nil,
            left_ = nil,
            right_ = nil,
            is_deleted_ = false
        }

        return setmetatable(instance, instance)
    end,
    remove = function(self)
        for k in pairs(self) do
            self[k] = nil
        end

        self = nil
    end,
    getIndex = function(self)
        return self._index_
    end
}

-- 紅黑樹
local require = require
local RBT = require 'std.class'('RedBlackTree')
local LeftRotate, RightRotate, InsertFixedUp, DeleteFixedUp, Replace

function RBT:_new()
    return {
        _size_ = 0,
        _root_ = nil
    }
end

function RBT:size()
    return self._size_
end

function RBT:iterator()
    local stack = require 'std.stack':new()
    local node = self._root_
    return function()
        -- 搜尋左子節點，並將中途遇到的節點壓入stack，方便回退時直接使用
        while node do
            stack:push(node)
            node = node.left_
        end

        -- 空棧表示所有節點都遍歷過了
        if stack:isEmpty() then
            stack:remove()
            return nil
        end

        -- 取值並印出
        node = stack:top()
        stack:pop()
        local idx, data = node:getIndex(), node.data_

        -- 搜尋右子節點。如果沒有的話，下一次會回退到父節點
        node = node.right_

        return idx, data
    end
end

function RBT:insert(index, data)
    if not (index and data) then
        return self
    end

    local new_node = Node:new(index, data)

    if not self._root_ then
        self._root_ = new_node
    else
        local node, direct = self._root_
        while node do
            direct = index < node:getIndex() and 'left_' or 'right_'

            if not node[direct] then
                node[direct] = new_node
                new_node.parent_ = node
                break
            else
                node = node[direct]
            end
        end

        InsertFixedUp(self, new_node)
    end

    self._root_.color_ = 1
    self._size_ = self._size_ + 1

    return self
end

InsertFixedUp = function(self, node)
    local direct, uncle  -- direct = 0(左) or 1(右)

    while node.parent_ and node.parent_.color_ == 0 do
        -- 根據父節點在祖父節點的位置，獲得uncle節點以及Case2的判斷式
        direct = node.parent_ == node.parent_.parent_.left_ and 'right_' or 'left_'
        uncle = node.parent_.parent_[direct]

        -- Case1: 若uncle是紅色
        if uncle and uncle.color_ == 0 then
            -- Case2 & 3: 若uncle是黑色
            node.parent_.color_ = 1
            uncle.color_ = 1
            node.parent_.parent_.color_ = 0
            node = node.parent_.parent_
        else
            -- Case2
            if node == node.parent_[direct] then
                -- Case3
                node = node.parent_

                if direct == 'right_' then
                    LeftRotate(self, node)
                else
                    RightRotate(self, node)
                end
            else
                node.parent_.color_ = 1
                node.parent_.parent_.color_ = 0

                if direct == 'right_' then
                    RightRotate(self, node.parent_.parent_)
                else
                    LeftRotate(self, node.parent_.parent_)
                end
            end
        end
    end
end

-- NOTE: 保留標記的方式處理刪除
function RBT:_delete(index)
    local node = self:find(index)
    if node then
        node.is_deleted_ = true
    end

    return self
end

function RBT:delete(index)
    local node = self:find(index)

    if not node then
        return false
    end

    -- 搜尋替代節點，記得把替代節點的值給原本的節點，這樣才算刪除
    if node.left_ and node.right_ then
        local origin = node
        node = Replace(node)
        origin._index_ = node._index_
        origin._data_ = node._data_
    end

    local replaced_node = node.left_ or node.right_

    if replaced_node then
        replaced_node.parent_ = node.parent_
    end

    if not node.parent_ then
        self._root_ = replaced_node
    elseif node == node.parent_.left_ then
        node.parent_.left_ = replaced_node
    else
        node.parent_.right_ = replaced_node
    end

    if node.color_ == 1 then
        DeleteFixedUp(replaced_node)
    end

    self._size_ = self._size_ - 1
end

Replace = function(node)
    local replaced_node

    if node.right_ then
        replaced_node = node.right_

        while replaced_node.left_ do
            replaced_node = replaced_node.left_
        end

        return replaced_node
    end

    replaced_node = node.parent_

    while replaced_node and node == replaced_node.right_ do
        node = replaced_node
        replaced_node = replaced_node.parent_
    end

    return replaced_node
end

DeleteFixedUp = function(self, node)
    local direct, rdirect, brother

    while node and node.color_ == 1 and node ~= self._root_ do
        -- 根據父節點在祖父節點的位置，獲得brother節點
        if node == node.parent_.left_ then
            direct = 'right'
            rdirect = 'left'
        else
            direct = 'left'
            rdirect = 'right'
        end

        brother = node.parent_[direct]

        -- Case1: 如果brother是紅色
        if brother and brother.color_ == 0 then
            brother.color_ = 1
            node.parent_.color_ = 0

            if direct == 'right_' then
                LeftRotate(self, node.parent_)
            else
                RightRotate(self, node.parent_)
            end

            brother = node.parent_[direct]
        end

        -- Case2: brother的兩個child都是黑色
        if (not brother.left_ or brother.left_.color_ == 1) and (not brother.right_ or brother.right_.color_ == 1) then
            brother.color_ = 0

            if node.parent_.color_ == 0 then
                node.parent_.color_ = 1
                break
            else
                node = node.parent_
            end
        else
            -- Case3: brother的right child是黑的, left child是紅色
            if brother[rdirect] and brother[rdirect].color_ == 0 then
                brother[rdirect].color_ = node.parent_.color_
                node.parent_.color_ = 1

                if direct == 'right_' then
                    RightRotate(self, brother)
                    LeftRotate(self, node.parent_)
                else
                    LeftRotate(self, brother)
                    RightRotate(self, node.parent_)
                end
            elseif brother[direct] and brother[direct].color_ == 0 then
                brother.color_ = node.parent_.color_
                node.parent_.color_ = 1
                brother[direct].color_ = 1

                if direct == 'right_' then
                    LeftRotate(self, node.parent_)
                else
                    RightRotate(self, node.parent_)
                end
            end

            break
        end
    end

    if node then
        node.color_ = 1
    end
end

-- HACK: 因為刪除很麻煩，先用標記代替，所以搜尋時要跳過被標記的節點
function RBT:find(index)
    local node = self._root_
    while node do
        if index == node:getIndex() then
            -- return node
            return node.is_deleted_ and nil or node
        elseif index < node:getIndex() then
            node = node.left_
        else
            node = node.right_
        end
    end

    return nil
end

LeftRotate = function(self, old)
    local new = old.right_

    -- 把新根節點的左子節點給舊根節點
    old.right_ = new.left_

    if new.left_ then
        new.left_.parent_ = old
    end

    -- 處理新根節點移到舊根節點的位置的關係
    new.parent_ = old.parent_

    if not old.parent_ then
        self._root_ = new
    elseif old == old.parent_.left_ then
        old.parent_.left_ = new
    else
        old.parent_.right_ = new
    end

    -- 建立新根結點和舊根結點的直屬關係
    new.left_ = old
    old.parent_ = new
end

RightRotate = function(self, old)
    local new = old.left_

    -- 把新根節點的右子節點給舊根節點
    old.left_ = new.right_

    if new.right_ then
        new.right_.parent_ = old
    end

    -- 處理新根節點變到舊根節點的位置的關係
    new.parent_ = old.parent_

    if not old.parent_ then
        self._root_ = new
    elseif old == old.parent_.left_ then
        old.parent_.left_ = new
    else
        old.parent_.right_ = new
    end

    -- 建立新根結點和舊根結點的直屬關係
    new.right_ = old
    old.parent_ = new
end

return RBT
