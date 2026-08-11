package com.fptpoly.controller.client;

import com.fptpoly.model.User;
import com.fptpoly.model.Voucher;
import com.fptpoly.repository.UserRepository;
import com.fptpoly.repository.VoucherRepository;
import com.fptpoly.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ProfileController", urlPatterns = "/profile")
public class ProfileController extends HttpServlet {

    private final UserService userService = new UserService();
    private final UserRepository userRepository = new UserRepository();
    private final VoucherRepository voucherRepository = new VoucherRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        // Lấy thông tin user mới nhất từ DB
        User latestUser = userService.getUserById(user.getMaKhachHang());
        if (latestUser != null) {
            session.setAttribute("user", latestUser);
            session.setAttribute("userName", latestUser.getHoTen());
            user = latestUser;
        }

        List<Voucher> listVouchers = voucherRepository.getAll();

        request.setAttribute("user", user);
        request.setAttribute("listVouchers", listVouchers);

        request.getRequestDispatcher("/views/client/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("updateInfo".equalsIgnoreCase(action)) {
            String fullName = request.getParameter("fullName");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String ngaySinhStr = request.getParameter("ngaySinh");
            String gioiTinh = request.getParameter("gioiTinh");

            if (fullName == null || fullName.isBlank()
                    || phone == null || phone.isBlank()
                    || email == null || email.isBlank()) {
                request.setAttribute("error", "Họ tên, Số điện thoại và Email không được để trống!");
                doGet(request, response);
                return;
            }

            user.setHoTen(fullName.trim());
            user.setSoDienThoai(phone.trim());
            user.setEmail(email.trim());
            if (ngaySinhStr != null && !ngaySinhStr.isBlank()) {
                try {
                    user.setNgaySinh(Date.valueOf(ngaySinhStr));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            user.setGioiTinh(gioiTinh);

            boolean ok = userRepository.updateProfile(user);
            if (ok) {
                session.setAttribute("userName", user.getHoTen());
                session.setAttribute("email", user.getEmail());
                request.setAttribute("success", "Cập nhật thông tin cá nhân thành công!");
            } else {
                request.setAttribute("error", "Cập nhật thông tin thất bại!");
            }
            doGet(request, response);

        } else if ("changePassword".equalsIgnoreCase(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (currentPassword == null || currentPassword.isBlank()
                    || newPassword == null || newPassword.isBlank()) {
                request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin mật khẩu!");
                doGet(request, response);
                return;
            }

            if (!user.getMatKhau().equals(currentPassword)) {
                request.setAttribute("error", "Mật khẩu hiện tại không chính xác!");
                doGet(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
                doGet(request, response);
                return;
            }

            boolean ok = userRepository.changePassword(user.getMaKhachHang(), newPassword);
            if (ok) {
                user.setMatKhau(newPassword);
                request.setAttribute("success", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("error", "Đổi mật khẩu thất bại!");
            }
            doGet(request, response);

        } else if ("redeemVoucher".equalsIgnoreCase(action)) {
            String maVoucher = request.getParameter("maVoucher");
            if (maVoucher == null || maVoucher.isBlank()) {
                request.setAttribute("error", "Mã voucher không hợp lệ!");
                doGet(request, response);
                return;
            }

            Voucher voucher = voucherRepository.findById(maVoucher);
            if (voucher == null) {
                request.setAttribute("error", "Voucher không tồn tại!");
                doGet(request, response);
                return;
            }

            int diemDoi = voucher.getDiemDoiVoucher();
            if (user.getDiemTichLuy() < diemDoi) {
                request.setAttribute("error", "Bạn không đủ điểm để đổi voucher này! Cần " + diemDoi + " điểm.");
                doGet(request, response);
                return;
            }

            int diemMoi = user.getDiemTichLuy() - diemDoi;
            boolean ok = userRepository.updatePoints(user.getMaKhachHang(), diemMoi);
            if (ok) {
                user.setDiemTichLuy(diemMoi);
                session.setAttribute("user", user);
                request.setAttribute("success", "Đổi điểm thành công! Bạn nhận được mã giảm giá: " 
                        + voucher.getMaCode() + ". Hãy dùng mã này khi đặt vé.");
            } else {
                request.setAttribute("error", "Đổi voucher thất bại!");
            }
            doGet(request, response);
        }
    }
}
