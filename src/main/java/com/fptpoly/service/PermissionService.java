package com.fptpoly.service;

import com.fptpoly.model.EmployeePermission;
import com.fptpoly.model.Permission;
import com.fptpoly.repository.PermissionRepository;

import java.util.List;

public class PermissionService {

    private final PermissionRepository permissionRepository;

    public PermissionService() {
        this.permissionRepository = new PermissionRepository();
    }

    public List<Permission> getAllPermissions() {
        return permissionRepository.getAllPermissions();
    }

    public List<EmployeePermission> getEmployeePermissions(String maNhanVien) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return List.of();
        }

        return permissionRepository.getEmployeePermissions(maNhanVien);
    }

    public boolean togglePermission(
            String maNhanVien,
            String maQuyen,
            int trangThai) {

        if (maNhanVien == null
                || maNhanVien.trim().isEmpty()
                || maQuyen == null
                || maQuyen.trim().isEmpty()) {
            return false;
        }

        if (trangThai != 0 && trangThai != 1) {
            return false;
        }

        return permissionRepository.togglePermission(
                maNhanVien,
                maQuyen,
                trangThai
        );
    }

    public List<String> getPermissionsByEmployee(String maNhanVien) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return List.of();
        }

        return permissionRepository.getPermissionsByEmployee(maNhanVien);
    }

    public boolean updateEmployeePermissions(
            String maNhanVien,
            List<String> permissions) {

        return permissionRepository.updateEmployeePermissions(
                maNhanVien,
                permissions
        );
    }

    public boolean hasPermission(
            List<String> userPermissions,
            String requiredPermission) {

        if (userPermissions == null) {
            return false;
        }

        return userPermissions.contains(requiredPermission);
    }

    /**
     * Khởi tạo quyền mặc định cho nhân viên mới
     * dựa theo vai trò của nhân viên.
     *
     * VT01: Admin - toàn bộ quyền.
     * VT02: Nhân viên - quyền mặc định theo VAI_TRO_QUYEN.
     */
    public boolean initializeDefaultPermissions(String maNhanVien, String maVaiTro) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return false;
        }

        if (maVaiTro == null || maVaiTro.trim().isEmpty()) {
            return false;
        }

        return permissionRepository.initializeDefaultPermissions(
                maNhanVien,
                maVaiTro
        );
    }
}