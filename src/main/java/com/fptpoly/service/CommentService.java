package com.fptpoly.service;

import com.fptpoly.model.Comment;
import com.fptpoly.repository.CommentRepository;

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
}