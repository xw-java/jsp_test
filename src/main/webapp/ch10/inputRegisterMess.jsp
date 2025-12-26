<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="userBean" class="com.design.project_design.Register" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>新用户注册</title>
</head>
<body>
<div class="container" style="display: flex; justify-content: center; padding-top: 40px;">
    <div class="card" style="width: 100%; max-width: 500px; padding: 40px;">
        <h2 class="card-title">📝 创建新账号</h2>

        <form action="registerServlet" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label class="form-label">用户名 <span style="color:red">*</span></label>
                <input type="text" class="form-control" name="logname" placeholder="字母、数字或下划线" required>
            </div>

            <div style="display: flex; gap: 20px;">
                <div class="form-group" style="flex:1">
                    <label class="form-label">密码 <span style="color:red">*</span></label>
                    <input type="password" class="form-control" name="password" id="pwd" required>
                </div>
                <div class="form-group" style="flex:1">
                    <label class="form-label">确认密码 <span style="color:red">*</span></label>
                    <input type="password" class="form-control" name="again_password" id="pwd2" required onkeyup="checkPwd()">
                </div>
            </div>
            <div id="pwdMsg" class="error-msg" style="margin-top: -15px; margin-bottom: 15px;">❌ 两次输入的密码不一致</div>

            <div class="form-group">
                <label class="form-label">联系电话</label>
                <input type="text" class="form-control" name="phone">
            </div>

            <div class="form-group">
                <label class="form-label">收货地址</label>
                <input type="text" class="form-control" name="address">
            </div>

            <div class="form-group">
                <label class="form-label">真实姓名</label>
                <input type="text" class="form-control" name="realname">
            </div>

            <button type="submit" class="btn btn-primary btn-block" style="margin-top: 20px;">立即注册</button>
        </form>

        <div style="margin-top: 20px; text-align: center;">
            <jsp:getProperty name="userBean" property="backNews"/>
        </div>
        <div style="margin-top: 10px; text-align: center; font-size: 14px;">
            <a href="login.jsp" style="color: #666;">已有账号？直接登录</a>
        </div>
    </div>
</div>

<script>
    function checkPwd() {
        var p1 = document.getElementById("pwd").value;
        var p2 = document.getElementById("pwd2").value;
        var msg = document.getElementById("pwdMsg");
        if(p1 != p2) {
            msg.style.display = "block";
            return false;
        } else {
            msg.style.display = "none";
            return true;
        }
    }
    function validateForm() { return checkPwd(); }
</script>
<div class="footer"><p>Copyright © 2023 Mobile Shop System.</p></div>
</body>
</html>
