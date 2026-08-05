package com.fptpoly.repository;


import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Movie;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieRepository {

    public List<Movie> getAll() {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM PHIM";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Movie(
                        rs.getString("MaPhim"), rs.getString("TenPhim"), rs.getString("MoTa"),
                        rs.getInt("ThoiLuong"), rs.getString("Trailer"), rs.getString("Poster"),
                        rs.getDate("NgayKhoiChieu"), rs.getString("DoTuoiGiaiTri"), rs.getString("TrangThai")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean add(Movie movie) {
        String sql = "INSERT INTO PHIM (MaPhim, TenPhim, MoTa, ThoiLuong, Trailer, Poster, NgayKhoiChieu, DoTuoiGiaiTri, TrangThai) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, movie.getMaPhim());
            ps.setString(2, movie.getTenPhim());
            ps.setString(3, movie.getMoTa());
            ps.setInt(4, movie.getThoiLuong());
            ps.setString(5, movie.getTrailer());
            ps.setString(6, movie.getPoster());
            ps.setDate(7, movie.getNgayKhoiChieu());
            ps.setString(8, movie.getDoTuoiGiaiTri());
            ps.setString(9, movie.getTrangThai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean update(Movie movie) {
        String sql = "UPDATE PHIM SET TenPhim=?, MoTa=?, ThoiLuong=?, Trailer=?, Poster=?, NgayKhoiChieu=?, DoTuoiGiaiTri=?, TrangThai=? WHERE MaPhim=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, movie.getTenPhim());
            ps.setString(2, movie.getMoTa());
            ps.setInt(3, movie.getThoiLuong());
            ps.setString(4, movie.getTrailer());
            ps.setString(5, movie.getPoster());
            ps.setDate(6, movie.getNgayKhoiChieu());
            ps.setString(7, movie.getDoTuoiGiaiTri());
            ps.setString(8, movie.getTrangThai());
            ps.setString(9, movie.getMaPhim());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public Movie getByID(String id) {
        String sql = "SELECT * FROM PHIM WHERE MaPhim = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Movie(
                            rs.getString("MaPhim"), rs.getString("TenPhim"), rs.getString("MoTa"),
                            rs.getInt("ThoiLuong"), rs.getString("Trailer"), rs.getString("Poster"),
                            rs.getDate("NgayKhoiChieu"), rs.getString("DoTuoiGiaiTri"), rs.getString("TrangThai")
                    );
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}

