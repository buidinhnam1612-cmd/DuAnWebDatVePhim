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

        // Không cần kiểm tra đăng nhập ở đây nữa vì Filter đã làm
        HttpSession session = req.getSession();

        // Kiểm tra thông báo lỗi từ AuthorizationFilter
        String error = (String) session.getAttribute("error");
        if (error != null) {
            req.setAttribute("error", error);
            session.removeAttribute("error");
        }

        // TÍNH TOÁN SỐ LIỆU THỰC TẾ TỪ DATABASE
        int totalTheaters = 0;
        int totalGenres = 0;
        try {
            if (theaterService.getall() != null) totalTheaters = theaterService.getall().size();
            if (genreService.getAll() != null) totalGenres = genreService.getAll().size();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // ĐẨY DỮ LIỆU SANG JSP
        req.setAttribute("totalTheaters", totalTheaters);
        req.setAttribute("totalGenres", totalGenres);

        // Demo số liệu giả lập khớp với các chức năng trong ảnh bạn gửi
        req.setAttribute("totalRooms", 24);
        req.setAttribute("totalMovies", 15);
        req.setAttribute("totalShowtimes", 48);
        req.setAttribute("totalTickets", 342);
        req.setAttribute("totalUsers", 1250);
        req.setAttribute("totalStaffs", 18);
        req.setAttribute("totalRevenue", "154,250,000đ");

        // CHUYỂN TIẾP SANG GIAO DIỆN
        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
