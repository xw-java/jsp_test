<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="userBean" class="com.design.project_design.Register" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>新用户注册</title>
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .register-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .register-card {
            background: #ffffff;
            width: 100%;
            max-width: 600px; /* 比登录页宽一点 */
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.08);
        }

        .card-header {
            margin-bottom: 30px;
            text-align: center;
        }
        .card-header h2 {
            margin: 0;
            color: #333;
            font-size: 26px;
        }

        .form-row {
            display: flex;
            gap: 20px; /* 两个输入框之间的间距 */
        }

        .form-col {
            flex: 1;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 600;
            font-size: 14px;
        }

        .input-group label span {
            color: #ff4d4f;
            margin-left: 4px;
        }

        .custom-input {
            width: 100%;
            padding: 14px;
            border: 2px solid #eee;
            border-radius: 10px;
            background: #f9f9f9;
            font-size: 14px;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        .custom-input:focus {
            background: #fff;
            border-color: #28a745; /* 注册页用绿色系代表通过 */
            box-shadow: 0 0 0 4px rgba(40, 167, 69, 0.1);
            outline: none;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(90deg, #28a745, #218838);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
            box-shadow: 0 10px 20px rgba(40, 167, 69, 0.2);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 15px 25px rgba(40, 167, 69, 0.3);
        }

        .error-msg {
            color: #ff4d4f;
            font-size: 12px;
            margin-top: 5px;
            display: none;
            background: #fff1f0;
            padding: 5px 10px;
            border-radius: 4px;
            border: 1px solid #ffccc7;
        }

        .back-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        .back-link a {
            color: #666;
            text-decoration: none;
        }
        .back-link a:hover {
            color: #000;
            text-decoration: underline;
        }

        /* 响应式调整：手机端变成单列 */
        @media (max-width: 600px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>

<div class="register-wrapper">
    <div class="register-card">
        <div class="card-header">
            <h2>🚀 创建新账号</h2>
            <p style="color:#999; font-size:14px; margin-top:5px;">几秒钟即可完成注册</p>
        </div>

        <form action="registerServlet" method="post" onsubmit="return validateForm()">
            <div class="input-group">
                <label>用户名 <span>*</span></label>
                <input type="text" class="custom-input" name="logname" placeholder="字母、数字或下划线" required>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="input-group">
                        <label>密码 <span>*</span></label>
                        <input type="password" class="custom-input" name="password" id="pwd" required>
                    </div>
                </div>
                <div class="form-col">
                    <div class="input-group">
                        <label>确认密码 <span>*</span></label>
                        <input type="password" class="custom-input" name="again_password" id="pwd2" required onkeyup="checkPwd()">
                        <div id="pwdMsg" class="error-msg">❌ 两次输入的密码不一致</div>
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-col">
                    <div class="input-group">
                        <label>真实姓名</label>
                        <input type="text" class="custom-input" name="realname" placeholder="您的称呼">
                    </div>
                </div>
                <div class="form-col">
                    <div class="input-group">
                        <label>联系电话</label>
                        <input type="text" class="custom-input" name="phone" placeholder="11位手机号">
                    </div>
                </div>
            </div>

            <div class="input-group">
                <label>收货地址</label>
                <input type="text" class="custom-input" name="address" placeholder="用于接收快递">
            </div>

            <button type="submit" class="submit-btn">立即注册</button>
        </form>

        <div style="margin-top: 20px; text-align: center;">
            <jsp:getProperty name="userBean" property="backNews"/>
        </div>

        <div class="back-link">
            <a href="login.jsp">已有账号？返回登录</a>
        </div>
    </div>
</div>

<script>
    function checkPwd() {
        var p1 = document.getElementById("pwd").value;
        var p2 = document.getElementById("pwd2").value;
        var msg = document.getElementById("pwdMsg");
        if(p1 && p2 && p1 != p2) {
            msg.style.display = "block";
            return false;
        } else {
            msg.style.display = "none";
            return true;
        }
    }
    function validateForm() {
        return checkPwd();
    }
</script>

</body>
</html>
