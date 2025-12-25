<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="loginBean" class="com.design.project_design.Login" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>我的订单</title>
</head>
<body>
<div class="container">
    <div class="card">
        <h2 class="card-title">📦 我的历史订单</h2>

        <%
            if (loginBean == null || loginBean.getLogname() == null || loginBean.getLogname().isEmpty()) {
                response.sendRedirect("login.jsp");
                return;
            }

            Context context = new InitialContext();
            Context contextNeeded = (Context) context.lookup("java:comp/env");
            DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
            Connection con = null;
            try {
                con = ds.getConnection();
                Statement sql = con.createStatement();
                String SQL = "SELECT * FROM orderForm where logname = '" + loginBean.getLogname() + "'";
                ResultSet rs = sql.executeQuery(SQL);
        %>
        <table class="table">
            <thead>
            <tr>
                <th width="10%">订单号</th>
                <th width="10%">用户</th>
                <th width="80%">订单详情</th>
            </tr>
            </thead>
            <tbody>
            <% while (rs.next()) { %>
            <tr>
                <td><span style="background: #e9ecef; padding: 4px 8px; border-radius: 4px; font-family: monospace;">#<%=rs.getString(1)%></span></td>
                <td><%=rs.getString(2)%></td>
                <td style="font-size: 14px; line-height: 1.8; color: #555;"><%=rs.getString(3)%></td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <div style="margin-top: 30px; text-align: center;">
            <a href="index.jsp" class="btn btn-outline">返回首页</a>
        </div>

        <%
                con.close();
            } catch (Exception e) { out.print(e); }
            finally { try{if(con!=null)con.close();}catch(Exception e){} }
        %>
    </div>
</div>
</body>
</html>
