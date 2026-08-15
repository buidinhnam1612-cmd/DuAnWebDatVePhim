package com.fptpoly.controller.admin;

import com.fptpoly.model.Movie;
import com.fptpoly.service.GenreService;
import com.fptpoly.service.MovieService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet(name = "MovieController", urlPatterns = {"/admin/movie"})
public class MovieController extends HttpServlet {
    private final MovieService service = new MovieService();
    private final GenreService genreService = new GenreService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            String id = req.getParameter("id");
            if (id != null) {
                req.setAttribute("movieEdit", service.getByID(id.trim()));
            }
        } else if ("hide".equals(action)) {
            String id = req.getParameter("id");
            if (id != null) {
                service.toggleHide(id.trim());
                resp.sendRedirect(req.getContextPath() + "/admin/movie");
                return;
            }
        }

        req.setAttribute("listMovie", service.getAll());
        // Đẩy danh sách thể loại để hiển thị dropdown trong form thêm/sửa phim
        req.setAttribute("listGenre", genreService.getAll());
        req.getRequestDispatcher("/views/admin/movie.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        String maPhim = req.getParameter("maPhim");
        String tenPhim = req.getParameter("tenPhim");
        String moTa = req.getParameter("moTa");
        int thoiLuong = Integer.parseInt(req.getParameter("thoiLuong"));
        String trailer = req.getParameter("trailer");
        String poster = req.getParameter("poster");
        Date ngayKhoiChieu = Date.valueOf(req.getParameter("ngayKhoiChieu"));
        String doTuoiGiaiTri = req.getParameter("doTuoiGiaiTri");
        String trangThai = req.getParameter("trangThai");
        String maTheLoai = req.getParameter("maTheLoai");

        Movie movie = new Movie(maPhim, tenPhim, moTa, thoiLuong, trailer, poster, ngayKhoiChieu, doTuoiGiaiTri, trangThai, maTheLoai);
        boolean success = "update".equals(action) ? service.sua(movie) : service.them(movie);

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/admin/movie");
        } else {
            req.setAttribute("errorMessage", "Thao tác dữ liệu thất bại!");
            req.setAttribute("listMovie", service.getAll());
            req.setAttribute("listGenre", genreService.getAll());
            req.getRequestDispatcher("/views/admin/movie.jsp").forward(req, resp);
        }
    }
}
