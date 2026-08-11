package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class CommentRepository {

    public List<Comment> getByMovie(String maPhim) {
        List<Comment> list = new ArrayList<>();
        String sql = """
                SELECT bl.*, kh.HoTen AS TenKhachHang
                FROM BINH_LUAN bl
                INNER JOIN KHACH_HANG kh ON bl.MaKhachHang = kh.MaKhachHang
                WHERE bl.MaPhim = ?
                ORDER BY bl.NgayTao DESC
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, maPhim);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment c = new Comment();
                    c.setMaBinhLuan(rs.getString("MaBinhLuan"));
                    c.setSoSao(rs.getInt("SoSao"));
                    c.setNoiDung(rs.getString("NoiDung"));
                    c.setNgayTao(rs.getTimestamp("NgayTao"));
                    c.setMaKhachHang(rs.getString("MaKhachHang"));
                    c.setMaPhim(rs.getString("MaPhim"));
                    c.setTenKhachHang(rs.getString("TenKhachHang"));
                    list.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String generateCommentId() {
        String sql = """
                SELECT COALESCE(MAX(CAST(SUBSTRING(MaBinhLuan, 3, LEN(MaBinhLuan)) AS INT)), 0) AS MaxNum
                FROM BINH_LUAN
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                int maxNum = rs.getInt("MaxNum");
                return String.format("BL%02d", maxNum + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "BL01";
    }

    public boolean insert(Comment c) {
        if (c.getMaBinhLuan() == null || c.getMaBinhLuan().isBlank()) {
            c.setMaBinhLuan(generateCommentId());
        }
        String sql = """
                INSERT INTO BINH_LUAN (MaBinhLuan, SoSao, NoiDung, NgayTao, MaKhachHang, MaPhim)
                VALUES (?, ?, ?, ?, ?, ?)
                """;
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, c.getMaBinhLuan());
            ps.setInt(2, c.getSoSao());
            ps.setString(3, c.getNoiDung());
            ps.setTimestamp(4, c.getNgayTao() != null ? c.getNgayTao() : new Timestamp(System.currentTimeMillis()));
            ps.setString(5, c.getMaKhachHang());
            ps.setString(6, c.getMaPhim());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
