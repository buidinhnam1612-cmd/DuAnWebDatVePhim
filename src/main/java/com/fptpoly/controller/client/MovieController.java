package com.fptpoly.controller.client;

import com.fptpoly.model.Comment;
import com.fptpoly.model.Movie;
import com.fptpoly.model.Showtime;
import com.fptpoly.model.User;
import com.fptpoly.repository.MovieRepository;
import com.fptpoly.repository.ShowtimeRepository;
import com.fptpoly.service.CommentService;

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

            HttpSession session = request.getSession(false);
            User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;
            String userMaKH = (loggedInUser != null) ? loggedInUser.getMaKhachHang() : null;

            List<Showtime> listShowtimes = showtimeRepository.getByMovie(maPhim);
            List<Comment> listComments = commentService.getCommentsByMovie(maPhim, userMaKH);

            // Tính toán điểm trung bình đánh giá và tổng lượt đánh giá
            double avgRating = 0.0;
            int totalBinhLuan = listComments.size();
            if (totalBinhLuan > 0) {
                int sum = 0;
                for (Comment c : listComments) {
                    sum += c.getSoSao();
                }
                avgRating = (double) sum / totalBinhLuan;
            }

            // Đồng bộ flash messages từ Session sang Request và xóa để tránh hiển thị lặp lại
            if (session != null) {
                String successMsg = (String) session.getAttribute("successMsg");
                String errorMsg = (String) session.getAttribute("errorMsg");
                Object tempNoiDung = session.getAttribute("tempNoiDung");
                Object tempSoSao = session.getAttribute("tempSoSao");

                if (successMsg != null) {
                    request.setAttribute("successMsg", successMsg);
                    session.removeAttribute("successMsg");
                }
                if (errorMsg != null) {
                    request.setAttribute("errorMsg", errorMsg);
                    session.removeAttribute("errorMsg");
                }
                if (tempNoiDung != null) {
                    request.setAttribute("tempNoiDung", tempNoiDung);
                    session.removeAttribute("tempNoiDung");
                }
                if (tempSoSao != null) {
                    request.setAttribute("tempSoSao", tempSoSao);
                    session.removeAttribute("tempSoSao");
                }
            }

            request.setAttribute("movie", movie);
            request.setAttribute("listSuatChieu", listShowtimes);
            request.setAttribute("listBinhLuan", listComments);
            request.setAttribute("avgRating", avgRating);
            request.setAttribute("totalBinhLuan", totalBinhLuan);

            request.getRequestDispatcher("/views/client/movieDetail.jsp").forward(request, response);
        } else {
            String keyword = request.getParameter("keyword");
            List<Movie> allMovies = movieRepository.getAll();
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

            request.setAttribute("listPhim", filteredMovies);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("/views/client/movie.jsp").forward(request, response);
        }
    }
}