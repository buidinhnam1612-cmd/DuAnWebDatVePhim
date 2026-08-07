package com.fptpoly.service;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Booking;
import com.fptpoly.model.BookingDetail;
import com.fptpoly.repository.BookingDetailRepository;
import com.fptpoly.repository.BookingRepository;

import java.sql.Connection;
import java.time.LocalDateTime;
import com.fptpoly.model.Booking;
import com.fptpoly.repository.BookingRepository;

import java.util.List;

public class BookingService {

    private final BookingRepository bookingRepository;
    private final BookingDetailRepository bookingDetailRepository;

    public BookingService() {

        bookingRepository = new BookingRepository();
        bookingDetailRepository = new BookingDetailRepository();

    }

    public String generateBookingId() {

        return bookingRepository.generateBookingId();

    }

    public String generateBookingDetailId() {

        return bookingDetailRepository.generateBookingDetailId();

    }

    public boolean createBooking(Booking booking) {

        return bookingRepository.insertBooking(booking);

    }

    public boolean createBookingDetail(BookingDetail bookingDetail) {

        return bookingDetailRepository.insertBookingDetail(bookingDetail);

    }

    public Booking findBookingById(String maDatVe) {

        return bookingRepository.findById(maDatVe);

    }

    public Booking getBookingById(String maDatVe) {

        return bookingRepository.findById(maDatVe);

    }

    public List<Booking> getAllBooking() {

        return bookingRepository.findAll();

    }

    public List<BookingDetail> getBookingDetailByBookingId(String maDatVe) {

        return bookingDetailRepository.findByBookingId(maDatVe);

    }

    public List<String> getSeatBooked(String maSuatChieu) {

        return bookingDetailRepository.findSeatBookedByShowtime(maSuatChieu);

    }

    public boolean isSeatBooked(String maSuatChieu,
                                String maGhe) {

        return bookingDetailRepository.checkSeatBooked(
                maSuatChieu,
                maGhe
        );

    }

    public boolean updateBookingStatus(String maDatVe,
                                       String trangThai) {

        return bookingRepository.updateStatus(
                maDatVe,
                trangThai
        );

    }

    public boolean confirmPayment(String maDatVe) {

        return bookingRepository.updateStatus(
                maDatVe,
                "DA_THANH_TOAN"
        );

    }

    public boolean deleteBooking(String maDatVe) {

        return bookingRepository.deleteBooking(
                maDatVe
        );

    }

    public boolean deleteBookingDetail(String maChiTietDatVe) {

        return bookingDetailRepository.deleteBookingDetail(
                maChiTietDatVe
        );

    }

    /**
     * Đặt vé
     * Sau khi khách chọn ghế:
     * - Lưu hóa đơn
     * - Lưu chi tiết ghế
     * - Trạng thái = CHO_THANH_TOAN
     */
    public boolean bookingTicket(Booking booking,
                                 List<BookingDetail> details) {

        Connection connection = null;

        try {

            connection = DBConnection.getConnection();

            connection.setAutoCommit(false);

            booking.setMaDatVe(
                    bookingRepository.generateBookingId()
            );

            booking.setThoiGianDat(
                    LocalDateTime.now()
            );

            booking.setTrangThai(
                    "CHO_THANH_TOAN"
            );

            if (!bookingRepository.insertBooking(
                    connection,
                    booking
            )) {

                connection.rollback();

                return false;

            }

            String startDetailId = bookingDetailRepository.generateBookingDetailId();
            int currentDetailNum = Integer.parseInt(startDetailId.substring(4));

            for (BookingDetail detail : details) {

                if (bookingDetailRepository.checkSeatBooked(
                        detail.getMaSuatChieu(),
                        detail.getMaGhe()
                )) {

                    connection.rollback();

                    return false;

                }

                detail.setMaChiTietDatVe(
                        String.format("CTDV%03d", currentDetailNum++)
                );

                detail.setMaDatVe(
                        booking.getMaDatVe()
                );

                detail.setThoiGianGiuGhe(
                        LocalDateTime.now()
                );

                detail.setTrangThai(
                        "CHO_THANH_TOAN"
                );

                if (!bookingDetailRepository.insertBookingDetail(
                        connection,
                        detail
                )) {

                    connection.rollback();

                    return false;

                }

            }

            connection.commit();

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            try {

                if (connection != null) {

                    connection.rollback();

                }

            } catch (Exception ex) {

                ex.printStackTrace();

            }

            return false;

        } finally {

            try {

                if (connection != null) {

                    connection.setAutoCommit(true);

                    connection.close();

                }

            } catch (Exception e) {

                e.printStackTrace();

            }

        }


    public BookingService() {
        bookingRepository = new BookingRepository();
    }

    /**
     * Lấy toàn bộ danh sách đặt vé
     */
    public List<Booking> getAllBookings() {
        return bookingRepository.getAll();
    }

    /**
     * Lấy thông tin đặt vé theo mã
     */
    public Booking getBookingById(String maDatVe) {
        return bookingRepository.getById(maDatVe);
    }

    /**
     * Tìm kiếm theo mã vé, khách hàng, phim, rạp hoặc trạng thái
     */
    public List<Booking> searchBooking(String keyword) {
        return bookingRepository.search(keyword);
    }

    /**
     * Cập nhật trạng thái đặt vé
     */
    public boolean updateStatus(String maDatVe, String trangThai) {
        return bookingRepository.updateStatus(maDatVe, trangThai);
    }

    /**
     * Đếm tổng số đơn đặt vé
     */
    public int countBooking() {
        return bookingRepository.countBooking();
    }

    /**
     * Đếm số đơn theo trạng thái
     */
    public int countByStatus(String trangThai) {
        return bookingRepository.countByStatus(trangThai);
    }

    /**
     * Tính tổng doanh thu các vé đã thanh toán
     */
    public double getTotalRevenue() {
        return bookingRepository.getTotalRevenue();
    }

}