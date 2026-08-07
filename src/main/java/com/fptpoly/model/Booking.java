package com.fptpoly.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Booking {

    private String maDatVe;
    private Timestamp thoiGianDat;
    private BigDecimal tongTien;
    private String trangThai;
    private String maKhachHang;
    private String maNhanVien;
    private String maVoucher;
    // Thông tin hiển thị cho Admin
    private String tenKhachHang;
    private String tenPhim;
    private String tenRap;
    private String tenPhong;
    private String danhSachGhe;
    private String tenVoucher;
    private String tenNhanVien;

    private java.sql.Date ngayChieu;
    private java.sql.Time gioBatDau;

    private String hinhThucDat;

    public Booking() {
    }

    public Booking(String maDatVe, Timestamp thoiGianDat, BigDecimal tongTien,
                   String trangThai, String maKhachHang, String maNhanVien, String maVoucher) {
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

    public Timestamp getThoiGianDat() {
        return thoiGianDat;
    }

    public void setThoiGianDat(Timestamp thoiGianDat) {
        this.thoiGianDat = thoiGianDat;
    }

    public BigDecimal getTongTien() {
        return tongTien;
    }

    public void setTongTien(BigDecimal tongTien) {
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
    public String getTenKhachHang() {
        return tenKhachHang;
    }

    public void setTenKhachHang(String tenKhachHang) {
        this.tenKhachHang = tenKhachHang;
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

    public String getTenPhong() {
        return tenPhong;
    }

    public void setTenPhong(String tenPhong) {
        this.tenPhong = tenPhong;
    }

    public java.sql.Date getNgayChieu() {
        return ngayChieu;
    }

    public void setNgayChieu(java.sql.Date ngayChieu) {
        this.ngayChieu = ngayChieu;
    }

    public java.sql.Time getGioBatDau() {
        return gioBatDau;
    }

    public void setGioBatDau(java.sql.Time gioBatDau) {
        this.gioBatDau = gioBatDau;
    }

    public String getHinhThucDat() {
        return hinhThucDat;
    }

    public void setHinhThucDat(String hinhThucDat) {
        this.hinhThucDat = hinhThucDat;
    }
    public String getDanhSachGhe() {
        return danhSachGhe;
    }
    public void setDanhSachGhe(String danhSachGhe) {
        this.danhSachGhe = danhSachGhe;
    }
    public String getTenVoucher() {
        return tenVoucher;
    }

    public void setTenVoucher(String tenVoucher) {
        this.tenVoucher = tenVoucher;
    }
    public String getTenNhanVien() {
        return tenNhanVien;
    }

    public void setTenNhanVien(String tenNhanVien) {
        this.tenNhanVien = tenNhanVien;
    }

}