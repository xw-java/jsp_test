package com.design.project_design;

import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class HandleExit  extends HttpServlet {
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    public void service(HttpServletRequest request,
                        HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        session.invalidate(); //销毁用户的session对象
        response.sendRedirect("index.jsp"); //返回主页
    }
}
