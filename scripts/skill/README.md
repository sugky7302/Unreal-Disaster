<h1 align=center>Skill - 技能管理器</h1>
<p align=center>從 <b>Behavior Tree</b> 派生的特殊行為樹，用來管理玩家角色的技能數據、觸發技能行為。</p>
<p align="center">
    <img src="https://img.shields.io/badge/platform-War3-blue"/>
    <img src="https://img.shields.io/badge/lua-5.4-yellow" />
    <img src="https://img.shields.io/badge/extends-Behavior Tree-yellow" />
</p>
<br/>

## 目錄
- [使用](#使用)
- [FAQ](#faq)

## 專案結構
```
.
├─README.md
├─__init__.lua：技能節點類別。會把技能數據、腳本轉換成技能樹。
├─manager.lua：統一管理技能的接口。主要功能為新增/刪除/修改技能符文、設置技能數據、觸發技能行為。
├─module.lua：統一管理所有的技能樹。
├─scripts：放置技能腳本。
|    ├─common：常用的技能腳本。
|    ├─__init__.lua：載入所有的技能腳本。要先載入 common/ 再載入其它。
|    .：其它腳本。可能會用資料夾分類，記得裡面要新建 __init__.lua 記錄資料夾下的所有腳本。
```

## 使用
### 如何撰寫腳本？
1. 一開始先撰寫技能腳本。腳本有兩個要素，一個是技能數據，系統會合併自訂數據和 **ability.slk** 的數據；另一個則是技能樹腳本，以 Behavior Tree 制定的規範撰寫。以下是腳本規範：
```lua
-- 技能數據
local metadata = {
    id: 技能 ID。必須和物體編輯器的 ID 一致。
    dmg<[min: number, max: number]>: 技能傷害範圍。實際傷害會從 [min, max] 隨機取得。
    name?: 技能名稱。從 slk 中獲取。
    lv?: 技能等級。基礎數據從 slk 中獲取，但會根據玩家角色計算出實際數據。
    desc?: 技能敘述。敘述腳本會從 slk 獲得，但會把 `{XX}` 替換成對應的數據。
    cooldown?: 技能冷卻時間。基礎數據從 slk 中獲取，但會根據玩家角色計算出實際數據。
    cost?: 能量消耗。基礎數據從 slk 中獲取，但會根據玩家角色計算出實際數據。
    dur?: 技能效果持續時間。基礎數據只會從 **持續時間（一般）** 取得。
    dist?: 施法距離。基礎數據從 slk 中獲取，但會根據玩家角色計算出實際數據。
    range?: 技能範圍。基礎數據從 slk 中獲取，但會根據玩家角色計算出實際數據。
    <[property: string]: any>?: 自訂屬性。
}

-- 技能腳本
local script = {
    -- 按照行為樹的規範撰寫
}

return metadata, script
```
2. 在 `skill/scripts/__init__.lua` 裡添加腳本路徑。

## FAQ