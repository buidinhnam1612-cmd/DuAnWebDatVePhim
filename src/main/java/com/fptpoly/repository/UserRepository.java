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

    /**
     * Tạo mã khách hàng duy nhất tiếp theo
     */
    public String generateUserId() {
        String sql = """
                SELECT COALESCE(MAX(CAST(SUBSTRING(MaKhachHang, 3, LEN(MaKhachHang)) AS INT)), 0) AS MaxNum
                FROM KHACH_HANG
                """;
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) {
                int maxNum = rs.getInt("MaxNum");
                return String.format("KH%02d", maxNum + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "KH01";
    }

    /**
     * Thêm mới khách hàng
     */
    public boolean add(User user) {
        String sql = """
                INSERT INTO KHACH_HANG
                (MaKhachHang, TenDangNhap, MatKhau, HoTen, Email, SoDienThoai, NgaySinh, GioiTinh, DiemTichLuy, TrangThai, MaVaiTro)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            if (user.getMaKhachHang() == null || user.getMaKhachHang().isBlank()) {
                user.setMaKhachHang(generateUserId());
            }
            ps.setString(1, user.getMaKhachHang());
            ps.setString(2, user.getTenDangNhap());
            ps.setString(3, user.getMatKhau());
            ps.setString(4, user.getHoTen());
            ps.setString(5, user.getEmail());
            ps.setString(6, user.getSoDienThoai());
            ps.setDate(7, user.getNgaySinh());
            ps.setString(8, user.getGioiTinh());
            ps.setInt(9, user.getDiemTichLuy());
            ps.setString(10, user.getTrangThai());
            ps.setString(11, user.getMaVaiTro());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Tìm khách hàng theo email
     */
    public User findByEmail(String email) {
        String sql = "SELECT * FROM KHACH_HANG WHERE Email = ?";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, email.trim());
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
     * Xác thực thông tin đăng nhập khách hàng
     */
    public User findByEmailAndPassword(String email, String password) {
        String sql = "SELECT * FROM KHACH_HANG WHERE Email = ? AND MatKhau = ?";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, email.trim());
            ps.setString(2, password);
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
     * Cập nhật thông tin cá nhân khách hàng
     */
    public boolean updateProfile(User user) {
        String sql = """
                UPDATE KHACH_HANG
                SET HoTen = ?, SoDienThoai = ?, Email = ?, NgaySinh = ?, GioiTinh = ?
                WHERE MaKhachHang = ?
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user.getHoTen());
            ps.setString(2, user.getSoDienThoai());
            ps.setString(3, user.getEmail());
            ps.setDate(4, user.getNgaySinh());
            ps.setString(5, user.getGioiTinh());
            ps.setString(6, user.getMaKhachHang());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đổi mật khẩu khách hàng
     */
    public boolean changePassword(String maKhachHang, String newPassword) {
        String sql = "UPDATE KHACH_HANG SET MatKhau = ? WHERE MaKhachHang = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, maKhachHang);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Cập nhật điểm tích lũy của khách hàng
     */
    public boolean updatePoints(String maKhachHang, int newPoints) {
        String sql = "UPDATE KHACH_HANG SET DiemTichLuy = ? WHERE MaKhachHang = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, newPoints);
            ps.setString(2, maKhachHang);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}