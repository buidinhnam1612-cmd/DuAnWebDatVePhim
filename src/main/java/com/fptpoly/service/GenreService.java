package com.fptpoly.service;

import com.fptpoly.model.Genre;
import com.fptpoly.repository.GenreRepository;
import java.util.List;

public class GenreService {
    private final GenreRepository repo = new GenreRepository();

    public List<Genre> getAll() {
        return repo.getAll();
    }

    public boolean them(Genre genre) {
        return repo.add(genre);
    }

    public boolean sua(Genre genre) {
        return repo.update(genre);
    }

    public Genre getByID(String id) {
        return repo.getByID(id);
    }

    public boolean lockOrUnlock(String id) {
        Genre genre = repo.getByID(id);
        if (genre == null) return false;

        String tenHienTai = genre.getTenTheLoai();
        if (tenHienTai.contains("(Đã khóa)")) {
            genre.setTenTheLoai(tenHienTai.replace(" (Đã khóa)", ""));
        } else {
            genre.setTenTheLoai(tenHienTai + " (Đã khóa)");
        }
        return repo.update(genre);
    }
}

