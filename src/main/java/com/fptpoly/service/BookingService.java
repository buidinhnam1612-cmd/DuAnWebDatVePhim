package com.fptpoly.service;

import com.fptpoly.model.Booking;
import com.fptpoly.repository.BookingRepository;

import java.util.List;

public class BookingService {

    private final BookingRepository bookingRepository;

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

    /**
     * Xác nhận khách đã sử dụng vé
     */
    public boolean confirmBooking(String maDatVe) {
        return bookingRepository.confirmBooking(maDatVe);
    }

    /**
     * Đếm số vé đặt hôm nay
     */
    public int countTodayBookings() {
        return bookingRepository.countTodayBookings();
    }

    /**
     * Tính doanh thu tháng này (chỉ tính vé đã thanh toán)
     */
    public double getMonthlyRevenue() {
        return bookingRepository.getMonthlyRevenue();
    }
}