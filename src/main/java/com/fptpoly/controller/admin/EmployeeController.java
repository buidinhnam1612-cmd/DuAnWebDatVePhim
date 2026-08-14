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

@WebServlet(
        name = "EmployeeController",
        urlPatterns = {
                "/admin/employee",
                "/admin/employee/permission"
        }
)
public class EmployeeController extends HttpServlet {

    private EmployeeService employeeService;
    private PermissionService permissionService;

    @Override
    public void init() {
        employeeService = new EmployeeService();
        permissionService = new PermissionService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        List<String> permissions =
                (List<String>) session.getAttribute("userPermissions");

        String uri = request.getRequestURI();

        /*
         * ==========================================
         * PHÂN QUYỀN NHÂN VIÊN
         * Q15 = Phân quyền nhân viên
         * ==========================================
         */
        if (uri != null && uri.endsWith("/permission")) {

            if (permissions == null || !permissions.contains("Q15")) {
                session.setAttribute(
                        "error",
                        "Bạn không có quyền truy cập chức năng phân quyền nhân viên!"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/dashboard"
                );
                return;
            }

            String maNhanVien =
                    request.getParameter("maNhanVien");

            if (maNhanVien == null
                    || maNhanVien.trim().isEmpty()) {

                maNhanVien =
                        request.getParameter("selectedMaNhanVien");
            }

            if (maNhanVien == null
                    || maNhanVien.trim().isEmpty()) {

                maNhanVien =
                        request.getParameter("editPermission");
            }

            if (maNhanVien == null
                    || maNhanVien.trim().isEmpty()) {

                session.setAttribute(
                        "error",
                        "Vui lòng chọn nhân viên cần phân quyền!"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/employee"
                );
                return;
            }

            maNhanVien = maNhanVien.trim();

            Employee employee =
                    employeeService.getEmployeeById(maNhanVien);

            if (employee == null) {

                session.setAttribute(
                        "error",
                        "Nhân viên không tồn tại!"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/employee"
                );
                return;
            }

            List<EmployeePermission> employeePermissions =
                    permissionService.getEmployeePermissions(
                            maNhanVien
                    );

            request.setAttribute(
                    "employee",
                    employee
            );

            request.setAttribute(
                    "employeePermissions",
                    employeePermissions
            );

            request.getRequestDispatcher(
                    "/views/admin/employee-permission.jsp"
            ).forward(request, response);

            return;
        }

        /*
         * ==========================================
         * QUẢN LÝ NHÂN VIÊN
         * Q14 = Quản lý nhân viên
         * ==========================================
         */
        if (permissions == null
                || !permissions.contains("Q14")) {

            session.setAttribute(
                    "error",
                    "Bạn không có quyền truy cập chức năng Quản lý nhân viên!"
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/dashboard"
            );
            return;
        }

        String action =
                request.getParameter("action");

        List<Employee> employeeList;

        if ("search".equals(action)) {

            String keyword =
                    request.getParameter("keyword");

            employeeList =
                    employeeService.searchEmployees(keyword);

        } else {

            employeeList =
                    employeeService.getAllEmployees();
        }

        request.setAttribute(
                "employeeList",
                employeeList
        );

        List<Permission> allPermissions =
                permissionService.getAllPermissions();

        request.setAttribute(
                "allPermissions",
                allPermissions
        );

        request.getRequestDispatcher(
                "/views/admin/employee.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession();

        List<String> permissions =
                (List<String>) session.getAttribute("userPermissions");

        String uri =
                request.getRequestURI();

        String action =
                request.getParameter("action");

        /*
         * ==========================================
         * BẬT / TẮT QUYỀN
         * ==========================================
         */
        if ((uri != null && uri.endsWith("/permission"))
                || "togglePermission".equals(action)
                || request.getParameter("permissionToggle") != null) {

            if (permissions == null
                    || !permissions.contains("Q15")) {

                session.setAttribute(
                        "error",
                        "Bạn không có quyền phân quyền nhân viên!"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/dashboard"
                );
                return;
            }

            String maNhanVien =
                    request.getParameter("maNhanVien");

            String maQuyen =
                    request.getParameter("maQuyen");

            String trangThaiStr =
                    request.getParameter("trangThai");

            if (maNhanVien == null
                    || maNhanVien.trim().isEmpty()
                    || maQuyen == null
                    || maQuyen.trim().isEmpty()) {

                session.setAttribute(
                        "error",
                        "Dữ liệu phân quyền không hợp lệ!"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/employee"
                );
                return;
            }

            int trangThai;

            try {
                trangThai =
                        Integer.parseInt(trangThaiStr);

            } catch (Exception e) {

                session.setAttribute(
                        "error",
                        "Trạng thái quyền không hợp lệ!"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/employee/permission?maNhanVien="
                                + maNhanVien
                );

                return;
            }

            boolean result =
                    permissionService.togglePermission(
                            maNhanVien.trim(),
                            maQuyen.trim(),
                            trangThai
                    );

            if (result) {

                String statusText =
                        trangThai == 1
                                ? "BẬT"
                                : "TẮT";

                session.setAttribute(
                        "success",
                        "Cập nhật quyền "
                                + maQuyen
                                + " sang ["
                                + statusText
                                + "] thành công!"
                );

            } else {

                session.setAttribute(
                        "error",
                        "Cập nhật quyền thất bại!"
                );
            }

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/employee/permission?maNhanVien="
                            + maNhanVien.trim()
            );

            return;
        }

        /*
         * ==========================================
         * CÁC CHỨC NĂNG QUẢN LÝ NHÂN VIÊN
         * ==========================================
         */
        if (permissions == null
                || !permissions.contains("Q14")) {

            session.setAttribute(
                    "error",
                    "Bạn không có quyền quản lý nhân viên!"
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/dashboard"
            );
            return;
        }

        /*
         * ==========================================
         * THÔNG TIN ADMIN HIỆN TẠI
         * ==========================================
         */
        String adminDangDangNhap =
                (String) session.getAttribute("maNhanVien");

        /*
         * ==========================================
         * THÊM NHÂN VIÊN
         * ==========================================
         */
        if ("create".equals(action)) {

            String maNhanVien =
                    request.getParameter("maNhanVien");

            String maVaiTro =
                    request.getParameter("maVaiTro");

            String tenDangNhap =
                    request.getParameter("tenDangNhap");

            String matKhau =
                    request.getParameter("matKhau");

            String hoTen =
                    request.getParameter("hoTen");

            String email =
                    request.getParameter("email");

            String soDienThoai =
                    request.getParameter("soDienThoai");

            String gioiTinh =
                    request.getParameter("gioiTinh");

            /*
             * Không cho tạo thêm Admin
             */
            if ("VT01".equals(maVaiTro)) {

                session.setAttribute(
                        "error",
                        "Bạn không được phép tạo thêm tài khoản Quản trị viên!"
                );

                response.sendRedirect(
                        request.getContextPath()
                                + "/admin/employee"
                );

                return;
            }

            Employee employee =
                    new Employee();

            employee.setMaNhanVien(maNhanVien);
            employee.setMaVaiTro(maVaiTro);
            employee.setTenDangNhap(tenDangNhap);
            employee.setMatKhau(matKhau);
            employee.setHoTen(hoTen);
            employee.setEmail(email);
            employee.setSoDienThoai(soDienThoai);
            employee.setGioiTinh(gioiTinh);
            employee.setTrangThai("Đang làm việc");

            boolean result =
                    employeeService.createEmployee(employee);

            if (result) {

                session.setAttribute(
                        "success",
                        "Thêm tài khoản nhân viên thành công!"
                );

            } else {

                session.setAttribute(
                        "error",
                        "Thêm tài khoản nhân viên thất bại!"
                );
            }
        }

        /*
         * ==========================================
         * CẬP NHẬT VAI TRÒ
         * ==========================================
         */
        if ("updateRole".equals(action)) {

            String maNhanVien = request.getParameter("maNhanVien");
            String maVaiTro = request.getParameter("maVaiTro");

            // Không cho Admin tự thay đổi chính mình
            String loggedInMaNhanVien =
                    (String) request.getSession().getAttribute("maNhanVien");

            if (loggedInMaNhanVien != null
                    && loggedInMaNhanVien.equals(maNhanVien)) {

                request.getSession().setAttribute(
                        "error",
                        "Bạn không được phép tự thay đổi vai trò của chính mình!"
                );

                response.sendRedirect(
                        request.getContextPath() + "/admin/employee"
                );
                return;
            }

            // Không cho cấp vai trò Admin VT01
            if ("VT01".equals(maVaiTro)) {

                request.getSession().setAttribute(
                        "error",
                        "Bạn không có quyền cấp vai trò Quản trị viên cho nhân viên!"
                );

                response.sendRedirect(
                        request.getContextPath() + "/admin/employee"
                );
                return;
            }

            employeeService.updateRole(maNhanVien, maVaiTro);

            request.getSession().setAttribute(
                    "success",
                    "Cập nhật vai trò thành công!"
            );
        }

        /*
         * ==========================================
         * CẬP NHẬT TRẠNG THÁI
         * ==========================================
         */
        if ("updateStatus".equals(action)) {

            String maNhanVien =
                    request.getParameter("maNhanVien");

            String trangThai =
                    request.getParameter("trangThai");

            /*
             * Không cho tự khóa chính mình
             */
            if (adminDangDangNhap != null
                    && adminDangDangNhap.equals(maNhanVien)) {

                if ("Khóa".equalsIgnoreCase(trangThai)
                        || "Ngừng làm việc"
                        .equalsIgnoreCase(trangThai)) {

                    session.setAttribute(
                            "error",
                            "Bạn không được phép tự khóa tài khoản của chính mình!"
                    );

                    response.sendRedirect(
                            request.getContextPath()
                                    + "/admin/employee"
                    );

                    return;
                }
            }

            employeeService.updateStatus(
                    maNhanVien,
                    trangThai
            );

            session.setAttribute(
                    "success",
                    "Cập nhật trạng thái nhân sự thành công!"
            );
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/employee"
        );
    }
}