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
     * Tìm kiếm bình luận chuẩn hóa
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
                    UPPER(bl.MaBinhLuan) LIKE UPPER(?)
                    OR UPPER(kh.HoTen) LIKE UPPER(?)
                    OR UPPER(ph.TenPhim) LIKE UPPER(?)
                    OR UPPER(bl.NoiDung) LIKE UPPER(?)
                ORDER BY bl.NgayTao DESC
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            String search = (keyword != null) ? "%" + keyword.trim() + "%" : "%%";

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
     * Cập nhật trạng thái duyệt bình luận
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
     * Đếm theo trạng thái duyệt
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
     * Lấy danh sách bình luận theo mã phim hiển thị ra trang chi tiết phim
     */
    public List<Comment> getByMovie(String maPhim) {
        return getByMovie(maPhim, null);
    }

    /**
     * Lấy danh sách bình luận theo mã phim và mã khách hàng để lấy thêm bình luận chờ duyệt của chính khách hàng đó
     */
    public List<Comment> getByMovie(String maPhim, String maKhachHang) {
        List<Comment> list = new ArrayList<>();
        String sql;
        boolean hasUser = (maKhachHang != null && !maKhachHang.isBlank());

        if (hasUser) {
            sql = """
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
                    AND (bl.TrangThai = N'Đã duyệt' OR bl.MaKhachHang = ?)
                ORDER BY bl.NgayTao DESC
                """;
        } else {
            sql = """
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
                    AND bl.TrangThai = N'Đã duyệt'
                ORDER BY bl.NgayTao DESC
                """;
        }
        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setString(1, maPhim);
            if (hasUser) {
                ps.setString(2, maKhachHang);
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Comment c = new Comment();
                    c.setMaBinhLuan(rs.getString("MaBinhLuan"));
                    c.setSoSao(rs.getInt("SoSao"));
                    c.setNoiDung(rs.getString("NoiDung"));

                    // Gán trực tiếp đối tượng Timestamp đồng bộ chuẩn xác với Model Comment mới của bạn
                    c.setNgayTao(rs.getTimestamp("NgayTao"));

                    c.setMaKhachHang(rs.getString("MaKhachHang"));
                    c.setMaPhim(rs.getString("MaPhim"));
                    c.setTenKhachHang(rs.getString("TenKhachHang"));
                    c.setTrangThai(rs.getString("TrangThai"));

                    list.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Kiểm tra xem khách hàng đã đánh giá bộ phim này hay chưa
     */
    public boolean hasReviewed(String maKhachHang, String maPhim) {
        String sql = """
                SELECT COUNT(*)
                FROM BINH_LUAN
                WHERE MaKhachHang = ? AND MaPhim = ?
                """;
        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, maKhachHang);
            ps.setString(2, maPhim);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    /**
     * Thêm mới bình luận từ khách hàng
     */
    public boolean insert(Comment comment) {
        if (comment.getMaBinhLuan() == null || comment.getMaBinhLuan().isBlank()) {
            String uniqueId = "BL_" + java.util.UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            comment.setMaBinhLuan(uniqueId);
        }

        String sql = """
                INSERT INTO BINH_LUAN (MaBinhLuan, SoSao, NoiDung, NgayTao, MaKhachHang, MaPhim, TrangThai)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, comment.getMaBinhLuan());
            ps.setInt(2, comment.getSoSao());
            ps.setString(3, comment.getNoiDung());

            // Xử lý kiểm tra gán Timestamp chuẩn chỉnh trực tiếp
            if (comment.getNgayTao() != null) {
                ps.setTimestamp(4, comment.getNgayTao());
            } else {
                ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            }

            ps.setString(5, comment.getMaKhachHang());
            ps.setString(6, comment.getMaPhim());
            ps.setString(7, "Chờ duyệt");

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // ===================== HÀM MAP DỮ LIỆU TỪ RESULTSET SANG MODEL COMMENT =====================
    private Comment mapResultSet(ResultSet rs) throws Exception {
        Comment comment = new Comment();

        comment.setMaBinhLuan(rs.getString("MaBinhLuan"));
        comment.setSoSao(rs.getInt("SoSao"));
        comment.setNoiDung(rs.getString("NoiDung"));

        // Nhận dữ liệu kiểu Timestamp đồng bộ chính xác với file Comment.java
        comment.setNgayTao(rs.getTimestamp("NgayTao"));

        comment.setTrangThai(rs.getString("TrangThai"));
        comment.setMaKhachHang(rs.getString("MaKhachHang"));
        comment.setMaPhim(rs.getString("MaPhim"));

        try {
            comment.setTenKhachHang(rs.getString("TenKhachHang"));
            comment.setTenPhim(rs.getString("TenPhim"));
        } catch (Exception ignored) {}

        return comment;
    }
}
