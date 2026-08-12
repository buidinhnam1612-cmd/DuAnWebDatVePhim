package com.fptpoly.controller.client;

import com.fptpoly.model.Voucher;
import com.fptpoly.repository.VoucherRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PromotionController", urlPatterns = "/promotion")
public class PromotionController extends HttpServlet {

    private final VoucherRepository voucherRepository = new VoucherRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Lấy danh sách tất cả voucher
        List<Voucher> allVouchers = voucherRepository.getAll();

        // Phân loại voucher: đang hoạt động và đã hết hạn
        List<Voucher> activeVouchers = new ArrayList<>();
        List<Voucher> expiredVouchers = new ArrayList<>();

        java.time.LocalDate today = java.time.LocalDate.now();

        for (Voucher v : allVouchers) {
            boolean isActive = "Hoạt động".equals(v.getTrangThai());
            boolean isNotExpired = v.getNgayKetThuc() == null
                    || !today.isAfter(v.getNgayKetThuc().toLocalDate());
            boolean hasStock = v.getSoLuong() > 0;

            if (isActive && isNotExpired && hasStock) {
                activeVouchers.add(v);
            } else {
                expiredVouchers.add(v);
            }
        }

        request.setAttribute("activeVouchers", activeVouchers);
        request.setAttribute("expiredVouchers", expiredVouchers);
        request.setAttribute("allVouchers", allVouchers);

        request.getRequestDispatcher("/views/client/promotion.jsp").forward(request, response);
    }
}
