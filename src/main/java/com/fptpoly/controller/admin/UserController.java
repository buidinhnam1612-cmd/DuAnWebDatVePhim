package com.fptpoly.controller.admin;

import com.fptpoly.model.User;
import com.fptpoly.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/user")
public class UserController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            action = "list";
        }

        switch (action) {

            case "search":

                String keyword = request.getParameter("keyword");

                List<User> searchList = userService.searchUsers(keyword);

                request.setAttribute("userList", searchList);

                break;

            case "list":
            default:

                List<User> userList = userService.getAllUsers();

                request.setAttribute("userList", userList);

                break;
        }

        request.getRequestDispatcher("/views/admin/user.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {

            String maKhachHang = request.getParameter("maKhachHang");
            String trangThai = request.getParameter("trangThai");

            boolean result = userService.updateStatus(maKhachHang, trangThai);

            if (result) {
                request.getSession().setAttribute("message",
                        "Cập nhật trạng thái thành công!");
            } else {
                request.getSession().setAttribute("message",
                        "Cập nhật trạng thái thất bại!");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/user");
    }

}