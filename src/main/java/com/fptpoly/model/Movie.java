package com.fptpoly.model;

import java.time.LocalDate;
import java.sql.Date;

public class Movie {
    private String maPhim;
    private String tenPhim;
    private String moTa;
    private int thoiLuong;
    private String trailer;
    private String poster;
    private Date ngayKhoiChieu;
    private String doTuoiGiaiTri;
    private String trangThai;

    public Movie() {
    }

    public Movie(String maPhim, String tenPhim, String moTa, int thoiLuong, String trailer, String poster, Date ngayKhoiChieu, String doTuoiGiaiTri, String trangThai) {
        this.maPhim = maPhim;
        this.tenPhim = tenPhim;
        this.moTa = moTa;
        this.thoiLuong = thoiLuong;
        this.trailer = trailer;
        this.poster = poster;
        this.ngayKhoiChieu = ngayKhoiChieu;
        this.doTuoiGiaiTri = doTuoiGiaiTri;
        this.trangThai = trangThai;
    }

    public String getMaPhim() {
        return maPhim;
    }

    public void setMaPhim(String maPhim) {
        this.maPhim = maPhim;
    }

    public String getTenPhim() {
        return tenPhim;
    }

    public void setTenPhim(String tenPhim) {
        this.tenPhim = tenPhim;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public int getThoiLuong() {
        return thoiLuong;
    }

    public void setThoiLuong(int thoiLuong) {
        this.thoiLuong = thoiLuong;
    }

    public String getTrailer() {
        return trailer;
    }

    public void setTrailer(String trailer) {
        this.trailer = trailer;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public Date getNgayKhoiChieu() {
        return ngayKhoiChieu;
    }

    public void setNgayKhoiChieu(Date ngayKhoiChieu) {
        this.ngayKhoiChieu = ngayKhoiChieu;
    }

    public String getDoTuoiGiaiTri() {
        return doTuoiGiaiTri;
    }

    public void setDoTuoiGiaiTri(String doTuoiGiaiTri) {
        this.doTuoiGiaiTri = doTuoiGiaiTri;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }
}