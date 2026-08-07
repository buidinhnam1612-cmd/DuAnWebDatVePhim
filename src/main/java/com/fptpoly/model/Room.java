package com.fptpoly.model;

public class Room {
    private String maPhong;
    private String tenPhong;
    private int tongSoGhe;
    private String maRap;

    public Room() {
    }

    public Room(String maPhong, String tenPhong, int tongSoGhe, String maRap) {
        this.maPhong = maPhong;
        this.tenPhong = tenPhong;
        this.tongSoGhe = tongSoGhe;
        this.maRap = maRap;
    }

    public String getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(String maPhong) {
        this.maPhong = maPhong;
    }

    public String getTenPhong() {
        return tenPhong;
    }

    public void setTenPhong(String tenPhong) {
        this.tenPhong = tenPhong;
    }

    public int getTongSoGhe() {
        return tongSoGhe;
    }

    public void setTongSoGhe(int tongSoGhe) {
        this.tongSoGhe = tongSoGhe;
    }

    public String getMaRap() {
        return maRap;
    }

    public void setMaRap(String maRap) {
        this.maRap = maRap;
    }
}
