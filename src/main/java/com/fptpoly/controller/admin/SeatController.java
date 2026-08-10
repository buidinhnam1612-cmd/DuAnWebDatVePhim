package com.fptpoly.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/seat")
public class SeatController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String maPhong = request.getParameter("maPhong");
        if (maPhong == null) {
            maPhong = "P01";
        }

        request.setAttribute("selectedRoom", maPhong);
        request.getRequestDispatcher("/views/admin/seat.jsp").forward(request, response);
    }
}
