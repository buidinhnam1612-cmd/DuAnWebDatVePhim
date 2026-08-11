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
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,
                dv.MaKhachHang,
                dv.MaNhanVien,
                dv.MaVoucher,
                kh.HoTen AS TenKhachHang,
                kh.SoDienThoai,
                kh.Email,
                p.TenPhim,
                r.TenRap,
                pc.TenPhong,
                sc.NgayChieu,
                sc.GioBatDau,
                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,
                v.TenVoucher,
                nv.HoTen AS TenNhanVien
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
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,
                dv.MaKhachHang,
                dv.MaNhanVien,
                dv.MaVoucher,
                kh.HoTen AS TenKhachHang,
                kh.SoDienThoai,
                kh.Email,
                p.TenPhim,
                r.TenRap,
                pc.TenPhong,
                sc.NgayChieu,
                sc.GioBatDau,
                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,
                v.TenVoucher,
                nv.HoTen AS TenNhanVien
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

    // ===================== TÌM KIẾM (Đã hoàn thiện phần thiếu) =====================

    public List<Booking> search(String keyword) {

        List<Booking> list = new ArrayList<>();

        String sql = """
            SELECT
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,
                dv.MaKhachHang,
                dv.MaNhanVien,
                dv.MaVoucher,
                kh.HoTen AS TenKhachHang,
                kh.SoDienThoai,
                kh.Email,
                p.TenPhim,
                r.TenRap,
                pc.TenPhong,
                sc.NgayChieu,
                sc.GioBatDau,
                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,
                v.TenVoucher,
                nv.HoTen AS TenNhanVien
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

    // ===================== TỰ ĐỘNG SINH MÃ ĐẶT VÉ (Bổ sung mới) =====================

    public String generateBookingId() {
        String sql = "SELECT MAX(CAST(SUBSTRING(MaDatVe, 3, LEN(MaDatVe)) AS INT)) FROM DAT_VE";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {
            if (rs.next()) {
                int maxId = rs.getInt(1);
                return String.format("BK%04d", maxId + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "BK0001";
    }

    // ===================== THÊM MỚI HÓA ĐƠN ĐẶT VÉ (Sửa lỗi chữ đỏ ảnh trước) =====================

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

    // ===================== MAP RESULTSET -> BOOKING =====================

    private Booking mapBooking(ResultSet rs) throws Exception {
        Booking booking = new Booking();

        booking.setMaDatVe(rs.getString("MaDatVe"));
        booking.setThoiGianDat(rs.getTimestamp("ThoiGianDat").toLocalDateTime());
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
        }
        else {booking.setHinhThucDat("Tại quầy");
        }
        return booking;
    }
    // ===================== CẬP NHẬT TRẠNG THÁI ĐẶT VÉ =====================
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
        // Chỉ tính tổng tiền của các hóa đơn có trạng thái là Đã thanh toán (NVARCHAR)
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

    // ===================== XÁC NHẬN SOÁT VÉ THÀNH CÔNG =====================
    public boolean confirmBooking(String maDatVe) {
        // Cập nhật trạng thái đơn vé sang Đã sử dụng khi khách đến rạp quét mã soát vé
        String sql = "UPDATE DAT_VE SET TrangThai = N'Đã sử dụng' WHERE MaDatVe = ?";
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, maDatVe);
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
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,
                dv.MaKhachHang,
                dv.MaNhanVien,
                dv.MaVoucher,
                kh.HoTen AS TenKhachHang,
                kh.SoDienThoai,
                kh.Email,
                p.TenPhim,
                r.TenRap,
                pc.TenPhong,
                sc.NgayChieu,
                sc.GioBatDau,
                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,
                v.TenVoucher,
                nv.HoTen AS TenNhanVien
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
                    list.add(mapBooking(rs)); // Gọi lại hàm map dữ liệu có sẵn của bạn
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


}
