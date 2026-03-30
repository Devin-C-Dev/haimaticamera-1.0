# GitHub Actions 自动部署配置

## 📖 说明

本项目已配置 GitHub Actions，用于自动化 CI/CD 流程。当推送代码到 GitHub 时，会自动触发部署到 Vercel。

## 🔧 配置步骤

### 1. 获取 Vercel 凭证

#### 1.1 获取 Vercel Token

1. 访问 [Vercel Dashboard](https://vercel.com/account/tokens)
2. 点击 "Create Token"
3. 输入 Token 名称（如：GitHub Actions）
4. 选择作用域（选择你的账户）
5. 复制生成的 Token

#### 1.2 获取 Org ID 和 Project ID

**方法 1：通过 Vercel CLI**

```bash
# 安装 Vercel CLI
npm i -g vercel

# 登录
vercel login

# 在项目目录运行
vercel link

# 查看配置
cat .vercel/project.json
```

你会看到类似输出：
```json
{
  "orgId": "your-org-id",
  "projectId": "your-project-id"
}
```

**方法 2：通过项目 URL**

查看 Vercel 项目 URL，格式为：
```
https://vercel.com/your-org-id/your-project-id
```

其中：
- `your-org-id` → Org ID
- `your-project-id` → Project ID

### 2. 在 GitHub 配置 Secrets

1. 进入 GitHub 仓库
2. 点击 **Settings** → **Secrets and variables** → **Actions**
3. 点击 **New repository secret**
4. 添加以下 Secrets：

| 名称 | 值 | 说明 |
|------|-----|------|
| `VERCEL_TOKEN` | 步骤 1.1 获取的 Token | Vercel API Token |
| `VERCEL_ORG_ID` | 步骤 1.2 获取的 Org ID | Vercel 组织 ID |
| `VERCEL_PROJECT_ID` | 步骤 1.2 获取的 Project ID | Vercel 项目 ID |

### 3. 触发部署

配置完成后，推送代码到 `main` 分支：

```bash
git add .
git commit -m "feat: 新功能"
git push origin main
```

GitHub Actions 会自动：
1. 运行测试（如果有）
2. 构建项目
3. 部署到 Vercel Production 环境

## 🔄 工作流程

### Push 到 main 分支

```
代码推送 → GitHub Actions 触发
    ↓
构建项目
    ↓
运行测试
    ↓
部署到 Vercel (Production)
    ↓
完成：https://your-project.vercel.app
```

### 创建 Pull Request

```
创建 PR → GitHub Actions 触发
    ↓
构建项目
    ↓
运行测试
    ↓
部署到 Vercel (Preview)
    ↓
完成：https://your-project-git-branch.vercel.app
```

## 📊 监控部署

### 查看部署状态

1. 进入 GitHub 仓库
2. 点击 **Actions** 标签
3. 选择最近的 workflow run
4. 查看部署日志

### 部署状态徽章

在 README.md 中添加状态徽章：

```markdown
[![Deploy Status](https://github.com/YOUR_USERNAME/instax-camera-web/actions/workflows/deploy.yml/badge.svg)](https://github.com/YOUR_USERNAME/instax-camera-web/actions/workflows/deploy.yml)
```

## 🛠️ 故障排查

### 部署失败

**问题**: GitHub Actions 部署失败

**解决方案**:
1. 检查 Secrets 是否正确配置
2. 查看 Actions 日志获取详细错误信息
3. 确认 Vercel Token 有足够权限

### 环境变量未生效

**问题**: Vercel 环境变量在生产环境不生效

**解决方案**:
1. 在 Vercel Dashboard 中配置环境变量
2. 确保选择了所有环境（Production, Preview, Development）
3. 重新触发部署

### 部署超时

**问题**: 部署过程超时

**解决方案**:
1. 检查网络连接
2. 查看 Vercel 构建日志
3. 优化构建时间

## 🎯 最佳实践

1. **分支保护**
   - 在 GitHub 设置中启用分支保护
   - 要求 PR 审查才能合并到 main

2. **自动化测试**
   - 添加测试脚本到 package.json
   - 确保测试通过后再部署

3. **版本标签**
   - 使用 Git 标签标记版本
   - 在创建 Release 时触发部署

4. **回滚策略**
   - 保留最近几个版本的部署
   - 必要时可以快速回滚

## 📚 相关文档

- [GitHub Actions 文档](https://docs.github.com/en/actions)
- [Vercel 部署文档](https://vercel.com/docs/deployments/overview)
- [Vercel GitHub Integration](https://vercel.com/docs/integrations/git)

---

**需要帮助？** 请查看 [VERCEL_DEPLOYMENT.md](./VERCEL_DEPLOYMENT.md) 或创建 Issue。
