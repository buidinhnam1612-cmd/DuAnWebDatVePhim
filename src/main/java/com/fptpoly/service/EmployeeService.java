package com.fptpoly.service;

import com.fptpoly.model.Employee;
import com.fptpoly.repository.EmployeeRepository;

import java.util.List;

public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    public EmployeeService() {
        employeeRepository = new EmployeeRepository();
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

}