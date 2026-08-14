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

        // 2. PHẦN KIỂM TRA ĐĂNG NHẬP KHÁCH HÀNG (Tách lỗi rõ ràng từng dòng theo yêu cầu)

        // Tìm kiếm xem trong DB có tồn tại khách hàng nào trùng khớp với thông tin nhập vào hay không
        List<User> matchedUsers = userService.searchUsers(loginInput.trim());
        User userInDb = null;

        // Lọc chính xác xem có ông nào khớp hoàn toàn TenDangNhap hoặc Email không
        if (matchedUsers != null && !matchedUsers.isEmpty()) {
            for (User u : matchedUsers) {
                if (loginInput.trim().equalsIgnoreCase(u.getTenDangNhap()) || loginInput.trim().equalsIgnoreCase(u.getEmail())) {
                    userInDb = u;
                    break;
                }
            }
        }

        // Bước 2.1: Nếu KHÔNG tìm thấy bất kỳ tài khoản nào trùng khớp thông tin nhập vào
        if (userInDb == null) {
            request.setAttribute("emailError", "Tên đăng nhập hoặc Email này không tồn tại!");
            request.setAttribute("oldLoginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        // Bước 2.2: Nếu CÓ tài khoản tồn tại -> Tiến hành kiểm tra mật khẩu gõ vào
        if (!userInDb.getMatKhau().equals(password)) {
            request.setAttribute("passwordError", "Mật khẩu nhập vào không chính xác!");
            request.setAttribute("oldLoginInput", loginInput); // Giữ lại chữ ở ô trên để không phải gõ lại
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        // Bước 2.3: Nếu đúng cả tài khoản và pass -> Tiến hành kiểm tra các trạng thái hệ thống

        // Kiểm tra chặn trạng thái Chờ duyệt đăng nhập
        if ("Chờ duyệt".equalsIgnoreCase(userInDb.getTrangThai())) {
            request.setAttribute("error", "Tài khoản đang chờ Admin phê duyệt!");
            request.setAttribute("oldLoginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        // Kiểm tra trạng thái tài khoản bị khóa
        if ("Khóa".equals(userInDb.getTrangThai())) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ hỗ trợ.");
            request.setAttribute("oldLoginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        // Đăng nhập thành công hoàn toàn -> Cấp session và điều hướng về trang chủ công khai
        HttpSession session = request.getSession();
        session.setAttribute("user", userInDb);
        session.setAttribute("userName", userInDb.getHoTen());
        session.setAttribute("email", userInDb.getEmail());
        session.setAttribute("maKhachHang", userInDb.getMaKhachHang());
        session.setAttribute("role", "CUSTOMER");

        response.sendRedirect(request.getContextPath() + "/home");
    }
}
