package com.fptpoly;

import com.fptpoly.config.DBConnection;
import com.fptpoly.repository.PermissionRepository;

import java.sql.Connection;
import java.sql.Statement;
import java.util.List;

public class CleanAndVerifyDefaultPermissions {

    public static void main(String[] args) {
        System.out.println("=== XÓA SẠCH DỮ LIỆU THỬ NGHIỆM TRONG NHAN_VIEN_QUYEN ===");

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            stmt.executeUpdate("DELETE FROM NHAN_VIEN_QUYEN");
            System.out.println("Đã xóa sạch toàn bộ bản ghi trong NHAN_VIEN_QUYEN!");

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("\n=== KIỂM TRA QUYỀN MẶC ĐỊNH LẤY TỪ SQL DATABASE ===");
        PermissionRepository repo = new PermissionRepository();

        String[] employees = {"NV01", "NV02", "NV03", "NV04", "NV05", "NV06", "NV07"};

        for (String maNV : employees) {
            List<String> perms = repo.getPermissionsByEmployee(maNV);
            System.out.println("Nhân viên " + maNV + " có quyền: " + perms);
        }
    }
}
