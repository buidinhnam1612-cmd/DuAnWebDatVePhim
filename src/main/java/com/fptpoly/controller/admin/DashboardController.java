package com.fptpoly.controller.admin;

import com.fptpoly.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.Locale;

@WebServlet(name = "DashboardController", urlPatterns = {"/admin/dashboard"})
public class DashboardController extends HttpServlet {

    private final TheaterService theaterService = new TheaterService();
    private final GenreService genreService = new GenreService();
    private final BookingService bookingService = new BookingService();
    private final MovieService movieService = new MovieService();
    private final RoomService roomService = new RoomService();
    private final ShowtimeService showtimeService = new ShowtimeService();
    private final UserService userService = new UserService();
    private final EmployeeService employeeService = new EmployeeService();

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
        int totalRooms = 0;
        int totalMovies = 0;
        int totalShowtimes = 0;
        int totalTicketsToday = 0;
        int totalUsers = 0;
        int totalStaffs = 0;
        double monthlyRevenue = 0;

        try {
            if (theaterService.getall() != null) totalTheaters = theaterService.getall().size();
            if (genreService.getAll() != null) totalGenres = genreService.getAll().size();
            if (roomService.getAllRooms() != null) totalRooms = roomService.getAllRooms().size();
            if (movieService.getAll() != null) totalMovies = movieService.getAll().size();
            if (showtimeService.getAllShowtimes() != null) totalShowtimes = showtimeService.getAllShowtimes().size();
            if (userService.getAllUsers() != null) totalUsers = userService.getAllUsers().size();
            if (employeeService.getAllEmployees() != null) totalStaffs = employeeService.getAllEmployees().size();

            // Số vé đặt hôm nay (tự động khớp khi khách đặt vé mới)
            totalTicketsToday = bookingService.countTodayBookings();

            // Doanh thu tháng này (chỉ tính vé đã thanh toán)
            monthlyRevenue = bookingService.getMonthlyRevenue();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Format doanh thu theo định dạng tiền Việt Nam
        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
        String formattedRevenue = nf.format((long) monthlyRevenue) + "đ";

        // ĐẨY DỮ LIỆU THỰC TẾ SANG JSP
        req.setAttribute("totalTheaters", totalTheaters);
        req.setAttribute("totalGenres", totalGenres);
        req.setAttribute("totalRooms", totalRooms);
        req.setAttribute("totalMovies", totalMovies);
        req.setAttribute("totalShowtimes", totalShowtimes);
        req.setAttribute("totalTickets", totalTicketsToday);
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("totalStaffs", totalStaffs);
        req.setAttribute("totalRevenue", formattedRevenue);

        // CHUYỂN TIẾP SANG GIAO DIỆN
        req.getRequestDispatcher("/views/admin/dashboard.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
