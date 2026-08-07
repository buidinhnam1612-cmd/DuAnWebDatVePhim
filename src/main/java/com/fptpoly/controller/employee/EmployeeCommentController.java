package com.fptpoly.controller.employee;

import com.fptpoly.model.Comment;
import com.fptpoly.service.CommentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/employee/comment-management")
public class EmployeeCommentController extends HttpServlet {

    private CommentService commentService = new CommentService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");

        List<Comment> listComment;

        if (keyword == null || keyword.trim().isEmpty()) {

            listComment = commentService.getAllComment();

        } else {

            listComment = commentService.searchComment(keyword);

        }

        request.setAttribute("listComment", listComment);

        request.getRequestDispatcher("/views/employee/comment-management.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String maBinhLuan = request.getParameter("maBinhLuan");

        boolean success = false;

        switch (action) {

            case "approve":

                success = commentService.approveComment(maBinhLuan);
                break;

            case "reject":

                success = commentService.rejectComment(maBinhLuan);
                break;

            case "hide":

                success = commentService.hideComment(maBinhLuan);
                break;

            case "delete":

                success = commentService.deleteComment(maBinhLuan);
                break;

        }
        if (success) {

            request.getSession().setAttribute(
                    "message",
                    "Thao tác thành công!"
            );

        } else {

            request.getSession().setAttribute(
                    "message",
                    "Thao tác thất bại!"
            );

        }

        response.sendRedirect(
                request.getContextPath()
                        + "/employee/comment-management");
    }

}