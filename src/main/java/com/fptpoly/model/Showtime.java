package com.fptpoly.model;

// Đổi lại tên package nếu dự án của bạn khác

import java.time.LocalDate;
import java.time.LocalTime;

public class Showtime {
    private String maSuatChieu;
    private LocalDate ngayChieu;
    private LocalTime gioBatDau;
    private LocalTime gioKetThuc;
    private String maPhim;
    private String maPhong;

    // Hàm khởi tạo không tham số (Constructor mặc định)
    public Showtime() {
    }

    // Hàm khởi tạo có đầy đủ tham số
    public Showtime(String maSuatChieu, LocalDate ngayChieu, LocalTime gioBatDau, LocalTime gioKetThuc, String maPhim, String maPhong) {
        this.maSuatChieu = maSuatChieu;
        this.ngayChieu = ngayChieu;
        this.gioBatDau = gioBatDau;
        this.gioKetThuc = gioKetThuc;
        this.maPhim = maPhim;
        this.maPhong = maPhong;
    }

    // Các hàm Getter và Setter để lấy và gán dữ liệu
    public String getMaSuatChieu() {
        return maSuatChieu;
    }

    public void setMaSuatChieu(String maSuatChieu) {
        this.maSuatChieu = maSuatChieu;
    }

    public LocalDate getNgayChieu() {
        return ngayChieu;
    }

    public void setNgayChieu(LocalDate ngayChieu) {
        this.ngayChieu = ngayChieu;
    }

    public LocalTime getGioBatDau() {
        return gioBatDau;
    }

    public void setGioBatDau(LocalTime gioBatDau) {
        this.gioBatDau = gioBatDau;
    }

    public LocalTime getGioKetThuc() {
        return gioKetThuc;
    }

    public void setGioKetThuc(LocalTime gioKetThuc) {
        this.gioKetThuc = gioKetThuc;
    }

    public String getMaPhim() {
        return maPhim;
    }

    public void setMaPhim(String maPhim) {
        this.maPhim = maPhim;
    }

    public String getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(String maPhong) {
        this.maPhong = maPhong;
    }
}
