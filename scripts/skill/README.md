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
├─common：常用的技能腳本
```

## 使用
### 如何撰寫腳本？
撰寫技能腳本需要兩個要素，一個技能數據，這可以從 **ability.slk** 中讀取；另一個則是技能樹腳本。

>提醒：id（唯一編號）可以視為區域變數，只在行為樹實例下生效；而 name 類似全域變數，會記錄在 Module 裡面，供所有腳本使用。

以下是腳本規範：
- 腳本開頭
```lua
{
    name?: 腳本名稱。如果解析器讀到這個字，會自動把腳本儲存到 Module 裡。
    use: 根節點名稱。一定是流程節點，例如：C-Sequence、C-Selector…
    nodes<[node1, node2, ...]>: 存放子節點。
}

或者匯入腳本。
```
- 流程節點寫法
```lua
{
    id: 唯一編號。長 SN-{技能ID | 4 碼}-{任意數字、字母}
    use: 流程節點名稱。
    nodes<[node1, node2, ...]>: 存放子節點。
}
```
- 任務節點寫法
```lua
{
    --! 節點只有唯一編號時，會根據前文搜尋相同 id 的節點並複製於此。
    id: 唯一編號。長 SN-{技能ID | 4 碼}-{任意數字、字母}
    name?: 節點名稱。如果解析器讀到這個字，會自動把節點儲存到 Module 裡。
    args<any[]>?: 參數
    start<Function>?: 初始化函數。沒有寫的話會調用 BTNode.start()
    run<Function>?: 執行函數
    finish<Function>?: 完成函數。沒有寫的話會調用 BTNode.finish()
}
```
- 匯入腳本
```lua
{
    import: {
        script: 要匯入的腳本名稱
        args<[$1, $2, ...]>: 要替換的腳本參數，從 1 到 N 順序替換。
    }
    nodes<[node1, node2, ...]>?: 會接在匯入腳本後面執行的子節點。
}
```

## FAQ