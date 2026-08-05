package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Showtime;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

public class ShowtimeRepository {

    public List<Showtime> findAll() {

        List<Showtime> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM SUAT_CHIEU
                ORDER BY NgayChieu, GioBatDau
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()

        ) {

            while (rs.next()) {

                Showtime showtime = new Showtime();

                showtime.setMaSuatChieu(
                        rs.getString("MaSuatChieu")
                );

                Date ngay =
                        rs.getDate("NgayChieu");

                if (ngay != null) {

                    showtime.setNgayChieu(
                            ngay.toLocalDate()
                    );

                }

                Time batDau =
                        rs.getTime("GioBatDau");

                if (batDau != null) {

                    showtime.setGioBatDau(
                            batDau.toLocalTime()
                    );

                }

                Time ketThuc =
                        rs.getTime("GioKetThuc");

                if (ketThuc != null) {

                    showtime.setGioKetThuc(
                            ketThuc.toLocalTime()
                    );

                }

                showtime.setMaPhim(
                        rs.getString("MaPhim")
                );

                showtime.setMaPhong(
                        rs.getString("MaPhong")
                );

                list.add(showtime);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public List<Showtime> findByMovie(String maPhim) {

        List<Showtime> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM SUAT_CHIEU
                WHERE MaPhim = ?
                ORDER BY NgayChieu, GioBatDau
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            ps.setString(1, maPhim);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                Showtime showtime = new Showtime();

                showtime.setMaSuatChieu(
                        rs.getString("MaSuatChieu")
                );

                Date ngay =
                        rs.getDate("NgayChieu");

                if (ngay != null) {

                    showtime.setNgayChieu(
                            ngay.toLocalDate()
                    );

                }

                Time batDau =
                        rs.getTime("GioBatDau");

                if (batDau != null) {

                    showtime.setGioBatDau(
                            batDau.toLocalTime()
                    );

                }

                Time ketThuc =
                        rs.getTime("GioKetThuc");

                if (ketThuc != null) {

                    showtime.setGioKetThuc(
                            ketThuc.toLocalTime()
                    );

                }

                showtime.setMaPhim(
                        rs.getString("MaPhim")
                );

                showtime.setMaPhong(
                        rs.getString("MaPhong")
                );

                list.add(showtime);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public Showtime findById(String maSuatChieu) {

        String sql = """
                SELECT *
                FROM SUAT_CHIEU
                WHERE MaSuatChieu = ?
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            ps.setString(1, maSuatChieu);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                Showtime showtime = new Showtime();

                showtime.setMaSuatChieu(
                        rs.getString("MaSuatChieu")
                );

                Date ngay =
                        rs.getDate("NgayChieu");

                if (ngay != null) {

                    showtime.setNgayChieu(
                            ngay.toLocalDate()
                    );

                }

                Time batDau =
                        rs.getTime("GioBatDau");

                if (batDau != null) {

                    showtime.setGioBatDau(
                            batDau.toLocalTime()
                    );

                }

                Time ketThuc =
                        rs.getTime("GioKetThuc");

                if (ketThuc != null) {

                    showtime.setGioKetThuc(
                            ketThuc.toLocalTime()
                    );

                }

                showtime.setMaPhim(
                        rs.getString("MaPhim")
                );

                showtime.setMaPhong(
                        rs.getString("MaPhong")
                );

                return showtime;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return null;

    }

}