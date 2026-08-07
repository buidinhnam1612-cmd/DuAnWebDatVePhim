package com.fptpoly.controller.employee;

import com.fptpoly.model.Booking;
import com.fptpoly.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/employee/confirm-booking")
public class EmployeeConfirmBookingController extends HttpServlet {

    private BookingService bookingService = new BookingService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");

        if (keyword != null && !keyword.trim().isEmpty()) {

            Booking booking = bookingService.getBookingByCode(keyword);

            if (booking == null) {

                request.setAttribute(
                        "message",
                        "Không tìm thấy vé."
                );

            } else {

                request.setAttribute(
                        "booking",
                        booking
                );

            }

        }

        request.getRequestDispatcher(
                "/views/employee/confirm-booking.jsp"
        ).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String maDatVe = request.getParameter("maDatVe");

        String message = bookingService.confirmBooking(maDatVe);

        request.getSession().setAttribute(
                "message",
                message
        );

        response.sendRedirect(
                request.getContextPath()
                        + "/employee/confirm-booking?keyword=" + maDatVe
        );

    }

}