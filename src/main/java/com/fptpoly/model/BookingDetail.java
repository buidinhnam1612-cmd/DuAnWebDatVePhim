package com.fptpoly.model;

import java.time.LocalDateTime;

public class BookingDetail {

    private String maChiTietDatVe;
    private String maDatVe;
    private String maGhe;
    private String maSuatChieu;
    private String trangThai;
    private LocalDateTime thoiGianGiuGhe;
    private double giaVe;

    public BookingDetail() {
    }

    public BookingDetail(String maChiTietDatVe,
                         String maDatVe,
                         String maGhe,
                         String maSuatChieu,
                         String trangThai,
                         LocalDateTime thoiGianGiuGhe,
                         double giaVe) {

        this.maChiTietDatVe = maChiTietDatVe;
        this.maDatVe = maDatVe;
        this.maGhe = maGhe;
        this.maSuatChieu = maSuatChieu;
        this.trangThai = trangThai;
        this.thoiGianGiuGhe = thoiGianGiuGhe;
        this.giaVe = giaVe;
    }

    public String getMaChiTietDatVe() {
        return maChiTietDatVe;
    }

    public void setMaChiTietDatVe(String maChiTietDatVe) {
        this.maChiTietDatVe = maChiTietDatVe;
    }

    public String getMaDatVe() {
        return maDatVe;
    }

    public void setMaDatVe(String maDatVe) {
        this.maDatVe = maDatVe;
    }

    public String getMaGhe() {
        return maGhe;
    }

    public void setMaGhe(String maGhe) {
        this.maGhe = maGhe;
    }

    public String getMaSuatChieu() {
        return maSuatChieu;
    }

    public void setMaSuatChieu(String maSuatChieu) {
        this.maSuatChieu = maSuatChieu;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public LocalDateTime getThoiGianGiuGhe() {
        return thoiGianGiuGhe;
    }

    public void setThoiGianGiuGhe(LocalDateTime thoiGianGiuGhe) {
        this.thoiGianGiuGhe = thoiGianGiuGhe;
    }

    public double getGiaVe() {
        return giaVe;
    }

    public void setGiaVe(double giaVe) {
        this.giaVe = giaVe;
    }
}