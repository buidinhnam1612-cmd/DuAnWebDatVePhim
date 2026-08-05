package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Movie;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieRepository {

    public List<Movie> findAll() {

        List<Movie> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM PHIM
                ORDER BY NgayKhoiChieu DESC
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql);

                ResultSet rs =
                        ps.executeQuery()

        ) {

            while (rs.next()) {

                Movie movie = new Movie();

                movie.setMaPhim(
                        rs.getString("MaPhim")
                );

                movie.setTenPhim(
                        rs.getString("TenPhim")
                );

                movie.setMoTa(
                        rs.getString("MoTa")
                );

                movie.setThoiLuong(
                        rs.getInt("ThoiLuong")
                );

                movie.setTrailer(
                        rs.getString("Trailer")
                );

                movie.setPoster(
                        rs.getString("Poster")
                );

                Date ngay =
                        rs.getDate("NgayKhoiChieu");

                if (ngay != null) {

                    movie.setNgayKhoiChieu(
                            ngay.toLocalDate()
                    );

                }

                movie.setDoTuoiGiaiTri(
                        rs.getString("DoTuoiGiaiTri")
                );

                movie.setTrangThai(
                        rs.getString("TrangThai")
                );

                list.add(movie);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public Movie findById(String maPhim) {

        String sql = """
                SELECT *
                FROM PHIM
                WHERE MaPhim = ?
                """;

        try (

                Connection connection = DBConnection.getConnection();

                PreparedStatement ps =
                        connection.prepareStatement(sql)

        ) {

            ps.setString(1, maPhim);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                Movie movie = new Movie();

                movie.setMaPhim(
                        rs.getString("MaPhim")
                );

                movie.setTenPhim(
                        rs.getString("TenPhim")
                );

                movie.setMoTa(
                        rs.getString("MoTa")
                );

                movie.setThoiLuong(
                        rs.getInt("ThoiLuong")
                );

                movie.setTrailer(
                        rs.getString("Trailer")
                );

                movie.setPoster(
                        rs.getString("Poster")
                );

                Date ngay =
                        rs.getDate("NgayKhoiChieu");

                if (ngay != null) {

                    movie.setNgayKhoiChieu(
                            ngay.toLocalDate()
                    );

                }

                movie.setDoTuoiGiaiTri(
                        rs.getString("DoTuoiGiaiTri")
                );

                movie.setTrangThai(
                        rs.getString("TrangThai")
                );

                return movie;

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return null;

    }

}