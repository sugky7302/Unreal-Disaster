local str = [=[
    內置japi1 .34更新內容: 
     1修復了 獲取圖像像素高 錯誤的bug
     2修復了 設置圖像Y軸 後鼠標移動事件無效的bug
     3修復了 騰訊平台 小退後再次玩圖崩潰的bug
     4修復了 錯誤的圖片路徑創建對象 導致崩潰的bug
     5修復了 設置傷害函數,傷害類型函數有幾率崩潰的bug
     6修復了 獲取文字字符串錯誤的bug
     7修復了 cj編譯器崩潰的問題
     8新增 jass崩潰跟蹤器
     9新增 異步掉線跟蹤器 (ps:包括掉線包括跟蹤lua引擎) 
     10兼容了openGL模式 不崩潰 d3d效果無效而已
     ]=]

local path = "UI\\Widgets\\EscMenu\\Human\\editbox-background.blp"
local path2 = "ReplaceableTextures\\WorldEditUI\\Editor-Random-Item.blp"
local path3 = "ReplaceableTextures\\WorldEditUI\\Editor-Random-Building.blp"

local jass = require 'jass.common'
local japi = require 'jass.japi'
local font = japi.CreateFont()

japi.SetFontHeight(font, 20)
japi.SetFontWidth(font, 20 * 0.6)
japi.SetFontWeight(font, 500)
japi.SetFontFaceName(font, "宋體")

local button = japi.CreateTexture(path2, 940, 208, 64, 64, 0xFFFFFFFF, 1)
local t = japi.CreateTexture(path, 640, 258, 300, 250, 0xFFFFFFFF, 1)
japi.SetTextureShow(t, false)
function ShowTip(str, x, y, width, height)
    local text = {}
    local num = 0
    str:gsub('([^\n]+)\n', function(line)
        text[num] = japi.CreateText(font, "", x, 768 - 300 - num * 20, 9999, 0xFFFFFFFF)
        num = num + 1
    end)
    local function ShowText(b)
        japi.SetTextureShow(t, b)
        num = 0
        str:gsub('([^\n]+)\n', function(line)
            if (b == true) then
                japi.SetTextString(text[num], line)
            else
                japi.SetTextString(text[num], "")
            end
            num = num + 1
        end)
    end

    japi.TextureAddEvent(button, 0x200, function()
        japi.SetTexture(button, path3)
        ShowText(true)
    end, function()
        japi.SetTexture(button, path2)
        ShowText(false)
    end)
end

ShowTip(str, 640, 258)
