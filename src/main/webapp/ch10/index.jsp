<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>小蜜蜂手机 - 首页</title>
    <style>
        .hero-section {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
            border-radius: 0 0 20px 20px;
            margin-bottom: 40px;
        }
        .hero-title { font-size: 48px; margin-bottom: 20px; font-weight: bold; }
        .hero-subtitle { font-size: 20px; margin-bottom: 40px; opacity: 0.9; }
        .feature-box {
            display: flex;
            justify-content: space-around;
            padding: 40px 0;
        }
        .feature-item {
            text-align: center;
            padding: 20px;
        }
        .feature-icon { font-size: 40px; margin-bottom: 15px; color: var(--primary-color); }
    </style>
</head>
<body>

<div class="hero-section">
    <div class="container">
        <h1 class="hero-title">发现科技之美</h1>
        <p class="hero-subtitle">正品保障 · 极速发货 · 售后无忧</p>
        <a href="lookMobile.jsp" class="btn btn-light" style="background: white; color: #007bff; padding: 15px 40px; font-size: 18px; border-radius: 30px;">立即选购</a>
    </div>
</div>

<div class="container">
    <div class="card">
        <div class="feature-box">
            <div class="feature-item">
                <div class="feature-icon">🚀</div>
                <h3>极速配送</h3>
                <p style="color:#666">次日达，风雨无阻</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">🛡️</div>
                <h3>官方正品</h3>
                <p style="color:#666">假一赔十，值得信赖</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">💎</div>
                <h3>优质售后</h3>
                <p style="color:#666">7天无理由退换货</p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
