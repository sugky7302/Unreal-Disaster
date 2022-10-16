<h1 align=center>虛幻之災</h1>
<p align=center>這是一張以 Zinc 撰寫的魔獸爭霸三地圖。別於過去使用 Lua 撰寫，為了通用性，改以 Zinc 將之前 Lua 實現的功能實作在地圖上。</p>
<p align="center">
    <img src="https://img.shields.io/badge/platform-War3-blue"/>
    <img src="https://img.shields.io/badge/lua-5.4-yellow" alt="Angular on npm" />
    <img src="https://img.shields.io/badge/ydwe-1.32.13-yellow" alt="Angular on npm" />
    <img src="https://img.shields.io/badge/release-0.2.0-brightgreen">
</p>
<br/>

## 目錄
- [使用](#使用)

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
├─table：地圖的觸發
├─w3x2lni：自動生成的 w3x2lni 格式轉換工具的版本紀錄
├─scripts：程式碼
|  ├─shared：公用包
```

## 使用
先將此專案下載下來:
```sh
git clone https://github.com/sugky7302/Unreal-Disaster.git
```
接著使用任何魔獸地圖編輯器打開專案目錄裡的 `UnrealDisaster.w3x` 即可。

## FAQ
1. 出現 `The term 'chcp 65001 && E:\projects\虛幻之災/tools/w3x2lni/bin/w3x2lni-lua.exe' is not recognized` 的問題。
>必須使用 cmd.exe 執行。