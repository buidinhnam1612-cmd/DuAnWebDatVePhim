package com.fptpoly.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/seat")
public class SeatController extends HttpServlet {

    private final com.fptpoly.service.RoomService roomService = new com.fptpoly.service.RoomService();
    private final com.fptpoly.service.SeatService seatService = new com.fptpoly.service.SeatService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        java.util.List<com.fptpoly.model.Room> roomList = roomService.getAllRooms();
        request.setAttribute("roomList", roomList);

        String maPhong = request.getParameter("maPhong");
        if (maPhong == null && !roomList.isEmpty()) {
            maPhong = roomList.get(0).getMaPhong();
        }

        if (maPhong != null) {
            com.fptpoly.model.Room room = roomService.getRoomById(maPhong);
            request.setAttribute("room", room);

            java.util.List<com.fptpoly.model.Seat> seats = seatService.getSeatsByRoom(maPhong);
            java.util.Map<String, com.fptpoly.model.Seat> seatMap = new java.util.HashMap<>();
            for (com.fptpoly.model.Seat s : seats) {
                seatMap.put(s.getHangGhe() + "_" + s.getSoGhe(), s);
            }
            request.setAttribute("seatMap", seatMap);
            request.setAttribute("selectedRoom", maPhong);
        }

        request.getRequestDispatcher("/views/admin/seat.jsp").forward(request, response);
    }
}
