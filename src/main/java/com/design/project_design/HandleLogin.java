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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class HandleLogin extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        Connection con = null;
        Statement sql;
        String logname = request.getParameter("logname").trim(),
                password = request.getParameter("password").trim();
        password = Encrypt.encrypt(password,"javajsp"); //给用户密码加密
        boolean boo = (logname.length() > 0) && (password.length() > 0);
        try{
            Context context = new InitialContext();
            Context contextNeeded =
                    (Context)context.lookup("java:comp/env");
            DataSource ds =
                    (DataSource)contextNeeded.lookup("mobileConn"); //获得连接池
            con = ds.getConnection(); //使用连接池中的连接
            String condition= "select * from user where logname = '"+
                    logname + "' and password = '"+ password +"'";
            sql = con.createStatement();
            if(boo){
                ResultSet rs = sql.executeQuery(condition);
                boolean m = rs.next();
                if(m){
                    //调用登录成功的方法
                    success(request,response,logname,password);
                    // 【关键修改】登录成功后，直接重定向到首页
                    response.sendRedirect("index.jsp");
                }
                else{
                    String backNews = "您输入的用户名不存在,或密码不匹配";
                    //调用登录失败的方法
                    fail(request,response,logname,backNews);
                }
            }
            else{
                String backNews = "请输入用户名和密码";
                fail(request,response,logname,backNews);
            }
            con.close(); //连接返回连接池
        }
        catch(SQLException exp){
            String backNews = ""+ exp;
            fail(request,response,logname,backNews);
        }
        catch(NamingException exp){
            String backNews = "没有设置连接池"+exp;
            fail(request,response,logname,backNews);
        }
        finally{
            try{
                if(con!=null) con.close();
            }
            catch(Exception ee){}
        }
    }
    public void success(HttpServletRequest request,
                        HttpServletResponse response,
                        String logname,String password) {
        Login loginBean = null;
        HttpSession session = request.getSession(true);
        try{ loginBean = (Login)session.getAttribute("loginBean");
            if(loginBean == null){
                loginBean = new Login(); //创建新的数据模型
                session.setAttribute("loginBean",loginBean);
                loginBean = (Login)session.getAttribute("loginBean");
            }
            String name = loginBean.getLogname();
            if(name.equals(logname)) {
                loginBean.setBackNews(logname + "已经登录了");
                loginBean.setLogname(logname);
            }
            else {
                //数据模型存储新的登录用户
                loginBean.setBackNews(logname + "登录成功");
                loginBean.setLogname(logname);
            }
        }
        catch(Exception ee){
            loginBean = new Login();
            session.setAttribute("loginBean",loginBean);
            loginBean.setBackNews(ee.toString());
            loginBean.setLogname(logname);
        }
    }
    public void fail(HttpServletRequest request,
                     HttpServletResponse response,
                     String logname,String backNews) {
        response.setContentType("text/html;charset=utf-8");
        try {
            PrintWriter out = response.getWriter();
            out.println("<html><head><title>登录失败</title>");
            // 简单美化一下报错页面
            out.println("<style>body{display:flex;justify-content:center;align-items:center;height:100vh;background:#f0f2f5;font-family:sans-serif;}.box{background:white;padding:40px;border-radius:10px;box-shadow:0 4px 10px rgba(0,0,0,0.1);text-align:center;}a{color:#007bff;text-decoration:none;margin:0 10px;}</style>");
            out.println("</head><body>");
            out.println("<div class='box'>");
            out.println("<h2 style='color:#dc3545'>登录失败</h2>");
            out.println("<p>"+ backNews +"</p>");
            out.println("<div style='margin-top:20px;'><a href=login.jsp>返回登录</a> <a href=index.jsp>返回首页</a></div>");
            out.println("</div></body></html>");
        }
        catch(IOException exp){}
    }
}
