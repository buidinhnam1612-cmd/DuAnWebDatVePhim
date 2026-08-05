package com.fptpoly.service;

import com.fptpoly.model.Theater;
import com.fptpoly.repository.TheaterRepository;
import java.util.List;

public class TheaterService {
    private final TheaterRepository repo = new TheaterRepository();

    // 1. LẤY DANH SÁCH TẤT CẢ RẠP CHIẾU PHIM
    public List<Theater> getall() {
        try {
            return repo.getAll();
        } catch (Exception e) {
            return null;
        }
    }

    // 2. CẬP NHẬT THÔNG TIN RẠP CHIẾU PHIM (SỬA)
    public boolean sua(Theater tt) {
        try {
            return repo.update(tt);
        } catch (Exception e) {
            return false;
        }
    }

    // 3. TÌM KIẾM RẠP CHIẾU PHIM THEO MÃ
    public Theater getByID(String id) {
        try {
            return repo.getByID(id);
        } catch (Exception e) {
            return null;
        }
    }
}
