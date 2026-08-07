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

    // Thực hiện lưu đồng thời Phòng chiếu và cấu hình ma trận Ghế (Dùng Transaction)
    public boolean saveRoomAndSeats(Room p, int soHang, int soCot, String loaiGhe) {
        String sqlPhong = "INSERT INTO PHONG_CHIEU (MaPhong, TenPhong, TongSoGhe, MaRap) VALUES(?,?,?,?)";
        String sqlGhe = "INSERT INTO GHE (MaGhe, MaPhong, SoHang, SoCot, TenGhe, LoaiGhe) VALUES(?,?,?,?,?,?)";

        try (Connection conn = new DBConnection().getConnection()) {
            conn.setAutoCommit(false); // Bật transaction để bảo toàn dữ liệu nếu lỗi

            try (PreparedStatement psP = conn.prepareStatement(sqlPhong)) {
                psP.setString(1, p.getMaPhong());
                psP.setNString(2, p.getTenPhong());
                psP.setInt(3, p.getTongSoGhe());
                psP.setString(4, p.getMaRap());
                psP.executeUpdate();
            }

            try (PreparedStatement psG = conn.prepareStatement(sqlGhe)) {
                for (int i = 1; i <= soHang; i++) {
                    char hangChu = (char) ('A' + (i - 1)); // Quy đổi hàng 1 -> A, hàng 2 -> B...
                    for (int j = 1; j <= soCot; j++) {
                        String maGhe = p.getMaPhong() + "_" + hangChu + j;
                        String tenGhe = String.valueOf(hangChu) + j;

                        psG.setString(1, maGhe);
                        psG.setString(2, p.getMaPhong());
                        psG.setInt(3, i);
                        psG.setInt(4, j);
                        psG.setString(5, tenGhe);
                        psG.setNString(6, loaiGhe);
                        psG.addBatch();
                    }
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

