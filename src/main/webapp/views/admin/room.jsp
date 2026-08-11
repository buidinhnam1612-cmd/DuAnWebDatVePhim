<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Phòng Chiếu - FPT CINEMA</title>
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
<% request.setAttribute("currentPage", "room"); %>

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
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-door-open me-2"></i>Quản Lý Phòng Chiếu</h1>
                    <p class="text-muted mb-0">Thêm mới phòng chiếu và cấu hình ma trận ghế ngồi</p>
                </div>
            </div>

            <!-- Thông báo trạng thái -->
            <c:if test="${param.status == 'success'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>Tạo phòng chiếu và ma trận ghế thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.status == 'fail'}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>Tạo phòng chiếu thất bại! Vui lòng kiểm tra lại dữ liệu.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- ==================== FORM THÊM PHÒNG CHIẾU ==================== -->
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="bi bi-plus-circle text-success me-2"></i>Thêm Phòng Chiếu Mới
                    </h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/room" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label for="maPhong" class="form-label fw-semibold">Mã Phòng</label>
                                <input type="text" class="form-control" id="maPhong" name="maPhong"
                                       placeholder="VD: P01" required>
                            </div>
                            <div class="col-md-3">
                                <label for="tenPhong" class="form-label fw-semibold">Tên Phòng</label>
                                <input type="text" class="form-control" id="tenPhong" name="tenPhong"
                                       placeholder="VD: Phòng 1" required>
                            </div>
                            <div class="col-md-3">
                                <label for="maRap" class="form-label fw-semibold">Mã Rạp (Thuộc rạp)</label>
                                <input type="text" class="form-control" id="maRap" name="maRap"
                                       placeholder="VD: R001" required>
                            </div>
                            <div class="col-md-3">
                                <label for="loaiGhe" class="form-label fw-semibold">Loại Ghế</label>
                                <select class="form-select" id="loaiGhe" name="loaiGhe">
                                    <option value="Thường">Thường</option>
                                    <option value="VIP">VIP</option>
                                    <option value="Sweetbox">Sweetbox</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label for="soHang" class="form-label fw-semibold">Số Hàng</label>
                                <input type="number" class="form-control" id="soHang" name="soHang"
                                       placeholder="VD: 8" min="1" max="26" required>
                            </div>
                            <div class="col-md-3">
                                <label for="soCot" class="form-label fw-semibold">Số Cột (Ghế mỗi hàng)</label>
                                <input type="number" class="form-control" id="soCot" name="soCot"
                                       placeholder="VD: 12" min="1" max="30" required>
                            </div>
                            <div class="col-md-6 d-flex align-items-end">
                                <button type="submit" class="btn btn-success w-100">
                                    <i class="bi bi-plus-lg me-1"></i> Tạo Phòng & Ma Trận Ghế
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- ==================== BẢNG DANH SÁCH PHÒNG CHIẾU ==================== -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Phòng Chiếu</h5>
                    <span class="badge bg-primary rounded-pill">${roomList.size()} phòng</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">#</th>
                                    <th>Mã Phòng</th>
                                    <th>Tên Phòng</th>
                                    <th>Tổng Số Ghế</th>
                                    <th>Mã Rạp</th>
                                    <th class="text-center">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${roomList}" varStatus="stt">
                                    <tr>
                                        <td class="ps-4 fw-semibold">${stt.index + 1}</td>
                                        <td><span class="badge bg-secondary">${r.maPhong}</span></td>
                                        <td class="fw-semibold">${r.tenPhong}</td>
                                        <td>
                                            <span class="badge bg-info text-dark">
                                                <i class="bi bi-grid-3x3 me-1"></i>${r.tongSoGhe} ghế
                                            </span>
                                        </td>
                                        <td><span class="badge bg-dark">${r.maRap}</span></td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/admin/seat?maPhong=${r.maPhong}" class="btn btn-outline-primary btn-action">
                                                <i class="bi bi-eye"></i> Xem ghế
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty roomList}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                            Chưa có phòng chiếu nào trong hệ thống
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
