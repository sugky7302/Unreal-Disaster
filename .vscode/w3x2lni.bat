@echo off
::设置为UTF-8编码
chcp 65001

::填写路径设置
set w3x2lniPath=%~1\tools\w3x2lni\w2l.exe
echo "當前 w3x2lni 路徑為 %w3x2lniPath%"
set mapName=%~1\%~3.w3x
set command=%~2
echo "當前操作為 %command%，地圖名稱為 %mapName%"
if "%command%"=="obj" (
    echo "開始打包 %~1 資料夾為 %~3.w3x"
    %w3x2lniPath% %command% %~1
) else if "%command%"=="lni" (
    echo "開始解包 %~3.w3x 為資料夾"
    %w3x2lniPath% %command% %mapName% %~1
)

