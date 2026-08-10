package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Food;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class FoodRepository {

    public FoodRepository() {
        initTable();
    }

    private void initTable() {
        String sqlTable = """
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'DO_AN')
                BEGIN
                    CREATE TABLE DO_AN (
                        MaDoAn VARCHAR(20) PRIMARY KEY,
                        TenDoAn NVARCHAR(100) NOT NULL,
                        Gia DECIMAL(18,2) NOT NULL,
                        SoLuong INT DEFAULT 0,
                        TrangThai NVARCHAR(50) DEFAULT N'Còn hàng',
                        HinhAnh NVARCHAR(255),
                        Loai NVARCHAR(50)
                    );
                END
                """;
        try (Connection con = DBConnection.getConnection()) {
            if (con != null) {
                try (Statement stmt = con.createStatement()) {
                    stmt.execute(sqlTable);
                }
                seedData(con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void seedData(Connection con) {
        String sqlCheck = "SELECT COUNT(*) FROM DO_AN";
        try (Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sqlCheck)) {
            if (rs.next() && rs.getInt(1) == 0) {
                String sqlInsert = """
                        INSERT INTO DO_AN (MaDoAn, TenDoAn, Gia, SoLuong, TrangThai, Loai) VALUES
                        ('DA01', N'Bắp bơ truyền thống Large', 65000, 100, N'Còn hàng', N'Đồ ăn'),
                        ('DA02', N'Bắp phô mai đặc biệt Large', 75000, 80, N'Còn hàng', N'Đồ ăn'),
                        ('DA03', N'Coca-Cola 500ml', 35000, 150, N'Còn hàng', N'Đồ uống'),
                        ('DA04', N'Pepsi 500ml', 35000, 120, N'Còn hàng', N'Đồ uống'),
                        ('DA05', N'Combo Single (1 Bắp + 1 Nước)', 90000, 50, N'Còn hàng', N'Combo'),
                        ('DA06', N'Combo Couple (1 Bắp L + 2 Nước)', 130000, 60, N'Còn hàng', N'Combo')
                        """;
                stmt.executeUpdate(sqlInsert);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Food> getAll() {
        List<Food> list = new ArrayList<>();
        String sql = "SELECT * FROM DO_AN ORDER BY MaDoAn";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapFood(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Food> search(String keyword) {
        List<Food> list = new ArrayList<>();
        String sql = "SELECT * FROM DO_AN WHERE MaDoAn LIKE ? OR TenDoAn LIKE ? OR Loai LIKE ? ORDER BY MaDoAn";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            String key = "%" + keyword + "%";
            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, key);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapFood(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateStatus(String maDoAn, String trangThai) {
        String sql = "UPDATE DO_AN SET TrangThai = ? WHERE MaDoAn = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, trangThai);
            ps.setString(2, maDoAn);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateQuantity(String maDoAn, int soLuong) {
        String sql = "UPDATE DO_AN SET SoLuong = ? WHERE MaDoAn = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, soLuong);
            ps.setString(2, maDoAn);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePrice(String maDoAn, double gia) {
        String sql = "UPDATE DO_AN SET Gia = ? WHERE MaDoAn = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setDouble(1, gia);
            ps.setString(2, maDoAn);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean insert(Food food) {
        String sql = "INSERT INTO DO_AN (MaDoAn, TenDoAn, Gia, SoLuong, TrangThai, HinhAnh, Loai) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, food.getMaDoAn());
            ps.setString(2, food.getTenDoAn());
            ps.setDouble(3, food.getGia());
            ps.setInt(4, food.getSoLuong());
            ps.setString(5, food.getTrangThai());
            ps.setString(6, food.getHinhAnh());
            ps.setString(7, food.getLoai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Food mapFood(ResultSet rs) throws Exception {
        Food f = new Food();
        f.setMaDoAn(rs.getString("MaDoAn"));
        f.setTenDoAn(rs.getString("TenDoAn"));
        f.setGia(rs.getDouble("Gia"));
        f.setSoLuong(rs.getInt("SoLuong"));
        f.setTrangThai(rs.getString("TrangThai"));
        try { f.setHinhAnh(rs.getString("HinhAnh")); } catch(Exception e){}
        try { f.setLoai(rs.getString("Loai")); } catch(Exception e){}
        return f;
    }
}
