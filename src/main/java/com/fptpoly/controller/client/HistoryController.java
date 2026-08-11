package com.fptpoly.controller.client;

import com.fptpoly.model.Booking;
import com.fptpoly.model.User;
import com.fptpoly.repository.BookingRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class HistoryController extends HttpServlet {

    private final BookingRepository bookingRepository = new BookingRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Booking> bookings = bookingRepository.getByKhachHang(user.getMaKhachHang());

        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/views/client/history.jsp").forward(request, response);
    }
}
