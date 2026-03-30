# Vercel 部署指南

## 🚀 部署步骤

### 1. 准备 GitHub 仓库

首先，将代码推送到新的 GitHub 仓库：

```bash
# 初始化 Git 仓库（如果还没有）
git init

# 添加所有文件
git add .

# 提交
git commit -m "feat: 初始化拍立得相机应用"

# 添加远程仓库（替换为你的仓库地址）
git remote add origin https://github.com/YOUR_USERNAME/instax-camera-web.git

# 推送到 GitHub
git push -u origin main
```

### 2. 在 Vercel 导入项目

1. 访问 [vercel.com](https://vercel.com)
2. 使用 GitHub 账号登录
3. 点击 "Add New..." → "Project"
4. 从 GitHub 导入你的仓库
5. Vercel 会自动检测项目配置

### 3. 配置环境变量

在 Vercel 项目设置中添加环境变量：

1. 进入项目 → **Settings** → **Environment Variables**
2. 添加以下环境变量：

| 名称 | 值 | 环境 |
|------|-----|------|
| `COZE_API_TOKEN` | 你的 Coze API Token | Production, Preview, Development |

⚠️ **重要**：
- 不要在代码中硬编码 API Token
- 不要将 `.env` 文件提交到 Git
- 在 Vercel 中设置的环境变量会被安全存储

### 4. 部署配置

项目已包含 `vercel.json` 配置文件，会自动：
- 配置 Serverless Functions 路由
- 设置静态文件服务
- 配置 API 代理

### 5. 自动部署

配置完成后，每次推送代码到 GitHub：
- Vercel 会自动构建和部署
- GitHub Actions 会触发 CI/CD
- 部署完成后会获得一个 HTTPS URL

## 🔒 安全说明

### API Token 保护

- ✅ **安全**：Token 存储在 Vercel 环境变量中，不会暴露到客户端
- ✅ **隔离**：Serverless Function 在服务端运行，客户端无法访问
- ✅ **加密**：Vercel 使用 HTTPS 加密所有请求

### 环境变量说明

```bash
# .env.local - 本地开发使用（不提交到 Git）
COZE_API_TOKEN=your_token_here

# Vercel Dashboard - 生产环境使用
COZE_API_TOKEN=your_production_token
```

## 📁 项目结构

```
instax-camera-web/
├── api/
│   ├── generate.js    # Coze API 代理 (Serverless Function)
│   └── health.js      # 健康检查 (Serverless Function)
├── index.html         # 前端页面
├── vercel.json        # Vercel 配置
├── package.json       # 项目依赖
├── .env.example       # 环境变量示例
├── .gitignore         # Git 忽略文件
└── README.md          # 项目说明
```

## 🧪 本地测试

### 使用 Vercel CLI 本地测试

```bash
# 安装 Vercel CLI
npm i -g vercel

# 登录 Vercel
vercel login

# 本地运行（模拟 Vercel 环境）
vercel dev

# 设置环境变量
vercel env add COZE_API_TOKEN
```

### 使用传统方式本地测试

```bash
# 安装依赖
npm install

# 创建 .env.local 文件
echo "COZE_API_TOKEN=your_token_here" > .env.local

# 启动开发服务器
npm start
```

## 🌐 部署后访问

部署完成后，你会获得：
- **生产环境**：`https://your-project.vercel.app`
- **预览环境**：`https://your-project-git-branch.vercel.app`

## 🔄 更新部署

每次推送代码到 GitHub 主分支：
```bash
git add .
git commit -m "feat: 更新功能"
git push
```

Vercel 会自动部署新版本。

## 🐛 调试

### 查看部署日志

1. 进入 Vercel 项目
2. 点击 **Deployments**
3. 选择部署版本
4. 查看 **Build Logs** 和 **Function Logs**

### 常见问题

**Q: API 调用失败？**
- 检查环境变量是否正确设置
- 查看 Vercel Function Logs

**Q: 页面无法访问？**
- 检查 vercel.json 配置
- 确认 index.html 在根目录

**Q: CORS 错误？**
- Serverless Function 已配置 CORS
- 检查 API 路径是否正确

## 📞 支持

如有问题，请：
1. 查看 [Vercel 文档](https://vercel.com/docs)
2. 检查项目 Issues
3. 联系技术支持

---

**部署完成后，请将生产 URL 添加到项目 README 中。**
