package com.fptpoly.model;

import java.sql.Timestamp;

public class Feedback {
    private String maFeedback;
    private String hoTen;
    private String email;
    private String noiDung;
    private Timestamp thoiGianGui;
    private String trangThai;
    private String maKhachHang;

    public Feedback() {}

    public Feedback(String maFeedback, String hoTen, String email, String noiDung, String maKhachHang) {
        this.maFeedback = maFeedback;
        this.hoTen = hoTen;
        this.email = email;
        this.noiDung = noiDung;
        this.maKhachHang = maKhachHang;
        this.trangThai = "Chưa xử lý";
    }

    // Getters and Setters...
    public String getMaFeedback() { return maFeedback; }
    public void setMaFeedback(String maFeedback) { this.maFeedback = maFeedback; }
    public String getHoTen() { return hoTen; }
    public void setHoTen(String hoTen) { this.hoTen = hoTen; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getNoiDung() { return noiDung; }
    public void setNoiDung(String noiDung) { this.noiDung = noiDung; }
    public Timestamp getThoiGianGui() { return thoiGianGui; }
    public void setThoiGianGui(Timestamp thoiGianGui) { this.thoiGianGui = thoiGianGui; }
    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
    public String getMaKhachHang() { return maKhachHang; }
    public void setMaKhachHang(String maKhachHang) { this.maKhachHang = maKhachHang; }
}