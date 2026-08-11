package com.fptpoly.service;

import com.fptpoly.model.Seat;
import com.fptpoly.repository.SeatRepository;

import java.util.List;

public class SeatService {

    private final SeatRepository seatRepository = new SeatRepository();

    /**
     * Lấy danh sách ghế theo mã phòng chiếu
     */
    public List<Seat> getSeatsByRoom(String maPhong) {
        return seatRepository.findByRoom(maPhong);
    }
}
