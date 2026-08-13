package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Employee;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRepository {

    // 1. Lấy toàn bộ nhân viên kèm tên chức vụ nhóm
    public List<Employee> getAll() {
        List<Employee> list = new ArrayList<>();
        String sql = """
                SELECT nv.*, vt.TenVaiTro
                FROM NHAN_VIEN nv
                INNER JOIN VAI_TRO vt ON nv.MaVaiTro = vt.MaVaiTro
                ORDER BY nv.MaNhanVien
                """;

        try (Connection con = DBConnection.getConnection();
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

    // 2. Lấy nhân viên chi tiết theo mã khóa chính
    public Employee getById(String maNhanVien) {
        String sql = """
                SELECT nv.*, vt.TenVaiTro
                FROM NHAN_VIEN nv
                INNER JOIN VAI_TRO vt ON nv.MaVaiTro = vt.MaVaiTro
                WHERE nv.MaNhanVien = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, maNhanVien);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapEmployee(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 3. Đăng nhập nhân viên đồng bộ quyền hạn
    public Employee findByLoginInputAndPassword(String loginInput, String password) {
        String sql = """
            SELECT nv.*, vt.TenVaiTro
            FROM NHAN_VIEN nv
            INNER JOIN VAI_TRO vt ON nv.MaVaiTro = vt.MaVaiTro
            WHERE (nv.TenDangNhap = ? OR nv.Email = ?) AND nv.MatKhau = ?
            """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, loginInput);
            ps.setString(2, loginInput);
            ps.setString(3, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Employee employee = mapEmployee(rs);
                    return employee;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 4. Tìm kiếm nhân viên nâng cao
    public List<Employee> search(String keyword) {
        List<Employee> list = new ArrayList<>();
        String sql = """
                SELECT nv.*, vt.TenVaiTro
                FROM NHAN_VIEN nv
                INNER JOIN VAI_TRO vt ON nv.MaVaiTro = vt.MaVaiTro
                WHERE nv.MaNhanVien LIKE ? OR nv.HoTen LIKE ? OR nv.Email LIKE ? 
                   OR nv.SoDienThoai LIKE ? OR vt.TenVaiTro LIKE ? OR nv.TrangThai LIKE ?
                ORDER BY nv.MaNhanVien
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            String key = "%" + keyword + "%";
            for (int i = 1; i <= 6; i++) {
                ps.setString(i, key);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapEmployee(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 5. Cập nhật mã vai trò nhóm mới
    public boolean updateRole(String maNhanVien, String maVaiTro) {
        String sql = "UPDATE NHAN_VIEN SET MaVaiTro = ? WHERE MaNhanVien = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, maVaiTro);
            ps.setString(2, maNhanVien);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 6. Cập nhật trạng thái khóa/mở hoạt động nhân sự
    public boolean updateStatus(String maNhanVien, String trangThai) {
        String sql = "UPDATE NHAN_VIEN SET TrangThai = ? WHERE MaNhanVien = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, trangThai);
            ps.setString(2, maNhanVien);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 7. Thêm mới bản ghi nhân sự vào DB
    // Thêm mới nhân viên - TỰ ĐỘNG TẠO MÃ KHÔNG TRÙNG LẶP
    public boolean insert(Employee e) {
        // 1. Câu lệnh SQL đếm tổng số nhân viên hiện tại để sinh mã tự nhảy
        String sqlCount = "SELECT COUNT(*) FROM NHAN_VIEN";

        String sqlInsert = """
                INSERT INTO NHAN_VIEN (MaNhanVien, MaVaiTro, TenDangNhap, MatKhau, HoTen, Email, SoDienThoai, GioiTinh, TrangThai)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection con = DBConnection.getConnection()) {

            // Bước 2.1: Tự động tính toán sinh mã nhân viên mới
            String maTuDong = "";
            try (PreparedStatement psCount = con.prepareStatement(sqlCount);
                 ResultSet rs = psCount.executeQuery()) {
                if (rs.next()) {
                    int total = rs.getInt(1);
                    // Tạo định dạng mã: NV01, NV02, NV05, NV10...
                    maTuDong = String.format("NV%02d", total + 1);
                }
            }

            // Bước 2.2: Thực hiện chèn dữ liệu với mã tự động vừa tạo
            try (PreparedStatement psInsert = con.prepareStatement(sqlInsert)) {
                psInsert.setString(1, maTuDong); // Truyền mã tự nhảy vào đây
                psInsert.setString(2, e.getMaVaiTro());
                psInsert.setString(3, e.getTenDangNhap());
                psInsert.setString(4, e.getMatKhau());
                psInsert.setString(5, e.getHoTen());
                psInsert.setString(6, e.getEmail());
                psInsert.setString(7, e.getSoDienThoai());
                psInsert.setString(8, e.getGioiTinh());
                psInsert.setString(9, "Đang làm việc"); // Mặc định tài khoản mới tạo là Đang làm việc

                return psInsert.executeUpdate() > 0;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }


    // 8. Kiểm tra trùng lặp khóa chính hệ thống
    public boolean existsById(String maNhanVien) {
        String sql = "SELECT 1 FROM NHAN_VIEN WHERE MaNhanVien = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, maNhanVien);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 9. Hàm chuyển đổi ResultSet sang thực thể Employee Java
    private Employee mapEmployee(ResultSet rs) throws SQLException {
        Employee e = new Employee();
        e.setMaNhanVien(rs.getString("MaNhanVien"));
        String maVaiTro = rs.getString("MaVaiTro");
        e.setMaVaiTro(maVaiTro);

        if ("VT01".equals(maVaiTro)) {
            e.setChucVu("Admin");
        } else if ("VT02".equals(maVaiTro)) {
            e.setChucVu("Nhân viên bán vé");
        } else if ("VT04".equals(maVaiTro)) {
            e.setChucVu("Nhân viên quầy đồ ăn");
        } else {
            e.setChucVu("Chưa phân quyền");
        }

        try { e.setTenVaiTro(rs.getString("TenVaiTro")); } catch (Exception ex) {}
        try { e.setTenDangNhap(rs.getString("TenDangNhap")); } catch (Exception ex) {}
        try { e.setMatKhau(rs.getString("MatKhau")); } catch (Exception ex) {}
        try { e.setHoTen(rs.getString("HoTen")); } catch (Exception ex) {}
        try { e.setEmail(rs.getString("Email")); } catch (Exception ex) {}
        try { e.setSoDienThoai(rs.getString("SoDienThoai")); } catch (Exception ex) {}
        try { e.setNgaySinh(rs.getDate("NgaySinh")); } catch (Exception ex) {}
        try { e.setGioiTinh(rs.getString("GioiTinh")); } catch (Exception ex) {}
        try { e.setNgayVaoLam(rs.getDate("NgayVaoLam")); } catch (Exception ex) {}
        try { e.setTrangThai(rs.getString("TrangThai")); } catch (Exception ex) {}
        return e;
    }
}
