<h1 align=center>Behavior Tree - 行為樹</h1>
<p align=center>參考 <b>Unreal Engine 4 & 5</b> 和我的另一個專案 <a href="https://github.com/sugky7302/skill-manager">Skill-Manager</a> 而設計出來的新版行為樹。相較於 <b>Skill-Manager</b> 的版本，做了一些簡化和優化，降低使用難度。</p>
<p align="center">
    <img src="https://img.shields.io/badge/platform-War3-blue"/>
    <img src="https://img.shields.io/badge/lua-5.4-yellow" alt="Angular on npm" />
</p>
<br/>

## 目錄
- [使用](#使用)
- [FAQ](#faq)

## 專案結構
```
.
├─README.md
├─node.lua：最基礎的節點類別，所有複雜節點都繼承它。
├─tree.lua：操作行為樹的類別。需要匯入腳本，然後系統會轉換成可執行的行為樹。
├─module.lua：統一管理常用的任務節點、流程節點、行為樹腳本，透過複用來簡化腳本的撰寫。
├─decorator.lua：節點裝飾器類別。執行行為樹前，會包裝指定節點，擴展出更複雜的功能。
├─parser.lua：腳本翻譯工具。把行為樹腳本轉換成可執行的行為樹。
├─composite：放置流程節點。
|     ├─__init__：流程節點的基本類別。所有流程節點都繼承它。
|     ├─...
├─task：放置常用的任務節點。
```

## 使用
### 如何撰寫腳本？
在撰寫腳本時，時常需要撰寫自己的腳本，特別是腳本擁有非常多自訂的任務節點，著實複雜。為了縮短撰寫時間，這裡提供制式化的腳本規範。只要按照此規範撰寫，BehaviorTree 會調用 parser 來轉換成行為樹承認的格式。

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