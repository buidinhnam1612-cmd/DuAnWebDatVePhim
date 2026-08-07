package com.fptpoly.service;

import com.fptpoly.model.DailyRevenue;
import com.fptpoly.model.Report;
import com.fptpoly.model.TopMovie;
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

    }

}