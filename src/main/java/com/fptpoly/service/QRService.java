package com.fptpoly.service;

import com.fptpoly.model.Booking;
import com.fptpoly.model.BookingDetail;
import com.fptpoly.utils.QRCodeUtil;

import java.util.List;

public class QRService {

    public String createTicketQR(Booking booking,
                                 List<BookingDetail> details) {

        StringBuilder content = new StringBuilder();

        content.append("Ma dat ve: ")
                .append(booking.getMaDatVe())
                .append("\n");

        content.append("Tong tien: ")
                .append(booking.getTongTien())
                .append("\n");

        content.append("Trang thai: ")
                .append(booking.getTrangThai())
                .append("\n");

        content.append("Danh sach ghe: ");

        for (BookingDetail detail : details) {

            content.append(detail.getMaGhe())
                    .append(" ");

        }

        return QRCodeUtil.generateQRCode(
                booking.getMaDatVe()
        );

    }

}