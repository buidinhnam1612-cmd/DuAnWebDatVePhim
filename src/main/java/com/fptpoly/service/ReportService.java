package com.fptpoly.service;

import com.fptpoly.model.DailyRevenue;
import com.fptpoly.model.Report;
import com.fptpoly.model.TopMovie;
import com.fptpoly.model.Report;
import com.fptpoly.repository.ReportRepository;

import java.util.List;

public class ReportService {

    private ReportRepository reportRepository = new ReportRepository();

    // Tổng quan báo cáo
    public Report getSummary() {

        return reportRepository.getSummary();

    }

    // Top phim bán chạy
    public List<TopMovie> getTopMovies() {

        return reportRepository.getTopMovies();

    }

    // Doanh thu theo ngày
    public List<DailyRevenue> getDailyRevenue() {

        return reportRepository.getDailyRevenue();
    private ReportRepository repository;

    public ReportService() {
        repository = new ReportRepository();
    }

    public double getTotalRevenue() {
        return repository.getTotalRevenue();
    }

    public int getTotalTicket() {
        return repository.getTotalTicket();
    }

    public List<Report> getTopMovie() {
        return repository.getTopMovie();
    }
    public List<Report> getRevenueByDate() {
        return repository.getRevenueByDate();
    }
    public List<Report> getTopCinema() {
        return repository.getTopCinema();
    }
    public List<Report> getRevenueByMonth(){

        return repository.getRevenueByMonth();

    }
    // Doanh thu theo năm
    public List<Report> getRevenueByYear() {

        return repository.getRevenueByYear();

    }


    // Thống kê trạng thái vé
    public List<Report> getBookingStatusReport() {

        return repository.getBookingStatusReport();

    }


    // Tỷ lệ lấp đầy ghế
    public List<Report> getSeatOccupancy() {

        return repository.getSeatOccupancy();

    }

}