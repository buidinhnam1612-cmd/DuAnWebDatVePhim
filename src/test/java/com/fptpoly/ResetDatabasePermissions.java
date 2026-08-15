package com.fptpoly;

import com.fptpoly.config.DBConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class ResetDatabasePermissions {

    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {

            System.out.println("Existing rows in NHAN_VIEN_QUYEN:");
            try (ResultSet rs = stmt.executeQuery("SELECT TOP 20 MaNhanVienQuyen, MaNhanVien, MaQuyen, TrangThai FROM NHAN_VIEN_QUYEN")) {
                while (rs.next()) {
                    System.out.println(" - " + rs.getString("MaNhanVienQuyen") + " | " + rs.getString("MaNhanVien") + " | " + rs.getString("MaQuyen") + " | " + rs.getInt("TrangThai"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
