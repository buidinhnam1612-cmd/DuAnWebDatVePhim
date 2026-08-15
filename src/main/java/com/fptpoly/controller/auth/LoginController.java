package com.fptpoly.controller.auth;

import com.fptpoly.model.Employee;
import com.fptpoly.model.User;
import com.fptpoly.service.EmployeeService;
import com.fptpoly.service.PermissionService;
import com.fptpoly.service.UserService;
import com.fptpoly.validator.UserValidator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

    private EmployeeService employeeService;
    private UserService userService;
    private PermissionService permissionService;

    @Override
    public void init() {
        employeeService = new EmployeeService();
        userService = new UserService();
        permissionService = new PermissionService();
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

        // Execute validation via UserValidator
        Map<String, String> errors = UserValidator.validateLogin(loginInput, password);
        if (!errors.isEmpty()) {
            for (Map.Entry<String, String> entry : errors.entrySet()) {
                request.setAttribute(entry.getKey(), entry.getValue());
            }
            request.setAttribute("loginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        String inputClean = loginInput.trim();

        // =========================================================
        // 1. ĐĂNG NHẬP NHÂN VIÊN / ADMIN
        // =========================================================

        List<Employee> allEmployees = employeeService.getAllEmployees();
        Employee employee = null;

        if (allEmployees != null) {
            for (Employee emp : allEmployees) {
                if (inputClean.equalsIgnoreCase(emp.getTenDangNhap())
                        || inputClean.equalsIgnoreCase(emp.getEmail())) {
                    if (password.equals(emp.getMatKhau())) {
                        employee = emp;
                        break;
                    }
                }
            }
        }

        if (employee == null) {
            employee = employeeService.login(inputClean, password);
        }

        if (employee != null) {
            String trangThai = employee.getTrangThai();

            if ("Khóa".equalsIgnoreCase(trangThai)
                    || "Ngừng làm việc".equalsIgnoreCase(trangThai)) {

                request.setAttribute("error", "Tài khoản của bạn đã bị khóa hoặc ngừng làm việc!");
                request.setAttribute("loginInput", loginInput);
                request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
                return;
            }

            HttpSession session = request.getSession();

            session.setAttribute("employee", employee);
            session.setAttribute("userName", employee.getHoTen());
            session.setAttribute("email", employee.getEmail());
            session.setAttribute("maNhanVien", employee.getMaNhanVien());

            String maVaiTro = employee.getMaVaiTro();

            if ("VT01".equalsIgnoreCase(maVaiTro)) {
                session.setAttribute("role", "ADMIN");
            } else {
                session.setAttribute("role", "EMPLOYEE");
            }

            List<String> permissions = permissionService.getPermissionsByEmployee(employee.getMaNhanVien());
            session.setAttribute("userPermissions", permissions);

            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // =========================================================
        // 2. ĐĂNG NHẬP KHÁCH HÀNG
        // =========================================================

        List<User> matchedUsers = userService.searchUsers(inputClean);
        User userInDb = null;

        if (matchedUsers != null) {
            for (User user : matchedUsers) {
                if (inputClean.equalsIgnoreCase(user.getTenDangNhap())
                        || inputClean.equalsIgnoreCase(user.getEmail())) {

                    userInDb = user;
                    break;
                }
            }
        }

        if (userInDb == null) {
            request.setAttribute("loginInputError", "Tên đăng nhập hoặc Email không tồn tại trong hệ thống!");
            request.setAttribute("loginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        if (!userInDb.getMatKhau().equals(password)) {
            request.setAttribute("passwordError", "Mật khẩu nhập vào không chính xác!");
            request.setAttribute("loginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        if ("Chờ duyệt".equalsIgnoreCase(userInDb.getTrangThai())) {
            request.setAttribute("error", "Tài khoản đang chờ Admin phê duyệt!");
            request.setAttribute("loginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        if ("Khóa".equalsIgnoreCase(userInDb.getTrangThai())) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa! Vui lòng liên hệ hỗ trợ.");
            request.setAttribute("loginInput", loginInput);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        HttpSession session = request.getSession();

        session.setAttribute("user", userInDb);
        session.setAttribute("userName", userInDb.getHoTen());
        session.setAttribute("email", userInDb.getEmail());
        session.setAttribute("maKhachHang", userInDb.getMaKhachHang());

        session.setAttribute("role", "CUSTOMER");

        session.removeAttribute("employee");
        session.removeAttribute("maNhanVien");
        session.removeAttribute("userPermissions");

        response.sendRedirect(request.getContextPath() + "/home");
    }
}