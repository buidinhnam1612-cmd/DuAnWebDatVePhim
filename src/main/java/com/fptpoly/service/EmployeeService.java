package com.fptpoly.service;

import com.fptpoly.model.Employee;
import com.fptpoly.repository.EmployeeRepository;

import java.util.List;

public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    public EmployeeService() {
        employeeRepository = new EmployeeRepository();
        // Loại bỏ kết nối tới permissionService cũ do không dùng cơ chế bật/tắt quyền riêng lẻ nữa
    }

    /**
     * Lấy toàn bộ danh sách nhân viên
     */
    public List<Employee> getAllEmployees() {
        return employeeRepository.getAll();
    }

    /**
     * Lấy nhân viên theo mã
     */
    public Employee getEmployeeById(String maNhanVien) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return null;
        }
        return employeeRepository.getById(maNhanVien);
    }

    /**
     * Tìm kiếm nhân viên
     */
    public List<Employee> searchEmployees(String keyword) {
        if (keyword == null) {
            keyword = "";
        }
        return employeeRepository.search(keyword.trim());
    }

    /**
     * Đăng nhập Nhân viên / Admin
     */
    public Employee login(String loginInput, String password) {
        if (loginInput == null || password == null) {
            return null;
        }

        String input = loginInput.trim();
        Employee emp = employeeRepository.findByLoginInputAndPassword(input, password);

        if (emp != null) {
            return emp;
        }

        // Tài khoản Gốc Test Hệ thống - Admin mẫu
        if (("admin@gmail.com".equalsIgnoreCase(input) || "admin".equalsIgnoreCase(input))
                && "123456".equals(password)) {

            Employee admin = new Employee();
            admin.setMaNhanVien("NV01"); // Đổi về mã trùng khớp dữ liệu gốc của bạn
            admin.setTenDangNhap("admin01");
            admin.setHoTen("Nguyễn Văn Toàn");
            admin.setEmail("toannv@cinema.com");
            admin.setMaVaiTro("VT01");
            admin.setChucVu("Quản lý rạp");
            admin.setTenVaiTro("Quản trị viên"); // Tên hiển thị đồng bộ giao diện
            admin.setTrangThai("Đang làm việc");

            return admin;
        }

        // Tài khoản Gốc Test Hệ thống - Nhân viên mẫu
        if (("nhanvien@gmail.com".equalsIgnoreCase(input) || "nv01".equalsIgnoreCase(input))
                && "123456".equals(password)) {

            Employee staff = new Employee();
            staff.setMaNhanVien("NV02");
            staff.setTenDangNhap("nhanvien01");
            staff.setHoTen("Trần Thị Thảo");
            staff.setEmail("thaott@cinema.com");
            staff.setMaVaiTro("VT02");
            staff.setChucVu("Thu ngân bán vé");
            staff.setTenVaiTro("Nhân viên bán vé"); // Tên hiển thị đồng bộ giao diện
            staff.setTrangThai("Đang làm việc");

            return staff;
        }

        return null;
    }

    /**
     * Cập nhật vai trò
     */
    public boolean updateRole(String maNhanVien, String maVaiTro) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return false;
        }
        if (maVaiTro == null || maVaiTro.trim().isEmpty()) {
            return false;
        }
        return employeeRepository.updateRole(maNhanVien, maVaiTro);
    }

    /**
     * Khóa / Mở khóa tài khoản
     */
    public boolean updateStatus(String maNhanVien, String trangThai) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return false;
        }
        if (trangThai == null || trangThai.trim().isEmpty()) {
            return false;
        }
        return employeeRepository.updateStatus(maNhanVien, trangThai);
    }

    /**
     * Thêm tài khoản mới chuẩn RBAC
     * Quyền lợi sẽ tự động áp dụng dựa theo mã vai trò khi nhân viên đăng nhập,
     * không cần tạo dữ liệu mảng quyền phụ thủ công nữa.
     */
    public boolean createEmployee(Employee e) {
        if (e == null || e.getMaNhanVien() == null || e.getMaNhanVien().trim().isEmpty()) {
            return false;
        }

        // Chỉ chạy lệnh thêm tài khoản vào cơ sở dữ liệu gốc
        return employeeRepository.insert(e);
    }

    /**
     * Kiểm tra trùng mã nhân viên
     */
    public boolean existsEmployee(String maNhanVien) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return false;
        }
        return employeeRepository.existsById(maNhanVien);
    }
}
