<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="loginBean" class="com.design.project_design.Login" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>登录</title>
</head>
<body>
<div class="container" style="display: flex; justify-content: center; align-items: center; min-height: 80vh;">
    <div class="card" style="width: 400px; padding: 40px;">
        <h2 style="text-align: center; margin-bottom: 30px; color: var(--primary-color);">👋 欢迎回来</h2>

        <form action="loginServlet" method="post">
            <div class="form-group">
                <label class="form-label">账号</label>
                <input type="text" class="form-control" name="logname" placeholder="请输入用户名" required>
            </div>
            <div class="form-group">
                <label class="form-label">密码</label>
                <input type="password" class="form-control" name="password" placeholder="请输入密码" required>
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="margin-top: 20px;">登录</button>
        </form>

        <div style="margin-top: 20px; text-align: center;">
            <a href="inputRegisterMess.jsp" style="color: var(--primary-color); text-decoration: none;">还没有账号？立即注册</a>
        </div>

        <% if(loginBean.getBackNews() != null && !loginBean.getBackNews().contains("未登录")) { %>
        <div class="alert alert-warning" style="margin-top: 20px; text-align: center;">
            <jsp:getProperty name="loginBean" property="backNews"/>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
