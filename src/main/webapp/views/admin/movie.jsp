<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Phim - FPT CINEMA</title>
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
        .poster-thumb { width: 60px; height: 85px; object-fit: cover; border-radius: 6px; }
    </style>
</head>
<body>
<% request.setAttribute("currentPage", "movie"); %>

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
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-camera-reels me-2"></i>Quản Lý Phim</h1>
                    <p class="text-muted mb-0">Thêm mới, chỉnh sửa và quản lý danh sách phim chiếu rạp</p>
                </div>
            </div>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- ==================== FORM THÊM / SỬA PHIM ==================== -->
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <c:choose>
                            <c:when test="${not empty movieEdit}">
                                <i class="bi bi-pencil-square text-warning me-2"></i>Cập Nhật Thông Tin Phim
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-plus-circle text-success me-2"></i>Thêm Phim Mới
                            </c:otherwise>
                        </c:choose>
                    </h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/movie" method="post">
                        <c:if test="${not empty movieEdit}">
                            <input type="hidden" name="action" value="update">
                        </c:if>
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label for="maPhim" class="form-label fw-semibold">Mã Phim</label>
                                <input type="text" class="form-control" id="maPhim" name="maPhim"
                                       value="${movieEdit.maPhim}" placeholder="VD: P001"
                                       ${not empty movieEdit ? 'readonly' : ''} required>
                            </div>
                            <div class="col-md-5">
                                <label for="tenPhim" class="form-label fw-semibold">Tên Phim</label>
                                <input type="text" class="form-control" id="tenPhim" name="tenPhim"
                                       value="${movieEdit.tenPhim}" placeholder="Nhập tên phim..." required>
                            </div>
                            <div class="col-md-2">
                                <label for="thoiLuong" class="form-label fw-semibold">Thời Lượng (phút)</label>
                                <input type="number" class="form-control" id="thoiLuong" name="thoiLuong"
                                       value="${movieEdit.thoiLuong}" placeholder="120" required>
                            </div>
                            <div class="col-md-2">
                                <label for="doTuoiGiaiTri" class="form-label fw-semibold">Độ Tuổi</label>
                                <select class="form-select" id="doTuoiGiaiTri" name="doTuoiGiaiTri">
                                    <option value="P" ${movieEdit.doTuoiGiaiTri == 'P' ? 'selected' : ''}>P - Mọi lứa tuổi</option>
                                    <option value="C13" ${movieEdit.doTuoiGiaiTri == 'C13' ? 'selected' : ''}>C13 - Trên 13 tuổi</option>
                                    <option value="C16" ${movieEdit.doTuoiGiaiTri == 'C16' ? 'selected' : ''}>C16 - Trên 16 tuổi</option>
                                    <option value="C18" ${movieEdit.doTuoiGiaiTri == 'C18' ? 'selected' : ''}>C18 - Trên 18 tuổi</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="maTheLoai" class="form-label fw-semibold">Thể Loại</label>
                                <select class="form-select" id="maTheLoai" name="maTheLoai">
                                    <option value="">-- Chọn thể loại --</option>
                                    <c:forEach var="g" items="${listGenre}">
                                        <option value="${g.maTheLoai}" ${movieEdit.maTheLoai == g.maTheLoai ? 'selected' : ''}>${g.tenTheLoai}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-12">
                                <label for="moTa" class="form-label fw-semibold">Mô Tả</label>
                                <textarea class="form-control" id="moTa" name="moTa" rows="3"
                                          placeholder="Nhập mô tả nội dung phim...">${movieEdit.moTa}</textarea>
                            </div>
                            <div class="col-md-4">
                                <label for="trailer" class="form-label fw-semibold">Link Trailer</label>
                                <input type="text" class="form-control" id="trailer" name="trailer"
                                       value="${movieEdit.trailer}" placeholder="URL trailer YouTube...">
                            </div>
                            <div class="col-md-4">
                                <label for="poster" class="form-label fw-semibold">Link Poster</label>
                                <input type="text" class="form-control" id="poster" name="poster"
                                       value="${movieEdit.poster}" placeholder="URL hình ảnh poster...">
                            </div>
                            <div class="col-md-2">
                                <label for="ngayKhoiChieu" class="form-label fw-semibold">Ngày Khởi Chiếu</label>
                                <input type="date" class="form-control" id="ngayKhoiChieu" name="ngayKhoiChieu"
                                       value="${movieEdit.ngayKhoiChieu}" required>
                            </div>
                            <div class="col-md-2">
                                <label for="trangThai" class="form-label fw-semibold">Trạng Thái</label>
                                <select class="form-select" id="trangThai" name="trangThai">
                                    <option value="Đang chiếu" ${movieEdit.trangThai == 'Đang chiếu' ? 'selected' : ''}>Đang chiếu</option>
                                    <option value="Sắp chiếu" ${movieEdit.trangThai == 'Sắp chiếu' ? 'selected' : ''}>Sắp chiếu</option>
                                    <option value="Ngừng chiếu" ${movieEdit.trangThai == 'Ngừng chiếu' ? 'selected' : ''}>Ngừng chiếu</option>
                                </select>
                            </div>
                            <div class="col-12 text-end">
                                <c:choose>
                                    <c:when test="${not empty movieEdit}">
                                        <a href="${pageContext.request.contextPath}/admin/movie" class="btn btn-secondary me-2">
                                            <i class="bi bi-x-lg me-1"></i> Hủy
                                        </a>
                                        <button type="submit" class="btn btn-warning">
                                            <i class="bi bi-check-lg me-1"></i> Cập Nhật
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="btn btn-success">
                                            <i class="bi bi-plus-lg me-1"></i> Thêm Phim Mới
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- ==================== BẢNG DANH SÁCH PHIM ==================== -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Phim</h5>
                    <span class="badge bg-primary rounded-pill">${listMovie.size()} phim</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">#</th>
                                    <th>Poster</th>
                                    <th>Mã Phim</th>
                                    <th>Tên Phim</th>
                                    <th>Thời Lượng</th>
                                    <th>Ngày Khởi Chiếu</th>
                                    <th>Độ Tuổi</th>
                                    <th>Thể Loại</th>
                                    <th>Trạng Thái</th>
                                    <th class="text-center">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="m" items="${listMovie}" varStatus="stt">
                                    <tr>
                                        <td class="ps-4 fw-semibold">${stt.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty m.poster}">
                                                    <img src="${m.poster}" alt="${m.tenPhim}" class="poster-thumb">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="poster-thumb bg-light d-flex align-items-center justify-content-center">
                                                        <i class="bi bi-image text-muted"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><span class="badge bg-secondary">${m.maPhim}</span></td>
                                        <td class="fw-semibold">${m.tenPhim}</td>
                                        <td>${m.thoiLuong} phút</td>
                                        <td>${m.ngayKhoiChieu}</td>
                                        <td>
                                            <span class="badge ${m.doTuoiGiaiTri == 'P' ? 'bg-success' : m.doTuoiGiaiTri == 'C18' ? 'bg-danger' : 'bg-warning text-dark'}">
                                                ${m.doTuoiGiaiTri}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty m.maTheLoai}">
                                                    <c:forEach var="g" items="${listGenre}">
                                                        <c:if test="${g.maTheLoai == m.maTheLoai}">
                                                            <span class="badge bg-info text-dark">${g.tenTheLoai}</span>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">-</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="badge ${m.trangThai == 'Đang chiếu' ? 'bg-success' : m.trangThai == 'Sắp chiếu' ? 'bg-info' : 'bg-secondary'}">
                                                ${m.trangThai}
                                            </span>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/admin/movie?action=edit&id=${m.maPhim}"
                                               class="btn btn-outline-warning btn-action me-1">
                                                <i class="bi bi-pencil"></i> Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/movie?action=hide&id=${m.maPhim}"
                                               class="btn ${m.trangThai == 'Ẩn' ? 'btn-outline-success' : 'btn-outline-danger'} btn-action"
                                               onclick="return confirm('Bạn có chắc muốn ẩn/hiện phim này?');">
                                                <i class="bi ${m.trangThai == 'Ẩn' ? 'bi-eye' : 'bi-eye-slash'}"></i> ${m.trangThai == 'Ẩn' ? 'Hiện' : 'Ẩn'}
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listMovie}">
                                    <tr>
                                        <td colspan="10" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                            Chưa có phim nào trong hệ thống
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
