package com.fptpoly.model;

public class Theater {
    // Sửa chữ cái đầu thành viết thường theo chuẩn Java
    private String maRap;
    private String tenRap;
    private String diaChi;
    private String hotLine;
    private String hinhAnh;

    public Theater() {
    }

    public Theater(String maRap, String tenRap, String diaChi, String hotLine, String hinhAnh) {
        this.maRap = maRap;
        this.tenRap = tenRap;
        this.diaChi = diaChi;
        this.hotLine = hotLine;
        this.hinhAnh = hinhAnh;
    }

    // Các hàm Getter và Setter chuẩn hóa
    public String getMaRap() {
        return maRap;
    }

    public void setMaRap(String maRap) {
        this.maRap = maRap;
    }

    public String getTenRap() {
        return tenRap;
    }

    public void setTenRap(String tenRap) {
        this.tenRap = tenRap;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getHotLine() {
        return hotLine;
    }

    public void setHotLine(String hotLine) {
        this.hotLine = hotLine;
    }

    public String getHinhAnh() {
        return hinhAnh;
    }

    public void setHinhAnh(String hinhAnh) {
        this.hinhAnh = hinhAnh;
    }
}
