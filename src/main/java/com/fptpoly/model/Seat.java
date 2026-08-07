package com.fptpoly.model;

public class Seat {

    private String maGhe;
    private String hangGhe;
    private int soGhe;
    private String loaiGhe;
    private String maPhong;

    public Seat() {
    }

    public Seat(String maGhe,
                String hangGhe,
                int soGhe,
                String loaiGhe,
                String maPhong) {

        this.maGhe = maGhe;
        this.hangGhe = hangGhe;
        this.soGhe = soGhe;
        this.loaiGhe = loaiGhe;
        this.maPhong = maPhong;
    }

    public String getMaGhe() {
        return maGhe;
    }

    public void setMaGhe(String maGhe) {
        this.maGhe = maGhe;
    }

    public String getHangGhe() {
        return hangGhe;
    }

    public void setHangGhe(String hangGhe) {
        this.hangGhe = hangGhe;
    }

    public int getSoGhe() {
        return soGhe;
    }

    public void setSoGhe(int soGhe) {
        this.soGhe = soGhe;
    }

    public String getLoaiGhe() {
        return loaiGhe;
    }

    public void setLoaiGhe(String loaiGhe) {
        this.loaiGhe = loaiGhe;
    }

    public String getMaPhong() {
        return maPhong;
    }

    public void setMaPhong(String maPhong) {
        this.maPhong = maPhong;
    }

    public String getTenGhe() {
        return hangGhe + soGhe;
    }
}