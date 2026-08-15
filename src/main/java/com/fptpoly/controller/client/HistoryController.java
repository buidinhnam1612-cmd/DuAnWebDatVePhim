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
        String action = request.getParameter("action");
        String maDatVe = request.getParameter("maDatVe");

        if ("cancel".equalsIgnoreCase(action) && maDatVe != null && !maDatVe.trim().isEmpty()) {
            Booking booking = bookingRepository.getById(maDatVe);

            if (booking == null || !user.getMaKhachHang().equalsIgnoreCase(booking.getMaKhachHang())) {
                request.setAttribute("error", "Đơn đặt vé không hợp lệ!");
            } else if ("Đã hủy".equalsIgnoreCase(booking.getTrangThai())) {
                request.setAttribute("error", "Đơn đặt vé này đã được hủy trước đó!");
            } else {
                // Tiến hành cập nhật trạng thái đơn vé thành 'Đã hủy'
                boolean success = bookingRepository.cancelBooking(maDatVe);

                if (success) {
                    request.setAttribute("message", "Hủy vé thành công mã đơn: " + maDatVe);
                } else {
                    request.setAttribute("error", "Không thể hủy vé. Vui lòng thử lại sau!");
                }
            }
        }

        // Tải lại danh sách sau khi thực hiện hành động
        doGet(request, response);
    }
}