<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.design.project_design.Login" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<jsp:useBean id="loginBean" class="com.design.project_design.Login" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>购物车</title>
</head>
<body>
<div class="container">
    <div class="card">
        <h2 class="card-title">🛒 您的购物车</h2>

        <%
            // 登录检查逻辑保留
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
                String SQL = "SELECT goodsId,goodsName,goodsPrice,goodsAmount FROM shoppingForm where logname = '" + loginBean.getLogname() + "'";
                ResultSet rs = sql.executeQuery(SQL);
        %>

        <table class="table">
            <thead>
            <tr>
                <th>ID</th>
                <th>商品名称</th>
                <th>单价</th>
                <th>数量</th>
                <th>修改数量</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasItems = false;
                float totalPrice = 0;
                while (rs.next()) {
                    hasItems = true;
                    String goodsId = rs.getString(1);
                    String name = rs.getString(2);
                    float price = rs.getFloat(3);
                    int amount = rs.getInt(4);
                    totalPrice += price * amount;
            %>
            <tr>
                <td><%=goodsId%></td>
                <td><b><%=name%></b></td>
                <td style="color:#f50;">¥ <%=price%></td>
                <td><%=amount%></td>
                <td>
                    <form action="updateServlet" method="post" style="display:flex; gap:5px;">
                        <input type="hidden" name="goodsId" value="<%=goodsId%>">
                        <input type="text" name="update" value="<%=amount%>" size="2" style="text-align:center; border:1px solid #ddd; padding:4px;">
                        <input type="submit" value="更新" class="btn btn-outline" style="padding:2px 8px; font-size:12px;">
                    </form>
                </td>
                <td>
                    <form action="deleteServlet" method="post">
                        <input type="hidden" name="goodsId" value="<%=goodsId%>">
                        <input type="submit" value="删除" class="btn btn-danger" style="padding:5px 10px; font-size:12px;">
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <% if(!hasItems) { %>
        <div style="text-align: center; padding: 50px; color: #999;">
            <h3>购物车空空如也 🍃</h3>
            <a href="lookMobile.jsp" class="btn btn-primary" style="margin-top: 20px;">去逛逛</a>
        </div>
        <% } else { %>
        <div style="margin-top: 30px; text-align: right; border-top: 1px solid #eee; padding-top: 20px;">
            <div style="font-size: 20px; margin-bottom: 20px;">总金额: <b style="color: #f50; font-size: 28px;">¥ <%=totalPrice%></b></div>
            <a href="lookMobile.jsp" class="btn btn-outline" style="margin-right: 10px;">继续购物</a>
            <form action="buyServlet" method="post" style="display: inline;">
                <input type="hidden" name="logname" value="<%=loginBean.getLogname()%>">
                <input type="submit" value="立即结算 / 生成订单" class="btn btn-primary" style="padding: 10px 30px;">
            </form>
        </div>
        <% }
            con.close();
        } catch(Exception e) { out.print(e); }
        finally { try{if(con!=null)con.close();}catch(Exception e){} }
        %>
    </div>
</div>
</body>
</html>
