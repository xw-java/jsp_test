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
    <title>我的购物车</title>
</head>
<body>
<div class="container">
    <div class="card">
        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; padding-bottom: 20px; margin-bottom: 20px;">
            <h2 class="card-title" style="margin-bottom: 0;">🛒 购物车</h2>
            <span style="color: #666; font-size: 14px;">请核对商品信息</span>
        </div>

        <%
            if (loginBean == null || loginBean.getLogname() == null || loginBean.getLogname().isEmpty()) {
        %>
        <div style="text-align: center; padding: 60px;">
            <h3>🔒 请先登录</h3>
            <p>登录后即可查看购物车中的商品</p>
            <a href="login.jsp" class="btn btn-primary" style="margin-top: 15px;">立即登录</a>
        </div>
        <%
                return;
            }

            Context context = new InitialContext();
            Context contextNeeded = (Context) context.lookup("java:comp/env");
            DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
            Connection con = null;
            try {
                con = ds.getConnection();
                Statement sql = con.createStatement();

                // 【技术升级】使用 LEFT JOIN 查出商品图片 (假设 mobile_version 对应 goodsId)
                String SQL = "SELECT s.goodsId, s.goodsName, s.goodsPrice, s.goodsAmount, m.mobile_pic " +
                        "FROM shoppingForm s LEFT JOIN mobileForm m ON s.goodsId = m.mobile_version " +
                        "WHERE s.logname = '" + loginBean.getLogname() + "'";

                ResultSet rs = sql.executeQuery(SQL);
        %>

        <table class="table">
            <thead>
            <tr>
                <th width="40%">商品信息</th>
                <th width="15%">单价</th>
                <th width="20%">数量</th>
                <th width="15%">小计</th>
                <th width="10%">操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasItems = false;
                float totalPrice = 0;
                int totalCount = 0;
                while (rs.next()) {
                    hasItems = true;
                    String goodsId = rs.getString(1);
                    String name = rs.getString(2);
                    float price = rs.getFloat(3);
                    int amount = rs.getInt(4);
                    String pic = rs.getString(5); // 获取图片
                    if(pic == null) pic = "default.png";

                    float subtotal = price * amount;
                    totalPrice += subtotal;
                    totalCount += amount;
            %>
            <tr>
                <td>
                    <div style="display: flex; align-items: center; gap: 15px;">
                        <img src="image/<%=pic%>" onerror="this.src='image/default.png'" style="width: 60px; height: 60px; object-fit: contain; border: 1px solid #eee; border-radius: 8px; padding: 5px;">
                        <div>
                            <div style="font-weight: bold; font-size: 15px;"><%=name%></div>
                            <div style="font-size: 12px; color: #888;">ID: <%=goodsId%></div>
                        </div>
                    </div>
                </td>
                <td style="color: #666;">¥ <%=price%></td>
                <td>
                    <form action="updateServlet" method="post" style="display:flex; gap:5px; align-items: center;">
                        <input type="hidden" name="goodsId" value="<%=goodsId%>">
                        <button type="button" onclick="this.nextElementSibling.stepDown()" style="border:1px solid #ddd; background:#fff; width:25px; height:25px; cursor:pointer;">-</button>
                        <input type="number" name="update" value="<%=amount%>" min="1" max="99" style="width: 40px; text-align:center; border:1px solid #ddd; height:23px;">
                        <button type="button" onclick="this.previousElementSibling.stepUp()" style="border:1px solid #ddd; background:#fff; width:25px; height:25px; cursor:pointer;">+</button>
                        <button type="submit" class="btn btn-outline" style="padding: 2px 8px; font-size: 12px; border-radius: 4px; margin-left: 5px;">保存</button>
                    </form>
                </td>
                <td style="color: var(--secondary-color); font-weight: bold;">¥ <%=String.format("%.2f", subtotal)%></td>
                <td>
                    <form action="deleteServlet" method="post">
                        <input type="hidden" name="goodsId" value="<%=goodsId%>">
                        <button type="submit" style="background: none; border: none; color: #999; cursor: pointer; font-size: 20px;" title="删除">×</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

        <% if(!hasItems) { %>
        <div style="text-align: center; padding: 80px; color: #999;">
            <div style="font-size: 64px; margin-bottom: 20px; opacity: 0.5;">🛒</div>
            <h3>购物车还是空的</h3>
            <p>去看看有什么喜欢的吧</p>
            <a href="lookMobile.jsp" class="btn btn-primary" style="margin-top: 20px;">浏览商品</a>
        </div>
        <% } else { %>
        <div style="margin-top: 30px; display: flex; justify-content: flex-end; align-items: center; border-top: 2px solid #f8f9fa; padding-top: 20px; gap: 30px;">
            <div style="text-align: right;">
                <div style="font-size: 14px; color: #666;">共 <%=totalCount%> 件商品</div>
                <div style="font-size: 14px;">合计: <span style="font-size: 28px; color: var(--secondary-color); font-weight: 800;">¥ <%=String.format("%.2f", totalPrice)%></span></div>
            </div>
            <form action="buyServlet" method="post" style="margin: 0;">
                <input type="hidden" name="logname" value="<%=loginBean.getLogname()%>">
                <button type="submit" class="btn btn-primary" style="padding: 15px 40px; font-size: 18px; border-radius: 50px; box-shadow: 0 5px 15px rgba(247, 37, 133, 0.4); background: var(--secondary-color);">立即结算</button>
            </form>
        </div>
        <% }
            con.close();
        } catch(Exception e) { out.print("<div class='alert alert-warning'>系统错误: " + e.getMessage() + "</div>"); }
        finally { try{if(con!=null)con.close();}catch(Exception e){} }
        %>
    </div>

    <jsp:include page="hotGoods.jsp" />
</div>
<div class="footer"><p>Copyright © 2025 Mobile Shop System.</p></div>
</body>
</html>
