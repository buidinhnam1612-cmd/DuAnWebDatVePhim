package com.fptpoly.service;

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

    public List<String> getPermissionsByEmployee(String maNhanVien) {
        return permissionRepository.getPermissionsByEmployee(maNhanVien);
    }

    public boolean updateEmployeePermissions(String maNhanVien, List<String> permissions) {
        return permissionRepository.updateEmployeePermissions(maNhanVien, permissions);
    }

    public boolean hasPermission(List<String> userPermissions, String requiredPermission) {
        if (userPermissions == null) return false;
        return userPermissions.contains(requiredPermission);
    }
}
