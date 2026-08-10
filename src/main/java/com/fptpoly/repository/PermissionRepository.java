package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.Permission;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PermissionRepository {

    public PermissionRepository() {
        initTablesAndData();
    }

    private void initTablesAndData() {
        String createQuyenTable = """
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'QUYEN')
                BEGIN
                    CREATE TABLE QUYEN (
                        MaQuyen VARCHAR(50) PRIMARY KEY,
                        TenQuyen NVARCHAR(100) NOT NULL,
                        MoTa NVARCHAR(255),
                        NhomQuyen NVARCHAR(100)
                    );
                END
                """;

        String createNhanVienQuyenTable = """
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'NHAN_VIEN_QUYEN')
                BEGIN
                    CREATE TABLE NHAN_VIEN_QUYEN (
                        MaNhanVien VARCHAR(20) NOT NULL,
                        MaQuyen VARCHAR(50) NOT NULL,
                        PRIMARY KEY (MaNhanVien, MaQuyen)
                    );
                END
                """;

        try (Connection con = DBConnection.getConnection()) {
            if (con != null) {
                try (Statement stmt = con.createStatement()) {
                    stmt.execute(createQuyenTable);
                    stmt.execute(createNhanVienQuyenTable);
                }
                seedPermissions(con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void seedPermissions(Connection con) {
        List<Permission> defaultPermissions = List.of(
                new Permission(Permission.VIEW_SHOWTIME, "Tra cứu suất chiếu", "Xem lịch chiếu, giờ chiếu và phòng chiếu", "Suất chiếu & Ghế"),
                new Permission(Permission.VIEW_SEAT, "Xem sơ đồ ghế", "Xem sơ đồ ghế và tình trạng ghế trống/đã đặt", "Suất chiếu & Ghế"),
                new Permission(Permission.VIEW_FOOD, "Xem danh sách đồ ăn", "Xem thông tin các món ăn và đồ uống", "Đồ ăn"),
                new Permission(Permission.MANAGE_FOOD, "Quản lý đồ ăn", "Cập nhật số lượng, giá và trạng thái đồ ăn", "Đồ ăn"),
                new Permission(Permission.VIEW_BOOKING, "Quản lý danh sách đặt vé", "Tìm kiếm, tra cứu vé theo mã, SĐT, email", "Vé & Check-in"),
                new Permission(Permission.CHECKIN_BOOKING, "Check-in vé", "Xác nhận và chuyển trạng thái vé sang Đã sử dụng", "Vé & Check-in"),
                new Permission(Permission.CANCEL_BOOKING, "Hủy vé", "Hỗ trợ khách hàng hủy booking", "Vé & Check-in"),
                new Permission(Permission.CHANGE_BOOKING, "Đổi vé", "Hỗ trợ khách hàng đổi suất chiếu / vé", "Vé & Check-in"),
                new Permission(Permission.VIEW_COMMENT, "Xem bình luận", "Xem danh sách bình luận đánh giá", "Bình luận"),
                new Permission(Permission.MODERATE_COMMENT, "Kiểm duyệt bình luận", "Ẩn hoặc xóa bình luận của khách hàng", "Bình luận"),
                new Permission(Permission.VIEW_SHIFT_REPORT, "Báo cáo ca trực", "Xem doanh thu và số vé do chính mình bán trong ca", "Báo cáo")
        );

        String sqlCheck = "SELECT 1 FROM QUYEN WHERE MaQuyen = ?";
        String sqlInsert = "INSERT INTO QUYEN (MaQuyen, TenQuyen, MoTa, NhomQuyen) VALUES (?, ?, ?, ?)";

        for (Permission p : defaultPermissions) {
            try (PreparedStatement psCheck = con.prepareStatement(sqlCheck)) {
                psCheck.setString(1, p.getMaQuyen());
                ResultSet rs = psCheck.executeQuery();
                if (!rs.next()) {
                    try (PreparedStatement psInsert = con.prepareStatement(sqlInsert)) {
                        psInsert.setString(1, p.getMaQuyen());
                        psInsert.setString(2, p.getTenQuyen());
                        psInsert.setString(3, p.getMoTa());
                        psInsert.setString(4, p.getNhomQuyen());
                        psInsert.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<Permission> getAllPermissions() {
        List<Permission> list = new ArrayList<>();
        String sql = "SELECT * FROM QUYEN ORDER BY NhomQuyen, MaQuyen";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Permission(
                        rs.getString("MaQuyen"),
                        rs.getString("TenQuyen"),
                        rs.getString("MoTa"),
                        rs.getString("NhomQuyen")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> getPermissionsByEmployee(String maNhanVien) {

        List<String> list = new ArrayList<>();

        // Bước 1: Lấy quyền riêng của nhân viên
        String sqlEmployeePermission = """
            SELECT MaQuyen
            FROM NHAN_VIEN_QUYEN
            WHERE MaNhanVien = ?
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sqlEmployeePermission)) {

            ps.setString(1, maNhanVien);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(rs.getString("MaQuyen"));
                }
            }

            // Nếu nhân viên đã được phân quyền riêng
            // thì sử dụng đúng quyền riêng đó.
            if (!list.isEmpty()) {
                return list;
            }

            // Bước 2: Nhân viên chưa có quyền riêng
            // => kiểm tra vai trò
            String sqlRole = """
                SELECT MaVaiTro
                FROM NHAN_VIEN
                WHERE MaNhanVien = ?
                """;

            try (PreparedStatement psRole = con.prepareStatement(sqlRole)) {

                psRole.setString(1, maNhanVien);

                try (ResultSet rsRole = psRole.executeQuery()) {

                    if (rsRole.next()) {

                        String maVaiTro = rsRole.getString("MaVaiTro");

                        // VT02 = Nhân viên
                        if ("VT02".equalsIgnoreCase(maVaiTro)) {

                            // Quyền mặc định của Nhân viên
                            list.add(Permission.VIEW_SHOWTIME);
                            list.add(Permission.VIEW_SEAT);
                            list.add(Permission.VIEW_FOOD);
                            list.add(Permission.MANAGE_FOOD);
                            list.add(Permission.VIEW_BOOKING);
                            list.add(Permission.CHECKIN_BOOKING);
                            list.add(Permission.VIEW_SHIFT_REPORT);
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateEmployeePermissions(String maNhanVien, List<String> permissions) {
        String sqlDelete = "DELETE FROM NHAN_VIEN_QUYEN WHERE MaNhanVien = ?";
        String sqlInsert = "INSERT INTO NHAN_VIEN_QUYEN (MaNhanVien, MaQuyen) VALUES (?, ?)";

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) return false;
            con.setAutoCommit(false);

            try (PreparedStatement psDel = con.prepareStatement(sqlDelete)) {
                psDel.setString(1, maNhanVien);
                psDel.executeUpdate();
            }

            if (permissions != null && !permissions.isEmpty()) {
                try (PreparedStatement psIns = con.prepareStatement(sqlInsert)) {
                    for (String perm : permissions) {
                        psIns.setString(1, maNhanVien);
                        psIns.setString(2, perm);
                        psIns.addBatch();
                    }
                    psIns.executeBatch();
                }
            }

            con.commit();
            con.setAutoCommit(true);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
