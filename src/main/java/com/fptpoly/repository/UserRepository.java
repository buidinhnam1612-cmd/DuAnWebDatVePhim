package com.fptpoly.repository;

import com.fptpoly.model.User;
import com.fptpoly.config.DBConnection;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserRepository {

    /**
     * Lấy toàn bộ danh sách khách hàng
     */
    public List<User> getAll() {

        List<User> list = new ArrayList<>();

        String sql = "SELECT * FROM KHACH_HANG";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {
                list.add(mapResultSet(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Lấy khách hàng theo mã
     */
    public User getById(String maKhachHang) {

        String sql = "SELECT * FROM KHACH_HANG WHERE MaKhachHang = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, maKhachHang);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSet(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Tìm kiếm khách hàng
     */
    public List<User> search(String keyword) {

        List<User> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM KHACH_HANG
                WHERE MaKhachHang LIKE ?
                   OR TenDangNhap LIKE ?
                   OR HoTen LIKE ?
                   OR Email LIKE ?
                   OR SoDienThoai LIKE ?
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            String key = "%" + keyword + "%";

            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, key);
            ps.setString(4, key);
            ps.setString(5, key);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(mapResultSet(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Khóa / Mở khóa tài khoản
     */
    public boolean updateStatus(String maKhachHang, String trangThai) {

        String sql = """
                UPDATE KHACH_HANG
                SET TrangThai = ?
                WHERE MaKhachHang = ?
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, trangThai);
            ps.setString(2, maKhachHang);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Mapping ResultSet -> User
     */
    private User mapResultSet(ResultSet rs) throws SQLException {

        User user = new User();

        user.setMaKhachHang(rs.getString("MaKhachHang"));
        user.setTenDangNhap(rs.getString("TenDangNhap"));
        user.setMatKhau(rs.getString("MatKhau"));
        user.setHoTen(rs.getString("HoTen"));
        user.setEmail(rs.getString("Email"));
        user.setSoDienThoai(rs.getString("SoDienThoai"));

        Date ngaySinh = rs.getDate("NgaySinh");
        user.setNgaySinh(ngaySinh);

        user.setGioiTinh(rs.getString("GioiTinh"));
        user.setDiemTichLuy(rs.getInt("DiemTichLuy"));
        user.setTrangThai(rs.getString("TrangThai"));
        user.setMaVaiTro(rs.getString("MaVaiTro"));

        return user;
    }

}