package com.fptpoly.model;

public class EmployeePermission {

    private String maNhanVien;
    private String hoTen;
    private String maQuyen;
    private String tenQuyen;
    private String moTa;
    private int trangThai; // 1 = BẬT (Được phép), 0 = TẮT (Không được phép)

    public EmployeePermission() {
    }

    public EmployeePermission(String maNhanVien, String hoTen, String maQuyen, String tenQuyen, String moTa, int trangThai) {
        this.maNhanVien = maNhanVien;
        this.hoTen = hoTen;
        this.maQuyen = maQuyen;
        this.tenQuyen = tenQuyen;
        this.moTa = moTa;
        this.trangThai = trangThai;
    }

    public String getMaNhanVien() {
        return maNhanVien;
    }

    public void setMaNhanVien(String maNhanVien) {
        this.maNhanVien = maNhanVien;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public String getMaQuyen() {
        return maQuyen;
    }

    public void setMaQuyen(String maQuyen) {
        this.maQuyen = maQuyen;
    }

    public String getTenQuyen() {
        return tenQuyen;
    }

    public void setTenQuyen(String tenQuyen) {
        this.tenQuyen = tenQuyen;
    }

    public String getMoTa() {
        return moTa;
    }

    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    public int getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(int trangThai) {
        this.trangThai = trangThai;
    }
}
