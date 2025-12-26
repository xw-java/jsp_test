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
        // 登录校验
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
        if (mobileID == null) { out.print("<div class='container'><div class='card'>无效的商品ID</div></div>"); return; }

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
        <div style="display: flex; gap: 50px; flex-wrap: wrap;">
            <div style="flex: 1; min-width: 300px; display: flex; justify-content: center; align-items: center; background: #fafafa; border-radius: 20px; padding: 40px; position: relative;">
                <div style="position: absolute; top: 20px; left: 20px; background: var(--secondary-color); color: white; padding: 4px 12px; border-radius: 4px; font-size: 12px; font-weight: bold;">自营</div>
                <img src="image/<%=pic%>" onerror="this.src='image/default.png'" style="max-width: 100%; max-height: 400px; object-fit: contain; filter: drop-shadow(0 15px 30px rgba(0,0,0,0.1)); transition: transform 0.3s;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1.0)'">
            </div>

            <div style="flex: 1; min-width: 300px; display: flex; flex-direction: column; justify-content: center;">
                <div style="margin-bottom: 15px;">
                    <span style="color: #999; font-size: 14px; background: #eee; padding: 2px 8px; border-radius: 4px;">型号: <%=mobileID%></span>
                </div>
                <h1 style="font-size: 36px; margin: 0 0 15px 0; line-height: 1.2; font-weight: 800; color: var(--text-main);"><%=name%></h1>
                <div style="color: #666; margin-bottom: 25px; font-size: 16px;">
                    制造商: <b style="color: var(--primary-color);"><%=maker%></b>
                </div>

                <div style="background: linear-gradient(90deg, #fff5f7 0%, #fff 100%); padding: 25px; border-radius: 12px; margin-bottom: 30px; border: 1px solid #ffeef2; border-left: 4px solid var(--secondary-color);">
                    <div style="font-size: 14px; color: var(--secondary-color); margin-bottom: 5px;">官方活动价</div>
                    <div style="font-size: 48px; color: var(--secondary-color); font-weight: 800; display: flex; align-items: baseline;">
                        <span style="font-size: 24px; margin-right: 5px;">¥</span><%=price%>
                    </div>
                </div>

                <div style="margin-bottom: 40px;">
                    <h4 style="margin: 0 0 10px 0; font-size: 18px; color: var(--text-main);">📋 商品简介</h4>
                    <p style="color: #666; line-height: 1.8; font-size: 15px; text-align: justify;"><%=msg%></p>
                </div>

                <div style="display: flex; gap: 20px;">
                    <a href="putGoodsServlet?mobileID=<%=mobileID%>" class="btn btn-primary" style="flex: 2; padding: 18px; font-size: 18px; display: flex; align-items: center; justify-content: center; gap: 10px;">
                        🛒 立即加入购物车
                    </a>
                    <a href="javascript:history.back()" class="btn btn-outline" style="flex: 1; padding: 18px; font-size: 18px;">返回</a>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="hotGoods.jsp" />

    <%
            }
            con.close();
        } catch (Exception e) { out.print(e); }
        finally { try{if(con!=null)con.close();}catch(Exception e){} }
    %>
</div>
<div class="footer"><p>Copyright © 2025 Mobile Shop System.</p></div>
</body>
</html>
