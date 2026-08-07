package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Genre;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GenreRepository {

    public List<Genre> getAll() {
        List<Genre> list = new ArrayList<>();
        String sql = "SELECT * FROM THE_LOAI";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Genre(rs.getString("MaTheLoai"), rs.getString("TenTheLoai")));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean add(Genre genre) {
        String sql = "INSERT INTO THE_LOAI (MaTheLoai, TenTheLoai) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, genre.getMaTheLoai());
            ps.setString(2, genre.getTenTheLoai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean update(Genre genre) {
        String sql = "UPDATE THE_LOAI SET TenTheLoai = ? WHERE MaTheLoai = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, genre.getTenTheLoai());
            ps.setString(2, genre.getMaTheLoai());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public Genre getByID(String id) {
        String sql = "SELECT * FROM THE_LOAI WHERE MaTheLoai = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Genre(rs.getString("MaTheLoai"), rs.getString("TenTheLoai"));
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}

