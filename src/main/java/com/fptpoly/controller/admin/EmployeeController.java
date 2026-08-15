package com.fptpoly.controller.admin;

import com.fptpoly.model.Employee;
import com.fptpoly.model.EmployeePermission;
import com.fptpoly.model.Permission;
import com.fptpoly.service.EmployeeService;
import com.fptpoly.service.PermissionService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
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

        String servletPath = request.getServletPath();

        if ("/admin/employee/permission".equals(servletPath)) {
            handleViewEmployeePermission(request, response);
        } else {
            handleListEmployees(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String servletPath = request.getServletPath();

        if ("/admin/employee/permission".equals(servletPath)) {
            handleTogglePermission(request, response);
        } else {
            handleEmployeeActions(request, response);
        }
    }

    private void handleListEmployees(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String keyword = request.getParameter("keyword");

        List<Employee> employeeList;
        if ("search".equalsIgnoreCase(action) && keyword != null && !keyword.trim().isEmpty()) {
            employeeList = employeeService.searchEmployees(keyword.trim());
        } else {
            employeeList = employeeService.getAllEmployees();
        }

        request.setAttribute("employeeList", employeeList);

        String editMaNV = request.getParameter("editMaNV");
        if (editMaNV != null && !editMaNV.trim().isEmpty()) {
            Employee editEmp = employeeService.getEmployeeById(editMaNV.trim());
            if (editEmp != null) {
                request.setAttribute("editEmployee", editEmp);
                request.setAttribute("empPermissions", permissionService.getPermissionsByEmployee(editEmp.getMaNhanVien()));
                request.setAttribute("allPermissions", permissionService.getAllPermissions());
            }
        }

        request.getRequestDispatcher("/views/admin/employee.jsp").forward(request, response);
    }

    private void handleViewEmployeePermission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String maNhanVien = request.getParameter("maNhanVien");
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/employee");
            return;
        }

        Employee employee = employeeService.getEmployeeById(maNhanVien.trim());
        if (employee == null) {
            request.getSession().setAttribute("error", "Không tìm thấy nhân viên có mã: " + maNhanVien);
            response.sendRedirect(request.getContextPath() + "/admin/employee");
            return;
        }

        List<EmployeePermission> employeePermissions = permissionService.getEmployeePermissions(employee.getMaNhanVien());

        request.setAttribute("employee", employee);
        request.setAttribute("employeePermissions", employeePermissions);

        request.getRequestDispatcher("/views/admin/employee-permission.jsp").forward(request, response);
    }

    private void handleTogglePermission(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String maNhanVien = request.getParameter("maNhanVien");
        String maQuyen = request.getParameter("maQuyen");
        String trangThaiStr = request.getParameter("trangThai");

        if (trangThaiStr == null) {
            trangThaiStr = request.getParameter("permissionToggle");
        }

        if (maNhanVien != null && maQuyen != null && trangThaiStr != null) {
            try {
                int trangThai = Integer.parseInt(trangThaiStr);
                boolean updated = permissionService.togglePermission(maNhanVien.trim(), maQuyen.trim(), trangThai);
                if (updated) {
                    session.setAttribute("success", "Cập nhật quyền " + maQuyen + " thành công!");

                    String loggedInMaNV = (String) session.getAttribute("maNhanVien");
                    if (maNhanVien.trim().equalsIgnoreCase(loggedInMaNV)) {
                        List<String> updatedPermissions = permissionService.getPermissionsByEmployee(loggedInMaNV);
                        session.setAttribute("userPermissions", updatedPermissions);
                    }
                } else {
                    session.setAttribute("error", "Cập nhật quyền thất bại!");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Dữ liệu trạng thái quyền không hợp lệ!");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/employee/permission?maNhanVien=" + maNhanVien);
    }

    private void handleEmployeeActions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if ("create".equalsIgnoreCase(action)) {
            String maNV = request.getParameter("maNhanVien");
            String hoTen = request.getParameter("hoTen");
            String tenDangNhap = request.getParameter("tenDangNhap");
            String email = request.getParameter("email");
            String soDienThoai = request.getParameter("soDienThoai");
            String matKhau = request.getParameter("matKhau");
            String gioiTinh = request.getParameter("gioiTinh");
            String maVaiTro = request.getParameter("maVaiTro");

            if (employeeService.existsEmployee(maNV)) {
                session.setAttribute("error", "Mã nhân viên đã tồn tại!");
            } else {
                Employee newEmp = new Employee();
                newEmp.setMaNhanVien(maNV);
                newEmp.setHoTen(hoTen);
                newEmp.setTenDangNhap(tenDangNhap);
                newEmp.setEmail(email);
                newEmp.setSoDienThoai(soDienThoai);
                newEmp.setMatKhau(matKhau);
                newEmp.setGioiTinh(gioiTinh);
                newEmp.setMaVaiTro(maVaiTro);

                boolean ok = employeeService.createEmployee(newEmp);
                if (ok) {
                    permissionService.initializeDefaultPermissions(maNV, maVaiTro);
                    session.setAttribute("success", "Thêm nhân viên thành công!");
                } else {
                    session.setAttribute("error", "Thêm nhân viên thất bại!");
                }
            }
        } else if ("updateRole".equalsIgnoreCase(action)) {
            String maNV = request.getParameter("maNhanVien");
            String maVaiTro = request.getParameter("maVaiTro");
            boolean ok = employeeService.updateRole(maNV, maVaiTro);
            if (ok) {
                permissionService.initializeDefaultPermissions(maNV, maVaiTro);
                session.setAttribute("success", "Cập nhật vai trò thành công!");
            } else {
                session.setAttribute("error", "Cập nhật vai trò thất bại!");
            }
        } else if ("updateStatus".equalsIgnoreCase(action)) {
            String maNV = request.getParameter("maNhanVien");
            String trangThai = request.getParameter("trangThai");
            boolean ok = employeeService.updateStatus(maNV, trangThai);
            if (ok) {
                session.setAttribute("success", "Cập nhật trạng thái thành công!");
            } else {
                session.setAttribute("error", "Cập nhật trạng thái thất bại!");
            }
        } else if ("updatePermissions".equalsIgnoreCase(action)) {
            String maNV = request.getParameter("maNhanVien");
            String[] permissions = request.getParameterValues("permissions");
            List<String> selectedList = permissions != null ? Arrays.asList(permissions) : List.of();

            boolean ok = permissionService.updateEmployeePermissions(maNV, selectedList);
            if (ok) {
                session.setAttribute("success", "Cập nhật danh sách quyền thành công!");
                String loggedInMaNV = (String) session.getAttribute("maNhanVien");
                if (maNV != null && maNV.trim().equalsIgnoreCase(loggedInMaNV)) {
                    session.setAttribute("userPermissions", selectedList);
                }
            } else {
                session.setAttribute("error", "Cập nhật danh sách quyền thất bại!");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/employee");
    }
}