#!/bin/bash
# Mac平台打包脚本（仅用于Mac，不能打包Windows exe）
# 这个脚本只能打包Mac版本，Windows exe需要在Windows系统上打包

echo "========================================"
echo "赛道接力图生成器 - Mac打包脚本"
echo "========================================"
echo ""

# 检查Python
if ! command -v python3 &> /dev/null; then
    echo "[错误] 未找到Python3"
    exit 1
fi

echo "[1/4] 安装打包依赖..."
pip3 install pyinstaller

echo ""
echo "[2/4] 清理旧的构建文件..."
rm -rf build dist __pycache__

echo ""
echo "[3/4] 开始打包Mac版本..."
pyinstaller --name="赛道接力图生成器" \
    --onefile \
    --console \
    --hidden-import=akshare \
    --hidden-import=pandas \
    --hidden-import=openpyxl \
    --hidden-import=numpy \
    --collect-all akshare \
    --collect-all pandas \
    sector_relay_chart.py

if [ $? -ne 0 ]; then
    echo "[错误] 打包失败！"
    exit 1
fi

echo ""
echo "[4/4] 打包完成！"
echo ""
echo "可执行文件位置: dist/赛道接力图生成器"
echo ""
echo "注意：这是Mac版本，不能在其他平台运行"
echo "要打包Windows exe，请使用Windows系统运行 build_windows.bat"
echo ""
