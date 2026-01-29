@echo off
REM Windows平台打包脚本
REM 在Windows系统上运行此脚本即可打包成exe

echo ========================================
echo 赛道接力图生成器 - Windows打包脚本
echo ========================================
echo.

REM 检查Python是否安装
python --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未找到Python，请先安装Python 3.7+
    pause
    exit /b 1
)

echo [1/4] 安装打包依赖...
pip install pyinstaller

echo.
echo [2/4] 清理旧的构建文件...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist __pycache__ rmdir /s /q __pycache__

echo.
echo [3/4] 开始打包...
pyinstaller --name="赛道接力图生成器" ^
    --onefile ^
    --windowed ^
    --icon=NONE ^
    --add-data "sector_relay_chart.py;." ^
    --hidden-import=akshare ^
    --hidden-import=pandas ^
    --hidden-import=openpyxl ^
    --hidden-import=numpy ^
    --hidden-import=json ^
    --collect-all akshare ^
    --collect-all pandas ^
    sector_relay_chart.py

if errorlevel 1 (
    echo [错误] 打包失败！
    pause
    exit /b 1
)

echo.
echo [4/4] 打包完成！
echo.
echo 可执行文件位置: dist\赛道接力图生成器.exe
echo.
echo 使用说明:
echo   1. 将 dist\赛道接力图生成器.exe 复制到任意位置
echo   2. 双击运行即可
echo   3. 首次运行会在exe同目录生成 赛道接力图.xlsx 和 sector_colors.json
echo.
pause
