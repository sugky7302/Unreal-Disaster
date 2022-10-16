<h1 align=center>虛幻之災</h1>
<p align=center>這是一張以 Zinc 撰寫的魔獸爭霸三地圖。別於過去使用 Lua 撰寫，為了通用性，改以 Zinc 將之前 Lua 實現的功能實作在地圖上。</p>
<p align="center">
    <img src="https://img.shields.io/badge/platform-War3-blue"/>
    <img src="https://img.shields.io/badge/lang-zinc-yellow" alt="Angular on npm" />
    <img src="https://img.shields.io/badge/ydwe-1.30.4-yellow" alt="Angular on npm" />
    <img src="https://img.shields.io/badge/release-0.1.0-brightgreen">
</p>
<br/>

## 目錄
- [使用](#使用)
- [API](#api)

## 專案結構
```
.
├─CHANGELOG.md
├─README.md
├─虛幻之災.w3x：地圖檔
├─src：程式碼
├─doc：文件
|  ├─flow：開發流程文件
```

## 使用
### 啟動伺服器
先將此專案下載下來:
```sh
git clone https://github.com/CAkai/Camera_backend.git
```
接著進入專案目錄裡，你會看到一個 `umc-camera-backend` 的執行檔，直接執行即可：
```sh
./umc-camera-backend
```
> 這個執行檔可以直接移植到各個 Linux 平台並執行，無須任何 Golang 環境。如果想要移植，請連同移植 `settings.toml` 這支設定檔。

### 建構專案環境
如果想要自行調整專案內容，我已經封裝了一個 Docker Image，把它抓下來使用即可：
```sh
docker pull sugky7302/umc-camera-backend
```
把環境建構出來後，我們再生成容器：
```sh
docker run -it -p 3003:3003 -p 1433:1433 sugky7302/umc-camera-backend /bin/bash
```
這樣就可以在容器裡面執行專案了。

### 編譯 proto
如果想要新增自己的 proto，首先要先建一個 .proto 在 **pb/** 底下，記得一定要加，不然編譯不會過：
```protobuf
// 寫上 proto 資料夾的位置
option go_package="{$專案目錄}/pb";
```
接著在使用 protoc 把檔案編譯成 Golang 看得懂的 .pb：
```sh
# 進入到根目錄下
cd {$專案目錄}
protoc pb/*.proto --go_out=. --go_opt=paths=source_relative --go-grpc_out=. --go-grpc_opt=paths=source_relative
```
### 設定檔
`settings.toml` 記錄著程式所有的設定，裡頭有詳細註解，重啟後台便會重新抓取設定檔。

### 單元測試
每支 Golang 檔案都有單元測試，只要執行在該目錄下執行 `go test`，就能夠在命令行檢查程式碼是否通過測試。

### gRPC 測試
由於 gRPC 要用特殊工具才能測試，因此這裡建議下載 [gRPCurl](https://github.com/fullstorydev/grpcurl)。

如果您是在 **Windows** 環境下，請執行 **main.exe**；反之，若是在 **Linux** 或者 **MacOS** 環境下，請執行 **umc-camera-backend**。
> 如果要移動到別的位置，記得要連同 **settings.toml** 一起複製。

接著使用命令行啟動伺服器：
```sh
### Windows ###
.\main.exe

### Linux OR MacOS ###
./umc-camera-backend
```
然後再開一個新的命令行視窗，呼叫 gRPCurl。以下提供幾個常用指令：
- 查看伺服器提供哪些服務。
```sh
grpcurl --plaintext localhost:<port> list
```
- 查看各服務有哪些方法可以使用
```sh
grpcurl --plaintext localhost:<port> describe
```
- 查看指定服務有哪些方法可以使用。
```sh
grpcurl --plaintext localhost:<port> describe <service>

### Example ###
grpcurl --plaintext localhost:<port> describe proto.LoginService
```
- 查看指定方法的具體格式。
```sh
grpcurl --plaintext localhost:<port> describe <method>

### Example ###
grpcurl --plaintext localhost:<port> describe proto.LoginService.Login
```
- 查看 proto 的參數。
```sh
grpcurl --plaintext localhost:<port> describe <message>

### Example ###
grpcurl --plaintext localhost:<port> describe .proto.LoginRequest
```

- 呼叫方法。請注意！！如果是在 Windows 輸入**雙引號**，請改成**反斜線加雙引號**。如果出現 `Too many arguments`，請嘗試添加或刪除單引號。
```sh
grpcurl --plaintext -d {"key": "value"} localhost:<port> <method>
OR
grpcurl --plaintext -d '{"key": "value"}' localhost:<port> <method>

### Example ###
grpcurl --plaintext -d {"token": "abc"} localhost:<port> proto.PhotoService.Load
```

## API
### proto.LoginService.Login
使用者登入時會呼叫這支 API。首先經過 UMC 的認證，認證成功後會發放訪問令牌和更新令牌。
- Request：
    - username（string）：使用者名稱
    - password（string）：密碼
- Response：
    - status（int）：狀態碼
    - access_token（string）：訪問令牌
    - refresh_token（string）：更新令牌

### proto.LoginService.RefreshToken
當訪問令牌失效時，這支 API 會根據更新令牌的狀態簽核新的訪問令牌。
- Request：
    - token（string）：更新令牌
- Response：
    - status（int）：狀態碼
    - new_token（string）：新的訪問令牌

### proto.PhotoService.Load
驗證訪問令牌後，會前往資料庫搜尋此工號擁有的照片。
- Request：
    - token（string）：訪問令牌
- Response：
    - status（int）：狀態碼
    - data（CameraGrab[]）：資料
