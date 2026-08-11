package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Food;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CustomerFoodRepository {

    public List<Food> getAllActive() {
        List<Food> list = new ArrayList<>();
        String sql = "SELECT * FROM DO_AN_UONG WHERE TrangThai = N'Còn hàng'";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Food f = new Food();
                f.setMaDoAn(rs.getString("MaDoAnUong"));
                f.setTenDoAn(rs.getString("TenDoAnUong"));
                f.setGia(rs.getDouble("Gia"));
                f.setTrangThai(rs.getString("TrangThai"));
                f.setHinhAnh(rs.getString("HinhAnh"));
                f.setLoai("Đồ ăn uống");
                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String generateDetailId(Connection con) throws Exception {
        String sql = """
                SELECT COALESCE(MAX(CAST(SUBSTRING(MaChiTietDatDoAn, 5, LEN(MaChiTietDatDoAn)) AS INT)), 0) AS MaxNum
                FROM CHI_TIET_DAT_DO_AN
                """;
        try (PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int maxNum = rs.getInt("MaxNum");
                return String.format("CTDA%02d", maxNum + 1);
            }
        }
        return "CTDA01";
    }

    public boolean insertOrderDetail(Connection con, String maDatVe, String maDoAnUong, int soLuong, double giaBan) throws Exception {
        String maDetail = generateDetailId(con);
        String sql = """
                INSERT INTO CHI_TIET_DAT_DO_AN (MaChiTietDatDoAn, MaDatVe, MaDoAnUong, SoLuong, GiaBanLucDat)
                VALUES (?, ?, ?, ?, ?)
                """;
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, maDetail);
            ps.setString(2, maDatVe);
            ps.setString(3, maDoAnUong);
            ps.setInt(4, soLuong);
            ps.setDouble(5, giaBan);
            return ps.executeUpdate() > 0;
        }
    }
}
