<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Suất Chiếu - FPT CINEMA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', system-ui, sans-serif; }
        .sidebar { min-height: 100vh; background-color: #1e293b; box-shadow: 2px 0 10px rgba(0,0,0,0.05); }
        .sidebar .nav-link { color: #94a3b8; border-radius: 8px; margin: 2px 0; padding: 10px 12px; font-size: 14px; transition: all 0.2s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #334155; color: #f8fafc !important; }
        .sidebar .nav-link.active { border-left: 4px solid #ef4444; border-radius: 0 8px 8px 0; background-color: #334155; }
        .menu-header { font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-top: 15px; margin-bottom: 5px; padding-left: 10px; }
        .content-card { border: none; border-radius: 14px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .table th { background-color: #f8fafc; font-size: 13px; text-transform: uppercase; color: #64748b; font-weight: 700; }
        .table td { vertical-align: middle; }
        .btn-action { padding: 5px 12px; font-size: 13px; border-radius: 6px; }
    </style>
</head>
<body>
<% request.setAttribute("currentPage", "showtime"); %>

<div class="container-fluid">
    <div class="row">
        <!-- ==================== SIDEBAR MENU ==================== -->
        <div class="col-md-3 col-lg-2 sidebar p-0 text-white">
            <jsp:include page="/views/common/admin-sidebar.jsp" />
        </div>

        <!-- ==================== MAIN CONTENT ==================== -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-calendar3 me-2"></i>Quản Lý Suất Chiếu</h1>
                    <p class="text-muted mb-0">Thêm mới và quản lý lịch chiếu phim theo phòng</p>
                </div>
            </div>

            <!-- Thông báo kết quả -->
            <c:if test="${not empty message}">
                <div class="alert ${message.startsWith('Thành công') ? 'alert-success' : 'alert-danger'} alert-dismissible fade show" role="alert">
                    <i class="bi ${message.startsWith('Thành công') ? 'bi-check-circle' : 'bi-exclamation-triangle'} me-2"></i>${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- ==================== FORM THÊM SUẤT CHIẾU ==================== -->
            <%
            String stRole = (String) session.getAttribute("role");
            java.util.List<String> stPerms = (java.util.List<String>) session.getAttribute("userPermissions");
            if ("ADMIN".equals(stRole) || (stPerms != null && stPerms.contains("MANAGE_SHOWTIME"))) {
            %>
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-plus-circle text-success me-2"></i>Thêm Suất Chiếu Mới
                    </h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/showtime" method="post">
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="maSuatChieu" class="form-label fw-semibold">Mã Suất Chiếu</label>
                                <input type="text" class="form-control" id="maSuatChieu" name="maSuatChieu"
                                       placeholder="VD: SC001" required>
                            </div>
                            <div class="col-md-4">
                                <label for="maPhim" class="form-label fw-semibold">Mã Phim</label>
                                <input type="text" class="form-control" id="maPhim" name="maPhim"
                                       placeholder="VD: P001" required>
                            </div>
                            <div class="col-md-4">
                                <label for="maPhong" class="form-label fw-semibold">Mã Phòng</label>
                                <input type="text" class="form-control" id="maPhong" name="maPhong"
                                       placeholder="VD: P01" required>
                            </div>
                            <div class="col-md-4">
                                <label for="ngayChieu" class="form-label fw-semibold">Ngày Chiếu</label>
                                <input type="date" class="form-control" id="ngayChieu" name="ngayChieu" required>
                            </div>
                            <div class="col-md-4">
                                <label for="gioBatDau" class="form-label fw-semibold">Giờ Bắt Đầu</label>
                                <input type="time" class="form-control" id="gioBatDau" name="gioBatDau" required>
                            </div>
                            <div class="col-md-4">
                                <label for="gioKetThuc" class="form-label fw-semibold">Giờ Kết Thúc</label>
                                <input type="time" class="form-control" id="gioKetThuc" name="gioKetThuc" required>
                            </div>
                            <div class="col-12 text-end">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-plus-lg me-1"></i> Thêm Suất Chiếu
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <% } %>

            <!-- ==================== BẢNG DANH SÁCH SUẤT CHIẾU ==================== -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Suất Chiếu</h5>
                    <span class="badge bg-primary rounded-pill">${listShowtime.size()} suất chiếu</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">#</th>
                                    <th>Mã Suất Chiếu</th>
                                    <th>Mã Phim</th>
                                    <th>Mã Phòng</th>
                                    <th>Ngày Chiếu</th>
                                    <th>Giờ Bắt Đầu</th>
                                    <th>Giờ Kết Thúc</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="s" items="${listShowtime}" varStatus="stt">
                                    <tr>
                                        <td class="ps-4 fw-semibold">${stt.index + 1}</td>
                                        <td><span class="badge bg-secondary">${s.maSuatChieu}</span></td>
                                        <td><span class="badge bg-info text-dark">${s.maPhim}</span></td>
                                        <td><span class="badge bg-dark">${s.maPhong}</span></td>
                                        <td class="fw-semibold">${s.ngayChieu}</td>
                                        <td>
                                            <span class="badge bg-success">
                                                <i class="bi bi-clock me-1"></i>${s.gioBatDau}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge bg-warning text-dark">
                                                <i class="bi bi-clock-history me-1"></i>${s.gioKetThuc}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listShowtime}">
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                            Chưa có suất chiếu nào trong hệ thống
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
