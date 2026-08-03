package com.fptpoly.model;

public class Genre {


    private String maTheLoai;

    private String tenTheLoai;



    public Genre() {

    }



    public Genre(String maTheLoai,
                 String tenTheLoai) {

        this.maTheLoai = maTheLoai;
        this.tenTheLoai = tenTheLoai;

    }



    public String getMaTheLoai() {

        return maTheLoai;

    }



    public void setMaTheLoai(String maTheLoai) {

        this.maTheLoai = maTheLoai;

    }



    public String getTenTheLoai() {

        return tenTheLoai;

    }



    public void setTenTheLoai(String tenTheLoai) {

        this.tenTheLoai = tenTheLoai;

    }


}