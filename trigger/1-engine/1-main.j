<?import("main.lua")[=[

-- 此module啟用lua訊息框，並加載路徑，使後續module在require時，能夠省去父路徑
local require = require
local runtime = require 'jass.runtime'
local console = require 'jass.console'

Console = {}

-- 判斷是否為發布版本
Console.release = not pcall(require, 'lua.currentpath')

-- 設定版本號
Console.version = '0.1.0'

-- 打開控制台
if not Console.release then
    console.enable = true
end

-- 重載print，自動轉換編碼
print = console.write

-- 將handle等級設為0(地圖中所有的 handle 均使用 table 封裝)
runtime.handle_level = 0

-- 關閉等待
runtime.sleep = false

function Console.error_handle(msg)
    print("---------------------------------------")
    print(tostring(msg) .. "\n")
    print(debug.traceback())
    print("---------------------------------------")
end

-- 顯示錯誤訊息
function runtime.error_handle(msg)
    Console.error_handle(msg)
end

--??版本和?布版本的?本路?
if Console.release then
    package.path = package.path .. [[;Poi\]] .. Console.version .. [[\?.lua;scripts\?.lua]]
end

if not Console.release then
    -- 調試器端口
    runtime.debugger = 4279
end

local function main()
    print("hello world")
    require "wenhao_texture"
end

main()

]=]?>