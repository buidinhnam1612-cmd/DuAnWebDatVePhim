package com.fptpoly.controller.admin;

import com.fptpoly.model.Booking;
import com.fptpoly.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/admin/cancel-booking")
public class CancelBookingController extends HttpServlet {

    private BookingService bookingService;

    @Override
    public void init() {
        bookingService = new BookingService();
    }

    // =========================================================
    // GET - Mở trang và tra cứu vé
    // =========================================================
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        request.setAttribute("currentPage", "cancelBooking");

        String maDatVe = request.getParameter("maDatVe");

        if (maDatVe != null && !maDatVe.trim().isEmpty()) {

            maDatVe = maDatVe.trim();
            Booking booking = bookingService.getBookingById(maDatVe);

            if (booking != null) {
                request.setAttribute("booking", booking);
            } else {
                request.setAttribute("error", "Không tìm thấy mã đặt vé: " + maDatVe);
            }
        }

        request.getRequestDispatcher("/views/admin/cancel-booking.jsp")
                .forward(request, response);
    }

    // =========================================================
    // POST - Thực hiện hỗ trợ hủy vé
    // =========================================================
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        request.setAttribute("currentPage", "cancelBooking");

        String maDatVe = request.getParameter("maDatVe");

        // 1. Kiểm tra mã đặt vé
        if (maDatVe == null || maDatVe.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mã đặt vé!");
            forwardToPage(request, response);
            return;
        }

        maDatVe = maDatVe.trim();

        // 2. Tìm thông tin vé
        Booking booking = bookingService.getBookingById(maDatVe);

        if (booking == null) {
            request.setAttribute("error", "Không tìm thấy mã đặt vé: " + maDatVe);
            forwardToPage(request, response);
            return;
        }

        request.setAttribute("booking", booking);

        // 3. Kiểm tra trạng thái vé (Chỉ cho phép Chờ thanh toán)
        if (!"Chờ thanh toán".equalsIgnoreCase(booking.getTrangThai())) {
            request.setAttribute("error", "Chỉ có vé đang chờ thanh toán mới được phép hủy.");
            forwardToPage(request, response);
            return;
        }

        // 4. Kiểm tra ngày và giờ chiếu
        if (booking.getNgayChieu() == null || booking.getGioBatDau() == null) {
            request.setAttribute("error", "Không xác định được thời gian chiếu của vé.");
            forwardToPage(request, response);
            return;
        }

        // 5. Kiểm tra thời điểm hết hạn hủy (Trước giờ chiếu ít nhất 15 phút)
        LocalDateTime thoiGianChieu = LocalDateTime.of(
                booking.getNgayChieu().toLocalDate(),
                booking.getGioBatDau().toLocalTime()
        );

        LocalDateTime hanHuy = thoiGianChieu.minusMinutes(15);
        LocalDateTime hienTai = LocalDateTime.now();

        if (!hienTai.isBefore(hanHuy)) {
            request.setAttribute("error", "Không thể hủy vé. Vé chỉ được hủy trước giờ chiếu ít nhất 15 phút.");
            forwardToPage(request, response);
            return;
        }

        // 6. Đủ điều kiện -> Gọi hàm hủy vé
        boolean success = bookingService.supportCancelBooking(maDatVe);

        // 7. Xử lý thông báo kết quả
        if (success) {
            request.setAttribute("success", "Hủy vé " + maDatVe + " thành công!");
        } else {
            request.setAttribute("error", "Không thể hủy vé. Trạng thái vé có thể đã thay đổi.");
        }

        // Lấy lại thông tin vé sau khi cập nhật để làm mới giao diện
        Booking updatedBooking = bookingService.getBookingById(maDatVe);
        if (updatedBooking != null) {
            request.setAttribute("booking", updatedBooking);
        }

        forwardToPage(request, response);
    }

    private void forwardToPage(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/views/admin/cancel-booking.jsp")
                .forward(request, response);
    }
}