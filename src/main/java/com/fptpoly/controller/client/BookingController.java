package com.fptpoly.controller.client;

import com.fptpoly.model.Booking;
import com.fptpoly.model.Movie;
import com.fptpoly.model.Seat;
import com.fptpoly.model.Showtime;
import com.fptpoly.model.Food;
import com.fptpoly.repository.BookingDetailRepository;
import com.fptpoly.repository.BookingRepository;
import com.fptpoly.repository.ShowtimeRepository;
import com.fptpoly.service.MovieService;
import com.fptpoly.service.SeatService;
import com.fptpoly.service.CustomerFoodService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Types;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/booking")
public class BookingController extends HttpServlet {

    private final ShowtimeRepository showtimeRepository = new ShowtimeRepository();
    private final MovieService movieService = new MovieService();
    private final SeatService seatService = new SeatService();
    private final com.fptpoly.service.RoomService roomService = new com.fptpoly.service.RoomService();
    private final BookingDetailRepository bookingDetailRepository = new BookingDetailRepository();
    private final BookingRepository bookingRepository = new BookingRepository();
    private final CustomerFoodService customerFoodService = new CustomerFoodService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String maSuatChieu = request.getParameter("maSuatChieu");
        if (maSuatChieu == null || maSuatChieu.trim().isEmpty()) {
            // Bước 1: Cho khách hàng chọn Phim & Suất Chiếu (Lotte Cinema style)
            String maPhim = request.getParameter("maPhim");
            List<Movie> listPhim = movieService.getAll();
            List<Showtime> listSuatChieu = showtimeRepository.getAll();

            request.setAttribute("listPhim", listPhim);
            request.setAttribute("listSuatChieu", listSuatChieu);
            request.setAttribute("selectedMovieId", maPhim);

            request.getRequestDispatcher("/views/client/select-showtime.jsp").forward(request, response);
            return;
        }

        Showtime showtime = showtimeRepository.getById(maSuatChieu);
        if (showtime == null) {
            response.sendRedirect(request.getContextPath() + "/booking");
            return;
        }

        Movie movie = movieService.getByID(showtime.getMaPhim());
        List<Seat> seatList = seatService.getSeatsByRoom(showtime.getMaPhong());
        List<String> bookedSeat = bookingDetailRepository.findSeatBookedByShowtime(maSuatChieu);
        com.fptpoly.model.Room room = roomService.getRoomById(showtime.getMaPhong());

        request.setAttribute("showtime", showtime);
        request.setAttribute("movie", movie);
        request.setAttribute("seatList", seatList);
        request.setAttribute("bookedSeat", bookedSeat);
        request.setAttribute("room", room);
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

        // Tạo đối tượng Booking
        Booking booking = new Booking();
        String maDatVe = bookingRepository.generateBookingId();
        booking.setMaDatVe(maDatVe);
        booking.setThoiGianDat(LocalDateTime.now());
        booking.setTongTien(tongTien);
        booking.setTrangThai("Chờ thanh toán"); // Đã xóa chữ N lỗi ở đây
        booking.setMaKhachHang(maKhachHang != null && !maKhachHang.trim().isEmpty() ? maKhachHang : "KH01");
        booking.setMaNhanVien(null);
        booking.setMaVoucher(maVoucher != null && !maVoucher.trim().isEmpty() ? maVoucher : null);

        String[] seatIds = seatIdsStr.split(",");

        // 1. Kiểm tra xem các ghế đã bị đặt chưa (Tránh đặt trùng)
        for (String seatId : seatIds) {
            if (bookingDetailRepository.checkSeatBooked(maSuatChieu, seatId.trim())) {
                request.setAttribute("error", "Một hoặc nhiều ghế bạn chọn đã có người đặt trước.");
                doGet(request, response);
                return;
            }
        }

        // 2. Chạy Transaction luồng dữ liệu an toàn kết nối SQL
        boolean transactionSuccess = false;
        try (Connection con = com.fptpoly.config.DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try {
                // Thêm hóa đơn Booking tổng
                String sqlBooking = "INSERT INTO DAT_VE (MaDatVe, ThoiGianDat, TongTien, TrangThai, MaKhachHang, MaNhanVien, MaVoucher) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement ps = con.prepareStatement(sqlBooking)) {
                    ps.setString(1, booking.getMaDatVe());
                    ps.setTimestamp(2, Timestamp.valueOf(booking.getThoiGianDat()));
                    ps.setDouble(3, booking.getTongTien());
                    ps.setString(4, booking.getTrangThai());
                    ps.setString(5, booking.getMaKhachHang());
                    ps.setNull(6, Types.VARCHAR);
                    if (booking.getMaVoucher() == null) {
                        ps.setNull(7, Types.VARCHAR);
                    } else {
                        ps.setString(7, booking.getMaVoucher());
                    }
                    ps.executeUpdate();
                }

                // Thêm chi tiết từng ghế ngồi xem phim
                String sqlDetail = "INSERT INTO CHI_TIET_DAT_VE (MaChiTietDatVe, MaDatVe, MaGhe, MaSuatChieu, TrangThai, ThoiGianGiuGhe, GiaVe) VALUES (?, ?, ?, ?, ?, ?, ?)";
                int detailIndex = 1;
                List<Seat> seats = seatService.getSeatsByRoom(maPhong);

                for (String seatId : seatIds) {
                    double giaVe = 75000; // Giá vé mặc định
                    for (Seat s : seats) {
                        if (s.getMaGhe().equals(seatId.trim()) && "VIP".equalsIgnoreCase(s.getLoaiGhe())) {
                            giaVe = 110000; // Tăng giá nếu là ghế VIP
                            break;
                        }
                    }

                    try (PreparedStatement ps = con.prepareStatement(sqlDetail)) {
                        ps.setString(1, "CT" + maDatVe + "_" + detailIndex++);
                        ps.setString(2, maDatVe);
                        ps.setString(3, seatId.trim());
                        ps.setString(4, maSuatChieu);
                        ps.setString(5, "Giữ ghế"); // Đã xóa chữ N lỗi ở đây
                        ps.setTimestamp(6, Timestamp.valueOf(LocalDateTime.now().plusMinutes(15)));
                        ps.setDouble(7, giaVe);
                        ps.executeUpdate();
                    }
                }

                // Thêm chi tiết đồ ăn nước uống (Bảng CHI_TIET_DAT_DO_AN)
                String sqlFood = "INSERT INTO CHI_TIET_DAT_DO_AN (MaChiTietDatDoAn, MaDatVe, MaDoAnUong, SoLuong, GiaBanLucDat) VALUES (?, ?, ?, ?, ?)";
                int foodIndex = 1;
                for (Map.Entry<Food, Integer> entry : selectedFoods.entrySet()) {
                    try (PreparedStatement ps = con.prepareStatement(sqlFood)) {
                        ps.setString(1, "CTDA" + maDatVe + "_" + foodIndex++);
                        ps.setString(2, maDatVe);
                        ps.setString(3, entry.getKey().getMaDoAn());
                        ps.setInt(4, entry.getValue());
                        ps.setDouble(5, entry.getKey().getGia());
                        ps.executeUpdate();
                    }
                }

                con.commit(); // Thành công thực tế lưu toàn bộ dữ liệu
                transactionSuccess = true;
            } catch (Exception ex) {
                con.rollback(); // Gặp lỗi ở bất cứ đâu thì hủy toàn bộ đơn hàng
                ex.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (transactionSuccess) {
            // Điều hướng sang trang hiển thị hóa đơn thành công
            response.sendRedirect(request.getContextPath() + "/invoice?maDatVe=" + maDatVe);
        } else {
            request.setAttribute("error", "Hệ thống bận, đặt vé thất bại. Vui lòng thử lại.");
            doGet(request, response);}
    }
}