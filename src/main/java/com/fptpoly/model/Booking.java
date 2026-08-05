package com.fptpoly.model;

import java.time.LocalDateTime;

public class Booking {

    private String maDatVe;
    private LocalDateTime thoiGianDat;
    private double tongTien;
    private String trangThai;
    private String maKhachHang;
    private String maNhanVien;
    private String maVoucher;

    public Booking() {
    }

    public Booking(String maDatVe,
                   LocalDateTime thoiGianDat,
                   double tongTien,
                   String trangThai,
                   String maKhachHang,
                   String maNhanVien,
                   String maVoucher) {

        this.maDatVe = maDatVe;
        this.thoiGianDat = thoiGianDat;
        this.tongTien = tongTien;
        this.trangThai = trangThai;
        this.maKhachHang = maKhachHang;
        this.maNhanVien = maNhanVien;
        this.maVoucher = maVoucher;
    }

    public String getMaDatVe() {
        return maDatVe;
    }

    public void setMaDatVe(String maDatVe) {
        this.maDatVe = maDatVe;
    }

    public LocalDateTime getThoiGianDat() {
        return thoiGianDat;
    }

    public void setThoiGianDat(LocalDateTime thoiGianDat) {
        this.thoiGianDat = thoiGianDat;
    }

    public double getTongTien() {
        return tongTien;
    }

    public void setTongTien(double tongTien) {
        this.tongTien = tongTien;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public String getMaKhachHang() {
        return maKhachHang;
    }

    public void setMaKhachHang(String maKhachHang) {
        this.maKhachHang = maKhachHang;
    }

    public String getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(String maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public String getMaVoucher() {
        return maVoucher;
    }

    public void setMaVoucher(String maVoucher) {
        this.maVoucher = maVoucher;
    }
}