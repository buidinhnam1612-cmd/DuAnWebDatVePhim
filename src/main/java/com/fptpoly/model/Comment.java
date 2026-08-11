package com.fptpoly.model;

import java.sql.Timestamp;

public class Comment {

    private String maBinhLuan;
    private Integer soSao; // Dùng Integer để đồng bộ tốt với giá trị null hoặc int
    private String noiDung;
    private Timestamp ngayTao;
    private String trangThai; // Giữ lại để xử lý bộ lọc ẩn/hiện bình luận trên giao diện

    private String maKhachHang;
    private String maPhim;

    // Thông tin hiển thị mở rộng (Lấy từ câu lệnh INNER JOIN sang các bảng khác)
    private String tenKhachHang;
    private String tenPhim;

    // 1. Hàm khởi tạo không tham số (Bắt buộc cho JDBC)
    public Comment() {
    }

    // 2. Hàm khởi tạo đầy đủ tham số cốt lõi
    public Comment(String maBinhLuan, Integer soSao, String noiDung, Timestamp ngayTao, String maKhachHang, String maPhim) {
        this.maBinhLuan = maBinhLuan;
        this.soSao = soSao;
        this.noiDung = noiDung;
        this.ngayTao = ngayTao;
        this.maKhachHang = maKhachHang;
        this.maPhim = maPhim;
    }

    // ===================== TOÀN BỘ GETTER & SETTER CHUẨN HÓA =====================

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
