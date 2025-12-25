<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.design.project_design.Login" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="java.sql.*" %>
<jsp:useBean id="loginBean" class="com.design.project_design.Login" scope="session"/>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>商品详情</title>
</head>
<body>
<div class="container">
    <%
        // 登录检查逻辑保留
        try {
            loginBean = (Login) session.getAttribute("loginBean");
            if (loginBean == null || loginBean.getLogname() == null || loginBean.getLogname().isEmpty()) {
                response.sendRedirect("login.jsp");
                return;
            }
        } catch (Exception exp) {
            response.sendRedirect("login.jsp");
            return;
        }

        String mobileID = request.getParameter("mobileID");
        if (mobileID == null) { out.print("无效的商品ID"); return; }

        Connection con = null;
        try {
            Context context = new InitialContext();
            Context contextNeeded = (Context) context.lookup("java:comp/env");
            DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
            con = ds.getConnection();
            Statement sql = con.createStatement();
            ResultSet rs = sql.executeQuery("SELECT * FROM mobileForm where mobile_version = '" + mobileID + "'");

            if (rs.next()) {
                String name = rs.getString(2);
                String maker = rs.getString(3);
                float price = rs.getFloat(4);
                String msg = rs.getString(5);
                String pic = rs.getString(6);
    %>
    <div class="card">
        <div style="display: flex; gap: 40px; flex-wrap: wrap;">
            <div style="flex: 1; min-width: 300px; display: flex; justify-content: center; align-items: center; background: #f9f9f9; border-radius: 10px; height: 400px;">
                <img src="image/<%=pic%>" onerror="this.src='image/default.png'" style="max-width: 90%; max-height: 90%; object-fit: contain;">
            </div>
            <div style="flex: 1; min-width: 300px;">
                <h2 style="font-size: 28px; margin-bottom: 10px;"><%=name%></h2>
                <div style="color: #666; margin-bottom: 20px;">
                    <span>产品编号: <%=mobileID%></span> |
                    <span>制造商: <%=maker%></span>
                </div>
                <div style="font-size: 32px; color: #f50; font-weight: bold; margin-bottom: 30px;">
                    ¥ <%=price%>
                </div>

                <div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin-bottom: 30px;">
                    <h4 style="margin-top: 0;">📋 商品简介</h4>
                    <p style="color: #555; line-height: 1.8;"><%=msg%></p>
                </div>

                <div style="display: flex; gap: 20px;">
                    <a href="putGoodsServlet?mobileID=<%=mobileID%>" class="btn btn-primary btn-block" style="padding: 15px;">立即购买 / 加入购物车</a>
                    <a href="javascript:history.back()" class="btn btn-outline" style="padding: 15px 30px;">返回</a>
                </div>
            </div>
        </div>
    </div>
    <%
            }
            con.close();
        } catch (Exception e) { out.print(e); }
        finally { try{if(con!=null)con.close();}catch(Exception e){} }
    %>
</div>
</body>
</html>
