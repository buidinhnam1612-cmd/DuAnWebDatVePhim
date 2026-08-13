package com.fptpoly.controller.auth;

import com.fptpoly.model.Employee;
import com.fptpoly.model.User;
import com.fptpoly.service.EmployeeService;
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
    private UserService userService;

    @Override
    public void init() {
        employeeService = new EmployeeService();
        userService = new UserService();
        // Loại bỏ permissionService cũ do không sử dụng bảng bật/tắt thủ công nữa
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

        String inputClean = loginInput.trim();

        // 🌟 1. SỬA LOGIC: KIỂM TRA ĐĂNG NHẬP NHÂN VIÊN / ADMIN CHÍNH XÁC THEO TÊN HOẶC EMAIL
        List<Employee> allEmployees = employeeService.getAllEmployees();
        Employee employee = null;

        // Vòng lặp quét toàn bộ danh sách nhân sự để tìm người khớp Tên đăng nhập hoặc Email
        if (allEmployees != null && !allEmployees.isEmpty()) {
            for (Employee emp : allEmployees) {
                if (inputClean.equalsIgnoreCase(emp.getTenDangNhap()) || inputClean.equalsIgnoreCase(emp.getEmail())) {
                    // Nếu tìm thấy tài khoản trùng khớp chức danh, đối chiếu tiếp mật khẩu gõ vào
                    if (password.equals(emp.getMatKhau())) {
                        employee = emp;
                        break;
                    }
                }
            }
        }

        // Nếu là tài khoản Demo cứng hệ thống (Bọc kiểm tra dự phòng khi DB trống dữ liệu)
        if (employee == null) {
            employee = employeeService.login(inputClean, password);
        }

        if (employee != null) {
            // Kiểm tra trạng thái tài khoản làm việc
            if ("Khóa".equals(employee.getTrangThai()) || "Ngừng làm việc".equals(employee.getTrangThai())) {
                request.setAttribute("error", "Tài khoản của bạn đã bị khóa hoặc ngừng làm việc!");
                request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();
            session.setAttribute("employee", employee);
            session.setAttribute("userName", employee.getHoTen());
            session.setAttribute("email", employee.getEmail());
            session.setAttribute("maNhanVien", employee.getMaNhanVien());

            // Xác định vai trò nhóm và nạp quyền cố định vào Session chuẩn RBAC khớp 100% dữ liệu SQL
            String maVaiTro = employee.getMaVaiTro();
            List<String> permissions = new ArrayList<>();

            if ("VT01".equals(maVaiTro)) {
                session.setAttribute("role", "ADMIN");
                // Admin sở hữu toàn bộ các quyền từ Q01 đến Q15
                permissions.add("Q01"); permissions.add("Q02"); permissions.add("Q03");
                permissions.add("Q04"); permissions.add("Q05"); permissions.add("Q06");
                permissions.add("Q07"); permissions.add("Q08"); permissions.add("Q09");
                permissions.add("Q10"); permissions.add("Q11"); permissions.add("Q12");
                permissions.add("Q13"); permissions.add("Q14"); permissions.add("Q15");
            }
            else if ("VT02".equals(maVaiTro)) {
                session.setAttribute("role", "EMPLOYEE");
                // Bổ sung đầy đủ quyền nghiệp vụ cho Nhân viên bán vé (Phan Minh Tuấn)
                permissions.add("Q01"); // Xem Dashboard ca trực
                permissions.add("Q02"); // Quản lý danh sách đặt vé
                permissions.add("Q03"); // Bán vé trực tiếp / Xác nhận trạng thái vé (Check-in)
                permissions.add("Q07"); // Tra cứu lịch chiếu / Suất chiếu
                permissions.add("Q12"); // Áp dụng mã voucher tại quầy
            }
            else if ("VT04".equals(maVaiTro)) {
                session.setAttribute("role", "EMPLOYEE");
                permissions.add("Q01"); // Xem Dashboard ca trực F&B
                permissions.add("Q11"); // Quản lý danh mục đồ ăn đồ uống
            }

            session.setAttribute("userPermissions", permissions);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // 2. PHẦN KIỂM TRA ĐĂNG NHẬP KHÁCH HÀNG (Giữ nguyên logic hoạt động gốc rất tốt của bạn)
        List<User> matchedUsers = userService.searchUsers(inputClean);
        User userInDb = null;

        if (matchedUsers != null && !matchedUsers.isEmpty()) {
            for (User u : matchedUsers) {
                if (inputClean.equalsIgnoreCase(u.getTenDangNhap()) || inputClean.equalsIgnoreCase(u.getEmail())) {
                    userInDb = u;
                    break;
                }
            }
        }

        if (userInDb == null) {
            request.setAttribute("emailError", "Tên đăng nhập hoặc Email này không tồn tại!");
            request.setAttribute("oldLoginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        if (!userInDb.getMatKhau().equals(password)) {
            request.setAttribute("passwordError", "Mật khẩu nhập vào không chính xác!");
            request.setAttribute("oldLoginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        if ("Chờ duyệt".equalsIgnoreCase(userInDb.getTrangThai())) {
            request.setAttribute("error", "Tài khoản đang chờ Admin phê duyệt!");
            request.setAttribute("oldLoginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        if ("Khóa".equals(userInDb.getTrangThai())) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ hỗ trợ.");
            request.setAttribute("oldLoginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", userInDb);
        session.setAttribute("userName", userInDb.getHoTen());
        session.setAttribute("email", userInDb.getEmail());
        session.setAttribute("maKhachHang", userInDb.getMaKhachHang());
        session.setAttribute("role", "CUSTOMER");

        response.sendRedirect(request.getContextPath() + "/home");
    }
}
