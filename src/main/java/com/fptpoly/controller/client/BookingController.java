package com.fptpoly.controller.client;

import com.fptpoly.model.Booking;
import com.fptpoly.model.BookingDetail;
import com.fptpoly.model.Movie;
import com.fptpoly.model.Showtime;
import com.fptpoly.service.BookingService;
import com.fptpoly.service.SeatService;
import com.fptpoly.service.ShowtimeService;

import com.fptpoly.repository.MovieRepository;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/booking")
public class BookingController extends HttpServlet {

    private BookingService bookingService;
    private SeatService seatService;
    private ShowtimeService showtimeService;
    private MovieRepository movieRepository;

    @Override
    public void init() {

        bookingService = new BookingService();
        seatService = new SeatService();
        showtimeService = new ShowtimeService();
        movieRepository = new MovieRepository();

    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String maSuatChieu = request.getParameter("maSuatChieu");

        if (maSuatChieu == null || maSuatChieu.isBlank()) {
            maSuatChieu = "SC01";
        }

        // Load thông tin suất chiếu
        Showtime showtime = showtimeService.getShowtimeById(maSuatChieu);

        String maPhong = "P01";
        if (showtime != null) {
            maPhong = showtime.getMaPhong();

            // Load thông tin phim
            Movie movie = movieRepository.findById(showtime.getMaPhim());
            request.setAttribute("movie", movie);
        }

        request.setAttribute(
                "maPhong",
                maPhong
        );

        request.setAttribute(
                "maSuatChieu",
                maSuatChieu
        );

        request.setAttribute(
                "showtime",
                showtime
        );

        request.setAttribute(
                "seatList",
                seatService.getSeatByRoom(maPhong)
        );

        request.setAttribute(
                "bookedSeat",
                seatService.getBookedSeat(maSuatChieu)
        );

        request.getRequestDispatcher(
                "/views/client/booking.jsp"
        ).forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String maKhachHang =
                request.getParameter("maKhachHang");

        String maSuatChieu =
                request.getParameter("maSuatChieu");

        String seatIds =
                request.getParameter("seatIds");

        String tongTienStr =
                request.getParameter("tongTien");

        if (seatIds == null || seatIds.isBlank()) {

            request.setAttribute(
                    "error",
                    "Vui lòng chọn ít nhất một ghế."
            );

            doGet(request, response);

            return;

        }

        double tongTien =
                Double.parseDouble(tongTienStr);

        Booking booking = new Booking();

        booking.setMaKhachHang(
                maKhachHang
        );

        booking.setTongTien(
                tongTien
        );

        booking.setTrangThai(
                "CHO_THANH_TOAN"
        );

        booking.setMaNhanVien(
                null
        );

        booking.setMaVoucher(
                null
        );

        List<BookingDetail> details =
                new ArrayList<>();

        String[] seats =
                seatIds.split(",");

        double giaMoiGhe =
                tongTien / seats.length;

        for (String seat : seats) {

            BookingDetail detail =
                    new BookingDetail();

            detail.setMaGhe(
                    seat.trim()
            );

            detail.setMaSuatChieu(
                    maSuatChieu
            );

            detail.setGiaVe(
                    giaMoiGhe
            );

            detail.setTrangThai(
                    "CHO_THANH_TOAN"
            );

            details.add(detail);

        }

        boolean success =
                bookingService.bookingTicket(
                        booking,
                        details
                );

        if (success) {

            request.setAttribute(
                    "booking",
                    booking
            );

            request.getRequestDispatcher(
                    "/views/client/booking-success.jsp"
            ).forward(request, response);

        } else {

            request.setAttribute(
                    "error",
                    "Đặt vé thất bại hoặc ghế đã được người khác đặt."
            );

            doGet(request, response);

        }

    }

}