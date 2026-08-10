package com.fptpoly.controller.admin;

import com.fptpoly.model.Employee;
import com.fptpoly.model.Permission;
import com.fptpoly.service.EmployeeService;
import com.fptpoly.service.PermissionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin/employee")
public class EmployeeController extends HttpServlet {

    private EmployeeService employeeService;
    private PermissionService permissionService;

    @Override
    public void init() {
        employeeService = new EmployeeService();
        permissionService = new PermissionService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        List<Employee> employeeList;

        if ("search".equals(action)) {
            String keyword = request.getParameter("keyword");
            employeeList = employeeService.searchEmployees(keyword);
        } else {
            employeeList = employeeService.getAllEmployees();
        }

        request.setAttribute("employeeList", employeeList);

        // Lấy danh sách tất cả quyền trong hệ thống
        List<Permission> allPermissions = permissionService.getAllPermissions();
        request.setAttribute("allPermissions", allPermissions);

        // Nếu đang xem chi tiết / phân quyền cho 1 nhân viên
        String editId = request.getParameter("editPermission");
        if (editId != null && !editId.trim().isEmpty()) {
            Employee editEmployee = employeeService.getEmployeeById(editId);
            if (editEmployee != null) {
                List<String> empPermissions =
                        permissionService.getPermissionsByEmployee(editId);
                request.setAttribute("editEmployee", editEmployee);
                request.setAttribute("empPermissions", empPermissions);
            }
        }

        request.getRequestDispatcher("/views/admin/employee.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("create".equals(action)) {

            String maNhanVien = request.getParameter("maNhanVien");
            String maVaiTro = request.getParameter("maVaiTro");
            String tenDangNhap = request.getParameter("tenDangNhap");
            String matKhau = request.getParameter("matKhau");
            String hoTen = request.getParameter("hoTen");
            String email = request.getParameter("email");
            String soDienThoai = request.getParameter("soDienThoai");
            String gioiTinh = request.getParameter("gioiTinh");

            // Kiểm tra mã nhân viên đã tồn tại
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

        if ("updateRole".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String maVaiTro = request.getParameter("maVaiTro");
            employeeService.updateRole(maNhanVien, maVaiTro);
            request.getSession().setAttribute("success", "Cập nhật vai trò thành công!");
        }

        if ("updateStatus".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String trangThai = request.getParameter("trangThai");
            employeeService.updateStatus(maNhanVien, trangThai);
            request.getSession().setAttribute("success", "Cập nhật trạng thái thành công!");
        }

        if ("updatePermissions".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String[] selectedPermissions = request.getParameterValues("permissions");

            List<String> permList = new ArrayList<>();
            if (selectedPermissions != null) {
                for (String p : selectedPermissions) {
                    permList.add(p);
                }
            }

            boolean result = permissionService.updateEmployeePermissions(maNhanVien, permList);

            if (result) {
                request.getSession().setAttribute("success",
                        "Cập nhật quyền cho nhân viên " + maNhanVien + " thành công!");
            } else {
                request.getSession().setAttribute("error",
                        "Cập nhật quyền thất bại!");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/employee");
    }

}