package com.design.project_design;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// 注意：不要改 java.sql.* 或 javax.naming.*，只改 servlet 相关的


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class HandleBuyGoods extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void service(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String logname = request.getParameter("logname");
        Connection con = null;
        PreparedStatement pre = null; //预处理语句
        ResultSet rs;
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try {
            loginBean = (Login) session.getAttribute("loginBean");
            if (loginBean == null) {
                response.sendRedirect("login.jsp"); //重定向到登录页面
                return;
            } else {
                boolean b = loginBean.getLogname() == null ||
                        loginBean.getLogname().isEmpty();
                if (b) {
                    response.sendRedirect("login.jsp"); //重定向到登录页面
                    return;
                }
            }
        } catch (Exception exp) {
            response.sendRedirect("login.jsp"); //重定向到登录页面
            return;
        }
        try {
            Context context = new InitialContext();
            Context contextNeeded = (Context) context.lookup("java:comp/env");
            DataSource ds =
                    (DataSource) contextNeeded.lookup("mobileConn"); //获得连接池
            con = ds.getConnection(); //使用连接池中的连接
            String querySQL =
                    "select * from shoppingForm where logname = ?"; //购物车
            String insertSQL = "insert into orderForm values(?,?,?)"; //订单表
            String deleteSQL = "delete from shoppingForm where logname = ?";
            pre = con.prepareStatement(querySQL);
            pre.setString(1, logname);
            rs = pre.executeQuery(); //查询购物车
            StringBuffer buffer = new StringBuffer();
            float sum = 0;
            boolean canCreateForm = false; //是否可以产生订单
            while (rs.next()) {
                canCreateForm = true;
                String goodsId = rs.getString(1);
                logname = rs.getString(2);
                String goodsName = rs.getString(3);
                float price = rs.getFloat(4);
                int amount = rs.getInt(5);
                sum += price * amount;
                buffer.append("<br>商品id:" + goodsId + ",名称:" + goodsName +
                        "单价" + price + "数量" + amount);
            }
            if (!canCreateForm) {
                response.setContentType("text/html;charset=utf-8");
                PrintWriter out = response.getWriter();
                out.println("<html><body>");
                out.println("<h2>" + logname + "请先选择商品添加到购物车");
                out.println("<br><a href=index.jsp>主页</a></h2>");
                out.println("</body></html>");
                return;
            }
            String strSum = String.format("%10.2f", sum);
            buffer.append("<br>" + logname + "<br>购物车的商品总价:" + strSum);
            pre = con.prepareStatement(insertSQL);
            pre.setInt(1, 0); //订单号会自动增加
            pre.setString(2, logname);
            pre.setString(3, new String(buffer));
            pre.executeUpdate(); //添加到订单表
            pre = con.prepareStatement(deleteSQL);
            pre.setString(1, logname);
            pre.executeUpdate(); //删除logname的购物车中货物
            con.close(); //连接放回连接池
            response.sendRedirect("lookOrderForm.jsp"); //查看订单
        } catch (Exception e) {
            response.getWriter().print("" + e);
        } finally {
            try {
                con.close();
            } catch (Exception ee) {
            }
        }
    }
}
