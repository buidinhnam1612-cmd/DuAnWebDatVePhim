package com.fptpoly.model;

import java.sql.Timestamp;

public class Comment {

    private String maBinhLuan;
    private Integer soSao;
    private String noiDung;
    private Timestamp ngayTao;
    private String trangThai;

    private String maKhachHang;
    private String maPhim;

    // Thông tin hiển thị
    private String tenKhachHang;
    private String tenPhim;
    private int soSao;
    private String noiDung;
    private Timestamp ngayTao;
    private String maKhachHang;
    private String maPhim;
    private String tenKhachHang;

    public Comment() {
    }

    public Comment(String maBinhLuan, int soSao, String noiDung, Timestamp ngayTao, String maKhachHang, String maPhim) {
        this.maBinhLuan = maBinhLuan;
        this.soSao = soSao;
        this.noiDung = noiDung;
        this.ngayTao = ngayTao;
        this.maKhachHang = maKhachHang;
        this.maPhim = maPhim;
    }

    public String getMaBinhLuan() {
        return maBinhLuan;
    }

    public void setMaBinhLuan(String maBinhLuan) {
        this.maBinhLuan = maBinhLuan;
    }

    public Integer getSoSao() {
        return soSao;
    }

    public void setSoSao(Integer soSao) {
    public int getSoSao() {
        return soSao;
    }

    public void setSoSao(int soSao) {
        this.soSao = soSao;
    }

    public String getNoiDung() {
        return noiDung;
    }

    public void setNoiDung(String noiDung) {
        this.noiDung = noiDung;
    }

    public Timestamp getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(Timestamp ngayTao) {
        this.ngayTao = ngayTao;
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

    public String getMaPhim() {
        return maPhim;
    }

    public void setMaPhim(String maPhim) {
        this.maPhim = maPhim;
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
}
}
