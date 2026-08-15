package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Feedback;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class FeedbackRepository {

    public boolean insert(Feedback feedback) {
        String sql = "INSERT INTO FEEDBACK (MaFeedback, HoTen, Email, NoiDung, MaKhachHang) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, feedback.getMaFeedback());
            ps.setString(2, feedback.getHoTen());
            ps.setString(3, feedback.getEmail());
            ps.setString(4, feedback.getNoiDung());
            ps.setString(5, feedback.getMaKhachHang());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}