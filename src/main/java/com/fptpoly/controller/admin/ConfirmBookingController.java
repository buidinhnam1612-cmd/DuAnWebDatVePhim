package com.fptpoly.controller.admin;

import com.fptpoly.model.Booking;
import com.fptpoly.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/confirm-booking")
public class ConfirmBookingController extends HttpServlet {

    private BookingService bookingService;

    @Override
    public void init() {
        bookingService = new BookingService();
    }

    /**
     * Hiển thị trang xác nhận vé
     *
     * GET:
     * /admin/confirm-booking
     *
     * GET tìm kiếm:
     * /admin/confirm-booking?maDatVe=DV01
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String maDatVe = request.getParameter("maDatVe");

        /*
         * Đặt currentPage để sidebar biết
         * đang ở trang xác nhận vé.
         */
        request.setAttribute(
                "currentPage",
                "confirm-booking"
        );

        /*
         * Nếu chưa nhập mã vé
         * thì chỉ hiển thị trang.
         */
        if (maDatVe != null && !maDatVe.trim().isEmpty()) {

            maDatVe = maDatVe.trim();

            Booking booking =
                    bookingService.getBookingById(maDatVe);

            /*
             * Không tìm thấy vé
             */
            if (booking == null) {

                request.setAttribute(
                        "error",
                        "Không tìm thấy vé với mã: " + maDatVe
                );

            } else {

                /*
                 * Tìm thấy vé
                 * → đưa thông tin sang JSP
                 */
                request.setAttribute(
                        "booking",
                        booking
                );
            }
        }

        /*
         * Hiển thị JSP
         */
        request.getRequestDispatcher(
                "/views/admin/confirm-booking.jsp"
        ).forward(request, response);
    }


    /**
     * Xử lý xác nhận khách đã sử dụng vé
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String maDatVe =
                request.getParameter("maDatVe");

        /*
         * Kiểm tra mã vé rỗng
         */
        if (maDatVe == null || maDatVe.trim().isEmpty()) {

            request.getSession().setAttribute(
                    "error",
                    "Vui lòng nhập mã vé."
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/confirm-booking"
            );

            return;
        }

        maDatVe = maDatVe.trim();

        /*
         * Tìm vé trong database
         */
        Booking booking =
                bookingService.getBookingById(maDatVe);

        /*
         * Không tìm thấy vé
         */
        if (booking == null) {

            request.getSession().setAttribute(
                    "error",
                    "Không tìm thấy vé với mã: " + maDatVe
            );

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/confirm-booking"
            );

            return;
        }

        /*
         * Lấy trạng thái hiện tại
         */
        String trangThai =
                booking.getTrangThai();


        /*
         * TRƯỜNG HỢP 1:
         * Vé đang chờ thanh toán
         */
        if ("Chờ thanh toán".equalsIgnoreCase(trangThai)) {

            request.getSession().setAttribute(
                    "error",
                    "Vé này đang chờ thanh toán, không thể xác nhận."
            );

        }


        /*
         * TRƯỜNG HỢP 2:
         * Vé đã sử dụng
         */
        else if ("Đã sử dụng".equalsIgnoreCase(trangThai)) {

            request.getSession().setAttribute(
                    "error",
                    "Bạn đã sử dụng vé này rồi."
            );

        }


        /*
         * TRƯỜNG HỢP 3:
         * Vé đã hủy
         */
        else if ("Đã hủy".equalsIgnoreCase(trangThai)) {

            request.getSession().setAttribute(
                    "error",
                    "Vé này đã bị hủy, không thể xác nhận."
            );

        }


        /*
         * TRƯỜNG HỢP 4:
         * Vé đã thanh toán
         *
         * Đây là trạng thái duy nhất
         * được phép xác nhận.
         */
        else if ("Đã thanh toán".equalsIgnoreCase(trangThai)) {

            boolean success =
                    bookingService.confirmBooking(maDatVe);

            if (success) {

                request.getSession().setAttribute(
                        "success",
                        "Xác nhận vé thành công."
                );

            } else {

                request.getSession().setAttribute(
                        "error",
                        "Xác nhận vé thất bại."
                );
            }

        }


        /*
         * TRƯỜNG HỢP 5:
         * Trạng thái không hợp lệ
         */
        else {

            request.getSession().setAttribute(
                    "error",
                    "Trạng thái vé không hợp lệ, không thể xác nhận."
            );
        }


        /*
         * Quay lại trang xác nhận vé
         */
        response.sendRedirect(
                request.getContextPath()
                        + "/admin/confirm-booking"
        );
    }
}