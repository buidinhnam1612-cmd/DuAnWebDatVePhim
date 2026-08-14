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

    public Room getRoomById(String maPhong) {
        return roomRepository.findById(maPhong);
    }

    // Xử lý nghiệp vụ thêm phòng và cấu hình ghế tự động
    public boolean createRoomWithMatrix(Room room, List<com.fptpoly.model.Seat> seats) {
        // Kiểm tra dữ liệu đầu vào cơ bản
        if (room == null || room.getMaPhong() == null || room.getMaPhong().trim().isEmpty() || room.getSoHang() <= 0 || room.getSoCot() <= 0) {
            return false;
        }

        return roomRepository.saveRoomAndSeats(room, seats);
    }
}

