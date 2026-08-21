package com.fptpoly.controller.client;

import com.fptpoly.model.Comment;
import com.fptpoly.model.Genre;
import com.fptpoly.model.Movie;
import com.fptpoly.model.Showtime;
import com.fptpoly.model.Theater;
import com.fptpoly.model.User;
import com.fptpoly.repository.MovieRepository;
import com.fptpoly.repository.ShowtimeRepository;
import com.fptpoly.service.CommentService;
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
    private final CommentService commentService = new CommentService();
    private final GenreService genreService = new GenreService();        // 1. Thêm GenreService
    private final TheaterService theaterService = new TheaterService();  // 2. Thêm TheaterService

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
            if (maPhim != null && !maPhim.trim().isEmpty()) {
                Movie movie = movieRepository.getByID(maPhim.trim());
                if (movie != null) {
                    List<Showtime> listSuatChieu = showtimeRepository.getByMovie(maPhim.trim());

                    HttpSession session = request.getSession(false);
                    User currentUser = (session != null) ? (User) session.getAttribute("user") : null;
                    String currentUserId = (currentUser != null) ? currentUser.getMaKhachHang() : null;

                    List<Comment> listBinhLuan = commentService.getCommentsByMovie(maPhim.trim(), currentUserId);

                    double totalStars = 0;
                    int totalCount = listBinhLuan.size();
                    for (Comment c : listBinhLuan) {
                        if (c.getSoSao() != null) totalStars += c.getSoSao();
                    }
                    double avgRating = totalCount > 0 ? (totalStars / totalCount) : 0;

                    request.setAttribute("movie", movie);
                    request.setAttribute("listSuatChieu", listSuatChieu);
                    request.setAttribute("listBinhLuan", listBinhLuan);
                    request.setAttribute("avgRating", avgRating);
                    request.setAttribute("totalBinhLuan", totalCount);

                    request.getRequestDispatcher("/views/client/movieDetail.jsp").forward(request, response);
                    return;
                }
            }
            response.sendRedirect(request.getContextPath() + "/movies");
        } else {
            String keyword = request.getParameter("keyword");
            String genre = request.getParameter("genre"); // 3. Lấy mã thể loại từ request

            List<Movie> allMovies = movieRepository.getAll();
            List<Movie> filteredMovies = new ArrayList<>();

            boolean hasKeyword = (keyword != null && !keyword.isBlank());
            boolean hasGenre = (genre != null && !genre.isBlank());
            String keyLower = hasKeyword ? keyword.trim().toLowerCase() : "";

            // 4. Lọc kết hợp cả tên/mô tả và thể loại
            for (Movie m : allMovies) {
                boolean matchKeyword = !hasKeyword || (
                        (m.getTenPhim() != null && m.getTenPhim().toLowerCase().contains(keyLower)) ||
                                (m.getMoTa() != null && m.getMoTa().toLowerCase().contains(keyLower))
                );

                boolean matchGenre = !hasGenre || (
                        m.getMaTheLoai() != null && m.getMaTheLoai().equalsIgnoreCase(genre.trim())
                );

                if (matchKeyword && matchGenre) {
                    filteredMovies.add(m);
                }
            }

            // 5. Đẩy danh sách thể loại và rạp từ DB sang JSP
            request.setAttribute("listTheLoai", genreService.getAll());
            request.setAttribute("listRap", theaterService.getall());

            // 6. Đẩy danh sách phim và dữ liệu lọc đã chọn
            request.setAttribute("listPhim", filteredMovies);
            request.setAttribute("keyword", keyword);
            request.setAttribute("selectedGenre", genre);

            request.getRequestDispatcher("/views/client/movie.jsp").forward(request, response);
        }
    }
}
