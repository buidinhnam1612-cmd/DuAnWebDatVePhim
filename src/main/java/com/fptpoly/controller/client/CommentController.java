package com.fptpoly.controller.client;

import com.fptpoly.model.Comment;
import com.fptpoly.model.User;
import com.fptpoly.repository.CommentRepository;

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

    private final CommentRepository commentRepository = new CommentRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String maPhim = request.getParameter("maPhim");
        String soSaoStr = request.getParameter("soSao");
        String noiDung = request.getParameter("noiDung");

        if (maPhim == null || maPhim.isBlank()
                || soSaoStr == null || soSaoStr.isBlank()
                || noiDung == null || noiDung.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/movies");
            return;
        }

        int soSao = 5;
        try {
            soSao = Integer.parseInt(soSaoStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        Comment comment = new Comment();
        comment.setMaPhim(maPhim);
        comment.setSoSao(soSao);
        comment.setNoiDung(noiDung.trim());
        comment.setMaKhachHang(user.getMaKhachHang());
        comment.setNgayTao(new Timestamp(System.currentTimeMillis()));

        commentRepository.insert(comment);

        response.sendRedirect(request.getContextPath() + "/movies?action=detail&id=" + maPhim);
    }
}
