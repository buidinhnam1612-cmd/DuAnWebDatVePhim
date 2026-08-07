package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingRepository {

    // ===================== LẤY TOÀN BỘ ĐẶT VÉ =====================

    public List<Booking> getAllBooking() {

        List<Booking> list = new ArrayList<>();

        String sql = """
            SELECT
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,

                kh.HoTen,
                kh.SoDienThoai,
                kh.Email,

                p.TenPhim,

                sc.NgayChieu,
                sc.GioBatDau

            FROM DAT_VE dv

            INNER JOIN KHACH_HANG kh
                ON dv.MaKhachHang = kh.MaKhachHang

            INNER JOIN CHI_TIET_DAT_VE ct
                ON dv.MaDatVe = ct.MaDatVe

            INNER JOIN SUAT_CHIEU sc
                ON ct.MaSuatChieu = sc.MaSuatChieu

            INNER JOIN PHIM p
                ON sc.MaPhim = p.MaPhim

            ORDER BY dv.ThoiGianDat DESC
        """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Booking b = new Booking();

                b.setMaDatVe(rs.getString("MaDatVe"));

                if (rs.getTimestamp("ThoiGianDat") != null) {
                    b.setThoiGianDat(
                            rs.getTimestamp("ThoiGianDat").toLocalDateTime()
                    );
                }

                b.setTongTien(rs.getBigDecimal("TongTien"));
                b.setTrangThai(rs.getString("TrangThai"));

                b.setHoTen(rs.getString("HoTen"));
                b.setSoDienThoai(rs.getString("SoDienThoai"));
                b.setEmail(rs.getString("Email"));

                b.setTenPhim(rs.getString("TenPhim"));

                if (rs.getDate("NgayChieu") != null) {
                    b.setNgayChieu(
                            rs.getDate("NgayChieu").toLocalDate()
                    );
                }

                if (rs.getTime("GioBatDau") != null) {
                    b.setGioBatDau(
                            rs.getTime("GioBatDau").toLocalTime()
                    );
                }

                list.add(b);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ===================== TÌM KIẾM =====================

    public List<Booking> searchBooking(String keyword) {

        List<Booking> list = new ArrayList<>();

        String sql = """
            SELECT
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,

                kh.HoTen,
                kh.SoDienThoai,
                kh.Email,

                p.TenPhim,

                sc.NgayChieu,
                sc.GioBatDau

            FROM DAT_VE dv

            INNER JOIN KHACH_HANG kh
                ON dv.MaKhachHang = kh.MaKhachHang

            INNER JOIN CHI_TIET_DAT_VE ct
                ON dv.MaDatVe = ct.MaDatVe

            INNER JOIN SUAT_CHIEU sc
                ON ct.MaSuatChieu = sc.MaSuatChieu

            INNER JOIN PHIM p
                ON sc.MaPhim = p.MaPhim

            WHERE
                dv.MaDatVe LIKE ?
                OR kh.SoDienThoai LIKE ?
                OR kh.Email LIKE ?

            ORDER BY dv.ThoiGianDat DESC
        """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Booking b = new Booking();

                b.setMaDatVe(rs.getString("MaDatVe"));

                if (rs.getTimestamp("ThoiGianDat") != null) {
                    b.setThoiGianDat(
                            rs.getTimestamp("ThoiGianDat").toLocalDateTime()
                    );
                }

                b.setTongTien(rs.getBigDecimal("TongTien"));
                b.setTrangThai(rs.getString("TrangThai"));

                b.setHoTen(rs.getString("HoTen"));
                b.setSoDienThoai(rs.getString("SoDienThoai"));
                b.setEmail(rs.getString("Email"));

                b.setTenPhim(rs.getString("TenPhim"));

                if (rs.getDate("NgayChieu") != null) {
                    b.setNgayChieu(
                            rs.getDate("NgayChieu").toLocalDate()
                    );
                }

                if (rs.getTime("GioBatDau") != null) {
                    b.setGioBatDau(
                            rs.getTime("GioBatDau").toLocalTime()
                    );
                }

                list.add(b);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    // tìm kiếm vé để ho trợ hủy
    public List<Booking> searchBookingForCancel(String keyword) {

        List<Booking> list = new ArrayList<>();

        String sql = """
        SELECT DISTINCT
            dv.MaDatVe,
            dv.ThoiGianDat,
            dv.TongTien,
            dv.TrangThai,

            kh.HoTen,
            kh.SoDienThoai,
            kh.Email,

            p.TenPhim,

            sc.NgayChieu,
            sc.GioBatDau

        FROM DAT_VE dv

        INNER JOIN KHACH_HANG kh
            ON dv.MaKhachHang = kh.MaKhachHang

        INNER JOIN CHI_TIET_DAT_VE ct
            ON dv.MaDatVe = ct.MaDatVe

        INNER JOIN SUAT_CHIEU sc
            ON ct.MaSuatChieu = sc.MaSuatChieu

        INNER JOIN PHIM p
            ON sc.MaPhim = p.MaPhim

        WHERE
            dv.MaDatVe LIKE ?
            OR kh.SoDienThoai LIKE ?
            OR kh.Email LIKE ?
        """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Booking booking = new Booking();

                booking.setMaDatVe(rs.getString("MaDatVe"));

                if (rs.getTimestamp("ThoiGianDat") != null) {
                    booking.setThoiGianDat(
                            rs.getTimestamp("ThoiGianDat").toLocalDateTime()
                    );
                }

                booking.setTongTien(rs.getBigDecimal("TongTien"));
                booking.setTrangThai(rs.getString("TrangThai"));

                booking.setHoTen(rs.getString("HoTen"));
                booking.setSoDienThoai(rs.getString("SoDienThoai"));
                booking.setEmail(rs.getString("Email"));

                booking.setTenPhim(rs.getString("TenPhim"));

                booking.setNgayChieu(rs.getDate("NgayChieu").toLocalDate());
                booking.setGioBatDau(rs.getTime("GioBatDau").toLocalTime());

                list.add(booking);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    // . Lấy thông tin một vé
    public Booking getBookingById(String maDatVe) {

        String sql = """
        SELECT
            MaDatVe,
            ThoiGianDat,
            TrangThai
        FROM DAT_VE
        WHERE MaDatVe = ?
        """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, maDatVe);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Booking booking = new Booking();

                booking.setMaDatVe(rs.getString("MaDatVe"));

                if (rs.getTimestamp("ThoiGianDat") != null) {
                    booking.setThoiGianDat(
                            rs.getTimestamp("ThoiGianDat").toLocalDateTime()
                    );
                }

                booking.setTrangThai(rs.getString("TrangThai"));

                return booking;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    // cập nhat trạng thái hủy
    public boolean cancelBooking(String maDatVe) {

        String sql = """
        UPDATE DAT_VE
        SET TrangThai = N'Đã hủy'
        WHERE MaDatVe = ?
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
    // xóa vé chi tiết
    public void cancelBookingDetail(String maDatVe) {

        String sql = """
        UPDATE CHI_TIET_DAT_VE
        SET TrangThai = N'Đã hủy'
        WHERE MaDatVe = ?
        """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, maDatVe);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Booking getBookingByCode(String maDatVe) {

        Booking booking = null;

        String sql = """
            SELECT
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,

                kh.HoTen,
                kh.SoDienThoai,
                kh.Email,

                p.TenPhim,

                sc.NgayChieu,
                sc.GioBatDau

            FROM DAT_VE dv

            INNER JOIN KHACH_HANG kh
                ON dv.MaKhachHang = kh.MaKhachHang

            INNER JOIN CHI_TIET_DAT_VE ct
                ON dv.MaDatVe = ct.MaDatVe

            INNER JOIN SUAT_CHIEU sc
                ON ct.MaSuatChieu = sc.MaSuatChieu

            INNER JOIN PHIM p
                ON sc.MaPhim = p.MaPhim

            WHERE dv.MaDatVe = ?
            """;

        try (

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)

        ) {

            ps.setString(1, maDatVe);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                booking = new Booking();

                booking.setMaDatVe(rs.getString("MaDatVe"));

                booking.setHoTen(rs.getString("HoTen"));

                booking.setSoDienThoai(rs.getString("SoDienThoai"));

                booking.setEmail(rs.getString("Email"));

                booking.setTenPhim(rs.getString("TenPhim"));

                booking.setTongTien(rs.getBigDecimal("TongTien"));

                booking.setTrangThai(rs.getString("TrangThai"));

                if (rs.getTimestamp("ThoiGianDat") != null) {

                    booking.setThoiGianDat(
                            rs.getTimestamp("ThoiGianDat").toLocalDateTime()
                    );

                }

                if (rs.getDate("NgayChieu") != null) {

                    booking.setNgayChieu(
                            rs.getDate("NgayChieu").toLocalDate()
                    );

                }

                if (rs.getTime("GioBatDau") != null) {

                    booking.setGioBatDau(
                            rs.getTime("GioBatDau").toLocalTime()
                    );

                }

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return booking;

    }

    public boolean confirmBooking(String maDatVe) {

        String sql = """
            UPDATE DAT_VE
            SET TrangThai = N'Đã sử dụng'
            WHERE MaDatVe = ?
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

}