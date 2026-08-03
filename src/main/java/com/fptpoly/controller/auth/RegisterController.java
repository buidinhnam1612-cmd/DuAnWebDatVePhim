package com.fptpoly.controller.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterController", urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/auth/register.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra mật khẩu
        if (!password.equals(confirmPassword)) {

            request.setAttribute("error",
                    "Mật khẩu xác nhận không khớp!");

            request.getRequestDispatcher("/views/auth/register.jsp")
                    .forward(request, response);

            return;
        }

        // Demo đăng ký thành công
        request.setAttribute("success",
                "Đăng ký thành công! Vui lòng đăng nhập.");

        request.getRequestDispatcher("/views/auth/login.jsp")
                .forward(request, response);

    }

}