<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>小蜜蜂手机 - 首页</title>
</head>
<body>

<div class="container">
    <jsp:include page="banner.jsp" />

    <div style="display: flex; justify-content: space-between; margin-bottom: 40px; padding: 0 20px;">
        <div style="display:flex; align-items:center; gap:10px;">
            <span style="font-size:24px; color:var(--primary-color);">🚀</span>
            <div><b>极速发货</b><div style="font-size:12px; color:#888;">24小时内发货</div></div>
        </div>
        <div style="display:flex; align-items:center; gap:10px;">
            <span style="font-size:24px; color:var(--primary-color);">🛡️</span>
            <div><b>官方正品</b><div style="font-size:12px; color:#888;">假一赔十保证</div></div>
        </div>
        <div style="display:flex; align-items:center; gap:10px;">
            <span style="font-size:24px; color:var(--primary-color);">💎</span>
            <div><b>售后无忧</b><div style="font-size:12px; color:#888;">7天无理由退换</div></div>
        </div>
        <div style="display:flex; align-items:center; gap:10px;">
            <span style="font-size:24px; color:var(--primary-color);">💳</span>
            <div><b>分期免息</b><div style="font-size:12px; color:#888;">最高24期免息</div></div>
        </div>
    </div>

    <jsp:include page="hotGoods.jsp" />

</div>

<div class="footer">
    <div style="font-weight: bold; font-size: 18px; margin-bottom: 10px;">🐝 小蜜蜂手机商城</div>
    <p>Copyright © 2025 Mobile Shop System. All Rights Reserved.</p>
    <p style="font-size: 12px; opacity: 0.6;">Designed for Java JSP Course</p>
</div>

</body>
</html>
