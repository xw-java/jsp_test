<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="loginBean" class="com.design.project_design.Login" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>会员登录</title>
</head>
<body>
<div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 80vh;">
    <div class="card" style="width: 100%; max-width: 400px; padding: 50px 40px;">
        <div style="text-align: center; margin-bottom: 30px;">
            <div style="font-size: 40px; margin-bottom: 10px;">👋</div>
            <h2 style="margin: 0; color: var(--text-main);">欢迎回来</h2>
            <p style="color: #999; font-size: 14px;">请登录您的小蜜蜂账号</p>
        </div>

        <form action="loginServlet" method="post">
            <div class="form-group">
                <label class="form-label">账号</label>
                <input type="text" class="form-control" name="logname" placeholder="请输入用户名" required style="background: #f9f9f9;">
            </div>
            <div class="form-group">
                <label class="form-label">密码</label>
                <input type="password" class="form-control" name="password" placeholder="••••••" required style="background: #f9f9f9;">
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="padding: 12px; margin-top: 30px; border-radius: 8px;">立即登录</button>
        </form>

        <div style="margin-top: 25px; text-align: center; font-size: 14px;">
            <span style="color: #999;">还没有账号？</span>
            <a href="inputRegisterMess.jsp" style="color: var(--primary-color); font-weight: bold; text-decoration: none;">去注册</a>
        </div>

        <% if(loginBean.getBackNews() != null && !loginBean.getBackNews().contains("未登录")) { %>
        <div class="alert alert-warning" style="margin-top: 20px; text-align: center; font-size: 13px;">
            <jsp:getProperty name="loginBean" property="backNews"/>
        </div>
        <% } %>
    </div>
</div>
<div class="footer"><p>Copyright © 2023 Mobile Shop System.</p></div>
</body>
</html>
