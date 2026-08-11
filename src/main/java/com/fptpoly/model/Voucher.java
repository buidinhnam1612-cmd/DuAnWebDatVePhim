package com.fptpoly.model;

import java.sql.Date;

public class Voucher {

    private String maVoucher;
    private String tenVoucher;
    private String maCode;
    private int phanTramGiam;
    private Date ngayBatDau;
    private Date ngayKetThuc;
    private int soLuong;
    private String trangThai;
    private int diemDoiVoucher;
    private double giamToiDa;

    public Voucher() {
    }

    public Voucher(String maVoucher, String tenVoucher, String maCode,
                   int phanTramGiam, Date ngayBatDau, Date ngayKetThuc,
                   int soLuong, String trangThai) {
        this.maVoucher = maVoucher;
        this.tenVoucher = tenVoucher;
        this.maCode = maCode;
        this.phanTramGiam = phanTramGiam;
        this.ngayBatDau = ngayBatDau;
        this.ngayKetThuc = ngayKetThuc;
        this.soLuong = soLuong;
        this.trangThai = trangThai;
    }

    public String getMaVoucher() {
        return maVoucher;
    }

    public void setMaVoucher(String maVoucher) {
        this.maVoucher = maVoucher;
    }

    public String getTenVoucher() {
        return tenVoucher;
    }

    public void setTenVoucher(String tenVoucher) {
        this.tenVoucher = tenVoucher;
    }

    public String getMaCode() {
        return maCode;
    }

    public void setMaCode(String maCode) {
        this.maCode = maCode;
    }

    public int getPhanTramGiam() {
        return phanTramGiam;
    }

    public void setPhanTramGiam(int phanTramGiam) {
        this.phanTramGiam = phanTramGiam;
    }

    public Date getNgayBatDau() {
        return ngayBatDau;
    }

    public void setNgayBatDau(Date ngayBatDau) {
        this.ngayBatDau = ngayBatDau;
    }

    public Date getNgayKetThuc() {
        return ngayKetThuc;
    }

    public void setNgayKetThuc(Date ngayKetThuc) {
        this.ngayKetThuc = ngayKetThuc;
    }

    public int getSoLuong() {
        return soLuong;
    }

    public void setSoLuong(int soLuong) {
        this.soLuong = soLuong;
    }

    public String getTrangThai() {
        return trangThai;
    }

    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    public int getDiemDoiVoucher() {
        return diemDoiVoucher;
    }

    public void setDiemDoiVoucher(int diemDoiVoucher) {
        this.diemDoiVoucher = diemDoiVoucher;
    }

    public double getGiamToiDa() {
        return giamToiDa;
    }

    public void setGiamToiDa(double giamToiDa) {
        this.giamToiDa = giamToiDa;
    }
}
