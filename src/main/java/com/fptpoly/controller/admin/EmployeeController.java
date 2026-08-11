package com.fptpoly.controller.admin;

import com.fptpoly.model.Employee;
import com.fptpoly.model.EmployeePermission;
import com.fptpoly.model.Permission;
import com.fptpoly.service.EmployeeService;
import com.fptpoly.service.PermissionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "EmployeeController", urlPatterns = {"/admin/employee", "/admin/employee/permission"})
public class EmployeeController extends HttpServlet {

    private EmployeeService employeeService;
    private PermissionService permissionService;

    @Override
    public void init() {
        employeeService = new EmployeeService();
        permissionService = new PermissionService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String uri = request.getRequestURI();

        // Xử lý riêng cho URL /admin/employee/permission
        if (uri != null && uri.endsWith("/permission")) {
            String maNhanVien = request.getParameter("maNhanVien");
            if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
                maNhanVien = request.getParameter("selectedMaNhanVien");
            }
            if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
                maNhanVien = request.getParameter("editPermission");
            }

            if (maNhanVien != null && !maNhanVien.trim().isEmpty()) {
                Employee emp = employeeService.getEmployeeById(maNhanVien.trim());
                if (emp != null) {
                    List<EmployeePermission> employeePermissions = permissionService.getEmployeePermissions(maNhanVien.trim());
                    request.setAttribute("employee", emp);
                    request.setAttribute("employeePermissions", employeePermissions);
                    request.getRequestDispatcher("/views/admin/employee-permission.jsp").forward(request, response);
                    return;
                }
            }

            request.getSession().setAttribute("error", "Nhân viên không tồn tại!");
            response.sendRedirect(request.getContextPath() + "/admin/employee");
            return;
        }

        // Xử lý cho URL /admin/employee (Danh sách nhân viên)
        String action = request.getParameter("action");
        List<Employee> employeeList;

        if ("search".equals(action)) {
            String keyword = request.getParameter("keyword");
            employeeList = employeeService.searchEmployees(keyword);
        } else {
            employeeList = employeeService.getAllEmployees();
        }

        request.setAttribute("employeeList", employeeList);

        List<Permission> allPermissions = permissionService.getAllPermissions();
        request.setAttribute("allPermissions", allPermissions);

        request.getRequestDispatcher("/views/admin/employee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String uri = request.getRequestURI();
        String action = request.getParameter("action");

        // Xử lý Bật/Tắt quyền (POST từ trang permission hoặc action togglePermission)
        if ((uri != null && uri.endsWith("/permission")) || "togglePermission".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String maQuyen = request.getParameter("maQuyen");
            String trangThaiStr = request.getParameter("trangThai");

            if (maNhanVien == null || maNhanVien.trim().isEmpty() || maQuyen == null || maQuyen.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/employee");
                return;
            }

            int trangThai = 0;
            try {
                trangThai = Integer.parseInt(trangThaiStr);
            } catch (Exception ignored) {}

            boolean result = permissionService.togglePermission(maNhanVien.trim(), maQuyen.trim(), trangThai);

            if (result) {
                String statusText = (trangThai == 1) ? "BẬT" : "TẮT";
                request.getSession().setAttribute("success",
                        "Cập nhật trạng thái quyền " + maQuyen + " sang [" + statusText + "] cho nhân viên " + maNhanVien + " thành công!");
            } else {
                request.getSession().setAttribute("error", "Cập nhật quyền thất bại!");
            }

            response.sendRedirect(request.getContextPath() + "/admin/employee/permission?maNhanVien=" + maNhanVien.trim());
            return;
        }

        // Xử lý Thêm mới Nhân viên
        if ("create".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String maVaiTro = request.getParameter("maVaiTro");
            String tenDangNhap = request.getParameter("tenDangNhap");
            String matKhau = request.getParameter("matKhau");
            String hoTen = request.getParameter("hoTen");
            String email = request.getParameter("email");
            String soDienThoai = request.getParameter("soDienThoai");
            String gioiTinh = request.getParameter("gioiTinh");

            if (employeeService.existsEmployee(maNhanVien)) {
                request.getSession().setAttribute("error", "Mã nhân viên đã tồn tại!");
                response.sendRedirect(request.getContextPath() + "/admin/employee");
                return;
            }

            Employee e = new Employee();
            e.setMaNhanVien(maNhanVien);
            e.setMaVaiTro(maVaiTro);
            e.setTenDangNhap(tenDangNhap);
            e.setMatKhau(matKhau);
            e.setHoTen(hoTen);
            e.setEmail(email);
            e.setSoDienThoai(soDienThoai);
            e.setGioiTinh(gioiTinh);
            e.setTrangThai("Hoạt động");

            boolean result = employeeService.createEmployee(e);

            if (result) {
                request.getSession().setAttribute("success", "Thêm tài khoản thành công!");
            } else {
                request.getSession().setAttribute("error", "Thêm tài khoản thất bại!");
            }
        }

        // Xử lý Cập nhật vai trò
        if ("updateRole".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String maVaiTro = request.getParameter("maVaiTro");
            employeeService.updateRole(maNhanVien, maVaiTro);
            request.getSession().setAttribute("success", "Cập nhật vai trò thành công!");
        }

        // Xử lý Cập nhật trạng thái
        if ("updateStatus".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String trangThai = request.getParameter("trangThai");
            employeeService.updateStatus(maNhanVien, trangThai);
            request.getSession().setAttribute("success", "Cập nhật trạng thái thành công!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/employee");
    }
}