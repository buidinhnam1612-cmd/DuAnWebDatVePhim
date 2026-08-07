package com.fptpoly.model;

import java.math.BigDecimal;

public class Report {

    private BigDecimal tongDoanhThu;

    private int tongVeBan;

    private int tongVeHuy;

    private int tongKhachHang;

    public Report() {
    }

    public BigDecimal getTongDoanhThu() {
        return tongDoanhThu;
    }

    public void setTongDoanhThu(BigDecimal tongDoanhThu) {
        this.tongDoanhThu = tongDoanhThu;
    }

    public int getTongVeBan() {
        return tongVeBan;
    }

    public void setTongVeBan(int tongVeBan) {
        this.tongVeBan = tongVeBan;
    }

    public int getTongVeHuy() {
        return tongVeHuy;
    }

    public void setTongVeHuy(int tongVeHuy) {
        this.tongVeHuy = tongVeHuy;
    }

    public int getTongKhachHang() {
        return tongKhachHang;
    }

    public void setTongKhachHang(int tongKhachHang) {
        this.tongKhachHang = tongKhachHang;
    private String tenPhim;
    private String tenRap;
    private int soVe;
    private BigDecimal doanhThu;
    private String ngay;
    private int tongVe;
    private String thang;
    private int nam;
    private String trangThai;
    private int soLuong;
    private int gheDaDat;
    private int tongGhe;
    private double tiLeLapDay;

    public Report() {
    }

    public Report(String tenPhim, String tenRap, int soVe, BigDecimal doanhThu) {
        this.tenPhim = tenPhim;
        this.tenRap = tenRap;
        this.soVe = soVe;
        this.doanhThu = doanhThu;
    }

    public String getTenPhim() {
        return tenPhim;
    }

    public void setTenPhim(String tenPhim) {
        this.tenPhim = tenPhim;
    }

    public String getTenRap() {
        return tenRap;
    }

    public void setTenRap(String tenRap) {
        this.tenRap = tenRap;
    }

    public int getSoVe() {
        return soVe;
    }

    public void setSoVe(int soVe) {
        this.soVe = soVe;
    }

    public BigDecimal getDoanhThu() {
        return doanhThu;
    }

    public void setDoanhThu(BigDecimal doanhThu) {
        this.doanhThu = doanhThu;
    }
    public String getNgay() {
        return ngay;
    }

    public void setNgay(String ngay) {
        this.ngay = ngay;
    }
    public int getTongVe() {
        return tongVe;
    }

    public void setTongVe(int tongVe) {
        this.tongVe = tongVe;
    }
    public String getThang() {
        return thang;
    }

    public void setThang(String thang) {
        this.thang = thang;
    }
    public int getNam() {
        return nam;
    }

    public void setNam(int nam) {
        this.nam = nam;
    }


    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }


    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }


    public int getGheDaDat() {
        return gheDaDat;
    }

    public void setGheDaDat(int gheDaDat) {
        this.gheDaDat = gheDaDat;
    }


    public int getTongGhe() {
        return tongGhe;
    }

    public void setTongGhe(int tongGhe) {
        this.tongGhe = tongGhe;
    }


    public double getTiLeLapDay() {
        return tiLeLapDay;
    }

    public void setTiLeLapDay(double tiLeLapDay) {
        this.tiLeLapDay = tiLeLapDay;
    }

}