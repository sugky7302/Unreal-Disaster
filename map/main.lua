local require = require
local runtime = require 'jass.runtime'
local console = require 'jass.console'

-- 重載 print，自動轉換編碼
print = console.write

-- 將 handle 等級設為 0（地圖中所有的 handle 均使用 table 封裝）
runtime.handle_level = 0

-- 關閉等待
runtime.sleep = false

--* 不設定成 local 是因為要讓所有程式都可以訪問
ENV = {
    -- 開發模式：debug、release
    MODE = "debug",
    -- 版本號
    VERSION = "0.2.0",
    -- 記錄所有 lua 的版本號。當啟動 hotfix 時，會將此表中的版本號與磁盤上的版本號進行比對，如果不一致則會重新加載
    VERSION_RECORDS = require "scripts.file_version",
    -- 顯示錯誤訊息
    error = function(msg)
        print("---------------------------------------")
        print(tostring(msg) .. "\n")
        print(debug.traceback())
        print("---------------------------------------")
    end
}

---於 debug 模式下顯示訊息
---@param ... string - 訊息
function Debug(...)
    if ENV.MODE == "debug" then
        print(...)
    end
end

-- 調試模式
if ENV.MODE == 'debug' then
    -- 打開控制台
    console.enable = true

    -- 開啟調試器端口
    runtime.debugger = 4279
end

---重載 runtime 的錯誤訊息
---@param msg string - 錯誤訊息
function runtime.error_handle(msg)
    ENV.error(msg)
end

---安全地匯入模塊，並簡化模塊名稱，以便未來調整位置
---* 不設定成 local 是因為要讓所有程式都可以訪問
---@param path string - 文件路徑 
---@return unknown - 如果文件有 return 會回傳
function Import(path)
    local concat, pcall = table.concat, pcall
    local path = {'scripts.', path}

    -- 先試著讀取文件，如果讀取失敗則在後面追加 __init__
    local success, result = pcall(require, concat(path))
    if not success then
        path[#path + 1] = '.__init__'
        success, result = pcall(require, concat(path))
    end

    print(path, success, result)
    return result
end

-- 入口函數
local function main()
    Debug(table.concat({"---Start Console---\nLua version: ", runtime.version, "\nMap version: ", ENV.VERSION, "\nMode: ", ENV.MODE, "\n-------------------"}))
    Import("test.wenhao_texture")
    Import("shared.timer")
    Import("shared.behavior-tree.composite")
end
main()
