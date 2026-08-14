package com.fptpoly.controller.auth;

import com.fptpoly.model.User;
import com.fptpoly.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "RegisterController", urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    private final UserService userService = new UserService();

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

        if (fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || phone == null || phone.isBlank()
                || password == null || password.isBlank()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng ký!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        // === BƯỚC 1: SỬA TẠI ĐÂY - KIỂM TRA TRÙNG EMAIL TRƯỚC ===
        // Nếu email đã tồn tại trong hệ thống, bắn lỗi riêng biệt xuống ngay dưới chân ô nhập Email
        if (userService.getUserByEmail(email.trim()) != null) {
            request.setAttribute("emailError", "Email đăng ký này đã tồn tại trong hệ thống!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        // === BƯỚC 2: SỬA TẠI ĐÂY - KIỂM TRA MẬT KHẨU XÁC NHẬN ===
        // Nếu gõ lại pass bị sai, bắn lỗi riêng biệt xuống dưới ô nhập Xác nhận mật khẩu để người dùng biết gõ lại
        if (!password.equals(confirmPassword)) {
            request.setAttribute("confirmPasswordError", "Mật khẩu xác nhận không trùng khớp!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setHoTen(fullName.trim());
        user.setEmail(email.trim());
        user.setSoDienThoai(phone.trim());
        user.setMatKhau(password);

        boolean success = userService.register(user);
        if (success) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng chờ Admin phê duyệt.");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        } else {
            // Lỗi hệ thống bất ngờ (Ví dụ: mất kết nối cơ sở dữ liệu)
            request.setAttribute("error", "Hệ thống gặp sự cố, đăng ký thất bại!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
    }
}
