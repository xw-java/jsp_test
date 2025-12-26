<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>商品搜索</title>
</head>
<body>
<div class="container">
    <div class="card" style="text-align: center; padding: 60px 40px;">
        <h1 style="margin-bottom: 10px; font-weight: 800; color: var(--text-main);">🔍 探索你的下一部手机</h1>
        <p style="color: #666; margin-bottom: 40px;">输入型号、品牌或价格范围，快速找到心仪好物</p>

        <form action="searchByConditionServlet" method="post" id="searchForm">
            <div class="search-hero">
                <div class="search-wrapper">
                    <input type="text" class="search-input" name="searchMess" placeholder="例如：iPhone 15 或 3000-5000" required>
                    <button type="submit" class="search-btn">搜 索</button>
                </div>
            </div>

            <div style="margin-top: 20px; display: flex; justify-content: center; gap: 30px;">
                <label style="cursor: pointer; display: flex; align-items: center; gap: 5px;">
                    <input type="radio" name="radio" value="mobile_name" checked> 按名称
                </label>
                <label style="cursor: pointer; display: flex; align-items: center; gap: 5px;">
                    <input type="radio" name="radio" value="mobile_version"> 按型号
                </label>
                <label style="cursor: pointer; display: flex; align-items: center; gap: 5px;">
                    <input type="radio" name="radio" value="mobile_price"> 按价格范围
                </label>
            </div>
        </form>

        <div style="margin-top: 40px;">
            <p style="font-size: 14px; color: #999; margin-bottom: 15px;">热门搜索：</p>
            <div style="display: flex; justify-content: center; gap: 10px; flex-wrap: wrap;">
                <a href="javascript:quickSearch('Apple')" class="btn btn-outline" style="border-radius: 8px; padding: 5px 15px; font-size: 12px;">🍎 Apple</a>
                <a href="javascript:quickSearch('Huawei')" class="btn btn-outline" style="border-radius: 8px; padding: 5px 15px; font-size: 12px;">🏵️ Huawei</a>
                <a href="javascript:quickSearch('Xiaomi')" class="btn btn-outline" style="border-radius: 8px; padding: 5px 15px; font-size: 12px;">📱 小米</a>
                <a href="javascript:quickSearch('5G')" class="btn btn-outline" style="border-radius: 8px; padding: 5px 15px; font-size: 12px;">📡 5G手机</a>
            </div>
        </div>
    </div>

    <jsp:include page="hotGoods.jsp" />
</div>

<script>
    function quickSearch(val) {
        document.querySelector('input[name="searchMess"]').value = val;
        document.querySelector('input[name="radio"][value="mobile_name"]').checked = true;
        document.getElementById('searchForm').submit();
    }
</script>

<div class="footer">
    <p>Copyright © 2025 Mobile Shop System.</p>
</div>
</body>
</html>
