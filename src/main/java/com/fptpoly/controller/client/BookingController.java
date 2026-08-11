package com.fptpoly.controller.client;

import com.fptpoly.model.Booking;
import com.fptpoly.model.BookingDetail;
import com.fptpoly.model.Movie;
import com.fptpoly.model.Seat;
import com.fptpoly.model.Showtime;
import com.fptpoly.model.User;
import com.fptpoly.model.Food;
import com.fptpoly.repository.BookingDetailRepository;
import com.fptpoly.repository.BookingRepository;
import com.fptpoly.repository.ShowtimeRepository;
import com.fptpoly.repository.UserRepository;
import com.fptpoly.service.MovieService;
import com.fptpoly.service.SeatService;
import com.fptpoly.service.UserService;
import com.fptpoly.service.CustomerFoodService;
import com.fptpoly.utils.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/booking")
public class BookingController extends HttpServlet {

    private final ShowtimeRepository showtimeRepository = new ShowtimeRepository();
    private final MovieService movieService = new MovieService();
    private final SeatService seatService = new SeatService();
    private final BookingDetailRepository bookingDetailRepository = new BookingDetailRepository();
    private final UserService userService = new UserService();
    private final BookingRepository bookingRepository = new BookingRepository();
    private final UserRepository userRepository = new UserRepository();
    private final com.fptpoly.service.VoucherService voucherService = new com.fptpoly.service.VoucherService();
    private final CustomerFoodService customerFoodService = new CustomerFoodService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String maSuatChieu = request.getParameter("maSuatChieu");
        if (maSuatChieu == null || maSuatChieu.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Showtime showtime = showtimeRepository.getById(maSuatChieu);
        if (showtime == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        Movie movie = movieService.getByID(showtime.getMaPhim());
        List<Seat> seatList = seatService.getSeatsByRoom(showtime.getMaPhong());
        List<String> bookedSeat = bookingDetailRepository.findSeatBookedByShowtime(maSuatChieu);

        request.setAttribute("showtime", showtime);
        request.setAttribute("movie", movie);
        request.setAttribute("seatList", seatList);
        request.setAttribute("bookedSeat", bookedSeat);
        request.setAttribute("maPhong", showtime.getMaPhong());
        request.setAttribute("maSuatChieu", maSuatChieu);
        request.setAttribute("listFoods", customerFoodService.getActiveFoods());

        request.getRequestDispatcher("/views/client/booking.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String maKhachHang = request.getParameter("maKhachHang");
        String maSuatChieu = request.getParameter("maSuatChieu");
        String maPhong = request.getParameter("maPhong");
        String seatIdsStr = request.getParameter("seatIds"); // ví dụ: "G01,G02"
        String tongTienStr = request.getParameter("tongTien");
        String maVoucher = request.getParameter("maVoucher");

        if (maSuatChieu == null || seatIdsStr == null || seatIdsStr.trim().isEmpty() || tongTienStr == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        double tongTien = 0;
        try {
            tongTien = Double.parseDouble(tongTienStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        // Lấy thông tin đồ ăn thức uống được chọn từ form
        List<Food> activeFoods = customerFoodService.getActiveFoods();
        Map<Food, Integer> selectedFoods = new HashMap<>();
        double tongTienDoAn = 0;
        for (Food food : activeFoods) {
            String qtyStr = request.getParameter("food_" + food.getMaDoAn());
            if (qtyStr != null && !qtyStr.trim().isEmpty()) {
                try {
                    int qty = Integer.parseInt(qtyStr.trim());
                    if (qty > 0) {
                        selectedFoods.put(food, qty);
                        tongTienDoAn += food.getGia() * qty;
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }
        tongTien += tongTienDoAn;

        // Kiểm tra và áp dụng Promo Code
        com.fptpoly.model.Voucher voucher = null;
        if (maVoucher != null && !maVoucher.trim().isEmpty()) {
            voucher = voucherService.validatePromoCode(maVoucher);
            if (voucher != null) {
                tongTien = voucherService.applyDiscount(tongTien, voucher.getPhanTramGiam());
            }
        }

        String[] seatIds = seatIdsStr.split(",");

        // 1. Kiểm tra xem các ghế đã bị đặt chưa (Tránh đặt trùng)
        for (String seatId : seatIds) {
            if (bookingDetailRepository.checkSeatBooked(maSuatChieu, seatId.trim())) {
                request.setAttribute("error", "Một hoặc nhiều ghế bạn chọn đã có người đặt trước. Vui lòng chọn ghế khác.");
                doGet(request, response);
                return;
            }
        }

        // 2. Tạo đối tượng Booking
        Booking booking = new Booking();
        String maDatVe = bookingRepository.generateBookingId();
        booking.setMaDatVe(maDatVe);
        booking.setThoiGianDat(LocalDateTime.now());
        booking.setTongTien(tongTien);
        booking.setTrangThai("Chờ thanh toán"); // Trạng thái mặc định khi đặt online
        booking.setMaKhachHang(maKhachHang != null && !maKhachHang.trim().isEmpty() ? maKhachHang : "KH01");
        booking.setMaNhanVien(null); // Đặt online thì không có nhân viên
        booking.setMaVoucher(voucher != null ? voucher.getMaVoucher() : null);

        // Thực hiện giao dịch (Transaction) dùng Connection chung để an toàn
        boolean success = false;
        try (Connection con = com.fptpoly.config.DBConnection.getConnection()) {
            con.setAutoCommit(false);
            try {
                // Lưu Booking
                boolean insertBookingOk = bookingRepository.insertBooking(con, booking);
                if (!insertBookingOk) {
                    throw new Exception("Lỗi khi thêm thông tin đặt vé.");
                }

                // Lưu từng BookingDetail
                int detailIndex = 1;
                for (String seatId : seatIds) {
                    BookingDetail detail = new BookingDetail();

                    // Tạo mã chi tiết đặt vé duy nhất: CTDV + MaDatVe + Index
                    String maChiTietDatVe = "CT" + maDatVe + "_" + detailIndex++;
                    detail.setMaChiTietDatVe(maChiTietDatVe);
                    detail.setMaDatVe(maDatVe);
                    detail.setMaGhe(seatId.trim());
                    detail.setMaSuatChieu(maSuatChieu);
                    detail.setTrangThai("Giữ ghế"); // trạng thái ghế
                    detail.setThoiGianGiuGhe(LocalDateTime.now().plusMinutes(15)); // Giữ ghế trong 15p

                    // Xác định giá vé cho mỗi ghế
                    double giaVe = 75000; // mặc định
                    List<Seat> seats = seatService.getSeatsByRoom(maPhong);
                    for (Seat s : seats) {
                        if (s.getMaGhe().equalsIgnoreCase(seatId.trim())) {
                            if ("VIP".equalsIgnoreCase(s.getLoaiGhe())) {
                                giaVe = 90000;
                            } else if ("Sweetbox".equalsIgnoreCase(s.getLoaiGhe())) {
                                giaVe = 120000;
                            }
                            break;
                        }
                    }
                    detail.setGiaVe(giaVe);

                    boolean insertDetailOk = bookingDetailRepository.insertBookingDetail(con, detail);
                    if (!insertDetailOk) {
                        throw new Exception("Lỗi khi thêm chi tiết đặt vé: " + seatId);
                    }
                }

                // Lưu chi tiết đồ ăn được đặt
                for (Map.Entry<Food, Integer> entry : selectedFoods.entrySet()) {
                    Food food = entry.getKey();
                    int qty = entry.getValue();
                    boolean insertFoodOk = customerFoodService.insertOrderDetail(con, maDatVe, food.getMaDoAn(), qty, food.getGia());
                    if (!insertFoodOk) {
                        throw new Exception("Lỗi khi thêm chi tiết đồ ăn đặt: " + food.getMaDoAn());
                    }
                }

                con.commit();
                success = true;

                // Giảm số lượng voucher trong database
                if (voucher != null) {
                    voucherService.useVoucher(voucher.getMaVoucher());
                }

                // Cộng điểm tích lũy cho khách hàng thành viên
                if (maKhachHang != null && !maKhachHang.trim().isEmpty() && !"KH01".equals(maKhachHang)) {
                    User currentUser = userService.getUserById(maKhachHang);
                    if (currentUser != null) {
                        int diemCong = (int) (booking.getTongTien() / 10000);
                        if (diemCong > 0) {
                            int diemMoi = currentUser.getDiemTichLuy() + diemCong;
                            userRepository.updatePoints(maKhachHang, diemMoi);
                            currentUser.setDiemTichLuy(diemMoi);
                            HttpSession session = request.getSession(false);
                            if (session != null) {
                                session.setAttribute("user", currentUser);
                            }
                        }
                    }
                }

            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (success) {
            // 3. Gửi email xác nhận nếu khách hàng có email hợp lệ
            try {
                User user = userService.getUserById(booking.getMaKhachHang());
                Showtime showtime = showtimeRepository.getById(maSuatChieu);
                Movie movie = movieService.getByID(showtime.getMaPhim());

                String emailTo = (user != null) ? user.getEmail() : null;
                String hoTen = (user != null) ? user.getHoTen() : "Khách hàng";
                String tenPhim = (movie != null) ? movie.getTenPhim() : "--";
                String ngayChieuStr = (showtime != null) ? showtime.getNgayChieu().toString() : "--";
                String gioChieuStr = (showtime != null) ? showtime.getGioBatDau().toString() : "--";

                // Lấy tên các ghế để đưa vào email
                List<Seat> roomSeats = seatService.getSeatsByRoom(maPhong);
                List<String> selectedSeatNames = new ArrayList<>();
                for (String seatId : seatIds) {
                    for (Seat s : roomSeats) {
                        if (s.getMaGhe().equalsIgnoreCase(seatId.trim())) {
                            selectedSeatNames.add(s.getTenGhe());
                            break;
                        }
                    }
                }
                String danhSachGhe = String.join(", ", selectedSeatNames);

                if (emailTo != null && !emailTo.trim().isEmpty()) {
                    new Thread(() -> {
                        EmailUtil.sendBookingConfirmation(
                                emailTo,
                                hoTen,
                                maDatVe,
                                tenPhim,
                                danhSachGhe,
                                ngayChieuStr,
                                gioChieuStr,
                                booking.getTongTien()
                        );
                    }).start();
                }
            } catch (Exception e) {
                System.out.println("⚠️ Lỗi gửi email xác nhận đặt vé: " + e.getMessage());
            }

            // Redirect sang trang thành công và truyền kèm mã đặt vé để hiển thị trên web
            response.sendRedirect(request.getContextPath() + "/views/client/booking-success.jsp?maDatVe=" + maDatVe);
        } else {
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình đặt vé. Vui lòng thử lại!");
            doGet(request, response);
        }
    }
}
