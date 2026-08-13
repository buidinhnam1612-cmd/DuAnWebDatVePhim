package com.fptpoly.controller.admin;

import com.fptpoly.model.Report;
import com.fptpoly.service.ReportService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/revenue-report")
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

        // 🌟 BẢO MẬT: Kiểm tra quyền Báo cáo doanh thu rạp (Q13) từ Session chống bị đá ra ngoài
        HttpSession session = request.getSession();
        List<String> permissions = (List<String>) session.getAttribute("userPermissions");

        if (permissions == null || !permissions.contains("Q13")) {
            session.setAttribute("error", "Tài khoản của bạn không có quyền xem Báo cáo doanh thu!");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // 🌟 ĐỒNG BỘ SIDEBAR: Giúp menu Báo cáo doanh thu thắp sáng gạch đỏ khi đang xem
        request.setAttribute("currentPage", "report");

        // Tổng doanh thu
        double doanhThu = reportService.getTotalRevenue();

        // Tổng doanh thu hôm nay
        double doanhThuHomNay = reportService.getTodayRevenue();

        // Tổng vé bán
        int tongVe = reportService.getTotalTicket();

        // Top phim
        List<Report> reports = reportService.getTopMovie();

        // Doanh thu theo ngày
        List<Report> revenueByDate = reportService.getRevenueByDate();

        // Top rạp
        List<Report> topCinema = reportService.getTopCinema();

        // Doanh thu theo tháng
        List<Report> revenueByMonth = reportService.getRevenueByMonth();

        // Doanh thu theo năm (bổ sung)
        List<Report> revenueByYear = reportService.getRevenueByYear();

        // Trạng thái vé (bổ sung)
        List<Report> bookingStatus = reportService.getBookingStatusReport();

        // Tỷ lệ lấp đầy ghế (bổ sung)
        List<Report> seatOccupancy = reportService.getSeatOccupancy();

        // Nạp tất cả dữ liệu báo cáo sang trang JSP hiển thị
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

        // Hiển thị giao diện báo cáo doanh thu độc lập
        request.getRequestDispatcher("/views/admin/report.jsp").forward(request, response);
    }
}
