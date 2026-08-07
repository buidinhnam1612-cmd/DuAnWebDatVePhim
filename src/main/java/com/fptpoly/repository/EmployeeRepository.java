package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Employee;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRepository {

    // Lấy toàn bộ nhân viên
    public List<Employee> getAll() {

        List<Employee> list = new ArrayList<>();

        String sql = """
                SELECT nv.*, vt.TenVaiTro
                FROM NHAN_VIEN nv
                INNER JOIN VAI_TRO vt
                ON nv.MaVaiTro = vt.MaVaiTro
                ORDER BY nv.MaNhanVien
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapEmployee(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy nhân viên theo mã
    public Employee getById(String maNhanVien) {

        String sql = """
                SELECT nv.*, vt.TenVaiTro
                FROM NHAN_VIEN nv
                INNER JOIN VAI_TRO vt
                ON nv.MaVaiTro = vt.MaVaiTro
                WHERE nv.MaNhanVien = ?
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, maNhanVien);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapEmployee(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Tìm kiếm
    public List<Employee> search(String keyword) {

        List<Employee> list = new ArrayList<>();

        String sql = """
                SELECT nv.*, vt.TenVaiTro
                FROM NHAN_VIEN nv
                INNER JOIN VAI_TRO vt
                ON nv.MaVaiTro = vt.MaVaiTro
                WHERE
                      nv.MaNhanVien LIKE ?
                   OR nv.HoTen LIKE ?
                   OR nv.Email LIKE ?
                   OR nv.SoDienThoai LIKE ?
                   OR vt.TenVaiTro LIKE ?
                   OR nv.TrangThai LIKE ?
                ORDER BY nv.MaNhanVien
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            String key = "%" + keyword + "%";

            ps.setString(1, key);
            ps.setString(2, key);
            ps.setString(3, key);
            ps.setString(4, key);
            ps.setString(5, key);
            ps.setString(6, key);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(mapEmployee(rs));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    // Đổi vai trò
    public boolean updateRole(String maNhanVien,
            String maVaiTro) {

        String sql = """
                UPDATE NHAN_VIEN
                SET MaVaiTro = ?
                WHERE MaNhanVien = ?
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, maVaiTro);
            ps.setString(2, maNhanVien);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    // Khóa / Mở khóa
    public boolean updateStatus(String maNhanVien,
            String trangThai) {

        String sql = """
                UPDATE NHAN_VIEN
                SET TrangThai = ?
                WHERE MaNhanVien = ?
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, trangThai);
            ps.setString(2, maNhanVien);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    // Thêm mới nhân viên
    public boolean insert(Employee e) {
        String sql = """
                INSERT INTO NHAN_VIEN (MaNhanVien, MaVaiTro, TenDangNhap, MatKhau, HoTen, Email, SoDienThoai, GioiTinh, TrangThai)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, e.getMaNhanVien());
            ps.setString(2, e.getMaVaiTro());
            ps.setString(3, e.getTenDangNhap());
            ps.setString(4, e.getMatKhau());
            ps.setString(5, e.getHoTen());
            ps.setString(6, e.getEmail());
            ps.setString(7, e.getSoDienThoai());
            ps.setString(8, e.getGioiTinh());
            ps.setString(9, e.getTrangThai());

            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    // Mapping dữ liệu
    private Employee mapEmployee(ResultSet rs)
            throws SQLException {

        Employee e = new Employee();

        e.setMaNhanVien(rs.getString("MaNhanVien"));
        String maVaiTro = rs.getString("MaVaiTro");

        e.setMaVaiTro(maVaiTro);

        if ("VT01".equals(maVaiTro)) {

            e.setChucVu("Admin");

        } else if ("VT02".equals(maVaiTro)) {

            e.setChucVu("Nhân viên bán vé");

        } else if ("VT03".equals(maVaiTro)) {

            e.setChucVu("Nhân viên rạp");

        } else {

            e.setChucVu("Chưa phân quyền");

        }
        e.setMaNhanVien(rs.getString("MaNhanVien"));
        e.setMaVaiTro(rs.getString("MaVaiTro"));
        e.setTenVaiTro(rs.getString("TenVaiTro"));
        e.setTenDangNhap(rs.getString("TenDangNhap"));
        e.setMatKhau(rs.getString("MatKhau"));
        e.setHoTen(rs.getString("HoTen"));
        e.setEmail(rs.getString("Email"));
        e.setSoDienThoai(rs.getString("SoDienThoai"));
        e.setNgaySinh(rs.getDate("NgaySinh"));
        e.setGioiTinh(rs.getString("GioiTinh"));
        e.setChucVu(rs.getString("ChucVu"));
        e.setNgayVaoLam(rs.getDate("NgayVaoLam"));
        e.setTrangThai(rs.getString("TrangThai"));

        return e;

    }
    public boolean existsById(String maNhanVien) {

        String sql = "SELECT 1 FROM NHAN_VIEN WHERE MaNhanVien = ?";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, maNhanVien);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}