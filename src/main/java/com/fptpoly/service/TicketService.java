package com.fptpoly.service;

import com.fptpoly.model.Booking;
import com.fptpoly.model.BookingDetail;
import com.fptpoly.model.User;
import com.fptpoly.utils.EmailUtil;

import java.util.List;

public class TicketService {

    private final BookingService bookingService;

    private final QRService qrService;

    public TicketService() {

        bookingService = new BookingService();

        qrService = new QRService();

    }

    public boolean sendTicket(String bookingId,
                              User user) {

        try {

            Booking booking =
                    bookingService.findBookingById(
                            bookingId
                    );

            if (booking == null) {

                return false;

            }

            List<BookingDetail> details =
                    bookingService.getBookingDetailByBookingId(
                            bookingId
                    );

            String qrPath =
                    qrService.createTicketQR(
                            booking,
                            details
                    );

            if (qrPath == null) {

                return false;

            }

            return EmailUtil.sendTicket(
                    user.getEmail(),
                    booking.getMaDatVe(),
                    qrPath
            );

        } catch (Exception e) {

            e.printStackTrace();

            return false;

        }

    }

}