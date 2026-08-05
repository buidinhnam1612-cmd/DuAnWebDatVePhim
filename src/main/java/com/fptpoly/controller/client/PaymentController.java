package com.fptpoly.controller.client;

import com.fptpoly.model.Booking;
import com.fptpoly.model.User;
import com.fptpoly.service.BookingService;
import com.fptpoly.service.TicketService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/payment")
public class PaymentController extends HttpServlet {

    private BookingService bookingService;
    private TicketService ticketService;

    @Override
    public void init() {

        bookingService = new BookingService();
        ticketService = new TicketService();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String bookingId = request.getParameter("bookingId");

        if (bookingId == null || bookingId.isBlank()) {

            response.sendRedirect(request.getContextPath() + "/");

            return;

        }

        request.setAttribute(
                "booking",
                bookingService.findBookingById(bookingId)
        );

        request.setAttribute(
                "details",
                bookingService.getBookingDetailByBookingId(bookingId)
        );

        request.getRequestDispatcher(
                "/views/client/payment.jsp"
        ).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("===== PAYMENT POST =====");

        String bookingId = request.getParameter("bookingId");

        System.out.println("bookingId = " + bookingId);

        response.getWriter().println("POST OK : " + bookingId);
    }

}