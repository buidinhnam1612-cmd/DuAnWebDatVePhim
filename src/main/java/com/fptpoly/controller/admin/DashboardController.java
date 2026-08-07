package com.fptpoly.controller.admin;


import com.fptpoly.service.GenreService;
import com.fptpoly.service.TheaterService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "DashboardController", urlPatterns = {"/admin/dashboard"})
public class DashboardController extends HttpServlet {

    private final TheaterService theaterService = new TheaterService();
    private final GenreService genreService = new GenreService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // 1. KIỂM TRA BẢO MẬT: Chỉ cho phép admin@gmail.com truy cập
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null || !"admin@gmail.com".equals(email)) {
            req.setAttribute("error", "Bạn không có quyền truy cập vào vùng quản trị!");
            req.getRequestDispatcher("/views/auth/login.jsp").forward(req, resp);
            return;
        }

        // 2. TÍNH TOÁN SỐ LIỆU THỰC TẾ TỪ DATABASE
        int totalTheaters = 0;
        int totalGenres = 0;
        try {
            if (theaterService.getall() != null) totalTheaters = theaterService.getall().size();
            if (genreService.getAll() != null) totalGenres = genreService.getAll().size();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 3. ĐẨY DỮ LIỆU SANG JSP (Bao gồm dữ liệu thật và dữ liệu giả lập cho các tính năng chưa viết)
        req.setAttribute("totalTheaters", totalTheaters);
        req.setAttribute("totalGenres", totalGenres);

        // Demo số liệu giả lập khớp với các chức năng trong ảnh bạn gửi
        req.setAttribute("totalRooms", 24);         // Quản lý phòng phim
        req.setAttribute("totalMovies", 15);        // Quản lý phim
        req.setAttribute("totalShowtimes", 48);     // Quản lý suất chiếu
        req.setAttribute("totalTickets", 342);      // Quản lý danh sách đặt vé / Xác nhận trạng thái
        req.setAttribute("totalUsers", 1250);       // Quản lý người dùng
        req.setAttribute("totalStaffs", 18);        // Quản lý & Phân quyền nhân viên
        req.setAttribute("totalRevenue", "154,250,000đ"); // Thống kê doanh thu

        // 4. CHUYỂN TIẾP SANG GIAO DIỆN
        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}

