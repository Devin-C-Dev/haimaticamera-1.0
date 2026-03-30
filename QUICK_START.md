# 快速开始指南

## 📋 前置要求

- GitHub 账号
- Vercel 账号（使用 GitHub 登录）
- Coze API Token

## 🚀 5 分钟快速部署

### 步骤 1: 准备 Coze API Token

1. 访问 [Coze 平台](https://www.coze.cn/)
2. 创建应用或使用现有应用
3. 复制 API Token

### 步骤 2: 推送代码到 GitHub

**Windows 用户**：
```bash
# 双击运行
deploy.bat
```

**Mac/Linux 用户**：
```bash
# 添加执行权限
chmod +x deploy.sh

# 运行脚本
./deploy.sh
```

或者手动执行：
```bash
git init
git add .
git commit -m "feat: 初始化拍立得相机应用"
git remote add origin https://github.com/YOUR_USERNAME/instax-camera-web.git
git push -u origin main
```

### 步骤 3: 在 Vercel 部署

1. 访问 [vercel.com/new](https://vercel.com/new)
2. 点击 "Import Git Repository"
3. 选择刚创建的仓库
4. 配置环境变量：
   - **Key**: `COZE_API_TOKEN`
   - **Value**: 你的 Coze API Token
   - **Environments**: 勾选所有选项
5. 点击 "Deploy"

### 步骤 4: 访问应用

等待 1-2 分钟，Vercel 会完成部署并显示：
```
✅ Production: https://your-project.vercel.app
```

点击链接即可访问应用！

## 🔧 本地开发

```bash
# 安装依赖
npm install

# 创建环境变量文件
echo "COZE_API_TOKEN=your_token_here" > .env.local

# 启动开发服务器
npm start

# 或者使用 Vercel 本地开发
npm run dev
```

访问：http://localhost:3001

## 📱 移动端测试

### 方法 1: 使用 ngrok（推荐）

```bash
# 安装 ngrok
npm install -g ngrok

# 启动本地服务器
npm start

# 在另一个终端窗口
ngrok http 3001
```

使用 ngrok 提供的 HTTPS URL 在手机上测试。

### 方法 2: 部署到 Vercel Preview

推送到 GitHub 后，Vercel 会自动创建预览环境：
```
https://your-project-git-branch.vercel.app
```

## 🐛 常见问题

### Q: API 调用失败？

**A**: 检查以下几点：
1. 确认 COZE_API_TOKEN 已正确设置
2. 在 Vercel Dashboard 中查看 Function Logs
3. 本地开发时检查 .env.local 文件

### Q: 部署后页面空白？

**A**: 检查以下几点：
1. 确认 index.html 在项目根目录
2. 查看 Vercel 部署日志
3. 检查浏览器控制台错误信息

### Q: 如何更新部署？

**A**: 简单地推送新代码：
```bash
git add .
git commit -m "feat: 更新功能"
git push
```

Vercel 会自动部署新版本。

## 🎯 下一步

- 查看 [VERCEL_DEPLOYMENT.md](./VERCEL_DEPLOYMENT.md) 了解更多部署详情
- 查看 [README.md](./README.md) 了解项目功能
- 在 GitHub 上 Star ⭐️ 这个项目

## 📞 需要帮助？

- 查看 [Vercel 文档](https://vercel.com/docs)
- 查看 [项目 Issues](https://github.com/YOUR_USERNAME/instax-camera-web/issues)
- 联系技术支持

---

**祝你使用愉快！🎉**
