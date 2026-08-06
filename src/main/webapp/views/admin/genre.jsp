<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Thể Loại Phim - FPT CINEMA</title>
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

<div class="container-fluid">
    <div class="row">
        <!-- ==================== SIDEBAR MENU ==================== -->
        <div class="col-md-3 col-lg-2 sidebar p-3 text-white">
            <div class="d-flex align-items-center mb-3 px-2">
                <i class="bi bi-film text-danger fs-3 me-2"></i>
                <span class="fs-5 fw-bold text-uppercase tracking-wider">FPT Cinema</span>
            </div>
            <hr class="text-secondary my-2">

            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="bi bi-grid-1x2-fill me-2"></i> Tổng quan Dashboard
                    </a>
                </li>

                <div class="menu-header">Hạ tầng & Danh mục</div>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/theater">
                        <i class="bi bi-building me-2"></i> 1. Quản lý rạp phim
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/genre">
                        <i class="bi bi-tags me-2"></i> 2. Quản lý thể loại phim
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/room">
                        <i class="bi bi-door-open me-2"></i> 3. Quản lý phòng phim
                    </a>
                </li>

                <div class="menu-header">Phim & Lịch chiếu</div>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/movie">
                        <i class="bi bi-camera-reels me-2"></i> 4. Quản lý phim
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/showtime">
                        <i class="bi bi-calendar3 me-2"></i> 5. Quản lý suất chiếu
                    </a>
                </li>

                <div class="menu-header">Kinh doanh & Thành viên</div>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/booking">
                        <i class="bi bi-ticket-detailed me-2"></i> 6. Quản lý danh sách đặt vé
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/booking">
                        <i class="bi bi-check2-circle me-2"></i> 7. Xác nhận trạng thái vé
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/user">
                        <i class="bi bi-people me-2"></i> 8. Quản lý người dùng
                    </a>
                </li>

                <div class="menu-header">Hệ thống & Báo cáo</div>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/employee">
                        <i class="bi bi-shield-lock me-2"></i> 9. Nhân viên & Phân quyền
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/admin/report">
                        <i class="bi bi-bar-chart-line me-2"></i> 10. Thống kê & Báo cáo
                    </a>
                </li>

                <hr class="text-secondary my-3">
                <li class="nav-item">
                    <a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-box-arrow-left me-2"></i> Trở về Trang chủ Website
                    </a>
                </li>
            </ul>
        </div>

        <!-- ==================== MAIN CONTENT ==================== -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-tags me-2"></i>Quản Lý Thể Loại Phim</h1>
                    <p class="text-muted mb-0">Thêm mới, chỉnh sửa và quản lý danh sách thể loại phim</p>
                </div>
            </div>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- ==================== FORM THÊM / SỬA THỂ LOẠI ==================== -->
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <c:choose>
                            <c:when test="${not empty genreEdit}">
                                <i class="bi bi-pencil-square text-warning me-2"></i>Cập Nhật Thể Loại
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-plus-circle text-success me-2"></i>Thêm Thể Loại Mới
                            </c:otherwise>
                        </c:choose>
                    </h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/genre" method="post">
                        <c:if test="${not empty genreEdit}">
                            <input type="hidden" name="action" value="update">
                        </c:if>
                        <div class="row g-3">
                            <div class="col-md-4">
                                <label for="maTheLoai" class="form-label fw-semibold">Mã Thể Loại</label>
                                <input type="text" class="form-control" id="maTheLoai" name="maTheLoai"
                                       value="${genreEdit.maTheLoai}" placeholder="Nhập mã thể loại..."
                                       ${not empty genreEdit ? 'readonly' : ''} required>
                            </div>
                            <div class="col-md-5">
                                <label for="tenTheLoai" class="form-label fw-semibold">Tên Thể Loại</label>
                                <input type="text" class="form-control" id="tenTheLoai" name="tenTheLoai"
                                       value="${genreEdit.tenTheLoai}" placeholder="Nhập tên thể loại..." required>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <c:choose>
                                    <c:when test="${not empty genreEdit}">
                                        <button type="submit" class="btn btn-warning w-100 me-2">
                                            <i class="bi bi-check-lg me-1"></i> Cập Nhật
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="btn btn-success w-100">
                                            <i class="bi bi-plus-lg me-1"></i> Thêm Mới
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- ==================== BẢNG DANH SÁCH THỂ LOẠI ==================== -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Thể Loại</h5>
                    <span class="badge bg-primary rounded-pill">${listGenre.size()} thể loại</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">#</th>
                                    <th>Mã Thể Loại</th>
                                    <th>Tên Thể Loại</th>
                                    <th class="text-center">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="g" items="${listGenre}" varStatus="stt">
                                    <tr>
                                        <td class="ps-4 fw-semibold">${stt.index + 1}</td>
                                        <td><span class="badge bg-secondary">${g.maTheLoai}</span></td>
                                        <td class="fw-semibold">${g.tenTheLoai}</td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/genre?action=edit&id=${g.maTheLoai}"
                                               class="btn btn-outline-warning btn-action me-1">
                                                <i class="bi bi-pencil"></i> Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/genre?action=lock&id=${g.maTheLoai}"
                                               class="btn btn-outline-danger btn-action"
                                               onclick="return confirm('Bạn có chắc muốn khóa/mở khóa thể loại này?');">
                                                <i class="bi bi-lock"></i> Khóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listGenre}">
                                    <tr>
                                        <td colspan="4" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                            Chưa có thể loại nào trong hệ thống
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
