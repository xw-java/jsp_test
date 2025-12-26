<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="loginBean" class="com.design.project_design.Login" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <%-- 依然引入head.txt以获取基础资源，但我们会用内联样式覆盖布局 --%>
    <%@ include file="head.txt" %>
    <title>会员登录</title>
    <style>
        /* 强制覆盖 body 样式，确保登录页全屏居中且背景美观 */
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* 登录页专用的容器样式 */
        .login-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .login-card {
            background: #ffffff;
            width: 100%;
            max-width: 420px;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease;
        }

        .login-card:hover {
            transform: translateY(-5px);
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h2 {
            font-size: 28px;
            color: #333;
            font-weight: 800;
            margin: 10px 0;
        }

        .login-header p {
            color: #888;
            font-size: 14px;
        }

        /* 美化输入框 */
        .input-group {
            margin-bottom: 20px;
            position: relative;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
            font-size: 14px;
        }

        .custom-input {
            width: 100%;
            padding: 15px;
            border: 2px solid #eee;
            border-radius: 12px;
            background: #f9f9f9;
            font-size: 15px;
            transition: all 0.3s;
            box-sizing: border-box; /* 关键：防止输入框撑破容器 */
        }

        .custom-input:focus {
            background: #fff;
            border-color: var(--primary-color, #007bff);
            box-shadow: 0 0 0 4px rgba(0, 123, 255, 0.1);
            outline: none;
        }

        /* 登录按钮 */
        .login-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(90deg, #007bff, #0056b3);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
            box-shadow: 0 10px 20px rgba(0, 123, 255, 0.2);
        }

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px rgba(0, 123, 255, 0.3);
        }

        /* 底部链接 */
        .footer-links {
            margin-top: 25px;
            text-align: center;
            font-size: 14px;
            color: #666;
        }

        .footer-links a {
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
            margin-left: 5px;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }

        /* 错误提示 */
        .alert-box {
            background: #fff2f2;
            color: #ff4d4f;
            padding: 12px;
            border-radius: 8px;
            font-size: 13px;
            margin-top: 20px;
            text-align: center;
            border: 1px solid #ffccc7;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
    </style>
</head>
<body>

<div class="login-wrapper">
    <div class="login-card">
        <div class="login-header">
            <div style="font-size: 48px; margin-bottom: 10px;">👋</div>
            <h2>欢迎回来</h2>
            <p>请登录您的小蜜蜂账号以继续</p>
        </div>

        <form action="loginServlet" method="post">
            <div class="input-group">
                <label>账号</label>
                <input type="text" class="custom-input" name="logname" placeholder="请输入您的用户名" required autocomplete="off">
            </div>

            <div class="input-group">
                <label>密码</label>
                <input type="password" class="custom-input" name="password" placeholder="请输入您的密码" required>
            </div>

            <button type="submit" class="login-btn">立即登录</button>
        </form>

        <div class="footer-links">
            还没有账号？<a href="inputRegisterMess.jsp">免费注册一个</a>
        </div>

        <% if(loginBean.getBackNews() != null && !loginBean.getBackNews().contains("未登录")) { %>
        <div class="alert-box">
            ⚠️ <jsp:getProperty name="loginBean" property="backNews"/>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
