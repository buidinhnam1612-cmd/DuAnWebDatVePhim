package com.fptpoly.model;

public class Permission {

    // Danh sách hằng số quyền cho Nhân viên (Employee Permissions)
    public static final String VIEW_SHOWTIME = "VIEW_SHOWTIME";
    public static final String VIEW_SEAT = "VIEW_SEAT";
    public static final String VIEW_FOOD = "VIEW_FOOD";
    public static final String MANAGE_FOOD = "MANAGE_FOOD";
    public static final String VIEW_BOOKING = "VIEW_BOOKING";
    public static final String CHECKIN_BOOKING = "CHECKIN_BOOKING";
    public static final String CANCEL_BOOKING = "CANCEL_BOOKING";
    public static final String CHANGE_BOOKING = "CHANGE_BOOKING";
    public static final String VIEW_COMMENT = "VIEW_COMMENT";
    public static final String MODERATE_COMMENT = "MODERATE_COMMENT";
    public static final String VIEW_SHIFT_REPORT = "VIEW_SHIFT_REPORT";

    // Danh sách hằng số quyền riêng cho Admin (Admin Management Permissions)
    public static final String MANAGE_THEATER = "MANAGE_THEATER";
    public static final String MANAGE_GENRE = "MANAGE_GENRE";
    public static final String MANAGE_ROOM = "MANAGE_ROOM";
    public static final String MANAGE_SEAT = "MANAGE_SEAT";
    public static final String MANAGE_MOVIE = "MANAGE_MOVIE";
    public static final String MANAGE_SHOWTIME = "MANAGE_SHOWTIME";
    public static final String MANAGE_BOOKING = "MANAGE_BOOKING";
    public static final String MANAGE_USER = "MANAGE_USER";
    public static final String MANAGE_EMPLOYEE = "MANAGE_EMPLOYEE";
    public static final String VIEW_REPORT = "VIEW_REPORT";
    public static final String EXPORT_REPORT = "EXPORT_REPORT";

    private String maQuyen;
    private String tenQuyen;
    private String moTa;
    private String nhomQuyen;

    public Permission() {
    }

    public Permission(String maQuyen, String tenQuyen, String moTa, String nhomQuyen) {
        this.maQuyen = maQuyen;
        this.tenQuyen = tenQuyen;
        this.moTa = moTa;
        this.nhomQuyen = nhomQuyen;
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

    public String getNhomQuyen() {
        return nhomQuyen;
    }

    public void setNhomQuyen(String nhomQuyen) {
        this.nhomQuyen = nhomQuyen;
    }
}
