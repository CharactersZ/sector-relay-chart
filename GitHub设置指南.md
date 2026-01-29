# GitHub Actions 自动打包设置指南

## 📋 前置准备

- ✅ 已有GitHub账号
- ✅ 已安装git（Mac通常自带）

## 🚀 快速设置步骤

### 第一步：在GitHub上创建仓库

1. 打开浏览器，访问：https://github.com/new
2. 填写仓库信息：
   - **Repository name**: `sector-relay-chart`（或你喜欢的名字）
   - **Description**: 赛道接力图生成器
   - **Visibility**: 选择 Public 或 Private（都可以）
   - **不要**勾选 "Add a README file"（我们已经有文件了）
3. 点击 **Create repository**

### 第二步：连接GitHub并推送代码

**方法一：使用自动化脚本（推荐）**

在终端运行：

```bash
cd /Users/ttzach/Documents/code
./连接到GitHub.sh
```

脚本会引导你输入GitHub用户名和仓库名，然后自动连接并推送代码。

**方法二：手动操作**

```bash
cd /Users/ttzach/Documents/code

# 添加GitHub远程仓库（替换YOUR_USERNAME为你的GitHub用户名）
git remote add origin https://github.com/YOUR_USERNAME/sector-relay-chart.git

# 推送代码
git branch -M main
git push -u origin main
```

**注意**：GitHub现在要求使用Personal Access Token而不是密码。如果提示输入密码，请：
1. 访问：https://github.com/settings/tokens
2. 点击 "Generate new token (classic)"
3. 勾选 `repo` 权限
4. 生成后复制token，推送时用token代替密码

### 第三步：在GitHub上触发打包

1. 打开你的GitHub仓库页面
2. 点击顶部的 **Actions** 标签
3. 在左侧找到 **Build Windows EXE** 工作流
4. 点击 **Run workflow** 按钮
5. 选择 **main** 分支，点击绿色的 **Run workflow**
6. 等待打包完成（通常5-10分钟）

### 第四步：下载打包好的exe

1. 打包完成后，在Actions页面点击刚才的运行记录
2. 滚动到页面底部，找到 **Artifacts** 部分
3. 点击 **赛道接力图生成器-exe** 下载
4. 解压后得到 `赛道接力图生成器.exe`

## 🎉 完成！

现在你可以在Mac上操作，GitHub自动在Windows环境打包exe了！

## 📝 后续使用

以后每次需要打包新版本：

1. 修改代码后提交：
   ```bash
   git add .
   git commit -m "更新说明"
   git push
   ```

2. 在GitHub Actions页面手动触发打包（或推送tag自动触发）

## ❓ 常见问题

### Q: 推送代码时提示需要登录？
A: GitHub现在要求使用Personal Access Token，而不是密码：
   1. 访问：https://github.com/settings/tokens
   2. 点击 "Generate new token (classic)"
   3. 勾选 `repo` 权限
   4. 生成后复制token，推送时用token代替密码

### Q: 找不到Actions标签？
A: 确保 `.github/workflows/build.yml` 文件已正确推送

### Q: 打包失败？
A: 查看Actions页面的错误日志，通常是依赖问题，我可以帮你修复
