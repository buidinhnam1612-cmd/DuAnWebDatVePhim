package com.fptpoly.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/auth/login.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Demo đăng nhập
        if ("admin@gmail.com".equals(email)
                && "123456".equals(password)) {

            HttpSession session = request.getSession();

            session.setAttribute("userName", "Admin");
            session.setAttribute("email", email);

            response.sendRedirect(request.getContextPath() + "/admin/dashboard");

        } // Demo đăng nhập NHÂN VIÊN
        else if ("nhanvien@gmail.com".equals(email)
                && "123456".equals(password)) {

            HttpSession session = request.getSession();

            session.setAttribute("userName", "Nhân viên");
            session.setAttribute("email", email);
            session.setAttribute("role", "EMPLOYEE");

            response.sendRedirect(
                    request.getContextPath() + "/employee/dashboard"
            );

        }
        else {

            request.setAttribute("error",
                    "Email hoặc mật khẩu không đúng!");

            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);

        }
    }

}