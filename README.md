<h1 align=center>虛幻之災</h1>
<p align=center>這是一張以 Lua 撰寫的魔獸爭霸三地圖。為了增強遊戲表現，我加入了內置 JAPI 來簡化遊戲設計並客製化 UI。</p>
<p align="center">
    <img src="https://img.shields.io/badge/platform-War3-blue"/>
    <img src="https://img.shields.io/badge/lua-5.4-yellow" alt="Angular on npm" />
    <img src="https://img.shields.io/badge/ydwe-1.32.13-yellow" alt="Angular on npm" />
    <img src="https://img.shields.io/badge/release-0.2.0-brightgreen">
</p>
<br/>

## 目錄
- [使用](#使用)
- [開發](#開發)

## 專案結構
```
.
├─CHANGELOG.md
├─README.md
├─UnrealDisaster.w3x：obj 格式的地圖檔
├─.w3x：lni 格式的地圖檔
├─doc：文件
├─map：地圖的原始碼
├─resource：地圖的靜態檔
├─table：地圖的數據檔
├─trigger：地圖的觸發檔
├─w3x2lni：自動生成的 w3x2lni 格式轉換工具的版本紀錄
├─scripts：程式碼
|  ├─shared：公用包
|  ├─—file_version.json：記錄所有 lua 版本，用在 hotfix 上。
```

## 使用
先將此專案下載下來:
```sh
git clone https://github.com/sugky7302/Unreal-Disaster.git
```
接著使用任何魔獸地圖編輯器打開專案目錄裡的 `UnrealDisaster.w3x` 即可。

## 開發
1. 資料夾名稱和地圖名稱一定要一樣，不然 w3x2lni 會無法打包。
2. 由於 w3x2lni 再打包後會自動將 `scripts/` 裡的檔案匯入到地圖裡。因此，當撰寫完程式之後，記得要先**打包再執行**。

## FAQ
1. 出現 `The term 'chcp 65001 && E:\projects\UnrealDisaster/tools/w3x2lni/bin/w3x2lni-lua.exe' is not recognized` 的問題。
>必須使用 cmd.exe 執行。