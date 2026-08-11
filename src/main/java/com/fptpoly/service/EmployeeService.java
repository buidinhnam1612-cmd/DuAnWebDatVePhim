package com.fptpoly.service;

import com.fptpoly.model.Employee;
import com.fptpoly.repository.EmployeeRepository;
import com.fptpoly.service.PermissionService;

import java.util.List;

public class EmployeeService {

    private final EmployeeRepository employeeRepository;
    private final PermissionService permissionService;

    public EmployeeService() {
        employeeRepository = new EmployeeRepository();
        permissionService = new PermissionService();
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

        Employee emp =
                employeeRepository.findByLoginInputAndPassword(
                        input,
                        password
                );

        if (emp != null) {
            return emp;
        }

        // Tài khoản Demo Admin
        if (("admin@gmail.com".equalsIgnoreCase(input)
                || "admin".equalsIgnoreCase(input))
                && "123456".equals(password)) {

            Employee admin = new Employee();

            admin.setMaNhanVien("NV001");
            admin.setTenDangNhap("admin");
            admin.setHoTen("Quản Trị Viên (Admin)");
            admin.setEmail("admin@gmail.com");
            admin.setMaVaiTro("VT01");
            admin.setChucVu("Admin");
            admin.setTenVaiTro("Quản lý");
            admin.setTrangThai("Hoạt động");

            return admin;
        }

        // Tài khoản Demo Nhân viên
        if (("nhanvien@gmail.com".equalsIgnoreCase(input)
                || "nv01".equalsIgnoreCase(input))
                && "123456".equals(password)) {

            Employee staff = new Employee();

            staff.setMaNhanVien("NV002");
            staff.setTenDangNhap("nv01");
            staff.setHoTen("Nhân Viên Bán Vé");
            staff.setEmail("nhanvien@gmail.com");
            staff.setMaVaiTro("VT02");
            staff.setChucVu("Nhân viên");
            staff.setTenVaiTro("Nhân viên");
            staff.setTrangThai("Hoạt động");

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

        return employeeRepository.updateStatus(
                maNhanVien,
                trangThai
        );
    }

    /**
     * Thêm tài khoản mới
     * Sau khi tạo thành công, tự động cấp quyền mặc định
     * theo vai trò của nhân viên.
     */
    public boolean createEmployee(Employee e) {

        if (e == null
                || e.getMaNhanVien() == null
                || e.getMaNhanVien().trim().isEmpty()) {
            return false;
        }

        boolean created = employeeRepository.insert(e);

        if (!created) {
            return false;
        }

        permissionService.initializeDefaultPermissions(
                e.getMaNhanVien(),
                e.getMaVaiTro()
        );

        return true;
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