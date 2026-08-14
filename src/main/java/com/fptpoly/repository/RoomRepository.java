package com.fptpoly.repository;




import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Room;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomRepository {

    // Lấy toàn bộ danh sách phòng chiếu từ SQL
    public List<Room> findAll() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT * FROM PHONG_CHIEU";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Room(
                        rs.getString("maPhong"),
                        rs.getNString("tenPhong"),
                        rs.getInt("tongSoGhe"),
                        rs.getString("maRap")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Room findById(String maPhong) {
        String sql = "SELECT * FROM PHONG_CHIEU WHERE MaPhong = ?";
        try (Connection conn = new DBConnection().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, maPhong);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int soHang = 10;
                    int soCot = 12;
                    try {
                        soHang = rs.getInt("SoHang");
                        soCot = rs.getInt("SoCot");
                    } catch (Exception ignored) { } // If old DB without these columns
                    return new Room(
                            rs.getString("maPhong"),
                            rs.getNString("tenPhong"),
                            rs.getInt("tongSoGhe"),
                            rs.getString("maRap"),
                            soHang,
                            soCot
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thực hiện lưu đồng thời Phòng chiếu và cấu hình ma trận Ghế (Dùng Transaction)
    public boolean saveRoomAndSeats(Room p, List<com.fptpoly.model.Seat> seats) {
        String sqlPhong = "INSERT INTO PHONG_CHIEU (MaPhong, TenPhong, TongSoGhe, MaRap, SoHang, SoCot) VALUES(?,?,?,?,?,?)";
        String sqlGhe = "INSERT INTO GHE (MaGhe, MaPhong, HangGhe, SoGhe, LoaiGhe) VALUES(?,?,?,?,?)";

        try (Connection conn = new DBConnection().getConnection()) {
            conn.setAutoCommit(false); // Bật transaction để bảo toàn dữ liệu nếu lỗi

            try (PreparedStatement psP = conn.prepareStatement(sqlPhong)) {
                psP.setString(1, p.getMaPhong());
                psP.setNString(2, p.getTenPhong());
                psP.setInt(3, p.getTongSoGhe());
                psP.setString(4, p.getMaRap());
                psP.setInt(5, p.getSoHang());
                psP.setInt(6, p.getSoCot());
                psP.executeUpdate();
            }

            try (PreparedStatement psG = conn.prepareStatement(sqlGhe)) {
                for (com.fptpoly.model.Seat seat : seats) {
                    psG.setString(1, seat.getMaGhe());
                    psG.setString(2, seat.getMaPhong());
                    psG.setString(3, seat.getHangGhe());
                    psG.setInt(4, seat.getSoGhe());
                    psG.setNString(5, seat.getLoaiGhe());
                    psG.addBatch();
                }
                psG.executeBatch();
            }

            conn.commit(); // Thành công thì lưu lại
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

