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
    }

}