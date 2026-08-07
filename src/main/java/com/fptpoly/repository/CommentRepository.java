package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentRepository {

    // ==========================
    // LẤY TOÀN BỘ BÌNH LUẬN
    // ==========================

    public List<Comment> getAllComment() {

        List<Comment> list = new ArrayList<>();

        String sql = """
                SELECT
                    bl.MaBinhLuan,
                    kh.HoTen,
                    p.TenPhim,
                    bl.SoSao,
                    bl.NoiDung,
                    bl.NgayTao,
                    bl.TrangThai
                FROM BINH_LUAN bl
                INNER JOIN KHACH_HANG kh
                    ON bl.MaKhachHang = kh.MaKhachHang
                INNER JOIN PHIM p
                    ON bl.MaPhim = p.MaPhim
                ORDER BY bl.NgayTao DESC
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {

                Comment comment = new Comment();

                comment.setMaBinhLuan(rs.getString("MaBinhLuan"));

                comment.setHoTen(rs.getString("HoTen"));

                comment.setTenPhim(rs.getString("TenPhim"));

                comment.setSoSao(rs.getInt("SoSao"));

                comment.setNoiDung(rs.getString("NoiDung"));

                if (rs.getTimestamp("NgayTao") != null) {

                    comment.setNgayTao(
                            rs.getTimestamp("NgayTao").toLocalDateTime()
                    );

                }

                comment.setTrangThai(rs.getString("TrangThai"));

                list.add(comment);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    // ==========================
    // TÌM KIẾM
    // ==========================

    public List<Comment> searchComment(String keyword) {

        List<Comment> list = new ArrayList<>();

        String sql = """
                SELECT
                    bl.MaBinhLuan,
                    kh.HoTen,
                    p.TenPhim,
                    bl.SoSao,
                    bl.NoiDung,
                    bl.NgayTao,
                    bl.TrangThai
                FROM BINH_LUAN bl
                INNER JOIN KHACH_HANG kh
                    ON bl.MaKhachHang = kh.MaKhachHang
                INNER JOIN PHIM p
                    ON bl.MaPhim = p.MaPhim
                WHERE
                    bl.MaBinhLuan LIKE ?
                    OR kh.HoTen LIKE ?
                    OR p.TenPhim LIKE ?
                ORDER BY bl.NgayTao DESC
                """;

        try (

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)

        ) {

            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Comment comment = new Comment();

                comment.setMaBinhLuan(rs.getString("MaBinhLuan"));

                comment.setHoTen(rs.getString("HoTen"));

                comment.setTenPhim(rs.getString("TenPhim"));

                comment.setSoSao(rs.getInt("SoSao"));

                comment.setNoiDung(rs.getString("NoiDung"));

                if (rs.getTimestamp("NgayTao") != null) {

                    comment.setNgayTao(
                            rs.getTimestamp("NgayTao").toLocalDateTime()
                    );

                }

                comment.setTrangThai(rs.getString("TrangThai"));

                list.add(comment);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    // ==========================
    // DUYỆT BÌNH LUẬN
    // ==========================

    public boolean approveComment(String maBinhLuan) {

        String sql = """
                UPDATE BINH_LUAN
                SET TrangThai = N'Đã duyệt'
                WHERE MaBinhLuan = ?
                """;

        try (

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)

        ) {

            ps.setString(1, maBinhLuan);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    // ==========================
    // TỪ CHỐI BÌNH LUẬN
    // ==========================

    public boolean rejectComment(String maBinhLuan) {

        String sql = """
                UPDATE BINH_LUAN
                SET TrangThai = N'Từ chối'
                WHERE MaBinhLuan = ?
                """;

        try (

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)

        ) {

            ps.setString(1, maBinhLuan);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;

    }

    // ẩn bình luận
    public boolean hideComment(String maBinhLuan) {

        String sql = """
        UPDATE BINH_LUAN
        SET TrangThai = N'Đã ẩn'
        WHERE MaBinhLuan = ?
        """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, maBinhLuan);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }

    // xóa bình luận
    public boolean deleteComment(String maBinhLuan) {

        String sql = """
        DELETE FROM BINH_LUAN
        WHERE MaBinhLuan = ?
        """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, maBinhLuan);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

        }

        return false;
    }

}