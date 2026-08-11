package com.fptpoly.controller.admin;

import com.fptpoly.model.Comment;
import com.fptpoly.service.CommentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/comment")
public class CommentController extends HttpServlet {

    private final CommentService commentService =
            new CommentService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("search".equals(action)) {

            searchComment(request, response);

        } else if ("detail".equals(action)) {

            detailComment(request, response);

        } else {

            showCommentList(request, response);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("update-status".equals(action)) {

            updateStatus(request, response);

        } else if ("delete".equals(action)) {

            deleteComment(request, response);

        } else {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/comment");
        }
    }

    /**
     * Hiển thị danh sách
     */
    private void showCommentList(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Comment> comments =
                commentService.getAllComments();

        request.setAttribute(
                "comments",
                comments);

        loadStatistics(request);

        request.setAttribute(
                "currentPage",
                "comment");

        request.getRequestDispatcher(
                        "/views/admin/comment.jsp")
                .forward(request, response);
    }

    /**
     * Tìm kiếm
     */
    private void searchComment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        if (keyword == null) {
            keyword = "";
        }

        keyword = keyword.trim();

        List<Comment> comments;

        if (keyword.isEmpty()) {

            comments =
                    commentService.getAllComments();

        } else {

            comments =
                    commentService.searchComment(keyword);
        }

        request.setAttribute(
                "comments",
                comments);

        request.setAttribute(
                "keyword",
                keyword);

        loadStatistics(request);

        request.setAttribute(
                "currentPage",
                "comment");

        request.getRequestDispatcher(
                        "/views/admin/comment.jsp")
                .forward(request, response);
    }

    /**
     * Xem chi tiết
     */
    private void detailComment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String maBinhLuan =
                request.getParameter("maBinhLuan");

        if (maBinhLuan == null ||
                maBinhLuan.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/comment");

            return;
        }

        Comment comment =
                commentService.getCommentById(
                        maBinhLuan);

        request.setAttribute(
                "comment",
                comment);

        request.setAttribute(
                "currentPage",
                "comment");

        request.getRequestDispatcher(
                        "/views/admin/comment-detail.jsp")
                .forward(request, response);
    }

    /**
     * Duyệt / Từ chối / Ẩn / Hiện lại
     */
    private void updateStatus(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String maBinhLuan =
                request.getParameter("maBinhLuan");

        String trangThai =
                request.getParameter("trangThai");

        if (maBinhLuan == null ||
                maBinhLuan.trim().isEmpty() ||
                trangThai == null ||
                trangThai.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/comment");

            return;
        }

        boolean success =
                commentService.updateStatus(
                        maBinhLuan,
                        trangThai);

        if (success) {

            request.getSession().setAttribute(
                    "success",
                    "Cập nhật trạng thái bình luận thành công.");

        } else {

            request.getSession().setAttribute(
                    "error",
                    "Cập nhật trạng thái bình luận thất bại.");
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/comment");
    }

    /**
     * Xóa bình luận
     */
    private void deleteComment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String maBinhLuan =
                request.getParameter("maBinhLuan");

        if (maBinhLuan == null ||
                maBinhLuan.trim().isEmpty()) {

            request.getSession().setAttribute(
                    "error",
                    "Mã bình luận không hợp lệ.");

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/comment");

            return;
        }

        boolean success =
                commentService.deleteComment(
                        maBinhLuan);

        if (success) {

            request.getSession().setAttribute(
                    "success",
                    "Xóa bình luận thành công.");

        } else {

            request.getSession().setAttribute(
                    "error",
                    "Xóa bình luận thất bại.");
        }

        response.sendRedirect(
                request.getContextPath()
                        + "/admin/comment");
    }

    /**
     * Thống kê
     */
    private void loadStatistics(
            HttpServletRequest request) {

        request.setAttribute(
                "pendingCount",
                commentService.countPending());

        request.setAttribute(
                "approvedCount",
                commentService.countApproved());

        request.setAttribute(
                "hiddenCount",
                commentService.countHidden());

        request.setAttribute(
                "rejectedCount",
                commentService.countRejected());
    }
}