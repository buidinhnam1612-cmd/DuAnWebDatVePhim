package com.fptpoly.controller.admin;

import com.fptpoly.model.Genre;
import com.fptpoly.service.GenreService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "GenreController", urlPatterns = {"/genre"})
public class GenreController extends HttpServlet {
    private final GenreService service = new GenreService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("edit".equals(action)) {
            String id = req.getParameter("id");
            if (id != null) {
                req.setAttribute("genreEdit", service.getByID(id.trim()));
            }
        } else if ("lock".equals(action)) {
            String id = req.getParameter("id");
            if (id != null) {
                service.lockOrUnlock(id.trim());
                resp.sendRedirect(req.getContextPath() + "/genre");
                return;
            }
        }

        req.setAttribute("listGenre", service.getAll());
        req.getRequestDispatcher("/views/admin/genre.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        String maTheLoai = req.getParameter("maTheLoai");
        String tenTheLoai = req.getParameter("tenTheLoai");

        Genre genre = new Genre(maTheLoai, tenTheLoai);
        boolean success;

        if ("update".equals(action)) {
            success = service.sua(genre);
        } else {
            success = service.them(genre);
        }

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/genre");
        } else {
            req.setAttribute("errorMessage", "Thao tác dữ liệu thất bại!");
            req.setAttribute("listGenre", service.getAll());
            req.getRequestDispatcher("/views/admin/genre.jsp").forward(req, resp);
        }
    }
}
