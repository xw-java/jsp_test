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
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class HandleRegister extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    public void service(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8"); // 补充响应编码，避免乱码

        Connection con = null;
        PreparedStatement sql = null;
        Register userBean = new Register(); //创建bean
        request.setAttribute("userBean", userBean);
        String logname = request.getParameter("logname").trim();
        String password = request.getParameter("password").trim();
        String again_password = request.getParameter("again_password").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();
        String realname = request.getParameter("realname").trim();
        if (!password.equals(again_password)) {
            userBean.setBackNews("两次密码不同,注册失败");
            RequestDispatcher dispatcher =
                    request.getRequestDispatcher("inputRegisterMess.jsp");
            dispatcher.forward(request, response); //转发
            return;
        }
        boolean isID = true;
        if (logname.isEmpty()) {
            isID = false;
        } else {
            for (int i = 0; i < logname.length(); i++) {
                char c = logname.charAt(i);
                if (!Character.isLetterOrDigit(c) && c != '_')
                    isID = false;
            }
        }
        boolean boo = !logname.isEmpty() && !password.isEmpty() && isID;
        String backNews = "";
        try {
            Context context = new InitialContext();
            Context contextNeeded =
                    (Context) context.lookup("java:comp/env");
            DataSource ds =
                    (DataSource) contextNeeded.lookup("mobileConn"); //获得连接池
            con = ds.getConnection(); //使用连接池中的连接
            String insertCondition = "INSERT INTO user VALUES (?,?,?,?,?)";
            sql = con.prepareStatement(insertCondition);
            if (boo) {
                sql.setString(1, logname);
                password =
                        Encrypt.encrypt(password, "javajsp"); //给用户密码加密
                sql.setString(2, password);
                sql.setString(3, phone);
                sql.setString(4, address);
                sql.setString(5, realname);
                int m = sql.executeUpdate();
                if (m != 0) {
                    backNews = "注册成功";
                    userBean.setBackNews(backNews);
                    userBean.setLogname(logname);
                    userBean.setPhone(phone);
                    userBean.setAddress(address);
                    userBean.setRealname(realname);
                }
            } else {
                backNews = "信息填写不完整或名字中有非法字符";
                userBean.setBackNews(backNews);
            }
            con.close(); //连接返回连接池
        } catch (SQLException exp) {
            backNews = "该会员名已被使用,请您更换名字" + exp;
            userBean.setBackNews(backNews);
        } catch (NamingException exp) {
            backNews = "没有设置连接池" + exp;
            userBean.setBackNews(backNews);
        } finally {
            try {
                con.close();
            } catch (Exception ee) {
            }
        }
        RequestDispatcher dispatcher =
                request.getRequestDispatcher("inputRegisterMess.jsp"); //转发
        dispatcher.forward(request, response);
    }
}
