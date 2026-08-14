package com.fptpoly.controller.admin;

import com.fptpoly.model.Room;
import com.fptpoly.service.RoomService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "RoomController", urlPatterns = {"/admin/room"})
public class RoomController extends HttpServlet {
    private final RoomService roomService = new RoomService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy danh sách phòng hiển thị lên trang quản lý
        List<Room> list = roomService.getAllRooms();
        request.setAttribute("roomList", list);

        // SỬA TẠI ĐÂY: Thêm "/views" vào trước đường dẫn để hệ thống tìm đúng file jsp
        request.getRequestDispatcher("/views/admin/room.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String maPhong = request.getParameter("maPhong");
            String tenPhong = request.getParameter("tenPhong");
            String maRap = request.getParameter("maRap");
            int soHang = Integer.parseInt(request.getParameter("soHang"));
            int soCot = Integer.parseInt(request.getParameter("soCot"));

            String[] hangGhes = request.getParameterValues("hangGhes[]");
            String[] soGhes = request.getParameterValues("soGhes[]");
            String[] loaiGhes = request.getParameterValues("loaiGhes[]");

            List<com.fptpoly.model.Seat> seats = new java.util.ArrayList<>();
            
            if (hangGhes != null && soGhes != null && loaiGhes != null) {
                for (int i = 0; i < hangGhes.length; i++) {
                    com.fptpoly.model.Seat seat = new com.fptpoly.model.Seat();
                    seat.setMaPhong(maPhong);
                    seat.setHangGhe(hangGhes[i]);
                    seat.setSoGhe(Integer.parseInt(soGhes[i]));
                    seat.setLoaiGhe(loaiGhes[i]);
                    seat.setMaGhe(maPhong + "_" + hangGhes[i] + soGhes[i]);
                    seats.add(seat);
                }
            }

            Room room = new Room(maPhong, tenPhong, seats.size(), maRap, soHang, soCot);

            // Gọi tầng Service xử lý tạo phòng & ma trận ghế
            boolean isSuccess = roomService.createRoomWithMatrix(room, seats);

            if (isSuccess) {
                response.sendRedirect(request.getContextPath() + "/admin/room?status=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/room?status=fail");
            }
        }
    }
}
