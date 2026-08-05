package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Theater;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TheaterRepository {

    // 1. LẤY DANH SÁCH TẤT CẢ RẠP CHIẾU PHIM
    public List<Theater> getAll() {
        List<Theater> list = new ArrayList<>();
        String sql = "SELECT * from RAP";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Theater tt = new Theater(
                        rs.getString("MaRap"), rs.getString("TenRap"), rs.getString("DiaChi"),
                        rs.getString("Hotline"), rs.getString("HinhAnh")
                );
                list.add(tt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. CẬP NHẬT THÔNG TIN RẠP CHIẾU PHIM (SỬA)
    public boolean update(Theater tt) {
        String sql = "UPDATE RAP SET TenRap = ?, DiaChi = ?, HotLine = ?, HinhAnh = ? WHERE MaRap = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, tt.getTenRap());
            ps.setString(2, tt.getDiaChi());
            ps.setString(3, tt.getHotLine());
            ps.setString(4, tt.getHinhAnh());
            ps.setString(5, tt.getMaRap());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. TÌM KIẾM RẠP CHIẾU PHIM THEO MÃ (ĐỂ ĐỔ LÊN FORM SỬA)
    public Theater getByID(String id) {
        String sql = "SELECT MaRap, TenRap, DiaChi, HotLine, HinhAnh FROM RAP WHERE MaRap = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Theater theater = new Theater();
                    theater.setMaRap(rs.getString("MaRap"));
                    theater.setTenRap(rs.getString("TenRap"));
                    theater.setDiaChi(rs.getString("DiaChi"));
                    theater.setHotLine(rs.getString("HotLine"));
                    theater.setHinhAnh(rs.getString("HinhAnh"));

                    return theater;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
