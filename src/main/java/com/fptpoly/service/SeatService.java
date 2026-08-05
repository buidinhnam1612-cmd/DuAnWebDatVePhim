package com.fptpoly.service;

import com.fptpoly.model.Seat;
import com.fptpoly.repository.BookingDetailRepository;
import com.fptpoly.repository.SeatRepository;

import java.util.List;

public class SeatService {

    private final SeatRepository seatRepository;

    private final BookingDetailRepository bookingDetailRepository;

    public SeatService() {

        seatRepository = new SeatRepository();

        bookingDetailRepository = new BookingDetailRepository();

    }

    public List<Seat> getAllSeat() {

        return seatRepository.findAll();

    }

    public List<Seat> getSeatByRoom(String maPhong) {

        return seatRepository.findByRoom(maPhong);

    }

    public Seat getSeatById(String maGhe) {

        return seatRepository.findById(maGhe);

    }

    public List<String> getBookedSeat(String maSuatChieu) {

        return bookingDetailRepository.findSeatBookedByShowtime(
                maSuatChieu
        );

    }

    public boolean isBooked(String maSuatChieu,
                            String maGhe) {

        return bookingDetailRepository.checkSeatBooked(
                maSuatChieu,
                maGhe
        );

    }

}