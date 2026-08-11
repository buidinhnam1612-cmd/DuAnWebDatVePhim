package com.fptpoly.service;

import com.fptpoly.model.Voucher;
import com.fptpoly.repository.VoucherRepository;

import java.time.LocalDate;

public class VoucherService {

    private final VoucherRepository voucherRepository = new VoucherRepository();

    /**
     * Validate mã promo code
     * Trả về Voucher nếu hợp lệ, null nếu không
     */
    public Voucher validatePromoCode(String code) {

        if (code == null || code.isBlank()) {
            return null;
        }

        Voucher voucher = voucherRepository.findByCode(code.trim());

        if (voucher == null) {
            return null;
        }

        // Kiểm tra ngày bắt đầu
        LocalDate today = LocalDate.now();

        if (voucher.getNgayBatDau() != null
                && today.isBefore(voucher.getNgayBatDau().toLocalDate())) {
            return null;
        }

        // Kiểm tra ngày kết thúc
        if (voucher.getNgayKetThuc() != null
                && today.isAfter(voucher.getNgayKetThuc().toLocalDate())) {
            return null;
        }

        // Kiểm tra số lượng
        if (voucher.getSoLuong() <= 0) {
            return null;
        }

        return voucher;
    }

    /**
     * Tính giá sau khi giảm
     */
    public double applyDiscount(double totalPrice, int phanTramGiam) {

        if (phanTramGiam <= 0) {
            return totalPrice;
        }

        if (phanTramGiam >= 100) {
            return 0;
        }

        return totalPrice * (100 - phanTramGiam) / 100.0;
    }

    /**
     * Giảm số lượng voucher sau khi sử dụng
     */
    public boolean useVoucher(String maVoucher) {
        return voucherRepository.decreaseQuantity(maVoucher);
    }
}
