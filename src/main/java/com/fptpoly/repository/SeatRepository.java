package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Seat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SeatRepository {

    /**
     * Lấy tất cả ghế theo mã phòng chiếu
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

                String hangGhe = rs.getString("HangGhe");
                int soGhe = rs.getInt("SoGhe");

                seat.setMaGhe(rs.getString("MaGhe"));
                seat.setHangGhe(hangGhe);
                seat.setSoGhe(soGhe);
                seat.setLoaiGhe(rs.getString("LoaiGhe"));

                String tenGhe = hangGhe + soGhe;
                try {
                    tenGhe = rs.getString("TenGhe");
                } catch (Exception e) {
                    // Cột TenGhe không tồn tại trong database
                }
                seat.setTenGhe(tenGhe);
                
                seat.setMaPhong(rs.getString("MaPhong"));

                list.add(seat);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
