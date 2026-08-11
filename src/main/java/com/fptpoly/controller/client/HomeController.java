package com.fptpoly.controller.client;

import com.fptpoly.model.Genre;
import com.fptpoly.model.Theater;
import com.fptpoly.service.GenreService;
import com.fptpoly.service.TheaterService;
import com.fptpoly.model.Movie;
import com.fptpoly.model.Food;
import com.fptpoly.repository.MovieRepository;
import com.fptpoly.service.CustomerFoodService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeController", urlPatterns = {"/", "/home"})
public class HomeController extends HttpServlet {

    private final GenreService genreService = new GenreService();
    private final TheaterService theaterService = new TheaterService();
    private final MovieRepository movieRepository = new MovieRepository();
    private final CustomerFoodService customerFoodService = new CustomerFoodService();

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

        // 3. Lấy danh sách toàn bộ phim và đẩy vào request scope
        List<Movie> listMovies = movieRepository.getAll();
        request.setAttribute("listPhim", listMovies);

        // 4. Lấy danh sách đồ ăn thức uống và đẩy vào request scope
        List<Food> listFoods = customerFoodService.getActiveFoods();
        request.setAttribute("listFoods", listFoods);

        // 5. Chuyển tiếp dữ liệu sang giao diện trang chủ
        request.getRequestDispatcher("/views/client/home.jsp").forward(request, response);
    }
}
