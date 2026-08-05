package com.fptpoly.service;



import com.fptpoly.model.Room;
import com.fptpoly.repository.RoomRepository;

import java.util.List;



public class RoomService {
    private final RoomRepository roomRepository = new RoomRepository();

    // Lấy danh sách phòng
    public List<Room> getAllRooms() {
        return roomRepository.findAll();
    }

    // Xử lý nghiệp vụ thêm phòng và cấu hình ghế tự động
    public boolean createRoomWithMatrix(String maPhong, String tenPhong, String maRap, int soHang, int soCot, String loaiGhe) {
        // Kiểm tra dữ liệu đầu vào cơ bản
        if (maPhong == null || maPhong.trim().isEmpty() || soHang <= 0 || soCot <= 0) {
            return false;
        }

        // Logic nghiệp vụ: Tổng số ghế = Số hàng x Số cột
        int tongSoGhe = soHang * soCot;

        Room phong = new Room(maPhong, tenPhong, tongSoGhe, maRap);
        return roomRepository.saveRoomAndSeats(phong, soHang, soCot, loaiGhe);
    }
}

