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
import java.util.ArrayList;
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String loginInput = request.getParameter("loginInput");
        String password = request.getParameter("password");

        if (loginInput == null || loginInput.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin đăng nhập!");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        // 1. Kiểm tra đăng nhập Nhân viên / Admin từ bảng NHAN_VIEN
        Employee employee = employeeService.login(loginInput.trim(), password);

        if (employee != null) {

            // Kiểm tra trạng thái tài khoản
            if ("Khóa".equals(employee.getTrangThai())) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ quản trị viên.");
                request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();

            session.setAttribute("employee", employee);
            session.setAttribute("userName", employee.getHoTen());
            session.setAttribute("email", employee.getEmail());
            session.setAttribute("maNhanVien", employee.getMaNhanVien());

            // Xác định vai trò và nạp quyền vào Session
            String maVaiTro = employee.getMaVaiTro();

            if ("VT01".equals(maVaiTro)) {
                // ADMIN - Toàn quyền (Nạp danh sách rỗng thay vì null để Filter không bị crash)
                session.setAttribute("role", "ADMIN");
                List<String> adminPermissions = new ArrayList<>();
                // Tự động add full quyền thử nghiệm cho admin nếu Filter check bằng mã Q
                for (int i = 1; i <= 15; i++) {
                    adminPermissions.add(String.format("Q%02d", i));
                }
                session.setAttribute("userPermissions", adminPermissions);
            } else {
                // NHÂN VIÊN - Lấy danh sách quyền được kích hoạt (TrangThai = 1) từ database
                session.setAttribute("role", "EMPLOYEE");
                List<String> permissions = permissionService.getPermissionsByEmployee(employee.getMaNhanVien());
                session.setAttribute("userPermissions", permissions);
            }

            // Điều hướng vào trang quản trị
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // 2. Kiểm tra đăng nhập Khách hàng từ bảng KHACH_HANG
        User user = userService.login(loginInput.trim(), password);

        if (user != null) {

            // === PHẦN THÊM MỚI CHÍNH XÁC: Kiểm tra chặn trạng thái Chờ duyệt đăng nhập ===
            if ("Chờ duyệt".equalsIgnoreCase(user.getTrangThai())) {
                request.setAttribute("error", "Tài khoản đang chờ Admin phê duyệt!");
                request.setAttribute("oldLoginInput", loginInput); // Gửi lại dữ liệu cũ để hiển thị trên ô nhập của form login.jsp
                request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
                return;
            }

            // Kiểm tra trạng thái tài khoản bị khóa
            if ("Khóa".equals(user.getTrangThai())) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ hỗ trợ.");
                request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
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

        // Đăng nhập thất bại hoàn toàn (Sai thông tin đăng nhập hoặc mật khẩu)
        request.setAttribute("error", "Email/Tên đăng nhập hoặc mật khẩu không đúng!");
        request.setAttribute("oldLoginInput", loginInput); // Đồng bộ giữ lại chữ trên form khi gõ sai tài khoản
        request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
    }
}
