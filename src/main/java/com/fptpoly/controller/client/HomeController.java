package com.fptpoly.controller.client;

import com.fptpoly.model.Genre;
import com.fptpoly.model.Theater;
import com.fptpoly.service.GenreService;
import com.fptpoly.service.TheaterService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeController", urlPatterns = {"/", "/home"})
public class HomeController extends HttpServlet {

    // Khởi tạo các dịch vụ để lấy dữ liệu từ database
    private final GenreService genreService = new GenreService();
    private final TheaterService theaterService = new TheaterService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. Lấy danh sách thể loại phim và đẩy vào request scope
        List<Genre> listGenre = genreService.getAll();
        request.setAttribute("listTheLoai", listGenre);

        // 2. Lấy danh sách rạp phim và đẩy vào request scope
        List<Theater> listTheater = theaterService.getall();
        request.setAttribute("listRap", listTheater);

        // 3. Chuyển tiếp dữ liệu sang giao diện trang chủ
        request.getRequestDispatcher("/views/client/home.jsp").forward(request, response);
    }
}
