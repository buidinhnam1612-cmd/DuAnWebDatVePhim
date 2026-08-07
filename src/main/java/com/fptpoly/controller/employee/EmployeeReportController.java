package com.fptpoly.controller.employee;

import com.fptpoly.model.DailyRevenue;
import com.fptpoly.model.Report;
import com.fptpoly.model.TopMovie;
import com.fptpoly.service.ReportService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/employee/report")
public class EmployeeReportController extends HttpServlet {

    private ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Thống kê tổng quan
        Report report = reportService.getSummary();

        // Top phim bán chạy
        List<TopMovie> topMovies = reportService.getTopMovies();

        // Doanh thu theo ngày
        List<DailyRevenue> dailyRevenue = reportService.getDailyRevenue();

        request.setAttribute("report", report);
        request.setAttribute("topMovies", topMovies);
        request.setAttribute("dailyRevenue", dailyRevenue);

        request.getRequestDispatcher("/views/employee/report.jsp")
                .forward(request, response);
    }

}