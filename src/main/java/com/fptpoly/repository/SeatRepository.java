package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Seat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SeatRepository {

    public List<Seat> findAll() {

        List<Seat> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM GHE
                ORDER BY MaPhong, HangGhe, SoGhe
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Seat seat = new Seat();

                seat.setMaGhe(rs.getString("MaGhe").trim());
                seat.setHangGhe(rs.getString("HangGhe").trim());
                seat.setSoGhe(rs.getInt("SoGhe"));
                seat.setLoaiGhe(rs.getString("LoaiGhe").trim());
                seat.setMaPhong(rs.getString("MaPhong").trim());

                list.add(seat);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Lấy ghế theo phòng
     */
    public List<Seat> findByRoom(String maPhong) {

        List<Seat> list = new ArrayList<>();

        String sql = """
                SELECT *
                FROM GHE
                WHERE MaPhong = ?
                ORDER BY HangGhe, SoGhe
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, maPhong);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Seat seat = new Seat();

                seat.setMaGhe(rs.getString("MaGhe").trim());
                seat.setHangGhe(rs.getString("HangGhe").trim());
                seat.setSoGhe(rs.getInt("SoGhe"));
                seat.setLoaiGhe(rs.getString("LoaiGhe").trim());
                seat.setMaPhong(rs.getString("MaPhong").trim());

                list.add(seat);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Seat findById(String maGhe) {

        String sql = """
                SELECT *
                FROM GHE
                WHERE MaGhe = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, maGhe);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                Seat seat = new Seat();

                seat.setMaGhe(rs.getString("MaGhe").trim());
                seat.setHangGhe(rs.getString("HangGhe").trim());
                seat.setSoGhe(rs.getInt("SoGhe"));
                seat.setLoaiGhe(rs.getString("LoaiGhe").trim());
                seat.setMaPhong(rs.getString("MaPhong").trim());

                return seat;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}