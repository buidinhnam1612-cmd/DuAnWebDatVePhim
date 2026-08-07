package com.fptpoly.service;

import com.fptpoly.model.Booking;
import com.fptpoly.repository.BookingRepository;
import java.time.Duration;
import java.time.LocalDateTime;

import java.util.List;

public class BookingService {

    private BookingRepository bookingRepository = new BookingRepository();

    // Hiển thị toàn bộ danh sách đặt vé
    public List<Booking> getAllBooking() {
        return bookingRepository.getAllBooking();
    }

    // Tìm kiếm theo mã vé, SĐT hoặc Email
    public List<Booking> searchBooking(String keyword) {
        return bookingRepository.searchBooking(keyword);
    }
    // Hàm tìm kiếm vé
    public List<Booking> searchBookingForCancel(String keyword) {

        List<Booking> list = bookingRepository.searchBookingForCancel(keyword);

        LocalDateTime now = LocalDateTime.now();

        for (Booking booking : list) {

            if ("Đã hủy".equalsIgnoreCase(booking.getTrangThai())) {

                booking.setAllowCancel(false);
                continue;

            }

            long minute = Duration.between(
                    booking.getThoiGianDat(),
                    now
            ).toMinutes();

            booking.setAllowCancel(minute <= 30);

        }

        return list;
    }

    public String cancelBooking(String maDatVe) {

        Booking booking = bookingRepository.getBookingById(maDatVe);

        if (booking == null) {
            return "Không tìm thấy vé.";
        }

        if ("Đã hủy".equalsIgnoreCase(booking.getTrangThai())) {
            return "Vé này đã được hủy trước đó.";
        }
        // hàm hủyvé
        LocalDateTime thoiGianDat = booking.getThoiGianDat();

        LocalDateTime hienTai = LocalDateTime.now();

        long soPhut = Duration.between(thoiGianDat, hienTai).toMinutes();

        if (soPhut > 30) {
            return "Đã quá 30 phút kể từ khi đặt vé. Không thể hỗ trợ hủy.";
        }

        boolean success = bookingRepository.cancelBooking(maDatVe);

        if (success) {

            bookingRepository.cancelBookingDetail(maDatVe);

            return "Hủy vé thành công.";

        }

        return "Hủy vé thất bại.";
    }

    public Booking getBookingByCode(String maDatVe) {

        return bookingRepository.getBookingByCode(maDatVe);

    }

    public String confirmBooking(String maDatVe) {

        Booking booking = bookingRepository.getBookingByCode(maDatVe);

        if (booking == null) {

            return "Không tìm thấy vé.";

        }

        if ("Đã sử dụng".equalsIgnoreCase(booking.getTrangThai())) {

            return "Vé này đã được xác nhận trước đó.";

        }

        if ("Đã hủy".equalsIgnoreCase(booking.getTrangThai())) {

            return "Vé đã bị hủy, không thể xác nhận.";

        }

        boolean success = bookingRepository.confirmBooking(maDatVe);

        if (success) {

            return "Xác nhận vé thành công.";

        }

        return "Xác nhận vé thất bại.";

    }

}