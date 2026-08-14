package com.fptpoly.repository;

import com.fptpoly.config.DBConnection;
import com.fptpoly.model.EmployeePermission;
import com.fptpoly.model.Permission;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PermissionRepository {

    public PermissionRepository() {
        initTablesAndData();
    }

    private void initTablesAndData() {
        String createVaiTroTable = """
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'VAI_TRO')
                BEGIN
                    CREATE TABLE VAI_TRO (
                        MaVaiTro VARCHAR(20) PRIMARY KEY,
                        TenVaiTro NVARCHAR(100) NOT NULL
                    );
                END
                """;

        String createQuyenTable = """
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'QUYEN')
                BEGIN
                    CREATE TABLE QUYEN (
                        MaQuyen VARCHAR(50) PRIMARY KEY,
                        TenQuyen NVARCHAR(100) NOT NULL,
                        MoTa NVARCHAR(255)
                    );
                END
                """;

        String createVaiTroQuyenTable = """
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'VAI_TRO_QUYEN')
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
                IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'NHAN_VIEN_QUYEN')
                BEGIN
                    CREATE TABLE NHAN_VIEN_QUYEN (
                        MaNhanVienQuyen INT IDENTITY(1,1) PRIMARY KEY,
                        MaNhanVien VARCHAR(20) NOT NULL,
                        MaQuyen VARCHAR(50) NOT NULL,
                        TrangThai BIT DEFAULT 1,
                        CONSTRAINT UQ_NV_QUYEN UNIQUE (MaNhanVien, MaQuyen)
                    );
                END
                """;

        String addTrangThaiColumn = """
                IF EXISTS (SELECT * FROM sys.tables WHERE name = 'NHAN_VIEN_QUYEN')
                   AND NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('NHAN_VIEN_QUYEN') AND name = 'TrangThai')
                BEGIN
                    ALTER TABLE NHAN_VIEN_QUYEN ADD TrangThai BIT DEFAULT 1;
                END
                """;

        try (Connection con = DBConnection.getConnection()) {
            if (con != null) {
                try (Statement stmt = con.createStatement()) {
                    stmt.execute(createVaiTroTable);
                    stmt.execute(createQuyenTable);
                    stmt.execute(createVaiTroQuyenTable);
                    stmt.execute(createNhanVienQuyenTable);
                    stmt.execute(addTrangThaiColumn);
                }
                seedRolesAndPermissions(con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void seedRolesAndPermissions(Connection con) {
        String sqlCheckRole = "SELECT 1 FROM VAI_TRO WHERE MaVaiTro = ?";
        String sqlInsertRole = "INSERT INTO VAI_TRO (MaVaiTro, TenVaiTro) VALUES (?, ?)";

        String[][] defaultRoles = {
                {"VT01", "Quản trị viên"},
                {"VT02", "Nhân viên bán vé"},
                {"VT03", "Khách hàng thành viên"}
        };

        for (String[] r : defaultRoles) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckRole)) {
                ps.setString(1, r[0]);
                ResultSet rs = ps.executeQuery();
                if (!rs.next()) {
                    try (PreparedStatement psIns = con.prepareStatement(sqlInsertRole)) {
                        psIns.setString(1, r[0]);
                        psIns.setString(2, r[1]);
                        psIns.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        List<Permission> defaultPermissions = List.of(
                new Permission("Q01", "Xem Dashboard", "Được phép xem trang tổng quan hệ thống"),
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
                new Permission("Q12", "Thống kê & Báo cáo", "Xem báo cáo thống kê và doanh thu"),
                new Permission("Q13", "Quyền quản lý ca", "Quản lý thông tin ca làm việc"),
                new Permission("Q14", "Nhân viên & Phân quyền", "Quản lý tài khoản và phân quyền nhân viên"),
                new Permission("Q15", "Kiểm duyệt bình luận", "Kiểm duyệt và quản lý bình luận")
        );

        String sqlCheckPerm = "SELECT 1 FROM QUYEN WHERE MaQuyen = ?";
        String sqlInsertPerm = "INSERT INTO QUYEN (MaQuyen, TenQuyen, MoTa) VALUES (?, ?, ?)";

        for (Permission p : defaultPermissions) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckPerm)) {
                ps.setString(1, p.getMaQuyen());
                ResultSet rs = ps.executeQuery();
                if (!rs.next()) {
                    try (PreparedStatement psIns = con.prepareStatement(sqlInsertPerm)) {
                        psIns.setString(1, p.getMaQuyen());
                        psIns.setString(2, p.getTenQuyen());
                        psIns.setString(3, p.getMoTa());
                        psIns.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        String sqlCheckVTQ = "SELECT 1 FROM VAI_TRO_QUYEN WHERE MaVaiTro = ? AND MaQuyen = ?";
        String sqlInsertVTQ = "INSERT INTO VAI_TRO_QUYEN (MaVaiTro, MaQuyen) VALUES (?, ?)";

        for (Permission p : defaultPermissions) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckVTQ)) {
                ps.setString(1, "VT01");
                ps.setString(2, p.getMaQuyen());
                ResultSet rs = ps.executeQuery();
                if (!rs.next()) {
                    try (PreparedStatement psIns = con.prepareStatement(sqlInsertVTQ)) {
                        psIns.setString(1, "VT01");
                        psIns.setString(2, p.getMaQuyen());
                        psIns.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        String[] vt02Perms = {"Q01", "Q09"};
        for (String qCode : vt02Perms) {
            try (PreparedStatement ps = con.prepareStatement(sqlCheckVTQ)) {
                ps.setString(1, "VT02");
                ps.setString(2, qCode);
                ResultSet rs = ps.executeQuery();
                if (!rs.next()) {
                    try (PreparedStatement psIns = con.prepareStatement(sqlInsertVTQ)) {
                        psIns.setString(1, "VT02");
                        psIns.setString(2, qCode);
                        psIns.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        String sqlCheckNVQ = "SELECT 1 FROM NHAN_VIEN_QUYEN WHERE MaNhanVien = ? AND MaQuyen = ?";
        String sqlInsertNVQ = "INSERT INTO NHAN_VIEN_QUYEN (MaNhanVien, MaQuyen, TrangThai) VALUES (?, ?, ?)";

        Object[][] nv02Data = {
                {"NV02", "Q01", 1},
                {"NV02", "Q02", 1},
                {"NV02", "Q03", 1},
                {"NV02", "Q04", 0}
        };

        for (Object[] nvq : nv02Data) {
            String maNV = (String) nvq[0];
            String maQ = (String) nvq[1];
            int status = (Integer) nvq[2];

            try (PreparedStatement ps = con.prepareStatement(sqlCheckNVQ)) {
                ps.setString(1, maNV);
                ps.setString(2, maQ);
                ResultSet rs = ps.executeQuery();
                if (!rs.next()) {
                    try (PreparedStatement psIns = con.prepareStatement(sqlInsertNVQ)) {
                        psIns.setString(1, maNV);
                        psIns.setString(2, maQ);
                        psIns.setInt(3, status);
                        psIns.executeUpdate();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public List<Permission> getAllPermissions() {
        List<Permission> list = new ArrayList<>();
        String sql = "SELECT * FROM QUYEN ORDER BY MaQuyen";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Permission(
                        rs.getString("MaQuyen"),
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
        List<EmployeePermission> list = new ArrayList<>();

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
                    WHEN nvq.TrangThai IS NOT NULL
                        THEN CAST(nvq.TrangThai AS INT)
                    WHEN vtq.MaQuyen IS NOT NULL
                        THEN 1
                    ELSE 0
                END AS TrangThai
            FROM QUYEN q
            LEFT JOIN NHAN_VIEN nv
                ON RTRIM(LTRIM(nv.MaNhanVien)) = ?
            LEFT JOIN VAI_TRO_QUYEN vtq
                ON RTRIM(LTRIM(vtq.MaVaiTro)) = RTRIM(LTRIM(nv.MaVaiTro))
                AND RTRIM(LTRIM(vtq.MaQuyen)) = RTRIM(LTRIM(q.MaQuyen))
            LEFT JOIN NHAN_VIEN_QUYEN nvq
                ON (RTRIM(LTRIM(nvq.MaNhanVien)) = ? OR RTRIM(LTRIM(nvq.MaNhanVien)) = RTRIM(LTRIM(nv.MaNhanVien)))
                AND RTRIM(LTRIM(nvq.MaQuyen)) = RTRIM(LTRIM(q.MaQuyen))
            ORDER BY q.MaQuyen
            """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            String cleanMaNV = maNhanVien.trim();
            ps.setString(1, cleanMaNV);
            ps.setString(2, cleanMaNV);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    list.add(new EmployeePermission(
                            rs.getString("MaNhanVien"),
                            rs.getString("HoTen"),
                            rs.getString("MaQuyen"),
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

    public boolean togglePermission(String maNhanVien, String maQuyen, int trangThai) {

        String checkSql = """
        SELECT COUNT(*)
        FROM NHAN_VIEN_QUYEN
        WHERE RTRIM(LTRIM(MaNhanVien)) = ?
          AND RTRIM(LTRIM(MaQuyen)) = ?
        """;

        String updateSql = """
        UPDATE NHAN_VIEN_QUYEN
        SET TrangThai = ?
        WHERE RTRIM(LTRIM(MaNhanVien)) = ?
          AND RTRIM(LTRIM(MaQuyen)) = ?
        """;

        String insertSql = """
        INSERT INTO NHAN_VIEN_QUYEN (MaNhanVien, MaQuyen, TrangThai)
        VALUES (?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement checkPs = conn.prepareStatement(checkSql)) {

            String cleanMaNV = maNhanVien != null ? maNhanVien.trim() : "";
            String cleanMaQ = maQuyen != null ? maQuyen.trim() : "";

            checkPs.setString(1, cleanMaNV);
            checkPs.setString(2, cleanMaQ);

            try (ResultSet rs = checkPs.executeQuery()) {

                if (rs.next() && rs.getInt(1) > 0) {

                    try (PreparedStatement updatePs =
                                 conn.prepareStatement(updateSql)) {

                        updatePs.setInt(1, trangThai);
                        updatePs.setString(2, cleanMaNV);
                        updatePs.setString(3, cleanMaQ);

                        return updatePs.executeUpdate() > 0;
                    }

                } else {

                    try (PreparedStatement insertPs =
                                 conn.prepareStatement(insertSql)) {

                        insertPs.setString(1, cleanMaNV);
                        insertPs.setString(2, cleanMaQ);
                        insertPs.setInt(3, trangThai);

                        return insertPs.executeUpdate() > 0;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private String generatePermissionId(Connection conn) throws SQLException {

        // Bổ sung điều kiện LIKE 'NVQ%' để ngăn chặn crash sập luồng dữ liệu khi quét trúng dấu gạch dưới '_'
        String sql = """
        SELECT ISNULL(
            MAX(CAST(SUBSTRING(MaNhanVienQuyen, 4, 10) AS INT)),
            0
        ) + 1
        FROM NHAN_VIEN_QUYEN
        WHERE MaNhanVienQuyen LIKE 'NVQ%'
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                int number = rs.getInt(1);
                return String.format("NVQ%02d", number);
            }
        }

        return "NVQ01";
    }

    public List<String> getPermissionsByEmployee(String maNhanVien) {
        List<String> enabledPermissions = new ArrayList<>();
        List<EmployeePermission> allEmpPermissions = getEmployeePermissions(maNhanVien);
        for (EmployeePermission ep : allEmpPermissions) {
            if (ep.getTrangThai() == 1) {
                enabledPermissions.add(ep.getMaQuyen());
            }
        }
        return enabledPermissions;
    }

    public boolean updateEmployeePermissions(String maNhanVien, List<String> selectedPermissions) {
        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return false;
        }
        List<Permission> allPermissions = getAllPermissions();
        boolean success = true;
        for (Permission p : allPermissions) {
            int status = (selectedPermissions != null && selectedPermissions.contains(p.getMaQuyen())) ? 1 : 0;
            boolean ok = togglePermission(maNhanVien, p.getMaQuyen(), status);
            if (!ok) success = false;
        }
        return success;
    }

    public boolean initializeEmployeePermissions(String maNhanVien, String maVaiTro) {

        String sql = """
        INSERT INTO NHAN_VIEN_QUYEN
            (MaNhanVien, MaQuyen, TrangThai)
        SELECT
            ?,
            vtq.MaQuyen,
            1
        FROM VAI_TRO_QUYEN vtq
        WHERE vtq.MaVaiTro = ?
          AND NOT EXISTS (
              SELECT 1
              FROM NHAN_VIEN_QUYEN nvq
              WHERE nvq.MaNhanVien = ?
                AND nvq.MaQuyen = vtq.MaQuyen
          )
        """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, maNhanVien.trim());
            ps.setString(2, maVaiTro.trim());
            ps.setString(3, maNhanVien.trim());

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean initializeDefaultPermissions(String maNhanVien, String maVaiTro) {

        if (maNhanVien == null || maNhanVien.trim().isEmpty()) {
            return false;
        }

        if (maVaiTro == null || maVaiTro.trim().isEmpty()) {
            return false;
        }

        String[] defaultPermissions;

        if ("VT01".equals(maVaiTro)) {
            defaultPermissions = new String[]{
                    "Q01", "Q02", "Q03", "Q04", "Q05",
                    "Q06", "Q07", "Q08", "Q09", "Q10",
                    "Q11", "Q12", "Q13", "Q14", "Q15"
            };
        } else if ("VT04".equals(maVaiTro)) {
            defaultPermissions = new String[]{
                    "Q01", "Q09", "Q10", "Q15"
            };
        } else if ("VT02".equals(maVaiTro)) {
            defaultPermissions = new String[]{
                    "Q01", "Q09"
            };
        } else {
            return true;
        }

        String checkSql = """
        SELECT COUNT(*)
        FROM NHAN_VIEN_QUYEN
        WHERE MaNhanVien = ?
          AND MaQuyen = ?
        """;

        String insertSql = """
        INSERT INTO NHAN_VIEN_QUYEN
            (MaNhanVienQuyen, MaNhanVien, MaQuyen, TrangThai)
        VALUES (?, ?, ?, ?)
        """;

        try (Connection conn = DBConnection.getConnection()) {

            for (String maQuyen : defaultPermissions) {

                try (PreparedStatement checkPs =
                             conn.prepareStatement(checkSql)) {

                    checkPs.setString(1, maNhanVien);
                    checkPs.setString(2, maQuyen);

                    try (ResultSet rs = checkPs.executeQuery()) {

                        if (rs.next() && rs.getInt(1) > 0) {
                            continue;
                        }
                    }
                }

                String maNhanVienQuyen = generatePermissionId(conn);

                try (PreparedStatement insertPs =
                             conn.prepareStatement(insertSql)) {

                    insertPs.setString(1, maNhanVienQuyen);
                    insertPs.setString(2, maNhanVien);
                    insertPs.setString(3, maQuyen);
                    insertPs.setInt(4, 1);

                    insertPs.executeUpdate();
                }
            }

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

