package com.fptpoly.controller.admin;

import com.fptpoly.model.Employee;
import com.fptpoly.service.EmployeeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "EmployeeController", urlPatterns = {"/admin/employee"})
public class EmployeeController extends HttpServlet {

    private EmployeeService employeeService;

    @Override
    public void init() {
        employeeService = new EmployeeService();
        // Loại bỏ hoàn toàn permissionService thừa để tránh lỗi gạch đỏ biên dịch
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // CHẶN QUYỀN TRUY CẬP: Chỉ cho tài khoản có quyền Quản lý nhân viên (Q14) đi tiếp
        HttpSession session = request.getSession();
        List<String> permissions = (List<String>) session.getAttribute("userPermissions");
        if (permissions == null || !permissions.contains("Q14")) {
            session.setAttribute("error", "Bạn không có quyền truy cập vào chức năng Quản lý nhân viên!");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // Xử lý hiển thị danh sách nhân viên thông thường
        String action = request.getParameter("action");
        List<Employee> employeeList;

        if ("search".equals(action)) {
            String keyword = request.getParameter("keyword");
            employeeList = employeeService.searchEmployees(keyword);
        } else {
            employeeList = employeeService.getAllEmployees();
        }

        request.setAttribute("employeeList", employeeList);

        // Chuyển hướng dữ liệu tĩnh sang trang hiển thị nhân sự
        request.getRequestDispatcher("/views/admin/employee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // Lấy ID của chính Admin đang thao tác click chuột từ Session ra để đối chiếu
        String adminDangDangNhap = (String) session.getAttribute("maNhanVien");
        List<String> permissions = (List<String>) session.getAttribute("userPermissions");

        // Kiểm tra lại quyền hệ thống Q14 trước khi thực thi xử lý POST dữ liệu
        if (permissions == null || !permissions.contains("Q14")) {
            session.setAttribute("error", "Hành động bị từ chối! Bạn không có quyền quản trị.");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        String action = request.getParameter("action");

        // 🌟 XỬ LÝ THÊM MỚI NHÂN VIÊN (ĐÃ BỎ Ô NHẬP MÃ - backend TỰ ĐỘNG TĂNG)
        if ("create".equals(action)) {
            String maVaiTro = request.getParameter("maVaiTro");
            String tenDangNhap = request.getParameter("tenDangNhap");
            String matKhau = request.getParameter("matKhau");
            String hoTen = request.getParameter("hoTen");
            String email = request.getParameter("email");
            String soDienThoai = request.getParameter("soDienThoai");
            String gioiTinh = request.getParameter("gioiTinh");

            // 🔥 BẢO MẬT: Không cho phép tạo tài khoản có quyền Admin cấp tối cao (VT01) bừa bãi
            if ("VT01".equals(maVaiTro)) {
                session.setAttribute("error", "Bảo mật hệ thống: Bạn không được phép tự tạo thêm tài khoản Quản trị viên!");
                response.sendRedirect(request.getContextPath() + "/admin/employee");
                return;
            }

            // Tạo thực thể nhân viên (maNhanVien không cần gán vì EmployeeRepository sẽ tự tính đếm trong cơ sở dữ liệu)
            Employee e = new Employee();
            e.setMaVaiTro(maVaiTro);
            e.setTenDangNhap(tenDangNhap);
            e.setMatKhau(matKhau);
            e.setHoTen(hoTen);
            e.setEmail(email);
            e.setSoDienThoai(soDienThoai);
            e.setGioiTinh(gioiTinh);
            e.setTrangThai("Đang làm việc"); // Đồng bộ chuỗi trạng thái hoạt động mới

            boolean result = employeeService.createEmployee(e);

            if (result) {
                session.setAttribute("success", "Thêm tài khoản nhân viên mới thành công!");
            } else {
                session.setAttribute("error", "Thêm tài khoản thất bại!");
            }
        }

        // Xử lý Cập nhật chức vụ/vai trò nhóm
        if ("updateRole".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String maVaiTro = request.getParameter("maVaiTro");

            // 🔥 BẢO MẬT 1: Chặn Admin tự hạ cấp chức vụ của chính bản thân mình
            if (adminDangDangNhap != null && adminDangDangNhap.equals(maNhanVien)) {
                session.setAttribute("error", "Bảo mật hệ thống: Bạn không được phép tự hạ cấp chức vụ của chính mình!");
                response.sendRedirect(request.getContextPath() + "/admin/employee");
                return;
            }

            // 🔥 BẢO MẬT 2: Chặn Admin cấp dưới nâng cấp một nhân viên thông thường lên làm Admin tối cao
            if ("VT01".equals(maVaiTro)) {
                session.setAttribute("error", "Bảo mật hệ thống: Bạn không có quyền cấu hình nhân viên khác thành Quản trị viên!");
                response.sendRedirect(request.getContextPath() + "/admin/employee");
                return;
            }

            employeeService.updateRole(maNhanVien, maVaiTro);
            session.setAttribute("success", "Cập nhật chức vụ thành công!");
        }

        // Xử lý Cập nhật trạng thái khóa/mở hoạt động
        if ("updateStatus".equals(action)) {
            String maNhanVien = request.getParameter("maNhanVien");
            String trangThai = request.getParameter("trangThai");

            // 🔥 BẢO MẬT: Chặn Admin tự khóa tài khoản hoặc tự chuyển mình thành "Khóa/Ngừng làm việc"
            if (adminDangDangNhap != null && adminDangDangNhap.equals(maNhanVien)) {
                // Đồng bộ từ khóa so sánh chuỗi theo đúng lựa chọn select option tĩnh ở giao diện JSP
                if ("Khóa".equalsIgnoreCase(trangThai) || "Ngừng làm việc".equalsIgnoreCase(trangThai)) {
                    session.setAttribute("error", "Bảo mật hệ thống: Bạn không được phép tự khóa tài khoản hoạt động của chính mình!");
                    response.sendRedirect(request.getContextPath() + "/admin/employee");
                    return;
                }
            }

            employeeService.updateStatus(maNhanVien, trangThai);
            session.setAttribute("success", "Cập nhật trạng thái nhân sự thành công!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/employee");
    }
}
