package com.fptpoly.controller.admin;

import com.fptpoly.model.Report;
import com.fptpoly.service.ReportService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(
        name = "ReportController",
        urlPatterns = {
                "/admin/report",
                "/admin/revenue-report"
        }
)
public class ReportController extends HttpServlet {

    private ReportService reportService;

    @Override
    public void init() {
        reportService = new ReportService();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();

        /*
         * =========================================================
         * KIỂM TRA QUYỀN BÁO CÁO
         * =========================================================
         *
         * Q1/Admin: được phép truy cập tất cả chức năng.
         * Nhân viên: phải có Q13 mới được xem báo cáo doanh thu.
         */

        String role = (String) session.getAttribute("role");

        List<String> permissions =
                (List<String>) session.getAttribute("userPermissions");

        boolean isAdmin = "ADMIN".equalsIgnoreCase(role);

        boolean hasReportPermission =
                permissions != null && permissions.contains("Q13");

        if (!isAdmin && !hasReportPermission) {

            session.setAttribute(
                    "error",
                    "Bạn không có quyền truy cập chức năng Báo cáo doanh thu!"
            );

            response.sendRedirect(
                    request.getContextPath() + "/admin/dashboard"
            );

            return;
        }

        /*
         * =========================================================
         * SIDEBAR
         * =========================================================
         */

        request.setAttribute("currentPage", "report");

        /*
         * =========================================================
         * DỮ LIỆU BÁO CÁO
         * =========================================================
         */

        // Tổng doanh thu
        double doanhThu = reportService.getTotalRevenue();

        // Tổng doanh thu hôm nay
        double doanhThuHomNay = reportService.getTodayRevenue();

        // Tổng vé bán
        int tongVe = reportService.getTotalTicket();

        // Top phim
        List<Report> reports =
                reportService.getTopMovie();

        // Doanh thu theo ngày
        List<Report> revenueByDate =
                reportService.getRevenueByDate();

        // Top rạp
        List<Report> topCinema =
                reportService.getTopCinema();

        // Doanh thu theo tháng
        List<Report> revenueByMonth =
                reportService.getRevenueByMonth();

        // Doanh thu theo năm
        List<Report> revenueByYear =
                reportService.getRevenueByYear();

        // Trạng thái vé
        List<Report> bookingStatus =
                reportService.getBookingStatusReport();

        // Tỷ lệ lấp đầy ghế
        List<Report> seatOccupancy =
                reportService.getSeatOccupancy();

        /*
         * =========================================================
         * TRUYỀN DỮ LIỆU SANG JSP
         * =========================================================
         */

        request.setAttribute("doanhThu", doanhThu);
        request.setAttribute("doanhThuHomNay", doanhThuHomNay);
        request.setAttribute("tongVe", tongVe);

        request.setAttribute("reports", reports);
        request.setAttribute("revenueByDate", revenueByDate);
        request.setAttribute("topCinema", topCinema);
        request.setAttribute("revenueByMonth", revenueByMonth);
        request.setAttribute("revenueByYear", revenueByYear);
        request.setAttribute("bookingStatus", bookingStatus);
        request.setAttribute("seatOccupancy", seatOccupancy);

        /*
         * =========================================================
         * HIỂN THỊ TRANG BÁO CÁO
         * =========================================================
         */

        request.getRequestDispatcher(
                "/views/admin/report.jsp"
        ).forward(request, response);
    }
}