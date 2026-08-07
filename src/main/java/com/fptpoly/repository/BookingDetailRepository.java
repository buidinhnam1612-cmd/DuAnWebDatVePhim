package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.BookingDetail;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class BookingDetailRepository {

    /**
     * Sinh mã chi tiết đặt vé
     * CTDV001
     * CTDV002
     */
    public String generateBookingDetailId() {

        String sql = """
                SELECT COALESCE(MAX(CAST(SUBSTRING(MaChiTietDatVe, 5, LEN(MaChiTietDatVe)) AS INT)), 0) AS MaxNum
                FROM CHI_TIET_DAT_VE
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()

        ) {

            if (rs.next()) {

                int maxNum = rs.getInt("MaxNum");

                return String.format(
                        "CTDV%03d",
                        maxNum + 1
                );

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return "CTDV001";

    }

    /**
     * Thêm chi tiết đặt vé
     */
    public boolean insertBookingDetail(
            BookingDetail bookingDetail
    ) {

        String sql = """
                INSERT INTO CHI_TIET_DAT_VE
                (
                    MaChiTietDatVe,
                    MaDatVe,
                    MaGhe,
                    MaSuatChieu,
                    TrangThai,
                    ThoiGianGiuGhe,
                    GiaVe
                )
                VALUES
                (
                    ?,?,?,?,?,?,?
                )
                """;

        try (

                Connection connection =
                        DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            if (bookingDetail.getMaChiTietDatVe() == null
                    || bookingDetail.getMaChiTietDatVe().isBlank()) {

                bookingDetail.setMaChiTietDatVe(
                        generateBookingDetailId()
                );

            }

            if (bookingDetail.getThoiGianGiuGhe() == null) {

                bookingDetail.setThoiGianGiuGhe(
                        LocalDateTime.now()
                );

            }

            ps.setString(
                    1,
                    bookingDetail.getMaChiTietDatVe()
            );

            ps.setString(
                    2,
                    bookingDetail.getMaDatVe()
            );

            ps.setString(
                    3,
                    bookingDetail.getMaGhe()
            );

            ps.setString(
                    4,
                    bookingDetail.getMaSuatChieu()
            );

            ps.setString(
                    5,
                    bookingDetail.getTrangThai()
            );

            ps.setTimestamp(
                    6,
                    Timestamp.valueOf(
                            bookingDetail.getThoiGianGiuGhe()
                    )
            );

            ps.setDouble(
                    7,
                    bookingDetail.getGiaVe()
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }
    public List<BookingDetail> findByBookingId(String maDatVe) {

        List<BookingDetail> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM CHI_TIET_DAT_VE
                WHERE MaDatVe = ?
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            ps.setString(1, maDatVe);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                BookingDetail detail = new BookingDetail();

                detail.setMaChiTietDatVe(
                        rs.getString("MaChiTietDatVe")
                );

                detail.setMaDatVe(
                        rs.getString("MaDatVe")
                );

                detail.setMaGhe(
                        rs.getString("MaGhe")
                );

                detail.setMaSuatChieu(
                        rs.getString("MaSuatChieu")
                );

                detail.setTrangThai(
                        rs.getString("TrangThai")
                );

                Timestamp timestamp =
                        rs.getTimestamp("ThoiGianGiuGhe");

                if (timestamp != null) {

                    detail.setThoiGianGiuGhe(
                            timestamp.toLocalDateTime()
                    );

                }

                detail.setGiaVe(
                        rs.getDouble("GiaVe")
                );

                list.add(detail);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public List<String> findSeatBookedByShowtime(String maSuatChieu) {

        List<String> seats = new ArrayList<>();

        String sql = """
                SELECT MaGhe
                FROM CHI_TIET_DAT_VE
                WHERE MaSuatChieu = ?
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            ps.setString(1, maSuatChieu);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                seats.add(
                        rs.getString("MaGhe").trim()
                );

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return seats;

    }

    public boolean checkSeatBooked(String maSuatChieu,
                                   String maGhe) {

        String sql = """
                SELECT COUNT(*)
                FROM CHI_TIET_DAT_VE
                WHERE MaSuatChieu = ?
                AND MaGhe = ?
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            ps.setString(1, maSuatChieu);

            ps.setString(2, maGhe);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                return rs.getInt(1) > 0;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    public boolean deleteBookingDetail(String maChiTietDatVe) {

        String sql = """
                DELETE FROM CHI_TIET_DAT_VE
                WHERE MaChiTietDatVe = ?
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            ps.setString(1, maChiTietDatVe);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    public List<BookingDetail> findAll() {

        List<BookingDetail> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM CHI_TIET_DAT_VE
                ORDER BY ThoiGianGiuGhe DESC
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()

        ) {

            while (rs.next()) {

                BookingDetail detail = new BookingDetail();

                detail.setMaChiTietDatVe(
                        rs.getString("MaChiTietDatVe")
                );

                detail.setMaDatVe(
                        rs.getString("MaDatVe")
                );

                detail.setMaGhe(
                        rs.getString("MaGhe")
                );

                detail.setMaSuatChieu(
                        rs.getString("MaSuatChieu")
                );

                detail.setTrangThai(
                        rs.getString("TrangThai")
                );

                Timestamp timestamp =
                        rs.getTimestamp("ThoiGianGiuGhe");

                if (timestamp != null) {

                    detail.setThoiGianGiuGhe(
                            timestamp.toLocalDateTime()
                    );

                }

                detail.setGiaVe(
                        rs.getDouble("GiaVe")
                );

                list.add(detail);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }
    public boolean insertBookingDetail(Connection connection,
                                       BookingDetail detail) {

        String sql = """
            INSERT INTO CHI_TIET_DAT_VE
            (
                MaChiTietDatVe,
                MaDatVe,
                MaGhe,
                MaSuatChieu,
                TrangThai,
                ThoiGianGiuGhe,
                GiaVe
            )
            VALUES
            (
                ?,?,?,?,?,?,?
            )
            """;

        try (

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            ps.setString(
                    1,
                    detail.getMaChiTietDatVe()
            );

            ps.setString(
                    2,
                    detail.getMaDatVe()
            );

            ps.setString(
                    3,
                    detail.getMaGhe()
            );

            ps.setString(
                    4,
                    detail.getMaSuatChieu()
            );

            ps.setString(
                    5,
                    detail.getTrangThai()
            );

            ps.setTimestamp(
                    6,
                    Timestamp.valueOf(
                            detail.getThoiGianGiuGhe()
                    )
            );

            ps.setDouble(
                    7,
                    detail.getGiaVe()
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }
}

