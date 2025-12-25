<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>商品搜索</title>
</head>
<body>
<div class="container">
    <div class="card" style="max-width: 800px; margin: 0 auto;">
        <h2 class="card-title">🔍 商品高级搜索</h2>

        <form action="searchByConditionServlet" method="post">
            <div class="form-group">
                <label class="form-label">请输入关键词（名称、版本号或价格范围）</label>
                <input type="text" class="form-control" name="searchMess" placeholder="例如：iPhone 或 3000-5000">
            </div>

            <div class="form-group">
                <label class="form-label">搜索类型</label>
                <div style="display: flex; gap: 20px; padding: 10px 0;">
                    <label style="cursor: pointer;">
                        <input type="radio" name="radio" value="mobile_name" checked>
                        按手机名称 (模糊查询)
                    </label>
                    <label style="cursor: pointer;">
                        <input type="radio" name="radio" value="mobile_version">
                        按版本号
                    </label>
                    <label style="cursor: pointer;">
                        <input type="radio" name="radio" value="mobile_price">
                        按价格范围 (格式: min-max)
                    </label>
                </div>
            </div>

            <button type="submit" class="btn btn-primary btn-block">开始搜索</button>
        </form>

        <div class="alert alert-info" style="margin-top: 30px;">
            <strong>💡 提示：</strong><br>
            1. 价格搜索格式为：最低价-最高价（如：1000-3000）<br>
            2. 名称搜索支持模糊匹配，输入"小米"可搜到所有小米手机
        </div>
    </div>
</div>
</body>
</html>
