package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.EmployeePermission;
import com.fptpoly.model.Permission;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PermissionRepository {

    public PermissionRepository() {
        // Constructor không tự động chạy DDL/Seed database mỗi khi khởi tạo
    }

    public static void initTablesAndData() {
        String createVaiTroTable = """
                IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'VAI_TRO')
                BEGIN
                    CREATE TABLE VAI_TRO (
                        MaVaiTro VARCHAR(20) PRIMARY KEY,
                        TenVaiTro NVARCHAR(100) NOT NULL
                    );
                END
                """;

        String createQuyenTable = """
                IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'QUYEN')
                BEGIN
                    CREATE TABLE QUYEN (
                        MaQuyen VARCHAR(50) PRIMARY KEY,
                        TenQuyen NVARCHAR(100) NOT NULL,
                        MoTa NVARCHAR(255)
                    );
                END
                """;

        String createVaiTroQuyenTable = """
                IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'VAI_TRO_QUYEN')
                BEGIN
                    CREATE TABLE VAI_TRO_QUYEN (
                        MaVaiTroQuyen INT IDENTITY(1,1) PRIMARY KEY,
                        MaVaiTro VARCHAR(20) NOT NULL,
                        MaQuyen VARCHAR(50) NOT NULL,
                        CONSTRAINT UQ_VT_QUYEN UNIQUE (MaVaiTro, MaQuyen)
                    );
                END
                """;

        String createNhanVienQuyenTable = """
                IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'NHAN_VIEN_QUYEN')
                BEGIN
                    CREATE TABLE NHAN_VIEN_QUYEN (
                        MaNhanVienQuyen VARCHAR(50) PRIMARY KEY,
                        MaNhanVien VARCHAR(20) NOT NULL,
                        MaQuyen VARCHAR(50) NOT NULL,
                        TrangThai BIT DEFAULT 1,
                        CONSTRAINT UQ_NV_QUYEN UNIQUE (MaNhanVien, MaQuyen)
                    );
                END
                """;

        try (Connection con = DBConnection.getConnection()) {
            if (con == null) return;
            try (Statement stmt = con.createStatement()) {
                stmt.execute(createVaiTroTable);
                stmt.execute(createQuyenTable);
                stmt.execute(createVaiTroQuyenTable);
                stmt.execute(createNhanVienQuyenTable);
            }
            seedRolesAndPermissions(con);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void seedRolesAndPermissions(Connection con) {
        String sqlCheckRole = "SELECT 1 FROM VAI_TRO WHERE MaVaiTro = ?";
        String sqlInsertRole = "INSERT INTO VAI_TRO (MaVaiTro, TenVaiTro) VALUES (?, ?)";
        String[][] defaultRoles = {
                {"VT01", "Quản trị viên"},
                {"VT02", "Nhân viên bán vé"},
                {"VT03", "Khách hàng thành viên"},
                {"VT04", "Nhân viên quầy đồ ăn"}
        };

        for (String[] role : defaultRoles) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckRole)) {
                ps.setString(1, role[0]);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        try (PreparedStatement psInsert = con.prepareStatement(sqlInsertRole)) {
                            psInsert.setString(1, role[0]);
                            psInsert.setString(2, role[1]);
                            psInsert.executeUpdate();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        List<Permission> defaultPermissions = List.of(
                new Permission("Q01", "Tổng quan Dashboard", "Được phép xem trang tổng quan hệ thống"),
                new Permission("Q02", "Quản lý rạp phim", "Quản lý thông tin các cụm rạp"),
                new Permission("Q03", "Quản lý thể loại phim", "Quản lý danh mục thể loại phim"),
                new Permission("Q04", "Quản lý phòng phim", "Quản lý danh sách phòng chiếu"),
                new Permission("Q05", "Quản lý phim", "Thêm, sửa, xóa danh sách phim"),
                new Permission("Q06", "Quản lý suất chiếu", "Tạo và cập nhật suất chiếu"),
                new Permission("Q07", "Quản lý đặt vé", "Xem và cập nhật danh sách đặt vé"),
                new Permission("Q08", "Xác nhận trạng thái vé", "Xác nhận và cập nhật trạng thái vé"),
                new Permission("Q09", "Sơ đồ ghế", "Xem và quản lý sơ đồ, trạng thái ghế"),
                new Permission("Q10", "Quản lý đồ ăn", "Quản lý danh mục đồ ăn và đồ uống"),
                new Permission("Q11", "Quản lý người dùng", "Xem và quản lý thông tin người dùng"),
                new Permission("Q12", "Quản lý voucher", "Quản lý mã giảm giá khuyến mãi"),
                new Permission("Q13", "Thống kê & Báo cáo", "Xem báo cáo thống kê và doanh thu"),
                new Permission("Q14", "Nhân viên & Phân quyền", "Quản lý tài khoản và phân quyền nhân viên"),
                new Permission("Q15", "Kiểm duyệt bình luận", "Kiểm duyệt và quản lý bình luận")
        );

        String sqlCheckPermission = "SELECT 1 FROM QUYEN WHERE MaQuyen = ?";
        String sqlInsertPermission = "INSERT INTO QUYEN (MaQuyen, TenQuyen, MoTa) VALUES (?, ?, ?)";
        String sqlUpdatePermission = "UPDATE QUYEN SET TenQuyen = ?, MoTa = ? WHERE MaQuyen = ?";

        for (Permission permission : defaultPermissions) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckPermission)) {
                ps.setString(1, permission.getMaQuyen());
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        try (PreparedStatement psInsert = con.prepareStatement(sqlInsertPermission)) {
                            psInsert.setString(1, permission.getMaQuyen());
                            psInsert.setString(2, permission.getTenQuyen());
                            psInsert.setString(3, permission.getMoTa());
                            psInsert.executeUpdate();
                        }
                    } else {
                        try (PreparedStatement psUpdate = con.prepareStatement(sqlUpdatePermission)) {
                            psUpdate.setString(1, permission.getTenQuyen());
                            psUpdate.setString(2, permission.getMoTa());
                            psUpdate.setString(3, permission.getMaQuyen());
                            psUpdate.executeUpdate();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        String sqlCheckRolePermission = "SELECT 1 FROM VAI_TRO_QUYEN WHERE MaVaiTro = ? AND MaQuyen = ?";
        String sqlInsertRolePermission = "INSERT INTO VAI_TRO_QUYEN (MaVaiTro, MaQuyen) VALUES (?, ?)";

        // VT01: Q01 -> Q15
        for (Permission permission : defaultPermissions) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckRolePermission)) {
                ps.setString(1, "VT01");
                ps.setString(2, permission.getMaQuyen());
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        try (PreparedStatement psInsert = con.prepareStatement(sqlInsertRolePermission)) {
                            psInsert.setString(1, "VT01");
                            psInsert.setString(2, permission.getMaQuyen());
                            psInsert.executeUpdate();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // VT04 (Nhân viên quầy): Q01, Q08, Q09, Q10, Q15
        String[] vt04Permissions = {"Q01", "Q08", "Q09", "Q10", "Q15"};
        for (String maQuyen : vt04Permissions) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckRolePermission)) {
                ps.setString(1, "VT04");
                ps.setString(2, maQuyen);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        try (PreparedStatement psInsert = con.prepareStatement(sqlInsertRolePermission)) {
                            psInsert.setString(1, "VT04");
                            psInsert.setString(2, maQuyen);
                            psInsert.executeUpdate();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // VT02 (Nhân viên rạp): Q01, Q09
        String[] vt02Permissions = {"Q01", "Q09"};
        for (String maQuyen : vt02Permissions) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckRolePermission)) {
                ps.setString(1, "VT02");
                ps.setString(2, maQuyen);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        try (PreparedStatement psInsert = con.prepareStatement(sqlInsertRolePermission)) {
                            psInsert.setString(1, "VT02");
                            psInsert.setString(2, maQuyen);
                            psInsert.executeUpdate();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<Permission> getAllPermissions() {
        List<Permission> list = new ArrayList<Permission>();
        String sql = "SELECT MaQuyen, TenQuyen, MoTa FROM QUYEN ORDER BY MaQuyen";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // 🔥 SỬA TẠI ĐÂY: Khử sạch khoảng trắng thừa của kiểu dữ liệu CHAR dưới SQL Server
                String rawMaQuyen = rs.getString("MaQuyen");
                String cleanMaQuyen = rawMaQuyen != null ? rawMaQuyen.trim() : "";

                list.add(new Permission(
                        cleanMaQuyen,
                        rs.getString("TenQuyen"),
                        rs.getString("MoTa")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public List<EmployeePermission> getEmployeePermissions(String maNhanVien) {
        List<EmployeePermission> list = new ArrayList<EmployeePermission>();
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return list;
        }

        String sql = """
                SELECT
                    nv.MaNhanVien,
                    nv.HoTen,
                    q.MaQuyen,
                    q.TenQuyen,
                    q.MoTa,
                    CASE
                        WHEN nvq.TrangThai IS NOT NULL THEN CAST(nvq.TrangThai AS INT)
                        WHEN vtq.MaQuyen IS NOT NULL THEN 1
                        ELSE 0
                    END AS TrangThai
                FROM QUYEN q
                LEFT JOIN NHAN_VIEN nv ON RTRIM(LTRIM(nv.MaNhanVien)) = ?
                LEFT JOIN VAI_TRO_QUYEN vtq
                    ON RTRIM(LTRIM(vtq.MaVaiTro)) = RTRIM(LTRIM(nv.MaVaiTro))
                    AND RTRIM(LTRIM(vtq.MaQuyen)) = RTRIM(LTRIM(q.MaQuyen))
                LEFT JOIN NHAN_VIEN_QUYEN nvq
                    ON RTRIM(LTRIM(nvq.MaNhanVien)) = RTRIM(LTRIM(nv.MaNhanVien))
                    AND RTRIM(LTRIM(nvq.MaQuyen)) = RTRIM(LTRIM(q.MaQuyen))
                ORDER BY q.MaQuyen
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            String cleanMaNhanVien = maNhanVien.trim();
            ps.setString(1, cleanMaNhanVien);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // 🔥 SỬA TẠI ĐÂY: .trim() sạch sẽ toàn bộ các mã chuỗi bốc lên từ Database
                    String rawMaNV = rs.getString("MaNhanVien");
                    String rawMaQuyen = rs.getString("MaQuyen");

                    String cleanMaNV = rawMaNV != null ? rawMaNV.trim() : "";
                    String cleanMaQuyen = rawMaQuyen != null ? rawMaQuyen.trim() : "";

                    list.add(new EmployeePermission(
                            cleanMaNV,
                            rs.getString("HoTen"),
                            cleanMaQuyen,
                            rs.getString("TenQuyen"),
                            rs.getString("MoTa"),
                            rs.getInt("TrangThai")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public List<String> getPermissionsByEmployee(String maNhanVien) {
        List<String> enabledPermissions = new ArrayList<String>();
        List<EmployeePermission> employeePermissions = getEmployeePermissions(maNhanVien);

        for (EmployeePermission permission : employeePermissions) {
            if (permission.getTrangThai() == 1) {
                // 🔥 SỬA TẠI ĐÂY: Chắc chắn mã quyền đẩy vào Session không bị dính khoảng trắng
                String rawMaQuyen = permission.getMaQuyen();
                if (rawMaQuyen != null) {
                    enabledPermissions.add(rawMaQuyen.trim());
                }
            }
        }
        return enabledPermissions;
    }


    public boolean togglePermission(String maNhanVien, String maQuyen, int trangThai) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()
                || maQuyen == null || maQuyen.trim().isEmpty()) {
            return false;
        }

        if (trangThai != 0 && trangThai != 1) {
            return false;
        }

        String cleanMaNhanVien = maNhanVien.trim();
        String cleanMaQuyen = maQuyen.trim();
        String maNhanVienQuyen = "NVQ_" + cleanMaNhanVien + "_" + cleanMaQuyen;

        String checkSql = "SELECT COUNT(*) FROM NHAN_VIEN_QUYEN WHERE RTRIM(LTRIM(MaNhanVien)) = ? AND RTRIM(LTRIM(MaQuyen)) = ?";
        String updateSql = "UPDATE NHAN_VIEN_QUYEN SET TrangThai = ? WHERE RTRIM(LTRIM(MaNhanVien)) = ? AND RTRIM(LTRIM(MaQuyen)) = ?";
        String insertSql = "INSERT INTO NHAN_VIEN_QUYEN (MaNhanVienQuyen, MaNhanVien, MaQuyen, TrangThai) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkPs = conn.prepareStatement(checkSql)) {

            checkPs.setString(1, cleanMaNhanVien);
            checkPs.setString(2, cleanMaQuyen);

            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    try (PreparedStatement updatePs = conn.prepareStatement(updateSql)) {
                        updatePs.setInt(1, trangThai);
                        updatePs.setString(2, cleanMaNhanVien);
                        updatePs.setString(3, cleanMaQuyen);
                        return updatePs.executeUpdate() > 0;
                    }
                } else {
                    try (PreparedStatement insertPs = conn.prepareStatement(insertSql)) {
                        insertPs.setString(1, maNhanVienQuyen);
                        insertPs.setString(2, cleanMaNhanVien);
                        insertPs.setString(3, cleanMaQuyen);
                        insertPs.setInt(4, trangThai);
                        return insertPs.executeUpdate() > 0;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateEmployeePermissions(String maNhanVien, List<String> selectedPermissions) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return false;
        }

        List<Permission> allPermissions = getAllPermissions();
        boolean success = true;

        for (Permission permission : allPermissions) {
            int trangThai = (selectedPermissions != null && selectedPermissions.contains(permission.getMaQuyen())) ? 1 : 0;
            boolean result = togglePermission(maNhanVien, permission.getMaQuyen(), trangThai);
            if (!result) {
                success = false;
            }
        }
        return success;
    }

    public boolean initializeDefaultPermissions(String maNhanVien, String maVaiTro) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()
                || maVaiTro == null || maVaiTro.trim().isEmpty()) {
            return false;
        }

        List<String> defaults = switch (maVaiTro.trim()) {
            case "VT01" -> List.of("Q01", "Q02", "Q03", "Q04", "Q05", "Q06", "Q07", "Q08",
                    "Q09", "Q10", "Q11", "Q12", "Q13", "Q14", "Q15");
            case "VT04" -> List.of("Q01", "Q08", "Q09", "Q10", "Q15");
            case "VT02" -> List.of("Q01", "Q09");
            default -> List.of();
        };

        // Store an explicit 1/0 record for every permission so stale data cannot
        // cause an employee to inherit rights beyond their role defaults.
        List<Permission> allPermissions = getAllPermissions();
        if (allPermissions.isEmpty()) {
            return false;
        }

        boolean success = true;
        for (Permission permission : allPermissions) {
            int trangThai = defaults.contains(permission.getMaQuyen()) ? 1 : 0;
            if (!togglePermission(maNhanVien.trim(), permission.getMaQuyen(), trangThai)) {
                success = false;
            }
        }
        return success;
    }
}
