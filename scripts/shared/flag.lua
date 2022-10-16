local message = require "jass.message"
local jass = require "jass.common"
local slk = require "jass.slk"
local runtime = require "jass.runtime"
local japi = require "jass.japi"
local keyboard = message.keyboard
--
-- 测试代码，显示本地发布的命令
-- 一定不要在正式环境中使用
--
message.order_enable_debug()
-- 目标允许的FLAG
local FLAG = {
    ["地面"] = 1 << 1,
    ["空中"] = 1 << 2,
    ["建筑"] = 1 << 3,
    ["守卫"] = 1 << 4,
    ["物品"] = 1 << 5,
    ["树木"] = 1 << 6,
    ["墙"] = 1 << 7,
    ["残骸"] = 1 << 8,
    ["装饰物"] = 1 << 9,
    ["桥"] = 1 << 10,
    ["位置"] = 1 << 11,
    ["自己"] = 1 << 12,
    ["玩家单位"] = 1 << 13,
    ["联盟"] = 1 << 14,
    ["中立"] = 1 << 15,
    ["敌人"] = 1 << 16,
    ["未知"] = 1 << 17,
    ["未知"] = 1 << 18,
    ["未知"] = 1 << 19,
    ["可攻击的"] = 1 << 20,
    ["无敌"] = 1 << 21,
    ["英雄"] = 1 << 22,
    ["非-英雄"] = 1 << 23,
    ["存活"] = 1 << 24,
    ["死亡"] = 1 << 25,
    ["有机生物"] = 1 << 26,
    ["机械类"] = 1 << 27,
    ["非-自爆工兵"] = 1 << 28,
    ["自爆工兵"] = 1 << 29,
    ["非-古树"] = 1 << 30,
    ["古树"] = 1 << 31,
}
FLAG["敌我判断"] = FLAG["自己"] | FLAG["玩家单位"] | FLAG["联盟"] | FLAG["中立"] | FLAG["敌人"]
-- 判断单位是否符合技能的目标允许
local function target_filter(unit, flag, slk)
    local player = jass.GetOwningPlayer(message.selection())
    -- 可见
    if jass.IsUnitInvisible(unit, player) then
        return false
    end
    -- 存活
    if flag & FLAG["死亡"] == 0 and jass.IsUnitType(unit, jass.UNIT_TYPE_DEAD) then
        return false
    end
    -- 无敌
    if flag & FLAG["无敌"] == 0 and jass.GetUnitAbilityLevel(unit, 1098282348 --[['Avul']]) == 1 then
        return false
    end
    -- 魔免
    if (not tonumber(slk.reqLevel) or tonumber(slk.reqLevel) <= 1) and jass.IsUnitType(unit, jass.UNIT_TYPE_MAGIC_IMMUNE) then
        return false
    end
    if flag & FLAG["敌我判断"] ~= 0 then
        -- 敌人
        if flag & FLAG["敌人"] == 0 and jass.IsUnitEnemy(unit, player) then
            return false
        end
        -- 自己
        if flag & FLAG["自己"] == 0 and unit == message.selection() then
            return false
        end
        -- 玩家单位
        if flag & FLAG["玩家单位"] == 0 and jass.GetOwningPlayer(unit) == player then
            return false
        end
        -- 联盟
        if flag & FLAG["联盟"] == 0 and jass.IsUnitAlly(unit, player) then
            return false
        end
    end
    -- 非英雄
    if flag & FLAG["非-英雄"] ~= 0 and jass.IsHeroUnitId(unit) then
        return false
    end
    -- 英雄
    if flag & FLAG["英雄"] ~= 0 and not jass.IsHeroUnitId(unit) then
        return false
    end
    -- 更多筛选请自己定义
    return true
end
-- 从鼠标位置处找出一个单位
local jass_group = jass.CreateGroup()
local function find_target(ability, x, y)
    -- 读取技能的目标类型
    local data = slk.ability[ability]
    if not data then
        return nil
    end
    local level = jass.GetUnitAbilityLevel(message.selection(), ability)
    -- 取出技能的目标类型
    local target_type = japi.EXGetAbilityDataInteger(japi.EXGetUnitAbility(message.selection(), ability), level, 0x64)
    local group = {}
    -- 选取单位组
    jass.GroupEnumUnitsInRange(jass_group, x, y, 200, nil)
    while true do
        local unit = jass.FirstOfGroup(jass_group)
        if not unit then 
            break
        end
        -- 判断是否符合目标允许
        if target_filter(unit, target_type, data) then
            table.insert(group, unit)
        end
        jass.GroupRemoveUnit(jass_group, unit)
    end
    -- 排序,找出最接近的那个单位
    table.sort(group, function(u1, u2)
        -- 英雄比非英雄优先
        local h1 = jass.IsHeroUnitId(u1)
        local h2 = jass.IsHeroUnitId(u2)
        if h1 and not h2 then
            -- 返回true表示u1排在u2前面
            return true
        end
        if h2 and not h1 then
            -- 返回false表示u2排在u1前面
            return false
        end
        -- 距离越近越优先
        local x1 = jass.GetUnitX(u1)
        local y1 = jass.GetUnitY(u1)
        local x2 = jass.GetUnitX(u2)
        local y2 = jass.GetUnitY(u2)
        return (x1 - x) * (x1 - x) + (y1 - y) * (y1 - y) < (x2 - x) * (x2 - x) + (y2 - y) * (y2 - y)
    end)
    -- 返回单位组里的第一个单位
    return group[1]
end
-- 本地消息的FLAG
local FLAG = {
    ["队列"] = 1 << 0, -- 指令进入队列,相当于按住shift发布指令
    ["瞬发"] = 1 << 1, -- 瞬发指令,该指令会立即触发发布命令事件(即使单位处于晕眩状态)
    ["独立"] = 1 << 2, -- 单独施放,当选中多个单位时只有一个单位会响应该指令
    ["恢复"] = 1 << 5, -- 恢复指令,该指令完成后会恢复之前的指令
}
-- 立即发动技能
local function cast_ability(ability, order, target_type)
    -- 鼠标当前指向的位置
    local x, y = message.mouse()
    if target_type == 2 then
        -- 点目标命令
        message.order_point(order, x, y, FLAG["独立"] | FLAG["恢复"])
        -- 返回false表示，这个消息会被扔掉(war3不会收到)
        return false
    elseif target_type == 4 then
        -- 单位目标命令
        -- 寻找技能目标
        local target = find_target(ability, x, y)
        if target then
            message.order_target(order, x, y, target, FLAG["独立"] | FLAG["恢复"])
        end
        return false
    elseif target_type == 1 then
        -- 无目标命令
        message.order_immediate(order, FLAG["独立"] | FLAG["恢复"])
        return false
    end
    return true
end
--
-- 键盘消息回调函数
-- 大多数的jass函数不能在这个函数里使用
-- 如果需要使用jass函数，可以把键盘消息保存下来，在计时器里处理这个消息
--
function message.hook(msg)
    if not message.selection() then
        return true
    end
    if msg.type == 'key_down' then
        -- 遍历技能栏,找到想按的技能
        for x = 0, 3 do
            for y = 0, 2 do
                -- message.button，根据格子找到技能id，命令id，目标类型
                local ability, order, target_type = message.button(x, y)
                local ability_data = slk.ability[ability]
                if ability_data then
                    local hot_key = ability_data.Hotkey
                    if keyboard[hot_key] == msg.code then
                        return cast_ability(ability, order, target_type)
                    end
                end
            end
        end
    end
    -- 返回true表示，war3会继续处理这个消息
    return true
end
