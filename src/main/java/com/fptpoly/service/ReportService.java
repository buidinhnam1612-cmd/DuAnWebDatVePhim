package com.fptpoly.service;

import com.fptpoly.model.Report;
import com.fptpoly.repository.ReportRepository;

import java.util.List;

public class ReportService {

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
    public double getTodayRevenue() {
        return repository.getTodayRevenue();
    }

}