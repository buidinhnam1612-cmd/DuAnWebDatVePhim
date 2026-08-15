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
        return permissionRepository.getEmployeePermissions(maNhanVien.trim());
    }

    public List<String> getPermissionsByEmployee(String maNhanVien) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return List.of();
        }
        return permissionRepository.getPermissionsByEmployee(maNhanVien.trim());
    }

    public boolean togglePermission(String maNhanVien, String maQuyen, int trangThai) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()
                || maQuyen == null || maQuyen.trim().isEmpty()) {
            return false;
        }
        if (trangThai != 0 && trangThai != 1) {
            return false;
        }
        return permissionRepository.togglePermission(maNhanVien.trim(), maQuyen.trim(), trangThai);
    }

    public boolean updateEmployeePermissions(String maNhanVien, List<String> permissions) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return false;
        }
        return permissionRepository.updateEmployeePermissions(maNhanVien.trim(), permissions);
    }

    public boolean hasPermission(List<String> userPermissions, String requiredPermission) {
        if (userPermissions == null || userPermissions.isEmpty()
                || requiredPermission == null || requiredPermission.trim().isEmpty()) {
            return false;
        }
        return userPermissions.contains(requiredPermission.trim());
    }

    public boolean initializeDefaultPermissions(String maNhanVien, String maVaiTro) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()
                || maVaiTro == null || maVaiTro.trim().isEmpty()) {
            return false;
        }
        return permissionRepository.initializeDefaultPermissions(maNhanVien.trim(), maVaiTro.trim());
    }
}