// Vercel Serverless Function for Health Check
// 健康检查端点

export default async function handler(req, res) {
  // 只允许 GET 请求
  if (req.method !== 'GET') {
    return res.status(405).json({
      success: false,
      error: 'Method not allowed'
    });
  }

  res.json({
    success: true,
    message: '拍立得相机服务运行中',
    platform: 'Vercel Serverless',
    timestamp: new Date().toISOString()
  });
}
