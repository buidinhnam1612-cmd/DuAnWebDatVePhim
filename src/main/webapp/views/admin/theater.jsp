<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Rạp Phim - FPT CINEMA</title>
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
        .theater-img { width: 80px; height: 55px; object-fit: cover; border-radius: 6px; }
    </style>
</head>
<body>
<% request.setAttribute("currentPage", "theater"); %>

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
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-building me-2"></i>Quản Lý Rạp Phim</h1>
                    <p class="text-muted mb-0">Chỉnh sửa thông tin các chi nhánh rạp phim trong hệ thống</p>
                </div>
            </div>

            <!-- Thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- ==================== FORM SỬA THÔNG TIN RẠP ==================== -->
            <c:if test="${not empty theaterEdit}">
                <div class="card content-card mb-4">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold">
                            <i class="bi bi-pencil-square text-warning me-2"></i>Cập Nhật Thông Tin Rạp
                        </h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/theater" method="post">
                            <div class="row g-3">
                                <div class="col-md-3">
                                    <label for="maRap" class="form-label fw-semibold">Mã Rạp</label>
                                    <input type="text" class="form-control" id="maRap" name="maRap"
                                           value="${theaterEdit.maRap}" readonly>
                                </div>
                                <div class="col-md-5">
                                    <label for="tenRap" class="form-label fw-semibold">Tên Rạp</label>
                                    <input type="text" class="form-control" id="tenRap" name="tenRap"
                                           value="${theaterEdit.tenRap}" placeholder="Nhập tên rạp..." required>
                                </div>
                                <div class="col-md-4">
                                    <label for="hotLine" class="form-label fw-semibold">Hotline</label>
                                    <input type="text" class="form-control" id="hotLine" name="hotLine"
                                           value="${theaterEdit.hotLine}" placeholder="Số điện thoại...">
                                </div>
                                <div class="col-md-8">
                                    <label for="diaChi" class="form-label fw-semibold">Địa Chỉ</label>
                                    <input type="text" class="form-control" id="diaChi" name="diaChi"
                                           value="${theaterEdit.diaChi}" placeholder="Nhập địa chỉ rạp..." required>
                                </div>
                                <div class="col-md-4">
                                    <label for="hinhAnh" class="form-label fw-semibold">Link Hình Ảnh</label>
                                    <input type="text" class="form-control" id="hinhAnh" name="hinhAnh"
                                           value="${theaterEdit.hinhAnh}" placeholder="URL hình ảnh rạp...">
                                </div>
                                <div class="col-12 text-end">
                                    <a href="${pageContext.request.contextPath}/theater" class="btn btn-secondary me-2">
                                        <i class="bi bi-x-lg me-1"></i> Hủy
                                    </a>
                                    <button type="submit" class="btn btn-warning">
                                        <i class="bi bi-check-lg me-1"></i> Cập Nhật
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </c:if>

            <!-- ==================== BẢNG DANH SÁCH RẠP PHIM ==================== -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Chi Nhánh Rạp</h5>
                    <span class="badge bg-primary rounded-pill">${listSP.size()} rạp</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">#</th>
                                    <th>Hình Ảnh</th>
                                    <th>Mã Rạp</th>
                                    <th>Tên Rạp</th>
                                    <th>Địa Chỉ</th>
                                    <th>Hotline</th>
                                    <th class="text-center">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="t" items="${listSP}" varStatus="stt">
                                    <tr>
                                        <td class="ps-4 fw-semibold">${stt.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty t.hinhAnh}">
                                                    <img src="${t.hinhAnh}" alt="${t.tenRap}" class="theater-img">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="theater-img bg-light d-flex align-items-center justify-content-center">
                                                        <i class="bi bi-image text-muted"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><span class="badge bg-secondary">${t.maRap}</span></td>
                                        <td class="fw-semibold">${t.tenRap}</td>
                                        <td>${t.diaChi}</td>
                                        <td>
                                            <c:if test="${not empty t.hotLine}">
                                                <span class="badge bg-success">
                                                    <i class="bi bi-telephone me-1"></i>${t.hotLine}
                                                </span>
                                            </c:if>
                                        </td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/theater?action=edit&id=${t.maRap}"
                                               class="btn btn-outline-warning btn-action">
                                                <i class="bi bi-pencil"></i> Sửa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listSP}">
                                    <tr>
                                        <td colspan="7" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                            Chưa có rạp phim nào trong hệ thống
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
