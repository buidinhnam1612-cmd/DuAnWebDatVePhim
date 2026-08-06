package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Booking;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

                p.TenPhim,

                r.TenRap,

                pc.TenPhong,

                sc.NgayChieu,

                sc.GioBatDau,

                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,

                v.TenVoucher,

                nv.HoTen AS TenNhanVien

            FROM DAT_VE dv

            INNER JOIN KHACH_HANG kh
                ON dv.MaKhachHang = kh.MaKhachHang

            INNER JOIN CHI_TIET_DAT_VE ct
                ON dv.MaDatVe = ct.MaDatVe

            INNER JOIN GHE g
                ON ct.MaGhe = g.MaGhe

            INNER JOIN SUAT_CHIEU sc
                ON ct.MaSuatChieu = sc.MaSuatChieu

            INNER JOIN PHIM p
                ON sc.MaPhim = p.MaPhim

            INNER JOIN PHONG_CHIEU pc
                ON sc.MaPhong = pc.MaPhong

            INNER JOIN RAP r
                ON pc.MaRap = r.MaRap

            LEFT JOIN VOUCHER v
                ON dv.MaVoucher = v.MaVoucher

            LEFT JOIN NHAN_VIEN nv
                ON dv.MaNhanVien = nv.MaNhanVien

            GROUP BY

                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,
                dv.MaKhachHang,
                dv.MaNhanVien,
                dv.MaVoucher,

                kh.HoTen,

                p.TenPhim,

                r.TenRap,

                pc.TenPhong,

                sc.NgayChieu,

                sc.GioBatDau,

                v.TenVoucher,

                nv.HoTen

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

    // ===================== MAP RESULTSET -> BOOKING =====================

    private Booking mapBooking(ResultSet rs) throws Exception {

        Booking booking = new Booking();

        // Thông tin đặt vé
        booking.setMaDatVe(rs.getString("MaDatVe"));
        booking.setThoiGianDat(rs.getTimestamp("ThoiGianDat"));
        booking.setTongTien(rs.getBigDecimal("TongTien"));
        booking.setTrangThai(rs.getString("TrangThai"));

        booking.setMaKhachHang(rs.getString("MaKhachHang"));
        booking.setMaNhanVien(rs.getString("MaNhanVien"));
        booking.setMaVoucher(rs.getString("MaVoucher"));

        // Thông tin hiển thị
        booking.setTenKhachHang(rs.getString("TenKhachHang"));
        booking.setTenPhim(rs.getString("TenPhim"));
        booking.setTenRap(rs.getString("TenRap"));
        booking.setTenPhong(rs.getString("TenPhong"));

        booking.setNgayChieu(rs.getDate("NgayChieu"));
        booking.setGioBatDau(rs.getTime("GioBatDau"));

        booking.setDanhSachGhe(rs.getString("DanhSachGhe"));
        booking.setTenVoucher(rs.getString("TenVoucher"));
        booking.setTenNhanVien(rs.getString("TenNhanVien"));

        // Xác định hình thức đặt
        if (booking.getMaNhanVien() == null) {
            booking.setHinhThucDat("Online");
        } else {
            booking.setHinhThucDat("Tại quầy");
        }

        return booking;
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

                p.TenPhim,

                r.TenRap,

                pc.TenPhong,

                sc.NgayChieu,

                sc.GioBatDau,

                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,

                v.TenVoucher,

                nv.HoTen AS TenNhanVien

            FROM DAT_VE dv

            INNER JOIN KHACH_HANG kh
                ON dv.MaKhachHang = kh.MaKhachHang

            INNER JOIN CHI_TIET_DAT_VE ct
                ON dv.MaDatVe = ct.MaDatVe

            INNER JOIN GHE g
                ON ct.MaGhe = g.MaGhe

            INNER JOIN SUAT_CHIEU sc
                ON ct.MaSuatChieu = sc.MaSuatChieu

            INNER JOIN PHIM p
                ON sc.MaPhim = p.MaPhim

            INNER JOIN PHONG_CHIEU pc
                ON sc.MaPhong = pc.MaPhong

            INNER JOIN RAP r
                ON pc.MaRap = r.MaRap

            LEFT JOIN VOUCHER v
                ON dv.MaVoucher = v.MaVoucher

            LEFT JOIN NHAN_VIEN nv
                ON dv.MaNhanVien = nv.MaNhanVien

            WHERE dv.MaDatVe = ?

            GROUP BY
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,
                dv.MaKhachHang,
                dv.MaNhanVien,
                dv.MaVoucher,

                kh.HoTen,

                p.TenPhim,

                r.TenRap,

                pc.TenPhong,

                sc.NgayChieu,

                sc.GioBatDau,

                v.TenVoucher,

                nv.HoTen
            """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, maDatVe);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapBooking(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // ===================== TÌM KIẾM =====================

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

                p.TenPhim,

                r.TenRap,

                pc.TenPhong,

                sc.NgayChieu,

                sc.GioBatDau,

                STRING_AGG(g.HangGhe + CAST(g.SoGhe AS VARCHAR(10)), ', ') AS DanhSachGhe,

                v.TenVoucher,

                nv.HoTen AS TenNhanVien

            FROM DAT_VE dv

            INNER JOIN KHACH_HANG kh
                ON dv.MaKhachHang = kh.MaKhachHang

            INNER JOIN CHI_TIET_DAT_VE ct
                ON dv.MaDatVe = ct.MaDatVe

            INNER JOIN GHE g
                ON ct.MaGhe = g.MaGhe

            INNER JOIN SUAT_CHIEU sc
                ON ct.MaSuatChieu = sc.MaSuatChieu

            INNER JOIN PHIM p
                ON sc.MaPhim = p.MaPhim

            INNER JOIN PHONG_CHIEU pc
                ON sc.MaPhong = pc.MaPhong

            INNER JOIN RAP r
                ON pc.MaRap = r.MaRap

            LEFT JOIN VOUCHER v
                ON dv.MaVoucher = v.MaVoucher

            LEFT JOIN NHAN_VIEN nv
                ON dv.MaNhanVien = nv.MaNhanVien

            WHERE
                dv.MaDatVe LIKE ?
                OR kh.HoTen LIKE ?
                OR p.TenPhim LIKE ?
                OR r.TenRap LIKE ?
                OR dv.TrangThai LIKE ?

            GROUP BY
                dv.MaDatVe,
                dv.ThoiGianDat,
                dv.TongTien,
                dv.TrangThai,
                dv.MaKhachHang,
                dv.MaNhanVien,
                dv.MaVoucher,

                kh.HoTen,

                p.TenPhim,

                r.TenRap,

                pc.TenPhong,

                sc.NgayChieu,

                sc.GioBatDau,

                v.TenVoucher,

                nv.HoTen

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
            ps.setString(5, value);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(mapBooking(rs));

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    // ===================== CẬP NHẬT TRẠNG THÁI =====================

    public boolean updateStatus(String maDatVe, String trangThai) {

        String sql = """
            UPDATE DAT_VE
            SET TrangThai = ?
            WHERE MaDatVe = ?
            """;

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
    // ===================== ĐẾM TỔNG ĐƠN =====================

    public int countBooking() {

        String sql = """
            SELECT COUNT(*)
            FROM DAT_VE
            """;

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
    // ===================== ĐẾM THEO TRẠNG THÁI =====================

    public int countByStatus(String trangThai) {

        String sql = """
            SELECT COUNT(*)
            FROM DAT_VE
            WHERE TrangThai = ?
            """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, trangThai);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
    // ===================== TỔNG DOANH THU =====================

    public double getTotalRevenue() {

        String sql = """
            SELECT ISNULL(SUM(TongTien),0)
            FROM DAT_VE
            WHERE TrangThai = N'Đã thanh toán'
            """;

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

        return 0;
    }
}
