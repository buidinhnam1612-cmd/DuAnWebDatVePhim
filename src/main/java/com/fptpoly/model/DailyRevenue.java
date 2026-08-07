package com.fptpoly.model;

import java.math.BigDecimal;
import java.time.LocalDate;

public class DailyRevenue {

    private LocalDate ngay;

    private BigDecimal doanhThu;

    public DailyRevenue() {
    }

    public LocalDate getNgay() {
        return ngay;
    }

    public void setNgay(LocalDate ngay) {
        this.ngay = ngay;
    }

    public BigDecimal getDoanhThu() {
        return doanhThu;
    }

    public void setDoanhThu(BigDecimal doanhThu) {
        this.doanhThu = doanhThu;
    }

}