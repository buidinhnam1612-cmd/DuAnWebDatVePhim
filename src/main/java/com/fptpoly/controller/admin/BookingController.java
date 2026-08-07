package com.fptpoly.controller.admin;

import com.fptpoly.model.Booking;
import com.fptpoly.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/booking")
public class BookingController extends HttpServlet {

    private BookingService bookingService;

    @Override
    public void init() {
        bookingService = new BookingService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {

            case "search":
                searchBooking(request, response);
                break;

            default:
                loadBooking(request, response);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("updateStatus".equals(action)) {

            updateStatus(request, response);

        }

    }

    /**
     * Hiển thị danh sách đặt vé
     */
    private void loadBooking(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        List<Booking> list = bookingService.getAllBookings();

        request.setAttribute("bookingList", list);

        request.getRequestDispatcher("/views/admin/booking.jsp")
                .forward(request, response);

    }

    /**
     * Tìm kiếm
     */
    private void searchBooking(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Booking> list = bookingService.searchBooking(keyword);

        request.setAttribute("bookingList", list);

        request.getRequestDispatcher("/views/admin/booking.jsp")
                .forward(request, response);

    }

    /**
     * Cập nhật trạng thái
     */
    private void updateStatus(HttpServletRequest request,
                              HttpServletResponse response)
            throws IOException {

        String maDatVe = request.getParameter("maDatVe");

        String trangThai = request.getParameter("trangThai");

        bookingService.updateStatus(maDatVe, trangThai);

        response.sendRedirect(request.getContextPath() + "/admin/booking");

    }

}