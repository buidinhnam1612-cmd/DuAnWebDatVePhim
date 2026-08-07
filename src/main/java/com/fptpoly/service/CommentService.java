package com.fptpoly.service;

import com.fptpoly.model.Comment;
import com.fptpoly.repository.CommentRepository;

import java.util.List;

public class CommentService {

    private CommentRepository commentRepository = new CommentRepository();

    // ==========================
    // LẤY TOÀN BỘ BÌNH LUẬN
    // ==========================

    public List<Comment> getAllComment() {

        return commentRepository.getAllComment();

    }

    // ==========================
    // TÌM KIẾM
    // ==========================

    public List<Comment> searchComment(String keyword) {

        return commentRepository.searchComment(keyword);

    }

    // ==========================
    // DUYỆT BÌNH LUẬN
    // ==========================

    public boolean approveComment(String maBinhLuan) {

        return commentRepository.approveComment(maBinhLuan);

    }

    // ==========================
    // TỪ CHỐI BÌNH LUẬN
    // ==========================

    public boolean rejectComment(String maBinhLuan) {

        return commentRepository.rejectComment(maBinhLuan);

    }
    // Ẩn bình luận
    public boolean hideComment(String maBinhLuan) {

        return commentRepository.hideComment(maBinhLuan);

    }

    // Xóa bình luận
    public boolean deleteComment(String maBinhLuan) {

        return commentRepository.deleteComment(maBinhLuan);

    }

}