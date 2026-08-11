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
     */
    public boolean updateStatus(String maBinhLuan, String trangThai) {

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
     * Lấy bình luận theo mã phim
     */
    public List<Comment> getByMovie(String maPhim) {

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
                    kh.HoTen AS TenKhachHang
                FROM BINH_LUAN bl
                INNER JOIN KHACH_HANG kh
                    ON bl.MaKhachHang = kh.MaKhachHang
                WHERE bl.MaPhim = ?
                ORDER BY bl.NgayTao DESC
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, maPhim);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Comment comment = new Comment();

                    comment.setMaBinhLuan(
                            rs.getString("MaBinhLuan")
                    );

                    comment.setSoSao(
                            rs.getInt("SoSao")
                    );

                    comment.setNoiDung(
                            rs.getString("NoiDung")
                    );

                    comment.setNgayTao(
                            rs.getTimestamp("NgayTao")
                    );

                    comment.setTrangThai(
                            rs.getString("TrangThai")
                    );

                    comment.setMaKhachHang(
                            rs.getString("MaKhachHang")
                    );

                    comment.setMaPhim(
                            rs.getString("MaPhim")
                    );

                    comment.setTenKhachHang(
                            rs.getString("TenKhachHang")
                    );

                    list.add(comment);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * Tạo mã bình luận mới
     */
    public String generateCommentId() {

        String sql = """
                SELECT COALESCE(
                    MAX(
                        CAST(
                            SUBSTRING(MaBinhLuan, 3, LEN(MaBinhLuan))
                            AS INT
                        )
                    ),
                    0
                ) AS MaxNum
                FROM BINH_LUAN
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()
        ) {

            if (rs.next()) {

                int maxNum = rs.getInt("MaxNum");

                return String.format(
                        "BL%02d",
                        maxNum + 1
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "BL01";
    }

    /**
     * Thêm bình luận
     */
    public boolean insert(Comment comment) {

        if (comment.getMaBinhLuan() == null
                || comment.getMaBinhLuan().isBlank()) {

            comment.setMaBinhLuan(
                    generateCommentId()
            );
        }

        String sql = """
                INSERT INTO BINH_LUAN
                (
                    MaBinhLuan,
                    SoSao,
                    NoiDung,
                    NgayTao,
                    MaKhachHang,
                    MaPhim
                )
                VALUES (?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(
                    1,
                    comment.getMaBinhLuan()
            );

            ps.setInt(
                    2,
                    comment.getSoSao()
            );

            ps.setString(
                    3,
                    comment.getNoiDung()
            );

            ps.setTimestamp(
                    4,
                    comment.getNgayTao() != null
                            ? comment.getNgayTao()
                            : new Timestamp(System.currentTimeMillis())
            );

            ps.setString(
                    5,
                    comment.getMaKhachHang()
            );

            ps.setString(
                    6,
                    comment.getMaPhim()
            );

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Mapping ResultSet -> Comment
     */
    private Comment mapResultSet(ResultSet rs) throws Exception {

        Comment comment = new Comment();

        comment.setMaBinhLuan(
                rs.getString("MaBinhLuan")
        );

        comment.setSoSao(
                rs.getInt("SoSao")
        );

        comment.setNoiDung(
                rs.getString("NoiDung")
        );

        comment.setNgayTao(
                rs.getTimestamp("NgayTao")
        );

        comment.setTrangThai(
                rs.getString("TrangThai")
        );

        comment.setMaKhachHang(
                rs.getString("MaKhachHang")
        );

        comment.setMaPhim(
                rs.getString("MaPhim")
        );

        comment.setTenKhachHang(
                rs.getString("TenKhachHang")
        );

        comment.setTenPhim(
                rs.getString("TenPhim")
        );

        return comment;
    }
}