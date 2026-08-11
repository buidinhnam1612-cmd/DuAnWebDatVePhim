package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Voucher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class VoucherRepository {

    /**
     * Tìm voucher theo mã code khách hàng nhập
     * Chỉ trả về voucher đang hoạt động
     */
    public Voucher findByCode(String maCode) {

        String sql = """
                SELECT *
                FROM VOUCHER
                WHERE MaCode = ?
                  AND TrangThai = N'Hoạt động'
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, maCode.trim());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapVoucher(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Tìm voucher theo mã voucher (MaVoucher)
     */
    public Voucher findById(String maVoucher) {

        String sql = """
                SELECT *
                FROM VOUCHER
                WHERE MaVoucher = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, maVoucher);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapVoucher(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Giảm số lượng voucher sau khi sử dụng
     */
    public boolean decreaseQuantity(String maVoucher) {

        String sql = """
                UPDATE VOUCHER
                SET SoLuong = SoLuong - 1
                WHERE MaVoucher = ?
                  AND SoLuong > 0
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, maVoucher);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Mapping ResultSet -> Voucher
     */
    private Voucher mapVoucher(ResultSet rs) throws Exception {

        Voucher voucher = new Voucher();

        voucher.setMaVoucher(rs.getString("MaVoucher"));
        voucher.setTenVoucher(rs.getString("TenVoucher"));

        // MaCode có thể không tồn tại trong bảng cũ
        try {
            voucher.setMaCode(rs.getString("MaCode"));
        } catch (Exception e) {
            // Nếu cột MaCode không tồn tại, dùng MaVoucher làm code
            voucher.setMaCode(rs.getString("MaVoucher"));
        }

        try {
            voucher.setPhanTramGiam(rs.getInt("PhanTramGiam"));
        } catch (Exception e) {
            voucher.setPhanTramGiam(0);
        }

        try {
            voucher.setNgayBatDau(rs.getDate("NgayBatDau"));
        } catch (Exception e) {
            voucher.setNgayBatDau(null);
        }

        try {
            voucher.setNgayKetThuc(rs.getDate("NgayHetHan"));
        } catch (Exception e) {
            try {
                voucher.setNgayKetThuc(rs.getDate("NgayKetThuc"));
            } catch (Exception ex) {
                voucher.setNgayKetThuc(null);
            }
        }

        try {
            voucher.setSoLuong(rs.getInt("SoLuong"));
        } catch (Exception e) {
            voucher.setSoLuong(999);
        }

        try {
            voucher.setTrangThai(rs.getString("TrangThai"));
        } catch (Exception e) {
            voucher.setTrangThai("Hoạt động");
        }

        try {
            voucher.setDiemDoiVoucher(rs.getInt("DiemDoiVoucher"));
        } catch (Exception e) {
            voucher.setDiemDoiVoucher(0);
        }

        try {
            voucher.setGiamToiDa(rs.getDouble("GiamToiDa"));
        } catch (Exception e) {
            voucher.setGiamToiDa(0);
        }

        return voucher;
    }

    /**
     * Lấy toàn bộ danh sách Voucher
     */
    public java.util.List<Voucher> getAll() {
        java.util.List<Voucher> list = new ArrayList<>();
        String sql = "SELECT * FROM VOUCHER";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapVoucher(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
