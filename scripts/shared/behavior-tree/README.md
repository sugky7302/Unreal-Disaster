<h1 align=center>Behavior Tree - 行為樹</h1>
<p align=center>參考 <b>Unreal Engine 4 & 5</b> 和我的另一個專案 <a href="https://github.com/sugky7302/skill-manager">Skill-Manager</a> 而設計出來的新版行為樹。相較於 <b>Skill-Manager</b> 的版本，做了一些簡化和優化，降低使用難度。</p>
<p align="center">
    <img src="https://img.shields.io/badge/platform-War3-blue"/>
    <img src="https://img.shields.io/badge/lua-5.4-yellow" alt="Angular on npm" />
    <img src="https://img.shields.io/badge/ydwe-1.32.13-yellow" alt="Angular on npm" />
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
├─composite：放置流程節點。
|     ├─__init__：流程節點的基本類別。所有流程節點都繼承它。
|     ├─...
├─task：放置常用的任務節點。
```

## 使用
### 如何撰寫任務節點？
在組合出行為樹時，時常需要撰寫自己的任務節點，
```sh
git clone https://github.com/sugky7302/Unreal-Disaster.git
```
接著使用任何魔獸地圖編輯器打開專案目錄裡的 `UnrealDisaster.w3x` 即可。

## FAQ
1. 出現 `The term 'chcp 65001 && E:\projects\UnrealDisaster/tools/w3x2lni/bin/w3x2lni-lua.exe' is not recognized` 的問題。
>必須使用 cmd.exe 執行。