package com.fptpoly.controller.admin;

import com.fptpoly.model.Employee;
import com.fptpoly.service.EmployeeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/employee")
public class EmployeeController extends HttpServlet {

    private EmployeeService employeeService;

    @Override
    public void init() {
        employeeService = new EmployeeService();
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

        }

        if ("updateStatus".equals(action)) {

            String maNhanVien = request.getParameter("maNhanVien");
            String trangThai = request.getParameter("trangThai");

            employeeService.updateStatus(maNhanVien, trangThai);

        }

        response.sendRedirect(request.getContextPath() + "/admin/employee");

    }

}