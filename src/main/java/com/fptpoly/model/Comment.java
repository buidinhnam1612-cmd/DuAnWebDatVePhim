package com.fptpoly.model;

import java.time.LocalDateTime;

public class Comment {

    private String maBinhLuan;

    private String hoTen;

    private String tenPhim;

    private int soSao;

    private String noiDung;

    private LocalDateTime ngayTao;

    private String trangThai;

    public Comment() {
    }

    public String getMaBinhLuan() {
        return maBinhLuan;
    }

    public void setMaBinhLuan(String maBinhLuan) {
        this.maBinhLuan = maBinhLuan;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getTenPhim() {
        return tenPhim;
    }

    public void setTenPhim(String tenPhim) {
        this.tenPhim = tenPhim;
    }

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

    public LocalDateTime getNgayTao() {
        return ngayTao;
    }

    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

}