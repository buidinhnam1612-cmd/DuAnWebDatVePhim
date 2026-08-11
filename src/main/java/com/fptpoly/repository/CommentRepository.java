package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CommentRepository {

    /**
     * Lấy tất cả bình luận
     */
    public List<Comment> getAll() {

        List<Comment> list = new ArrayList<>();

        String sql = """
                SELECT
                    bl.MaBinhLuan,
                    bl.SoSao,
                    bl.NoiDung,
                    bl.NgayTao,
                    bl.TrangThai,
                    bl.MaKhachHang,
                    bl.MaPhim,
                    kh.HoTen AS TenKhachHang,
                    ph.TenPhim
                FROM BINH_LUAN bl
                INNER JOIN KHACH_HANG kh
                    ON bl.MaKhachHang = kh.MaKhachHang
                INNER JOIN PHIM ph
                    ON bl.MaPhim = ph.MaPhim
                ORDER BY bl.NgayTao DESC
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {
                list.add(mapResultSet(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Lấy bình luận theo mã
     */
    public Comment getById(String maBinhLuan) {

        String sql = """
                SELECT
                    bl.MaBinhLuan,
                    bl.SoSao,
                    bl.NoiDung,
                    bl.NgayTao,
                    bl.TrangThai,
                    bl.MaKhachHang,
                    bl.MaPhim,
                    kh.HoTen AS TenKhachHang,
                    ph.TenPhim
                FROM BINH_LUAN bl
                INNER JOIN KHACH_HANG kh
                    ON bl.MaKhachHang = kh.MaKhachHang
                INNER JOIN PHIM ph
                    ON bl.MaPhim = ph.MaPhim
                WHERE bl.MaBinhLuan = ?
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, maBinhLuan);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return mapResultSet(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Tìm kiếm bình luận
     */
    public List<Comment> search(String keyword) {

        List<Comment> list = new ArrayList<>();

        String sql = """
                SELECT
                    bl.MaBinhLuan,
                    bl.SoSao,
                    bl.NoiDung,
                    bl.NgayTao,
                    bl.TrangThai,
                    bl.MaKhachHang,
                    bl.MaPhim,
                    kh.HoTen AS TenKhachHang,
                    ph.TenPhim
                FROM BINH_LUAN bl
                INNER JOIN KHACH_HANG kh
                    ON bl.MaKhachHang = kh.MaKhachHang
                INNER JOIN PHIM ph
                    ON bl.MaPhim = ph.MaPhim
                WHERE
                    bl.MaBinhLuan LIKE ?
                    OR kh.HoTen LIKE ?
                    OR ph.TenPhim LIKE ?
                    OR bl.NoiDung LIKE ?
                ORDER BY bl.NgayTao DESC
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            ps.setString(4, search);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    list.add(mapResultSet(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Cập nhật trạng thái
     *
     * Dùng cho:
     * Chờ duyệt -> Đã duyệt
     * Chờ duyệt -> Từ chối
     * Đã duyệt -> Đã ẩn
     * Từ chối -> Đã ẩn
     * Đã ẩn -> Đã duyệt
     */
    public boolean updateStatus(
            String maBinhLuan,
            String trangThai) {

        String sql = """
                UPDATE BINH_LUAN
                SET TrangThai = ?
                WHERE MaBinhLuan = ?
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, trangThai);
            ps.setString(2, maBinhLuan);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Xóa bình luận
     */
    public boolean delete(String maBinhLuan) {

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

    /**
     * Đếm theo trạng thái
     */
    public int countByStatus(String trangThai) {

        String sql = """
                SELECT COUNT(*)
                FROM BINH_LUAN
                WHERE TrangThai = ?
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, trangThai);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Mapping ResultSet -> Comment
     */
    private Comment mapResultSet(ResultSet rs) throws Exception {

        Comment comment = new Comment();

        comment.setMaBinhLuan(
                rs.getString("MaBinhLuan"));

        comment.setSoSao(
                rs.getInt("SoSao"));

        comment.setNoiDung(
                rs.getString("NoiDung"));

        comment.setNgayTao(
                rs.getTimestamp("NgayTao"));

        comment.setTrangThai(
                rs.getString("TrangThai"));

        comment.setMaKhachHang(
                rs.getString("MaKhachHang"));

        comment.setMaPhim(
                rs.getString("MaPhim"));

        comment.setTenKhachHang(
                rs.getString("TenKhachHang"));

        comment.setTenPhim(
                rs.getString("TenPhim"));

        return comment;
    }
}