package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReportRepository {

    public double getTotalRevenue() {

        String sql = """
                SELECT ISNULL(SUM(TongTien),0)
                FROM DAT_VE
                WHERE TrangThai = N'Đã thanh toán'
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getTotalTicket() {

        String sql = """
        SELECT COUNT(*)
        FROM CHI_TIET_DAT_VE CT
        JOIN DAT_VE DV
            ON CT.MaDatVe = DV.MaDatVe
        WHERE DV.TrangThai = N'Đã thanh toán'
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Report> getTopMovie() {

        List<Report> list = new ArrayList<>();

        String sql = """
        SELECT TOP 10
            P.TenPhim,
            R.TenRap,
            COUNT(*) AS SoVe,
            SUM(CT.GiaVe) AS DoanhThu
        FROM CHI_TIET_DAT_VE CT
        JOIN DAT_VE DV
            ON CT.MaDatVe = DV.MaDatVe
        JOIN SUAT_CHIEU SC
            ON CT.MaSuatChieu = SC.MaSuatChieu
        JOIN PHIM P
            ON SC.MaPhim = P.MaPhim
        JOIN PHONG_CHIEU PC
            ON SC.MaPhong = PC.MaPhong
        JOIN RAP R
            ON PC.MaRap = R.MaRap
        WHERE DV.TrangThai = N'Đã thanh toán'
        GROUP BY
            P.TenPhim,
            R.TenRap
        ORDER BY SoVe DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Report report = new Report();

                report.setTenPhim(rs.getString("TenPhim"));
                report.setTenRap(rs.getString("TenRap"));
                report.setSoVe(rs.getInt("SoVe"));
                report.setDoanhThu(rs.getBigDecimal("DoanhThu"));

                list.add(report);
            }

            System.out.println("Top Movie Size = " + list.size());

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Report> getRevenueByDate() {

        List<Report> list = new ArrayList<>();

        String sql = """
        SELECT
            CONVERT(varchar(10), ThoiGianDat, 103) AS Ngay,
            SUM(TongTien) AS DoanhThu
        FROM DAT_VE
        WHERE TrangThai = N'Đã thanh toán'
        GROUP BY CONVERT(varchar(10), ThoiGianDat, 103)
        ORDER BY MIN(ThoiGianDat) DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Report report = new Report();

                report.setNgay(rs.getString("Ngay"));
                report.setDoanhThu(rs.getBigDecimal("DoanhThu"));

                list.add(report);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Report> getTopCinema() {

        List<Report> list = new ArrayList<>();

        String sql = """
        SELECT
            R.TenRap,
            COUNT(*) AS TongVe,
            SUM(CT.GiaVe) AS DoanhThu
        FROM CHI_TIET_DAT_VE CT
        JOIN DAT_VE DV
            ON CT.MaDatVe = DV.MaDatVe
        JOIN SUAT_CHIEU SC
            ON CT.MaSuatChieu = SC.MaSuatChieu
        JOIN PHONG_CHIEU PC
            ON SC.MaPhong = PC.MaPhong
        JOIN RAP R
            ON PC.MaRap = R.MaRap
        WHERE DV.TrangThai = N'Đã thanh toán'
        GROUP BY
            R.TenRap
        ORDER BY DoanhThu DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Report report = new Report();

                report.setTenRap(rs.getString("TenRap"));
                report.setTongVe(rs.getInt("TongVe"));
                report.setDoanhThu(rs.getBigDecimal("DoanhThu"));

                list.add(report);

            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Report> getRevenueByMonth() {

        List<Report> list = new ArrayList<>();

        String sql = """
        SELECT
            MONTH(ThoiGianDat) AS Thang,
            YEAR(ThoiGianDat) AS Nam,
            SUM(TongTien) AS DoanhThu
        FROM DAT_VE
        WHERE TrangThai = N'Đã thanh toán'
        GROUP BY
            YEAR(ThoiGianDat),
            MONTH(ThoiGianDat)
        ORDER BY
            YEAR(ThoiGianDat) DESC,
            MONTH(ThoiGianDat) DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Report report = new Report();

                report.setThang(
                        rs.getInt("Thang") + "/" + rs.getInt("Nam")
                );

                report.setDoanhThu(
                        rs.getBigDecimal("DoanhThu")
                );

                list.add(report);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Report> getRevenueByYear() {

        List<Report> list = new ArrayList<>();

        String sql = """
        SELECT
            YEAR(ThoiGianDat) AS Nam,
            SUM(TongTien) AS DoanhThu
        FROM DAT_VE
        WHERE TrangThai = N'Đã thanh toán'
        GROUP BY YEAR(ThoiGianDat)
        ORDER BY Nam DESC
        """;


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {


            while (rs.next()) {

                Report report = new Report();

                report.setNam(
                        rs.getInt("Nam")
                );

                report.setDoanhThu(
                        rs.getBigDecimal("DoanhThu")
                );

                list.add(report);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }


        return list;
    }
    public List<Report> getBookingStatusReport() {

        List<Report> list = new ArrayList<>();

        String sql = """
        SELECT
            TrangThai,
            COUNT(*) AS SoLuong
        FROM DAT_VE
        GROUP BY TrangThai
        """;


        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){


            while(rs.next()){

                Report report = new Report();

                report.setTrangThai(
                        rs.getString("TrangThai")
                );


                report.setSoLuong(
                        rs.getInt("SoLuong")
                );


                list.add(report);

            }


        }catch(Exception e){
            e.printStackTrace();
        }


        return list;
    }
    public List<Report> getSeatOccupancy() {

        List<Report> list = new ArrayList<>();


        String sql = """
        SELECT
            P.TenPhim,
            COUNT(CT.MaGhe) AS GheDaDat,
            COUNT(G.MaGhe) AS TongGhe

        FROM SUAT_CHIEU SC

        JOIN PHIM P
        ON SC.MaPhim = P.MaPhim


        JOIN PHONG_CHIEU PC
        ON SC.MaPhong = PC.MaPhong


        JOIN GHE G
        ON PC.MaPhong = G.MaPhong


        LEFT JOIN CHI_TIET_DAT_VE CT
        ON SC.MaSuatChieu = CT.MaSuatChieu


        GROUP BY P.TenPhim
        """;


        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()){


            while(rs.next()){

                Report report = new Report();


                report.setTenPhim(
                        rs.getString("TenPhim")
                );


                report.setGheDaDat(
                        rs.getInt("GheDaDat")
                );


                report.setTongGhe(
                        rs.getInt("TongGhe")
                );


                if(report.getTongGhe() > 0){

                    double tiLe =
                            (double) report.getGheDaDat()
                                    / report.getTongGhe()
                                    * 100;


                    report.setTiLeLapDay(tiLe);

                }


                list.add(report);

            }


        }catch(Exception e){
            e.printStackTrace();
        }


        return list;
    }
    public double getTodayRevenue() {

        String sql = """
        SELECT ISNULL(SUM(TongTien),0)
        FROM DAT_VE
        WHERE TrangThai = N'Đã thanh toán'
        AND CAST(ThoiGianDat AS DATE) = CAST(GETDATE() AS DATE)
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}