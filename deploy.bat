@echo off
setlocal enabledelayedexpansion

REM 拍立得相机 - Vercel 部署脚本 (Windows)
REM 此脚本帮助你将项目推送到新的 GitHub 仓库并部署到 Vercel

echo =========================================
echo   拍立得相机 - Vercel 部署助手
echo =========================================
echo.

REM 检查是否在项目根目录
if not exist "package.json" (
    echo ❌ 错误：请在项目根目录运行此脚本
    pause
    exit /b 1
)

REM 1. 检查 Git 仓库
echo 📂 检查 Git 仓库...
if exist ".git" (
    echo ✅ Git 仓库已存在
) else (
    echo ⚠️  未找到 Git 仓库，正在初始化...
    git init
    echo ✅ Git 仓库已初始化
)

REM 2. 检查 .env 文件
echo.
echo 🔒 检查环境变量...
if exist ".env" (
    echo ⚠️  警告：检测到 .env 文件
    echo    此文件不应提交到 Git，已在 .gitignore 中排除
)
if exist ".env.local" (
    echo ⚠️  警告：检测到 .env.local 文件
    echo    此文件不应提交到 Git，已在 .gitignore 中排除
)

REM 3. 询问 GitHub 仓库信息
echo.
echo 请输入你的 GitHub 仓库信息：
set /p GITHUB_USERNAME="GitHub 用户名: "
set /p REPO_NAME="仓库名称 (instax-camera-web): "
if "!REPO_NAME!"=="" set REPO_NAME=instax-camera-web

set GITHUB_REPO=https://github.com/!GITHUB_USERNAME!/!REPO_NAME!.git

echo.
echo 📦 仓库地址: !GITHUB_REPO!
set /p CONFIRM="确认继续？ (y/n): "
if not "!CONFIRM!"=="y" (
    echo ❌ 已取消
    pause
    exit /b 1
)

REM 4. 添加所有文件到 Git
echo.
echo 📝 添加文件到 Git...
git add .
echo ✅ 文件已添加

REM 5. 提交
echo.
echo 💾 提交更改...
git commit -m "feat: 初始化拍立得相机应用，支持 Vercel 部署" 2>nul || echo ℹ️  没有新的更改需要提交

REM 6. 添加远程仓库
echo.
echo 🔗 配置远程仓库...
git remote get-url origin >nul 2>&1
if !errorlevel! == 0 (
    echo ℹ️  远程仓库 origin 已存在，正在更新...
    git remote set-url origin "!GITHUB_REPO!"
) else (
    git remote add origin "!GITHUB_REPO!"
)
echo ✅ 远程仓库已配置

REM 7. 推送到 GitHub
echo.
echo ⬆️  推送到 GitHub...
set /p BRANCH_NAME="分支名称 (main): "
if "!BRANCH_NAME!"=="" set BRANCH_NAME=main

git push -u origin !BRANCH_NAME!
if !errorlevel! neq 0 (
    echo.
    echo ❌ 推送失败！可能的原因：
    echo    1. GitHub 仓库尚未创建
    echo    2. 认证信息未配置
    echo.
    echo 📖 解决方法：
    echo    1. 在 GitHub 上创建新仓库: !GITHUB_REPO!
    echo    2. 配置 Git 认证（Personal Access Token 或 SSH）
    echo    3. 重新运行: git push -u origin !BRANCH_NAME!
    pause
    exit /b 1
)

echo ✅ 代码已推送到 GitHub

REM 8. Vercel 部署指引
echo.
echo =========================================
echo   ✅ 代码已成功推送到 GitHub！
echo =========================================
echo.
echo 📝 下一步：在 Vercel 部署
echo.
echo 1️⃣  访问: https://vercel.com/new
echo 2️⃣  导入 GitHub 仓库: !GITHUB_USERNAME!/!REPO_NAME!
echo 3️⃣  配置环境变量:
echo      名称: COZE_API_TOKEN
echo      值: 你的 Coze API Token
echo      环境: Production, Preview, Development
echo 4️⃣  点击 'Deploy'
echo.
echo 📖 详细部署指南: VERCEL_DEPLOYMENT.md
echo.
echo 🎉 部署完成后，你将获得一个 HTTPS URL！
echo.
pause
