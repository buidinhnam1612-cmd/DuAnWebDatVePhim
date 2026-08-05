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
            String loaiGhe = request.getParameter("loaiGhe");

            // Gọi tầng Service xử lý tạo phòng & ma trận ghế
            boolean isSuccess = roomService.createRoomWithMatrix(maPhong, tenPhong, maRap, soHang, soCot, loaiGhe);

            if (isSuccess) {
                response.sendRedirect(request.getContextPath() + "/admin/room?status=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/room?status=fail");
            }
        }
    }
}
