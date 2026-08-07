package com.fptpoly.model;

import java.math.BigDecimal;

public class Food {
    private String maDoAnUong;
    private String tenDoAnUong;
    private BigDecimal gia;
    private String hinhAnh;
    private String trangThai;

    public Food() {}

    public Food(String maDoAnUong, String tenDoAnUong, BigDecimal gia, String hinhAnh, String trangThai) {
        this.maDoAnUong = maDoAnUong;
        this.tenDoAnUong = tenDoAnUong;
        this.gia = gia;
        this.hinhAnh = hinhAnh;
        this.trangThai = trangThai;
    }

    public String getMaDoAnUong() { return maDoAnUong; }
    public void setMaDoAnUong(String maDoAnUong) { this.maDoAnUong = maDoAnUong; }

    public String getTenDoAnUong() { return tenDoAnUong; }
    public void setTenDoAnUong(String tenDoAnUong) { this.tenDoAnUong = tenDoAnUong; }

    public BigDecimal getGia() { return gia; }
    public void setGia(BigDecimal gia) { this.gia = gia; }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}