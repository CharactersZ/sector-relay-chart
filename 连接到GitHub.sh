#!/bin/bash
# 连接到GitHub仓库的脚本

echo "========================================"
echo "连接到GitHub仓库"
echo "========================================"
echo ""

# 获取GitHub用户名
read -p "请输入你的GitHub用户名: " GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "[错误] 用户名不能为空"
    exit 1
fi

# 获取仓库名
read -p "请输入仓库名（直接回车使用默认: sector-relay-chart）: " REPO_NAME
REPO_NAME=${REPO_NAME:-sector-relay-chart}

echo ""
echo "准备连接到: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo ""
read -p "请确认已在GitHub上创建了这个仓库（按回车继续）..."

# 添加远程仓库
echo ""
echo "[1/2] 添加GitHub远程仓库..."
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"

# 检查远程仓库
if git remote -v | grep -q "$GITHUB_USERNAME/$REPO_NAME"; then
    echo "✓ 远程仓库已添加"
else
    echo "[错误] 添加远程仓库失败"
    exit 1
fi

echo ""
echo "[2/2] 推送代码到GitHub..."
echo "提示：如果提示输入密码，请使用Personal Access Token（不是GitHub密码）"
echo "获取Token: https://github.com/settings/tokens"
echo ""

# 设置分支名
git branch -M main

# 推送代码
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "========================================"
    echo "✓ 代码已成功推送到GitHub！"
    echo "========================================"
    echo ""
    echo "下一步："
    echo "1. 打开浏览器访问: https://github.com/$GITHUB_USERNAME/$REPO_NAME"
    echo "2. 点击顶部的 'Actions' 标签"
    echo "3. 点击 'Build Windows EXE' 工作流"
    echo "4. 点击 'Run workflow' 按钮开始打包"
    echo ""
else
    echo ""
    echo "[错误] 推送失败"
    echo ""
    echo "可能的原因："
    echo "1. 仓库不存在，请先在GitHub上创建仓库"
    echo "2. 需要身份验证，请使用Personal Access Token"
    echo "   获取Token: https://github.com/settings/tokens"
    echo "   需要勾选 'repo' 权限"
    echo ""
fi
