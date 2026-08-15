package com.fptpoly.controller.admin;

import com.fptpoly.model.Booking;
import com.fptpoly.service.BookingService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/confirm-booking")
public class ConfirmBookingController extends HttpServlet {

    private BookingService bookingService;

    @Override
    public void init() {
        bookingService = new BookingService();
    }

    /**
     * Hiển thị trang xác nhận vé
     */
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Kiểm tra quyền Xác nhận trạng thái vé (Q08)
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        List<String> permissions = (List<String>) session.getAttribute("userPermissions");

        boolean isAdmin = "ADMIN".equalsIgnoreCase(role) || "VT01".equalsIgnoreCase(role);
        boolean hasPermission = isAdmin || (permissions != null && permissions.contains("Q08"));

        if (!hasPermission) {
            session.setAttribute("error", "Bạn không có quyền truy cập chức năng Xác nhận trạng thái vé này!");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        String maDatVe = request.getParameter("maDatVe");

        request.setAttribute("currentPage", "confirmBooking");

        /*
         * Nếu nhập mã vé thì tiến hành tra cứu
         */
        if (maDatVe != null && !maDatVe.trim().isEmpty()) {

            maDatVe = maDatVe.trim();
            Booking booking = bookingService.getBookingById(maDatVe);

            /*
             * Không tìm thấy vé
             */
            if (booking == null) {
                request.setAttribute("error", "Không tìm thấy đơn đặt vé nào với mã: " + maDatVe);
            } else {
                /*
                 * Tìm thấy vé → đưa thông tin sang JSP
                 */
                request.setAttribute("booking", booking);
            }
        }

        /*
         * Hiển thị JSP
         */
        request.getRequestDispatcher("/views/admin/confirm-booking.jsp").forward(request, response);
    }


    /**
     * Xử lý xác nhận khách đã sử dụng vé (Soát vé vào phòng chiếu)
     */
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        List<String> permissions = (List<String>) session.getAttribute("userPermissions");

        boolean isAdmin = "ADMIN".equalsIgnoreCase(role) || "VT01".equalsIgnoreCase(role);
        boolean hasPermission = isAdmin || (permissions != null && permissions.contains("Q08"));

        if (!hasPermission) {
            session.setAttribute("error", "Bảo mật hệ thống: Bạn không có quyền soát vé hay in vé!");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        String maDatVe = request.getParameter("maDatVe");

        /*
         * Kiểm tra mã vé rỗng
         */
        if (maDatVe == null || maDatVe.trim().isEmpty()) {
            request.getSession().setAttribute("error", "Vui lòng nhập mã vé.");
            response.sendRedirect(request.getContextPath() + "/admin/confirm-booking");
            return;
        }

        maDatVe = maDatVe.trim();

        /*
         * Tìm vé trong database
         */
        Booking booking = bookingService.getBookingById(maDatVe);

        /*
         * Không tìm thấy vé
         */
        if (booking == null) {
            request.getSession().setAttribute("error", "Không tìm thấy vé với mã: " + maDatVe);
            response.sendRedirect(request.getContextPath() + "/admin/confirm-booking");
            return;
        }

        /*
         * Lấy trạng thái hiện tại
         */
        String trangThai = booking.getTrangThai();

        /*
         * TRƯỜNG HỢP 1: Vé đang chờ thanh toán
         */
        if ("Chờ thanh toán".equalsIgnoreCase(trangThai)) {
            request.getSession().setAttribute("error", "Vé này đang chờ thanh toán, không thể xác nhận.");
        }

        /*
         * TRƯỜNG HỢP 2: Vé đã sử dụng
         */
        else if ("Đã sử dụng".equalsIgnoreCase(trangThai)) {
            request.getSession().setAttribute("error", "Hệ thống cảnh báo: Vé này đã được soát và sử dụng trước đó rồi.");
        }

        /*
         * TRƯỜNG HỢP 3: Vé đã hủy
         */
        else if ("Đã hủy".equalsIgnoreCase(trangThai)) {
            request.getSession().setAttribute("error", "Vé này đã bị hủy trên hệ thống, không thể xác nhận.");
        }

        /*
         * TRƯỜNG HỢP 4: Vé đã thanh toán (Được phép soát vé vào cổng)
         */
        else if ("Đã thanh toán".equalsIgnoreCase(trangThai)) {
            boolean success = bookingService.confirmBooking(maDatVe);

            if (success) {
                request.getSession().setAttribute("success", "Xác nhận trạng thái vé sang [Đã sử dụng] thành công.");
            } else {
                request.getSession().setAttribute("error", "Xác nhận soát vé thất bại.");
            }
        }

        /*
         * TRƯỜNG HỢP 5: Trạng thái không hợp lệ
         */
        else {
            request.getSession().setAttribute("error", "Trạng thái vé không hợp lệ, không thể xác nhận.");
        }

        /*
         * Quay lại trang xác nhận vé
         */
        response.sendRedirect(request.getContextPath() + "/admin/confirm-booking");
    }
}
