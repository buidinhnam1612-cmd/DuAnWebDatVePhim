package com.fptpoly.model;

public class Food {

    private String maDoAn;
    private String tenDoAn;
    private double gia;
    private int soLuong;
    private String trangThai;
    private String hinhAnh;
    private String loai;

    public Food() {
    }

    public Food(String maDoAn, String tenDoAn, double gia, int soLuong, String trangThai, String hinhAnh, String loai) {
        this.maDoAn = maDoAn;
        this.tenDoAn = tenDoAn;
        this.gia = gia;
        this.soLuong = soLuong;
        this.trangThai = trangThai;
        this.hinhAnh = hinhAnh;
        this.loai = loai;
    }

    public String getMaDoAn() {
        return maDoAn;
    }

    public void setMaDoAn(String maDoAn) {
        this.maDoAn = maDoAn;
    }

    public String getTenDoAn() {
        return tenDoAn;
    }

    public void setTenDoAn(String tenDoAn) {
        this.tenDoAn = tenDoAn;
    }

    public double getGia() {
        return gia;
    }

    public void setGia(double gia) {
        this.gia = gia;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }

    public String getLoai() {
        return loai;
    }

    public void setLoai(String loai) {
        this.loai = loai;
    }
}
