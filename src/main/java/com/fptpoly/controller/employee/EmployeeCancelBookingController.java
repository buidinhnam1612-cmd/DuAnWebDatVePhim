package com.fptpoly.controller.employee;

import com.fptpoly.model.Booking;
import com.fptpoly.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/employee/cancel-booking")
public class EmployeeCancelBookingController extends HttpServlet {

    private BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");

        if (keyword != null && !keyword.trim().isEmpty()) {

            List<Booking> listBooking =
                    bookingService.searchBookingForCancel(keyword);

            request.setAttribute("listBooking", listBooking);

        }

        request.getRequestDispatcher("/views/employee/cancel-booking.jsp")
                .forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String maDatVe = request.getParameter("maDatVe");

        String message = bookingService.cancelBooking(maDatVe);

        request.setAttribute("message", message);

        String keyword = maDatVe;

        List<Booking> listBooking =
                bookingService.searchBookingForCancel(keyword);

        request.setAttribute("listBooking", listBooking);

        request.getRequestDispatcher("/views/employee/cancel-booking.jsp")
                .forward(request, response);

    }

}