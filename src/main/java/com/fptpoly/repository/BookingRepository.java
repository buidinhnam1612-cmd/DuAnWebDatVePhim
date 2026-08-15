package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Booking;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookingRepository {

    // ===================== LẤY TOÀN BỘ DANH SÁCH ĐẶT VÉ =====================
    public List<Booking> getAll() {
        List<Booking> list = new ArrayList<>();
        String sql = """
            SELECT
                dv.MaDatVe, dv.ThoiGianDat, dv.TongTien, dv.TrangThai, dv.MaKhachHang, dv.MaNhanVien, dv.MaVoucher,
                kh.HoTen AS TenKhachHang, kh.SoDienThoai, kh.Email,
                p.TenPhim, r.TenRap, pc.TenPhong, sc.NgayChieu, sc.GioBatDau,
                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,
                v.TenVoucher, nv.HoTen AS TenNhanVien
            FROM DAT_VE dv
            INNER JOIN KHACH_HANG kh ON dv.MaKhachHang = kh.MaKhachHang
            INNER JOIN CHI_TIET_DAT_VE ct ON dv.MaDatVe = ct.MaDatVe
            INNER JOIN GHE g ON ct.MaGhe = g.MaGhe
            INNER JOIN SUAT_CHIEU sc ON ct.MaSuatChieu = sc.MaSuatChieu
            INNER JOIN PHIM p ON sc.MaPhim = p.MaPhim
            INNER JOIN PHONG_CHIEU pc ON sc.MaPhong = pc.MaPhong
            INNER JOIN RAP r ON pc.MaRap = r.MaRap
            LEFT JOIN VOUCHER v ON dv.MaVoucher = v.MaVoucher
            LEFT JOIN NHAN_VIEN nv ON dv.MaNhanVien = nv.MaNhanVien
            GROUP BY
                dv.MaDatVe, dv.ThoiGianDat, dv.TongTien, dv.TrangThai, dv.MaKhachHang, dv.MaNhanVien, dv.MaVoucher,
                kh.HoTen, kh.SoDienThoai, kh.Email, p.TenPhim, r.TenRap, pc.TenPhong, sc.NgayChieu, sc.GioBatDau,
                v.TenVoucher, nv.HoTen
            ORDER BY dv.ThoiGianDat DESC
            """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                list.add(mapBooking(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ===================== LẤY ĐẶT VÉ THEO MÃ =====================
    public Booking getById(String maDatVe) {
        String sql = """
            SELECT
                dv.MaDatVe, dv.ThoiGianDat, dv.TongTien, dv.TrangThai, dv.MaKhachHang, dv.MaNhanVien, dv.MaVoucher,
                kh.HoTen AS TenKhachHang, kh.SoDienThoai, kh.Email,
                p.TenPhim, r.TenRap, pc.TenPhong, sc.NgayChieu, sc.GioBatDau,
                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,
                v.TenVoucher, nv.HoTen AS TenNhanVien
            FROM DAT_VE dv
            INNER JOIN KHACH_HANG kh ON dv.MaKhachHang = kh.MaKhachHang
            INNER JOIN CHI_TIET_DAT_VE ct ON dv.MaDatVe = ct.MaDatVe
            INNER JOIN GHE g ON ct.MaGhe = g.MaGhe
            INNER JOIN SUAT_CHIEU sc ON ct.MaSuatChieu = sc.MaSuatChieu
            INNER JOIN PHIM p ON sc.MaPhim = p.MaPhim
            INNER JOIN PHONG_CHIEU pc ON sc.MaPhong = pc.MaPhong
            INNER JOIN RAP r ON pc.MaRap = r.MaRap
            LEFT JOIN VOUCHER v ON dv.MaVoucher = v.MaVoucher
            LEFT JOIN NHAN_VIEN nv ON dv.MaNhanVien = nv.MaNhanVien
            WHERE dv.MaDatVe = ?
            GROUP BY
                dv.MaDatVe, dv.ThoiGianDat, dv.TongTien, dv.TrangThai, dv.MaKhachHang, dv.MaNhanVien, dv.MaVoucher,
                kh.HoTen, kh.SoDienThoai, kh.Email, p.TenPhim, r.TenRap, pc.TenPhong, sc.NgayChieu, sc.GioBatDau,
                v.TenVoucher, nv.HoTen
            """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, maDatVe);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapBooking(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // ===================== TÌM KIẾM ĐƠN ĐẶT VÉ =====================
    public List<Booking> search(String keyword) {
        List<Booking> list = new ArrayList<>();
        String sql = """
            SELECT
                dv.MaDatVe, dv.ThoiGianDat, dv.TongTien, dv.TrangThai, dv.MaKhachHang, dv.MaNhanVien, dv.MaVoucher,
                kh.HoTen AS TenKhachHang, kh.SoDienThoai, kh.Email,
                p.TenPhim, r.TenRap, pc.TenPhong, sc.NgayChieu, sc.GioBatDau,
                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,
                v.TenVoucher, nv.HoTen AS TenNhanVien
            FROM DAT_VE dv
            INNER JOIN KHACH_HANG kh ON dv.MaKhachHang = kh.MaKhachHang
            INNER JOIN CHI_TIET_DAT_VE ct ON dv.MaDatVe = ct.MaDatVe
            INNER JOIN GHE g ON ct.MaGhe = g.MaGhe
            INNER JOIN SUAT_CHIEU sc ON ct.MaSuatChieu = sc.MaSuatChieu
            INNER JOIN PHIM p ON sc.MaPhim = p.MaPhim
            INNER JOIN PHONG_CHIEU pc ON sc.MaPhong = pc.MaPhong
            INNER JOIN RAP r ON pc.MaRap = r.MaRap
            LEFT JOIN VOUCHER v ON dv.MaVoucher = v.MaVoucher
            LEFT JOIN NHAN_VIEN nv ON dv.MaNhanVien = nv.MaNhanVien
            WHERE dv.MaDatVe LIKE ? 
               OR kh.HoTen LIKE ? 
               OR kh.SoDienThoai LIKE ? 
               OR p.TenPhim LIKE ?
            GROUP BY
                dv.MaDatVe, dv.ThoiGianDat, dv.TongTien, dv.TrangThai, dv.MaKhachHang, dv.MaNhanVien, dv.MaVoucher,
                kh.HoTen, kh.SoDienThoai, kh.Email, p.TenPhim, r.TenRap, pc.TenPhong, sc.NgayChieu, sc.GioBatDau,
                v.TenVoucher, nv.HoTen
            ORDER BY dv.ThoiGianDat DESC
            """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            String value = "%" + keyword + "%";
            ps.setString(1, value);
            ps.setString(2, value);
            ps.setString(3, value);
            ps.setString(4, value);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapBooking(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    // ===================== CẬP NHẬT TRẠNG THÁI TỔNG QUÁT =====================
    public boolean updateStatus(String maDatVe, String trangThai) {
        String sql = "UPDATE DAT_VE SET TrangThai = ? WHERE MaDatVe = ?";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, trangThai);
            ps.setString(2, maDatVe);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===================== ĐẾM TỔNG SỐ ĐƠN ĐẶT VÉ =====================
    public int countBooking() {
        String sql = "SELECT COUNT(*) FROM DAT_VE";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ===================== ĐẾM SỐ ĐƠN THEO TRẠNG THÁI =====================
    public int countByStatus(String trangThai) {
        String sql = "SELECT COUNT(*) FROM DAT_VE WHERE TrangThai = ?";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, trangThai);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ===================== TÍNH TỔNG DOANH THU ĐÃ THANH TOÁN =====================
    public double getTotalRevenue() {
        String sql = "SELECT SUM(TongTien) FROM DAT_VE WHERE TrangThai = N'Đã thanh toán'";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // ===================== ĐẾM SỐ VÉ ĐẶT HÔM NAY =====================
    public int countTodayBookings() {
        String sql = "SELECT COUNT(*) FROM DAT_VE WHERE CAST(ThoiGianDat AS DATE) = CAST(GETDATE() AS DATE)";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ===================== TÍNH DOANH THU THÁNG NÀY =====================
    public double getMonthlyRevenue() {
        String sql = "SELECT COALESCE(SUM(TongTien), 0) FROM DAT_VE WHERE TrangThai = N'Đã thanh toán' AND MONTH(ThoiGianDat) = MONTH(GETDATE()) AND YEAR(ThoiGianDat) = YEAR(GETDATE())";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // ===================== XÁC NHẬN KHÁCH ĐÃ SỬ DỤNG VÉ (SOÁT VÉ ONLINE) =====================
    public boolean confirmBooking(String maDatVe) {
        String sql = """
            UPDATE DAT_VE
            SET TrangThai = N'Đã sử dụng'
            WHERE MaDatVe = ?
            AND TrangThai = N'Đã thanh toán'
            """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, maDatVe);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // ===================== TỰ ĐỘNG SINH MÃ ĐẶT VÉ (BÁN VÉ TẠI QUẦY) =====================
    public String generateBookingId() {
        String sql = """
                SELECT COALESCE(MAX(CAST(SUBSTRING(MaDatVe, 3, LEN(MaDatVe)) AS INT)), 0) AS MaxNum
                FROM DAT_VE
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) {
                int maxNum = rs.getInt("MaxNum");
                return String.format("DV%02d", maxNum + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "DV01";
    }

    // ===================== THÊM MỚI ĐƠN ĐẶT VÉ (BÁN VÉ TẠI QUẦY) =====================
    public boolean insert(Booking booking) {
        String sql = """
            INSERT INTO DAT_VE (MaDatVe, ThoiGianDat, TongTien, TrangThai, MaKhachHang, MaNhanVien, MaVoucher)
            VALUES (?, ?, ?, ?, ?, ?, ?)
            """;
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            if (booking.getMaDatVe() == null || booking.getMaDatVe().isBlank()) {
                booking.setMaDatVe(generateBookingId());
            }
            if (booking.getThoiGianDat() == null) {
                booking.setThoiGianDat(LocalDateTime.now());
            }

            ps.setString(1, booking.getMaDatVe());
            ps.setTimestamp(2, Timestamp.valueOf(booking.getThoiGianDat()));
            ps.setDouble(3, booking.getTongTien());
            ps.setString(4, booking.getTrangThai());
            ps.setString(5, booking.getMaKhachHang());

            if (booking.getMaNhanVien() == null || booking.getMaNhanVien().isBlank()) {
                ps.setNull(6, Types.VARCHAR);
            } else {
                ps.setString(6, booking.getMaNhanVien());
            }

            if (booking.getMaVoucher() == null || booking.getMaVoucher().isBlank()) {
                ps.setNull(7, Types.VARCHAR);
            } else {
                ps.setString(7, booking.getMaVoucher());
            }

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===================== LẤY LỊCH SỬ ĐẶT VÉ CỦA MỘT KHÁCH HÀNG =====================
    public List<Booking> getByKhachHang(String maKhachHang) {
        List<Booking> list = new ArrayList<>();
        String sql = """
            SELECT
                dv.MaDatVe, dv.ThoiGianDat, dv.TongTien, dv.TrangThai, dv.MaKhachHang, dv.MaNhanVien, dv.MaVoucher,
                kh.HoTen AS TenKhachHang, kh.SoDienThoai, kh.Email,
                p.TenPhim, r.TenRap, pc.TenPhong, sc.NgayChieu, sc.GioBatDau,
                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,
                v.TenVoucher, nv.HoTen AS TenNhanVien
            FROM DAT_VE dv
            INNER JOIN KHACH_HANG kh ON dv.MaKhachHang = kh.MaKhachHang
            INNER JOIN CHI_TIET_DAT_VE ct ON dv.MaDatVe = ct.MaDatVe
            INNER JOIN GHE g ON ct.MaGhe = g.MaGhe
            INNER JOIN SUAT_CHIEU sc ON ct.MaSuatChieu = sc.MaSuatChieu
            INNER JOIN PHIM p ON sc.MaPhim = p.MaPhim
            INNER JOIN PHONG_CHIEU pc ON sc.MaPhong = pc.MaPhong
            INNER JOIN RAP r ON pc.MaRap = r.MaRap
            LEFT JOIN VOUCHER v ON dv.MaVoucher = v.MaVoucher
            LEFT JOIN NHAN_VIEN nv ON dv.MaNhanVien = nv.MaNhanVien
            WHERE dv.MaKhachHang = ?
            GROUP BY
                dv.MaDatVe, dv.ThoiGianDat, dv.TongTien, dv.TrangThai, dv.MaKhachHang, dv.MaNhanVien, dv.MaVoucher,
                kh.HoTen, kh.SoDienThoai, kh.Email, p.TenPhim, r.TenRap, pc.TenPhong, sc.NgayChieu, sc.GioBatDau,
                v.TenVoucher, nv.HoTen
            ORDER BY dv.ThoiGianDat DESC
            """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, maKhachHang);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapBooking(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ===================== HÀM MAP DỮ LIỆU TỪ RESULTSET SANG MODEL =====================
    private Booking mapBooking(ResultSet rs) throws SQLException {
        Booking booking = new Booking();

        booking.setMaDatVe(rs.getString("MaDatVe"));

        Timestamp timestamp = rs.getTimestamp("ThoiGianDat");
        if (timestamp != null) {
            booking.setThoiGianDat(timestamp.toLocalDateTime());
        }

        booking.setTongTien(rs.getDouble("TongTien"));
        booking.setTrangThai(rs.getString("TrangThai"));
        booking.setMaKhachHang(rs.getString("MaKhachHang"));
        booking.setMaNhanVien(rs.getString("MaNhanVien"));
        booking.setMaVoucher(rs.getString("MaVoucher"));

        booking.setTenKhachHang(rs.getString("TenKhachHang"));
        booking.setSoDienThoai(rs.getString("SoDienThoai"));
        booking.setEmail(rs.getString("Email"));
        booking.setTenPhim(rs.getString("TenPhim"));
        booking.setTenRap(rs.getString("TenRap"));
        booking.setTenPhong(rs.getString("TenPhong"));
        booking.setNgayChieu(rs.getDate("NgayChieu"));
        booking.setGioBatDau(rs.getTime("GioBatDau"));
        booking.setDanhSachGhe(rs.getString("DanhSachGhe"));
        booking.setTenVoucher(rs.getString("TenVoucher"));
        booking.setTenNhanVien(rs.getString("TenNhanVien"));

        if (booking.getMaNhanVien() == null) {
            booking.setHinhThucDat("Online");
        } else {
            booking.setHinhThucDat("Tại quầy");
        }

        return booking;
    }
    // ===================== HỦY VÉ & GIẢI PHÓNG GHẾ =====================
    public boolean cancelBooking(String maDatVe) {
        String updateBookingSql = "UPDATE DAT_VE SET TrangThai = N'Đã hủy' WHERE MaDatVe = ?";
        String deleteDetailsSql = "DELETE FROM CHI_TIET_DAT_VE WHERE MaDatVe = ?";

        Connection con = null;
        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false); // Bắt đầu Transaction

            // 1. Cập nhật trạng thái vé thành 'Đã hủy'
            try (PreparedStatement ps1 = con.prepareStatement(updateBookingSql)) {
                ps1.setString(1, maDatVe);
                ps1.executeUpdate();
            }

            // 2. Xóa dữ liệu ghế đã giữ trong CHI_TIET_DAT_VE để người khác có thể đặt
            try (PreparedStatement ps2 = con.prepareStatement(deleteDetailsSql)) {
                ps2.setString(1, maDatVe);
                ps2.executeUpdate();
            }

            con.commit(); // Xác nhận giao dịch thành công
            return true;
        } catch (Exception e) {
            if (con != null) {
                try {
                    con.rollback(); // Rollback nếu xảy ra lỗi
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }
}
