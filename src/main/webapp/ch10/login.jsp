<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="loginBean" class="com.design.project_design.Login" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>登录页面</title>
    <style>
        #tom {
            font-family: 宋体, serif; /* 兜底字体，避免宋体缺失 */
            font-size: 30px;
            color: black;
        }
        /* 补充表单元素样式统一 */
        #tom input {
            font-family: 宋体, serif;
            font-size: 24px;
            color: black;
        }
    </style>
</head>
<body id="tom" background="image/back.jpg">
<div align="center">
    <form action="loginServlet" method="post">
        <table id="tom" border="1">
            <tr>
                <th>登录</th>
            </tr>
            <tr>
                <td>登录名称:<input type="text" id="tom" name="logname"/></td> <!-- 规范属性引号 -->
            </tr>
            <tr>
                <td>输入密码:<input type="password" id="tom" name="password"/></td> <!-- 规范属性引号 -->
            </tr>
            <tr>
                <td align="center">
                    <input type="submit" id="tom" value="提交"/> <!-- 提交按钮放入table，布局更规整 -->
                </td>
            </tr>
        </table>
    </form>
</div>
<div align="center" style="margin-top: 20px;">
    登录反馈信息<br>
    <jsp:getProperty name="loginBean" property="backNews"/>
    <br>登录名称:<br>
    <jsp:getProperty name="loginBean" property="logname"/>
</div>
</body>
</html>
