package com.fptpoly.service;

import com.fptpoly.model.Movie;
import com.fptpoly.repository.MovieRepository;
import java.util.List;

public class MovieService {
    private final MovieRepository repo = new MovieRepository();

    public List<Movie> getAll() { return repo.getAll(); }
    public boolean them(Movie movie) { return repo.add(movie); }
    public boolean sua(Movie movie) { return repo.update(movie); }
    public Movie getByID(String id) { return repo.getByID(id); }
    public List<Movie> getByGenre(String maTheLoai) { return repo.getByGenre(maTheLoai); }

    public boolean toggleHide(String id) {
        Movie movie = repo.getByID(id);
        if (movie == null) return false;

        // Nếu đang hiển thị (hoặc rỗng) thì Ẩn, ngược lại thì Hiện lại
        if ("Ẩn".equals(movie.getTrangThai())) {
            movie.setTrangThai("Đang chiếu");
        } else {
            movie.setTrangThai("Ẩn");
        }
        return repo.update(movie);
    }
}

