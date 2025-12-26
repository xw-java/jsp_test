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
        <h2 class="card-title">📦 历史订单</h2>

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
            <tr style="background: #f1f3f5;">
                <th width="15%">订单编号</th>
                <th width="15%">下单用户</th>
                <th width="70%">订单详情</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasOrder = false;
                while (rs.next()) {
                    hasOrder = true;
            %>
            <tr>
                <td style="vertical-align: top;">
                    <div style="background: var(--text-main); color: white; padding: 4px 8px; border-radius: 4px; display: inline-block; font-family: monospace;">#<%=rs.getString(1)%></div>
                </td>
                <td style="vertical-align: top; font-weight: bold;"><%=rs.getString(2)%></td>
                <td>
                    <div style="background: #f9f9f9; padding: 15px; border-radius: 8px; border: 1px solid #eee; font-size: 14px; line-height: 1.8; color: #555;">
                        <%=rs.getString(3)%>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <% if(!hasOrder) { %>
        <div style="text-align: center; padding: 50px; color: #999;">暂无历史订单</div>
        <% } %>

        <div style="margin-top: 30px; text-align: center;">
            <a href="index.jsp" class="btn btn-outline">返回首页</a>
        </div>

        <%
                con.close();
            } catch (Exception e) { out.print(e); }
            finally { try{if(con!=null)con.close();}catch(Exception e){} }
        %>
    </div>

    <jsp:include page="hotGoods.jsp" />
</div>
<div class="footer"><p>Copyright © 2023 Mobile Shop System.</p></div>
</body>
</html>
