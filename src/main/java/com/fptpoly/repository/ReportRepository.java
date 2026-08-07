package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Report;
import com.fptpoly.model.TopMovie;
import com.fptpoly.model.DailyRevenue;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

public class ReportRepository {
    public Report getSummary() {

        Report report = new Report();

        String sql = """
        SELECT
            ISNULL(SUM(CASE
                WHEN TrangThai = N'Đã sử dụng'
                THEN TongTien
            END),0) AS TongDoanhThu,

            SUM(CASE
                WHEN TrangThai = N'Đã sử dụng'
                THEN 1
                ELSE 0
            END) AS TongVeBan,

            SUM(CASE
                WHEN TrangThai = N'Đã hủy'
                THEN 1
                ELSE 0
            END) AS TongVeHuy,

            (SELECT COUNT(*)
             FROM KHACH_HANG) AS TongKhachHang

        FROM DAT_VE
        """;

        try (

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()

        ) {

            if (rs.next()) {

                report.setTongDoanhThu(
                        rs.getBigDecimal("TongDoanhThu"));

                report.setTongVeBan(
                        rs.getInt("TongVeBan"));

                report.setTongVeHuy(
                        rs.getInt("TongVeHuy"));

                report.setTongKhachHang(
                        rs.getInt("TongKhachHang"));

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return report;

    }

    public List<TopMovie> getTopMovies() {

        List<TopMovie> list = new ArrayList<>();

        String sql = """
        SELECT

            p.TenPhim,

            COUNT(*) AS SoVe,

            SUM(dv.TongTien) AS DoanhThu

        FROM DAT_VE dv

        INNER JOIN CHI_TIET_DAT_VE ct
            ON dv.MaDatVe = ct.MaDatVe

        INNER JOIN SUAT_CHIEU sc
            ON ct.MaSuatChieu = sc.MaSuatChieu

        INNER JOIN PHIM p
            ON sc.MaPhim = p.MaPhim

        WHERE dv.TrangThai = N'Đã sử dụng'

        GROUP BY p.TenPhim

        ORDER BY SoVe DESC
        """;

        try (

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()

        ) {

            while (rs.next()) {

                TopMovie movie = new TopMovie();

                movie.setTenPhim(
                        rs.getString("TenPhim"));

                movie.setSoVe(
                        rs.getInt("SoVe"));

                movie.setDoanhThu(
                        rs.getBigDecimal("DoanhThu"));

                list.add(movie);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }

    public List<DailyRevenue> getDailyRevenue() {

        List<DailyRevenue> list = new ArrayList<>();

        String sql = """
        SELECT

            CAST(ThoiGianDat AS DATE) AS Ngay,

            SUM(TongTien) AS DoanhThu

        FROM DAT_VE

        WHERE TrangThai = N'Đã sử dụng'

        GROUP BY CAST(ThoiGianDat AS DATE)

        ORDER BY Ngay
        """;

        try (

                Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()

        ) {

            while (rs.next()) {

                DailyRevenue revenue = new DailyRevenue();

                revenue.setNgay(
                        rs.getDate("Ngay").toLocalDate());

                revenue.setDoanhThu(
                        rs.getBigDecimal("DoanhThu"));

                list.add(revenue);

            }

        } catch (Exception e) {

            e.printStackTrace();

        }

        return list;

    }
}
