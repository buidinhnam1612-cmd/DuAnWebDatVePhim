package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Booking;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookingRepository {

    //==========================
    // Sinh mã DV01 DV02 DV03...
    //==========================
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

    //==========================
    // Insert
    //==========================
    public boolean insertBooking(Booking booking) {

        String sql = """
                INSERT INTO DAT_VE
                (
                    MaDatVe,
                    ThoiGianDat,
                    TongTien,
                    TrangThai,
                    MaKhachHang,
                    MaNhanVien,
                    MaVoucher
                )
                VALUES
                (?,?,?,?,?,?,?)
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

    //==========================
    // Insert Transaction
    //==========================
    public boolean insertBooking(Connection con, Booking booking) {

        String sql = """
                INSERT INTO DAT_VE
                (
                    MaDatVe,
                    ThoiGianDat,
                    TongTien,
                    TrangThai,
                    MaKhachHang,
                    MaNhanVien,
                    MaVoucher
                )
                VALUES
                (?,?,?,?,?,?,?)
                """;

        try (

                PreparedStatement ps = con.prepareStatement(sql)

        ) {

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

    //==========================
    // Tìm theo mã
    //==========================
    public Booking findById(String maDatVe) {

        String sql = "SELECT * FROM DAT_VE WHERE MaDatVe=?";

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

    //==========================
    // Lấy toàn bộ
    //==========================
    public List<Booking> findAll() {

        List<Booking> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM DAT_VE
                ORDER BY ThoiGianDat DESC
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

    //==========================
    // Update trạng thái
    //==========================
    public boolean updateStatus(String maDatVe,
                                String trangThai) {

        String sql = """
            UPDATE DAT_VE
            SET TrangThai = ?
            WHERE MaDatVe = ?
            """;

        try (

                Connection con = DBConnection.getConnection();

                PreparedStatement ps =
                        con.prepareStatement(sql)

        ) {

            ps.setString(
                    1,
                    trangThai
            );

            ps.setString(
                    2,
                    maDatVe
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    //==========================
    // Delete
    //==========================
    public boolean deleteBooking(String maDatVe) {

        String sql = "DELETE FROM DAT_VE WHERE MaDatVe=?";

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

    //==========================
    // Mapping
    //==========================
    private Booking mapBooking(ResultSet rs) throws SQLException {

        Booking booking = new Booking();

        booking.setMaDatVe(rs.getString("MaDatVe"));

        Timestamp ts = rs.getTimestamp("ThoiGianDat");

        if (ts != null) {
            booking.setThoiGianDat(ts.toLocalDateTime());
        }

        booking.setTongTien(rs.getDouble("TongTien"));
        booking.setTrangThai(rs.getString("TrangThai"));
        booking.setMaKhachHang(rs.getString("MaKhachHang"));
        booking.setMaNhanVien(rs.getString("MaNhanVien"));
        booking.setMaVoucher(rs.getString("MaVoucher"));

        return booking;
    }

}