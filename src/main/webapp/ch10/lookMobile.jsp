<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="head.txt" %>
    <title>选择手机分类</title>
</head>
<body>
<div class="container">
    <div class="card">
        <h2 class="card-title">📱 请选择手机分类</h2>
        <div style="display: flex; gap: 20px; flex-wrap: wrap; margin-top: 30px;">
            <%
                Connection con = null;
                Statement sql;
                ResultSet rs;
                try {
                    Context context = new InitialContext();
                    Context contextNeeded = (Context) context.lookup("java:comp/env");
                    DataSource ds = (DataSource) contextNeeded.lookup("mobileConn");
                    con = ds.getConnection();
                    sql = con.createStatement();
                    rs = sql.executeQuery("SELECT * FROM mobileClassify");

                    while (rs.next()) {
                        int id = rs.getInt(1);
                        String category = rs.getString(2);
            %>
            <form action="queryServlet" method="post" style="flex: 1; min-width: 200px;">
                <input type="hidden" name="fenleiNumber" value="<%=id%>">
                <button type="submit" style="width: 100%; border: 1px solid #ddd; background: white; padding: 40px 20px; border-radius: 10px; cursor: pointer; transition: 0.3s; font-size: 18px; font-weight: bold; color: #555;">
                    <%=category%>
                    <div style="font-size: 14px; font-weight: normal; color: #999; margin-top: 10px;">点击浏览 ></div>
                </button>
            </form>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.print("<div class='alert alert-warning'>无法加载分类数据: " + e + "</div>");
                } finally {
                    try { if(con!=null) con.close(); } catch(Exception e){}
                }
            %>
        </div>
    </div>
</div>
</body>
</html>
