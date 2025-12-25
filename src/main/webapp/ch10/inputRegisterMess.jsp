<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="userBean" class="com.design.project_design.Register" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>用户注册</title>
</head>
<body>
<div class="container" style="max-width: 600px;">
    <div class="card">
        <h2 class="card-title">📝 新用户注册</h2>

        <form action="registerServlet" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label class="form-label">* 用户名 (字母/数字/下划线)</label>
                <input type="text" class="form-control" name="logname" required>
            </div>

            <div class="form-group">
                <label class="form-label">* 密码</label>
                <input type="password" class="form-control" name="password" id="pwd" required>
            </div>

            <div class="form-group">
                <label class="form-label">* 确认密码</label>
                <input type="password" class="form-control" name="again_password" id="pwd2" required onkeyup="checkPwd()">
                <div id="pwdMsg" class="error-msg">❌ 两次输入的密码不一致</div>
            </div>

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

            <button type="submit" class="btn btn-primary btn-block">立即注册</button>
        </form>

        <div style="margin-top: 20px; color: var(--danger-color); text-align: center;">
            <jsp:getProperty name="userBean" property="backNews"/>
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

    function validateForm() {
        return checkPwd();
    }
</script>
</body>
</html>
