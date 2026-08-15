package com.fptpoly;

import com.fptpoly.config.DBConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class InspectDatabase {

    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            System.out.println("=== 1. DANH SÁCH VAI_TRO ===");
            try (ResultSet rs = stmt.executeQuery("SELECT MaVaiTro, TenVaiTro FROM VAI_TRO")) {
                while (rs.next()) {
                    System.out.println("Role: " + rs.getString("MaVaiTro") + " - " + rs.getString("TenVaiTro"));
                }
            }

            System.out.println("\n=== 2. DANH SÁCH VAI_TRO_QUYEN (QUYỀN MẶC ĐỊNH THEO VAI TRÒ) ===");
            try (ResultSet rs = stmt.executeQuery("SELECT MaVaiTro, MaQuyen FROM VAI_TRO_QUYEN ORDER BY MaVaiTro, MaQuyen")) {
                while (rs.next()) {
                    System.out.println(" - " + rs.getString("MaVaiTro") + " -> " + rs.getString("MaQuyen"));
                }
            }

            System.out.println("\n=== 3. DANH SÁCH NHÂN VIÊN ===");
            try (ResultSet rs = stmt.executeQuery("SELECT MaNhanVien, HoTen, MaVaiTro, TrangThai FROM NHAN_VIEN")) {
                while (rs.next()) {
                    System.out.println(" - " + rs.getString("MaNhanVien") + " | " + rs.getString("HoTen") + " | Role: " + rs.getString("MaVaiTro") + " | Status: " + rs.getString("TrangThai"));
                }
            }

            System.out.println("\n=== 4. SỐ LƯỢNG BẢN GHI TRONG NHAN_VIEN_QUYEN ===");
            try (ResultSet rs = stmt.executeQuery("SELECT COUNT(*) FROM NHAN_VIEN_QUYEN")) {
                if (rs.next()) {
                    System.out.println("Tổng số bản ghi: " + rs.getInt(1));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
