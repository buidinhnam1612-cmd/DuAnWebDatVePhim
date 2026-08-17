package com.fptpoly.controller.client;

import com.fptpoly.model.Comment;
import com.fptpoly.model.User;
import com.fptpoly.service.CommentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(name = "CommentController", urlPatterns = "/comment")
public class CommentController extends HttpServlet {

    private final CommentService commentService = new CommentService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String maPhim = request.getParameter("maPhim");
        if (maPhim == null || maPhim.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            if (session != null) {
                session.setAttribute("errorMsg", "Vui lòng đăng nhập trước khi đánh giá!");
            }
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String soSaoStr = request.getParameter("soSao");
        String noiDung = request.getParameter("noiDung");

        // Validate cơ bản ở mức Controller trước khi chuyển đổi
        if (soSaoStr == null || soSaoStr.isBlank()) {
            session.setAttribute("errorMsg", "Vui lòng chọn số sao đánh giá!");
            session.setAttribute("tempNoiDung", noiDung);
            response.sendRedirect(request.getContextPath() + "/movies?action=detail&id=" + maPhim);
            return;
        }
        if (noiDung == null || noiDung.trim().isEmpty()) {
            session.setAttribute("errorMsg", "Vui lòng nhập nội dung đánh giá!");
            session.setAttribute("tempSoSao", soSaoStr);
            response.sendRedirect(request.getContextPath() + "/movies?action=detail&id=" + maPhim);
            return;
        }

        int soSao = 5;
        try {
            soSao = Integer.parseInt(soSaoStr);
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "Số sao đánh giá phải là số nguyên hợp lệ!");
            session.setAttribute("tempNoiDung", noiDung);
            response.sendRedirect(request.getContextPath() + "/movies?action=detail&id=" + maPhim);
            return;
        }

        Comment comment = new Comment();
        comment.setMaPhim(maPhim);
        comment.setSoSao(soSao);
        comment.setNoiDung(noiDung.trim());
        comment.setMaKhachHang(user.getMaKhachHang());
        comment.setNgayTao(new Timestamp(System.currentTimeMillis()));

        try {
            commentService.addComment(comment);
            session.setAttribute("successMsg", "Đánh giá của bạn đã được gửi thành công và đang chờ duyệt!");
        } catch (IllegalArgumentException e) {
            session.setAttribute("errorMsg", e.getMessage());
            session.setAttribute("tempNoiDung", noiDung);
            session.setAttribute("tempSoSao", soSao);
        }

        response.sendRedirect(request.getContextPath() + "/movies?action=detail&id=" + maPhim);
    }
}
