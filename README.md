# 拍立得相机 - Instax Camera Web App

> 📸 一个精美的拍立得相机 Web 应用，支持 AI 图像生成和多种滤镜效果

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/YOUR_USERNAME/instax-camera-web)

## ✨ 功能特性

- 📸 **真实拍立得相机界面** - 精心设计的相机 UI，还原真实拍立得体验
- 🤖 **AI 智能处理** - 集成 Coze API 进行智能图像生成和处理
- 🎨 **多种滤镜效果** - FRAGMENT BW 黑白、拍立得青色调等多种滤镜
- 📱 **摇晃加速显影** - 支持设备运动检测，摇晃手机或点击照片加速显影
- 📐 **精确 Instax 比例** - 严格按照 72mm×86mm 相纸规格，成像区域 62×62mm 正方形
- 🖼️ **照片下载** - 高清导出带滤镜效果的拍立得照片
- 💾 **本地相册** - 自动保存照片到本地（最多50张）
- 🔄 **前后摄像头切换** - 支持移动设备摄像头翻转
- 🔒 **安全部署** - 通过 Vercel Serverless Functions 保护 API Token

## 🚀 快速开始

### 在线体验

🌐 **生产环境**：[https://your-project.vercel.app](https://your-project.vercel.app)

### 本地开发

```bash
# 克隆仓库
git clone https://github.com/YOUR_USERNAME/instax-camera-web.git
cd instax-camera-web

# 安装依赖
npm install

# 创建环境变量文件
cp .env.example .env.local
# 编辑 .env.local，添加你的 COZE_API_TOKEN

# 启动开发服务器
npm start
```

访问：http://localhost:3001

### 部署到 Vercel

📖 **详细部署指南**：查看 [VERCEL_DEPLOYMENT.md](./VERCEL_DEPLOYMENT.md)

**快速部署**：
1. 将代码推送到 GitHub
2. 在 Vercel 导入项目
3. 在环境变量中添加 `COZE_API_TOKEN`
4. 自动部署完成！

## 📱 使用说明

### 拍摄照片

1. 点击"允许访问摄像头"授权摄像头权限
2. 看到实时画面后，点击红色快门按钮
3. 等待2秒"出片中"
4. 相纸吐出后，开始6秒显影过程
5. **摇晃手机或点击照片**可以加速显影
6. 显影完成后，点击照片可查看大图

### 照片管理

- **查看相册** - 点击底部导航栏的"相册"按钮
- **预览照片** - 点击任意照片查看大图
- **下载照片** - 在预览页面点击"下载"按钮
- **删除照片** - 在预览页面点击"删除"按钮

### 滤镜效果

本项目支持多种滤镜效果：

- **Instax 原色** - 经典拍立得色彩，温暖色调
- **FRAGMENT BW 黑白** - 藤原浩联名款，细腻层次感，静谥质感
- **拍立得青色** - 复古青色调，怀旧风格

### AI 智能处理

- 🤖 集成 Coze API 进行智能图像生成
- 🎯 自动裁剪和优化人像
- ⚡ 快速响应，实时处理

## 🎨 技术细节

### Instax 相纸规格

严格按照物理 Instax 相纸规格设计：

- **相纸尺寸**: 72mm × 86mm
- **成像区域**: 62mm × 62mm 正方形
- **上边距**: 5mm
- **下边距**: 19mm
- **左右边距**: 5mm

### 滤镜实现

```css
/* FRAGMENT BW 黑白滤镜 */
.fragmt-bw-filter {
    filter: grayscale(100%) contrast(115%) brightness(102%);
}

/* 细腻暗部层次 */
.fragmt-bw-filter::before {
    background: radial-gradient(
        ellipse at center,
        transparent 50%,
        rgba(0, 0, 0, 0.08) 80%,
        rgba(0, 0, 0, 0.15) 100%
    );
    mix-blend-mode: multiply;
}

/* 胶片颗粒噪点 */
.fragmt-bw-filter::after {
    background-image: url("data:image/svg+xml,...");
    mix-blend-mode: overlay;
    opacity: 0.18;
}
```

### 摇晃检测

使用 `DeviceMotionEvent` API 实现真实的摇晃检测：

```javascript
window.addEventListener('devicemotion', (event) => {
    const accel = event.accelerationIncludingGravity;
    const speed = Math.abs(accel.x) + Math.abs(accel.y) + Math.abs(accel.z);

    if (speed > 15) {  // 摇晃阈值
        developFaster();  // 加速显影
        navigator.vibrate(50);  // 震动反馈
    }
});
```

## 📦 项目结构

```
instax-camera-web/
├── api/
│   ├── generate.js    # Coze API 代理 (Serverless Function)
│   └── health.js      # 健康检查 (Serverless Function)
├── index.html         # 主应用（包含所有 HTML、CSS、JavaScript）
├── server.js          # 本地开发服务器
├── vercel.json        # Vercel 配置
├── package.json       # 项目配置
├── .env.example       # 环境变量示例
├── .gitignore         # Git 忽略文件
├── README.md          # 项目说明
└── VERCEL_DEPLOYMENT.md  # 部署指南
```

## 🔧 环境变量

创建 `.env.local` 文件（不提交到 Git）：

```bash
# Coze API Token (必需)
COZE_API_TOKEN=your_coze_api_token_here

# 服务器端口（可选，默认 3001）
PORT=3001
```

### 获取 Coze API Token

1. 访问 [Coze 平台](https://www.coze.cn/)
2. 创建应用并获取 API Token
3. 将 Token 添加到环境变量或 Vercel 项目设置中

⚠️ **重要**：
- 不要将 `.env` 文件提交到 Git
- 在 Vercel 中设置环境变量时，选择所有环境（Production, Preview, Development）

## 🔧 浏览器兼容性

- ✅ Chrome/Edge 90+
- ✅ Safari 14+
- ✅ Firefox 88+
- ✅ iOS Safari 14+
- ✅ Android Chrome 90+

**必需权限**：
- 📷 摄像头访问权限
- 📱 设备运动权限（可选，用于摇晃检测）

## 🐛 常见问题

### 摄像头无法启动

- 确保使用 HTTPS 或 `localhost`（浏览器安全限制）
- 检查浏览器是否已授权摄像头权限
- 尝试关闭其他使用摄像头的应用

### 摇晃功能不工作

- 确保在支持的设备上使用（iOS 13+ 需要手动授权设备运动权限）
- Android 设备通常默认支持
- 桌面浏览器可以点击照片区域加速

### 照片无法保存

- 照片保存在浏览器内存中，刷新页面后会清空
- 最多保存 50 张照片，超出后自动删除最旧的照片
- 可以下载照片永久保存到本地

## 🎯 未来计划

- [x] 添加 AI 智能图像处理
- [x] 支持 Vercel 一键部署
- [ ] 添加更多滤镜选项
- [ ] 支持自定义相纸边框
- [ ] 添加照片编辑功能
- [ ] 支持导出为 PDF
- [ ] 添加社交分享功能

## 🛠️ 技术栈

- **前端**：HTML5, CSS3, Vanilla JavaScript
- **后端**：Node.js, Express
- **部署**：Vercel (Serverless Functions)
- **API**：Coze AI API
- **样式**：Tailwind CSS

## 🔒 安全性

- ✅ API Token 通过环境变量管理，不暴露到客户端
- ✅ 使用 Serverless Functions 隔离后端逻辑
- ✅ HTTPS 加密传输
- ✅ .env 文件不提交到版本控制

## 📄 许可证

MIT License - 自由使用和修改

## 🙏 致谢

- Fujifilm Instax 相纸规格参考
- Fragment Design 藤原浩联名设计风格灵感
- Tailwind CSS 框架
- Material Symbols 图标库

---

**Enjoy capturing moments! 📸**
