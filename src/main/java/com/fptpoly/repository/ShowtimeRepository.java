package com.fptpoly.repository;

// Kiểm tra lại package cho đúng dự án của bạn

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Showtime; // Đổi lại class model tương ứng của bạn
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

public class ShowtimeRepository {

    // 1. Hàm lấy tất cả suất chiếu
    public List<Showtime> getAll() {
        List<Showtime> list = new ArrayList<>();
        String sql = "SELECT * FROM SUAT_CHIEU";
        try (Connection conn = DBConnection.getConnection(); // Đổi lại tên lớp kết nối DB của bạn nếu khác
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Showtime st = new Showtime();
                st.setMaSuatChieu(rs.getString("MaSuatChieu"));
                st.setNgayChieu(rs.getDate("NgayChieu").toLocalDate());
                st.setGioBatDau(rs.getTime("GioBatDau").toLocalTime());
                st.setGioKetThuc(rs.getTime("GioKetThuc").toLocalTime());
                st.setMaPhim(rs.getString("MaPhim"));
                st.setMaPhong(rs.getString("MaPhong"));
                list.add(st);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Hàm lấy danh sách suất chiếu theo phòng và ngày (Để check trùng lịch)
    public List<Showtime> getByPhongAndNgay(String maPhong, java.time.LocalDate ngayChieu) {
        List<Showtime> list = new ArrayList<>();
        String sql = "SELECT * FROM SUAT_CHIEU WHERE MaPhong = ? AND NgayChieu = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, maPhong);
            ps.setDate(2, Date.valueOf(ngayChieu)); // Chuyển từ LocalDate sang java.sql.Date

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Showtime st = new Showtime();
                    st.setMaSuatChieu(rs.getString("MaSuatChieu"));
                    st.setNgayChieu(rs.getDate("NgayChieu").toLocalDate());
                    st.setGioBatDau(rs.getTime("GioBatDau").toLocalTime());
                    st.setGioKetThuc(rs.getTime("GioKetThuc").toLocalTime());
                    st.setMaPhim(rs.getString("MaPhim"));
                    st.setMaPhong(rs.getString("MaPhong"));
                    list.add(st);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Hàm thêm mới suất chiếu vào database
    public boolean add(Showtime st) {
        String sql = "INSERT INTO SUAT_CHIEU (MaSuatChieu, NgayChieu, GioBatDau, GioKetThuc, MaPhim, MaPhong) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, st.getMaSuatChieu());
            ps.setDate(2, Date.valueOf(st.getNgayChieu()));
            ps.setTime(3, Time.valueOf(st.getGioBatDau())); // Chuyển từ LocalTime sang java.sql.Time
            ps.setTime(4, Time.valueOf(st.getGioKetThuc()));
            ps.setString(5, st.getMaPhim());
            ps.setString(6, st.getMaPhong());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    // ================= TRA CỨU SUẤT CHIẾU (NHÂN VIÊN) =================

    public List<Showtime> searchShowtime(String tenPhim) {

        List<Showtime> list = new ArrayList<>();

        String sql = """
            
                SELECT
                sc.MaSuatChieu,
                sc.NgayChieu,
                sc.GioBatDau,
                sc.GioKetThuc,
            
                p.TenPhim,
            
                pc.TenPhong,
            
                r.TenRap
            
            FROM SUAT_CHIEU sc
            
            INNER JOIN PHIM p
            ON sc.MaPhim = p.MaPhim
            
            INNER JOIN PHONG_CHIEU pc
            ON sc.MaPhong = pc.MaPhong
            
            INNER JOIN RAP r
            ON pc.MaRap = r.MaRap
            
            WHERE p.TenPhim LIKE ?
            
            ORDER BY sc.NgayChieu, sc.GioBatDau;
            """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, "%" + tenPhim + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Showtime st = new Showtime();

                st.setMaSuatChieu(rs.getString("MaSuatChieu"));
                st.setNgayChieu(rs.getDate("NgayChieu").toLocalDate());
                st.setGioBatDau(rs.getTime("GioBatDau").toLocalTime());
                st.setGioKetThuc(rs.getTime("GioKetThuc").toLocalTime());

                st.setTenPhim(rs.getString("TenPhim"));
                st.setTenPhong(rs.getString("TenPhong"));
                st.setTenRap(rs.getString("TenRap"));

                list.add(st);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}

