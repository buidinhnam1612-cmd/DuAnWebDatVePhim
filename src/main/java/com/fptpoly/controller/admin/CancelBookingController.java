package com.fptpoly.controller.admin;

import com.fptpoly.model.Booking;
import com.fptpoly.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/cancel-booking")
public class CancelBookingController extends HttpServlet {

    private BookingService bookingService;

    @Override
    public void init() {
        bookingService = new BookingService();
    }

    /**
     * GET:
     * - Mở trang hỗ trợ hủy vé
     * - Nếu có mã đặt vé thì tra cứu thông tin vé
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        request.setAttribute("currentPage", "cancelBooking");

        String maDatVe = request.getParameter("maDatVe");

        if (maDatVe != null && !maDatVe.trim().isEmpty()) {

            maDatVe = maDatVe.trim();

            try {

                Booking booking = bookingService.findByMaDatVe(maDatVe);

                if (booking != null) {

                    request.setAttribute("booking", booking);

                } else {

                    request.setAttribute(
                            "error",
                            "Không tìm thấy mã đặt vé: " + maDatVe
                    );
                }

            } catch (Exception e) {

                request.setAttribute(
                        "error",
                        "Có lỗi xảy ra khi tra cứu vé."
                );

                e.printStackTrace();
            }
        }

        request.getRequestDispatcher(
                "/views/admin/cancel-booking.jsp"
        ).forward(request, response);
    }

    /**
     * POST:
     * - Nhận mã đặt vé
     * - Gọi supportCancelBooking()
     * - Hiển thị kết quả
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        request.setAttribute("currentPage", "cancelBooking");

        String maDatVe = request.getParameter("maDatVe");

        if (maDatVe == null || maDatVe.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Vui lòng nhập mã đặt vé!"
            );

            request.getRequestDispatcher(
                    "/views/admin/cancel-booking.jsp"
            ).forward(request, response);

            return;
        }

        maDatVe = maDatVe.trim();

        try {

            boolean success =
                    bookingService.supportCancelBooking(maDatVe);

            if (success) {

                request.setAttribute(
                        "success",
                        "Hủy vé thành công!"
                );

                /*
                 * Lấy lại thông tin vé sau khi hủy
                 * để JSP hiển thị trạng thái mới.
                 */
                Booking booking =
                        bookingService.findByMaDatVe(maDatVe);

                if (booking != null) {
                    request.setAttribute("booking", booking);
                }

            } else {

                request.setAttribute(
                        "error",
                        "Không thể hủy vé. Vé có thể đã được hủy, đã sử dụng hoặc không còn đủ thời gian hỗ trợ."
                );

                /*
                 * Nếu hủy thất bại vẫn lấy thông tin vé
                 * để hiển thị cho nhân viên.
                 */
                Booking booking =
                        bookingService.findByMaDatVe(maDatVe);

                if (booking != null) {
                    request.setAttribute("booking", booking);
                }
            }

        } catch (Exception e) {

            request.setAttribute(
                    "error",
                    "Có lỗi xảy ra trong quá trình hủy vé."
            );

            e.printStackTrace();

            try {

                Booking booking =
                        bookingService.findByMaDatVe(maDatVe);

                if (booking != null) {
                    request.setAttribute("booking", booking);
                }

            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        request.getRequestDispatcher(
                "/views/admin/cancel-booking.jsp"
        ).forward(request, response);
    }
}