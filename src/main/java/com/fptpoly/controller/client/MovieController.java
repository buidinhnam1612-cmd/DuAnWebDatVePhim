package com.fptpoly.controller.client;

import com.fptpoly.model.Comment;
import com.fptpoly.model.Genre;
import com.fptpoly.model.Movie;
import com.fptpoly.model.Showtime;
import com.fptpoly.model.Theater;
import com.fptpoly.repository.CommentRepository;
import com.fptpoly.repository.MovieRepository;
import com.fptpoly.repository.ShowtimeRepository;
import com.fptpoly.service.GenreService;
import com.fptpoly.service.TheaterService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/movies")
public class MovieController extends HttpServlet {

    private final MovieRepository movieRepository = new MovieRepository();
    private final ShowtimeRepository showtimeRepository = new ShowtimeRepository();
    private final CommentRepository commentRepository = new CommentRepository();
    private final GenreService genreService = new GenreService();
    private final TheaterService theaterService = new TheaterService();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("detail".equalsIgnoreCase(action)) {
            String maPhim = request.getParameter("id");
            if (maPhim == null || maPhim.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/movies");
                return;
            }

            Movie movie = movieRepository.getByID(maPhim);
            if (movie == null) {
                response.sendRedirect(request.getContextPath() + "/movies");
                return;
            }

            List<Showtime> listShowtimes = showtimeRepository.getByMovie(maPhim);
            List<Comment> listComments = commentRepository.getByMovie(maPhim);

            request.setAttribute("movie", movie);
            request.setAttribute("listSuatChieu", listShowtimes);
            request.setAttribute("listBinhLuan", listComments);

            request.getRequestDispatcher("/views/client/movieDetail.jsp").forward(request, response);
        } else {
            // Lấy các tham số lọc
            String keyword = request.getParameter("keyword");
            String selectedGenre = request.getParameter("genre");

            // Lấy danh sách phim theo bộ lọc thể loại
            List<Movie> allMovies;
            if (selectedGenre != null && !selectedGenre.isBlank()) {
                allMovies = movieRepository.getByGenre(selectedGenre.trim());
            } else {
                allMovies = movieRepository.getAll();
            }

            // Lọc thêm theo keyword (tìm kiếm tên phim)
            List<Movie> filteredMovies = new ArrayList<>();
            if (keyword != null && !keyword.isBlank()) {
                String keyLower = keyword.trim().toLowerCase();
                for (Movie m : allMovies) {
                    if (m.getTenPhim().toLowerCase().contains(keyLower)
                            || (m.getMoTa() != null && m.getMoTa().toLowerCase().contains(keyLower))) {
                        filteredMovies.add(m);
                    }
                }
            } else {
                filteredMovies = allMovies;
            }

            // Lấy danh sách thể loại phim từ DB (liên kết với admin/genre)
            List<Genre> listGenre = genreService.getAll();
            request.setAttribute("listTheLoai", listGenre);

            // Lấy danh sách rạp chiếu từ DB (liên kết với admin/theater)
            List<Theater> listTheater = theaterService.getall();
            request.setAttribute("listRap", listTheater);

            // Đẩy dữ liệu phim và các tham số lọc đã chọn
            request.setAttribute("listPhim", filteredMovies);
            request.setAttribute("keyword", keyword);
            request.setAttribute("selectedGenre", selectedGenre);

            request.getRequestDispatcher("/views/client/movie.jsp").forward(request, response);
        }
    }
}