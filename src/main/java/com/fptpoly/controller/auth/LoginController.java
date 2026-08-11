package com.fptpoly.controller.auth;

import com.fptpoly.model.Employee;
import com.fptpoly.model.User;
import com.fptpoly.service.EmployeeService;
import com.fptpoly.service.PermissionService;
import com.fptpoly.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

    private EmployeeService employeeService;
    private PermissionService permissionService;
    private UserService userService;

    @Override
    public void init() {
        employeeService = new EmployeeService();
        permissionService = new PermissionService();
        userService = new UserService();
    }

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

        String loginInput = request.getParameter("loginInput");
        String password = request.getParameter("password");

        if (loginInput == null || loginInput.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute("error",
                    "Vui lòng nhập đầy đủ thông tin đăng nhập!");

            request.getRequestDispatcher("/views/auth/login.jsp")
                    .forward(request, response);
            return;
        }

        // 1. Kiểm tra đăng nhập Nhân viên / Admin từ bảng NHAN_VIEN
        Employee employee = employeeService.login(loginInput.trim(), password);

        if (employee != null) {

            // Kiểm tra trạng thái tài khoản
            if ("Khóa".equals(employee.getTrangThai())) {
                request.setAttribute("error",
                        "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ quản trị viên.");
                request.getRequestDispatcher("/views/auth/login.jsp")
                        .forward(request, response);
                return;
            }

            HttpSession session = request.getSession();

            session.setAttribute("employee", employee);
            session.setAttribute("userName", employee.getHoTen());
            session.setAttribute("email", employee.getEmail());
            session.setAttribute("maNhanVien", employee.getMaNhanVien());

            // Xác định vai trò
            String maVaiTro = employee.getMaVaiTro();

            if ("VT01".equals(maVaiTro)) {
                // ADMIN - Toàn quyền
                session.setAttribute("role", "ADMIN");
                session.setAttribute("userPermissions", null);
            } else {
                // NHÂN VIÊN - Lấy danh sách quyền được cấp
                session.setAttribute("role", "EMPLOYEE");
                List<String> permissions =
                        permissionService.getPermissionsByEmployee(
                                employee.getMaNhanVien()
                        );
                session.setAttribute("userPermissions", permissions);
            }

            // Cả Admin và Nhân viên đều vào cùng /admin/dashboard
            response.sendRedirect(
                    request.getContextPath() + "/admin/dashboard"
            );
            return;
        }

        // 2. Kiểm tra đăng nhập Khách hàng từ bảng KHACH_HANG
        User user = userService.login(email.trim(), password);

        if (user != null) {

            // Kiểm tra trạng thái tài khoản
            if ("Khóa".equals(user.getTrangThai())) {
                request.setAttribute("error",
                        "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ hỗ trợ.");
                request.getRequestDispatcher("/views/auth/login.jsp")
                        .forward(request, response);
                return;
            }

            HttpSession session = request.getSession();

            session.setAttribute("user", user);
            session.setAttribute("userName", user.getHoTen());
            session.setAttribute("email", user.getEmail());
            session.setAttribute("maKhachHang", user.getMaKhachHang());
            session.setAttribute("role", "CUSTOMER");

            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        // Đăng nhập thất bại
        request.setAttribute("error",
                "Email/Tên đăng nhập hoặc mật khẩu không đúng!");

        request.getRequestDispatcher("/views/auth/login.jsp")
                .forward(request, response);

    }
}