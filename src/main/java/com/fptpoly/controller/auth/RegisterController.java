package com.fptpoly.controller.auth;

import com.fptpoly.model.User;
import com.fptpoly.service.UserService;
import com.fptpoly.validator.UserValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Map;

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
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Execute validation via UserValidator
        Map<String, String> errors = UserValidator.validateRegister(fullName, username, email, phone, password, confirmPassword);

        // Check if username already exists in system database
        if (!errors.containsKey("usernameError") && username != null && userService.getUserByUsername(username.trim()) != null) {
            errors.put("usernameError", "Tên đăng nhập này đã tồn tại trong hệ thống!");
        }

        // Check if email already exists in system database
        if (!errors.containsKey("emailError") && email != null && userService.getUserByEmail(email.trim()) != null) {
            errors.put("emailError", "Email đăng ký này đã tồn tại trong hệ thống!");
        }

        if (!errors.isEmpty()) {
            for (Map.Entry<String, String> entry : errors.entrySet()) {
                request.setAttribute(entry.getKey(), entry.getValue());
            }
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);

            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setHoTen(fullName.trim());
        user.setTenDangNhap(username.trim());
        user.setEmail(email.trim());
        user.setSoDienThoai(phone.trim());
        user.setMatKhau(password);

        boolean success = userService.register(user);
        if (success) {
            request.setAttribute("success", "Đăng ký thành công! Vui lòng chờ Admin phê duyệt.");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Hệ thống gặp sự cố, đăng ký thất bại!");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
    }
}
