package com.fptpoly.service;

import com.fptpoly.model.Comment;
import com.fptpoly.repository.CommentRepository;
import com.fptpoly.repository.MovieRepository;

import java.util.List;

public class CommentService {

    private final CommentRepository commentRepository =
            new CommentRepository();

    /**
     * Lấy tất cả bình luận
     */
    public List<Comment> getAllComments() {
        return commentRepository.getAll();
    }

    /**
     * Lấy bình luận theo mã
     */
    public Comment getCommentById(String maBinhLuan) {

        if (maBinhLuan == null ||
                maBinhLuan.trim().isEmpty()) {

            return null;
        }

        return commentRepository.getById(maBinhLuan);
    }

    /**
     * Tìm kiếm
     */
    public List<Comment> searchComment(String keyword) {

        if (keyword == null) {
            keyword = "";
        }

        return commentRepository.search(keyword.trim());
    }

    /**
     * Cập nhật trạng thái
     */
    public boolean updateStatus(
            String maBinhLuan,
            String trangThai) {

        if (maBinhLuan == null ||
                maBinhLuan.trim().isEmpty()) {

            return false;
        }

        if (trangThai == null ||
                trangThai.trim().isEmpty()) {

            return false;
        }

        return commentRepository.updateStatus(
                maBinhLuan,
                trangThai);
    }

    /**
     * Xóa bình luận
     */
    public boolean deleteComment(String maBinhLuan) {

        if (maBinhLuan == null ||
                maBinhLuan.trim().isEmpty()) {

            return false;
        }

        return commentRepository.delete(maBinhLuan);
    }

    /**
     * Bình luận chờ duyệt
     */
    public int countPending() {
        return commentRepository.countByStatus("Chờ duyệt");
    }

    /**
     * Bình luận đã duyệt
     */
    public int countApproved() {
        return commentRepository.countByStatus("Đã duyệt");
    }

    /**
     * Bình luận đã ẩn
     */
    public int countHidden() {
        return commentRepository.countByStatus("Đã ẩn");
    }

    /**
     * Bình luận bị từ chối
     */
    public int countRejected() {
        return commentRepository.countByStatus("Từ chối");
    }

    private final MovieRepository movieRepository = new MovieRepository();

    /**
     * Thêm bình luận mới với các bước validate nghiệp vụ bắt buộc
     */
    public boolean addComment(Comment comment) {
        if (comment == null) {
            throw new IllegalArgumentException("Dữ liệu đánh giá không hợp lệ!");
        }

        // 1. Kiểm tra MaPhim
        if (comment.getMaPhim() == null || comment.getMaPhim().isBlank()) {
            throw new IllegalArgumentException("Mã phim không được để trống!");
        }
        if (movieRepository.getByID(comment.getMaPhim()) == null) {
            throw new IllegalArgumentException("Phim không tồn tại!");
        }

        // 2. Kiểm tra MaKhachHang
        if (comment.getMaKhachHang() == null || comment.getMaKhachHang().isBlank()) {
            throw new IllegalArgumentException("Mã khách hàng không được để trống!");
        }

        // 3. Validate rating (1 -> 5)
        if (comment.getSoSao() == null || comment.getSoSao() < 1 || comment.getSoSao() > 5) {
            throw new IllegalArgumentException("Số sao đánh giá không hợp lệ! Vui lòng chọn từ 1 đến 5 sao.");
        }

        // 4. Validate nội dung không rỗng
        if (comment.getNoiDung() == null || comment.getNoiDung().trim().isEmpty()) {
            throw new IllegalArgumentException("Nội dung đánh giá không được để trống!");
        }

        // 5. Kiểm tra khách hàng đã đánh giá phim này chưa
        if (commentRepository.hasReviewed(comment.getMaKhachHang(), comment.getMaPhim())) {
            throw new IllegalArgumentException("Bạn đã đánh giá bộ phim này rồi! Mỗi khách hàng chỉ được đánh giá một phim một lần.");
        }

        // Đặt mặc định trạng thái và ngày tạo
        comment.setTrangThai("Chờ duyệt");
        if (comment.getNgayTao() == null) {
            comment.setNgayTao(new java.sql.Timestamp(System.currentTimeMillis()));
        }

        return commentRepository.insert(comment);
    }

    /**
     * Lấy danh sách bình luận theo phim và người dùng đăng nhập hiện tại
     */
    public List<Comment> getCommentsByMovie(String maPhim, String maKhachHang) {
        if (maPhim == null || maPhim.isBlank()) {
            return java.util.Collections.emptyList();
        }
        return commentRepository.getByMovie(maPhim, maKhachHang);
    }
}