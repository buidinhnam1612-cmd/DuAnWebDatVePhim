package com.fptpoly.service;

import com.fptpoly.model.Showtime;
import com.fptpoly.repository.ShowtimeRepository;

import java.util.List;

public class ShowtimeService {

    private final ShowtimeRepository showtimeRepository;

    public ShowtimeService() {

        showtimeRepository = new ShowtimeRepository();

    }

    public List<Showtime> getAllShowtime() {

        return showtimeRepository.findAll();

    }

    public List<Showtime> getShowtimeByMovie(String maPhim) {

        return showtimeRepository.findByMovie(maPhim);

    }

    public Showtime getShowtimeById(String maSuatChieu) {

        return showtimeRepository.findById(maSuatChieu);

    }

}