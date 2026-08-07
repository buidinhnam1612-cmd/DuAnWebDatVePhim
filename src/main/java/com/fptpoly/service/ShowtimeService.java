package com.fptpoly.service;


import com.fptpoly.model.Showtime;
import com.fptpoly.repository.ShowtimeRepository;
import java.util.List;

public class ShowtimeService {

    // Khởi tạo trực tiếp bằng từ khóa new theo cách truyền thống
    private ShowtimeRepository showtimeRepository = new ShowtimeRepository();

    public List<Showtime> getAllShowtimes() {
        return showtimeRepository.getAll();
    }

    public String saveShowtime(Showtime newShowtime) {
        // 1. Kiểm tra xem phòng đó vào ngày đó đã có những suất nào
        List<Showtime> existingShowtimes = showtimeRepository.getByPhongAndNgay(
                newShowtime.getMaPhong(), newShowtime.getNgayChieu());

        // 2. Thuật toán kiểm tra trùng lịch
        for (Showtime oldShowtime : existingShowtimes) {
            if (newShowtime.getGioBatDau().isBefore(oldShowtime.getGioKetThuc()) &&
                    newShowtime.getGioKetThuc().isAfter(oldShowtime.getGioBatDau())) {
                return "Thất bại: Phòng này đã có lịch chiếu trong khoảng thời gian trên!";
            }
        }

        // 3. Lưu nếu không trùng
        boolean isSuccess = showtimeRepository.add(newShowtime);
        if (isSuccess) {
            return "Thành công: Đã thêm suất chiếu mới.";
        } else {
            return "Thất bại: Lỗi hệ thống khi lưu vào cơ sở dữ liệu.";
        }
    }
}

