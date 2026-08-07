package com.fptpoly.controller.admin;
// Kiểm tra và sửa lại package cho đúng dự án của bạn

import com.fptpoly.model.Showtime;
import com.fptpoly.service.ShowtimeService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet(name = "ShowtimeController", urlPatterns = {"/admin/showtime"}) // Đường dẫn để truy cập trang quản lý suất chiếu
public class ShowtimeController extends HttpServlet {

    private ShowtimeService showtimeService = new ShowtimeService();

    // 1. Hàm hiển thị giao diện và danh sách (Khi người dùng vào trang)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy danh sách suất chiếu từ Service và gửi sang file JSP
        request.setAttribute("listShowtime", showtimeService.getAllShowtimes());

        // Chuyển hướng sang file showtime.jsp hiển thị giao diện
        request.getRequestDispatcher("/views/admin/showtime.jsp").forward(request, response);
    }

    // 2. Hàm xử lý khi người dùng nhấn nút "Thêm suất chiếu" trên Form HTML
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Đặt tiếng Việt có dấu cho dữ liệu gửi lên
        request.setCharacterEncoding("UTF-8");

        try {
            // Đọc dữ liệu từ các ô nhập (input) có thuộc tính name tương ứng trong file JSP
            String maSuatChieu = request.getParameter("maSuatChieu");
            String maPhim = request.getParameter("maPhim");
            String maPhong = request.getParameter("maPhong");

            // Ép kiểu dữ liệu chuỗi (String) sang ngày tháng và giờ của Java 8
            LocalDate ngayChieu = LocalDate.parse(request.getParameter("ngayChieu"));
            LocalTime gioBatDau = LocalTime.parse(request.getParameter("gioBatDau"));
            LocalTime gioKetThuc = LocalTime.parse(request.getParameter("gioKetThuc"));

            // Tạo đối tượng suất chiếu mới và gán dữ liệu vào
            Showtime newShowtime = new Showtime();
            newShowtime.setMaSuatChieu(maSuatChieu);
            newShowtime.setMaPhim(maPhim);
            newShowtime.setMaPhong(maPhong);
            newShowtime.setNgayChieu(ngayChieu);
            newShowtime.setGioBatDau(gioBatDau);
            newShowtime.setGioKetThuc(gioKetThuc);

            // Gọi Service để xử lý kiểm tra trùng lịch và lưu vào DB
            String message = showtimeService.saveShowtime(newShowtime);

            // Gửi thông báo kết quả trả về ra màn hình giao diện
            request.setAttribute("message", message);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Thất bại: Định dạng ngày/giờ nhập vào không hợp lệ!");
        }

        // Sau khi xử lý xong, tải lại danh sách mới nhất và hiển thị lại trang jsp
        request.setAttribute("listShowtime", showtimeService.getAllShowtimes());
        request.getRequestDispatcher("/views/admin/showtime.jsp").forward(request, response);
    }
}


