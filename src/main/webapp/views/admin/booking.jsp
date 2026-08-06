<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.Booking"%>

<%
    List<Booking> bookingList = (List<Booking>) request.getAttribute("bookingList");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đặt vé - FPT CINEMA</title>
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
        .table th { background-color: #f8fafc; font-size: 13px; text-transform: uppercase; color: #64748b; font-weight: 700; white-space: nowrap; }
        .table td { vertical-align: middle; font-size: 14px; }
        .btn-action { padding: 5px 12px; font-size: 13px; border-radius: 6px; }
        .status-paid { background-color: #198754; color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; white-space: nowrap; display: inline-block; }
        .status-wait { background-color: #ffc107; color: #000; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; white-space: nowrap; display: inline-block; }
        .status-cancel { background-color: #dc3545; color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; white-space: nowrap; display: inline-block; }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- SIDEBAR -->
        <div class="col-md-3 col-lg-2 sidebar p-3 text-white">
            <div class="d-flex align-items-center mb-3 px-2">
                <i class="bi bi-film text-danger fs-3 me-2"></i>
                <span class="fs-5 fw-bold text-uppercase tracking-wider">FPT Cinema</span>
            </div>
            <hr class="text-secondary my-2">
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-grid-1x2-fill me-2"></i> Tổng quan Dashboard</a></li>
                <div class="menu-header">Hạ tầng & Danh mục</div>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/theater"><i class="bi bi-building me-2"></i> 1. Quản lý rạp phim</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/genre"><i class="bi bi-tags me-2"></i> 2. Quản lý thể loại phim</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/room"><i class="bi bi-door-open me-2"></i> 3. Quản lý phòng phim</a></li>
                <div class="menu-header">Phim & Lịch chiếu</div>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/movie"><i class="bi bi-camera-reels me-2"></i> 4. Quản lý phim</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/showtime"><i class="bi bi-calendar3 me-2"></i> 5. Quản lý suất chiếu</a></li>
                <div class="menu-header">Kinh doanh & Thành viên</div>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/booking"><i class="bi bi-ticket-detailed me-2"></i> 6. Quản lý danh sách đặt vé</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/booking"><i class="bi bi-check2-circle me-2"></i> 7. Xác nhận trạng thái vé</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/user"><i class="bi bi-people me-2"></i> 8. Quản lý người dùng</a></li>
                <div class="menu-header">Hệ thống & Báo cáo</div>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/employee"><i class="bi bi-shield-lock me-2"></i> 9. Nhân viên & Phân quyền</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/report"><i class="bi bi-bar-chart-line me-2"></i> 10. Thống kê & Báo cáo</a></li>
                <hr class="text-secondary my-3">
                <li class="nav-item"><a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/home"><i class="bi bi-box-arrow-left me-2"></i> Trở về Trang chủ Website</a></li>
            </ul>
        </div>

        <!-- MAIN CONTENT -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-ticket-detailed me-2"></i>Quản Lý Đặt Vé</h1>
                    <p class="text-muted mb-0">Xem danh sách, tìm kiếm và cập nhật trạng thái vé</p>
                </div>
            </div>

            <!-- SEARCH FORM -->
            <div class="card content-card mb-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/booking" method="get" class="d-flex w-50">
                        <input type="hidden" name="action" value="search">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" name="keyword" class="form-control border-start-0 ps-0" placeholder="Tìm theo mã vé, khách hàng, phim, rạp hoặc trạng thái...">
                            <button type="submit" class="btn btn-primary px-4"><i class="bi bi-search me-1"></i> Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- TABLE -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Đặt Vé</h5>
                    <span class="badge bg-primary rounded-pill"><%= bookingList != null ? bookingList.size() : 0 %> vé</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Mã vé</th>
                                    <th>Khách hàng</th>
                                    <th>Phim</th>
                                    <th>Rạp</th>
                                    <th>Phòng</th>
                                    <th>Ghế</th>
                                    <th>Ngày chiếu</th>
                                    <th>Giờ</th>
                                    <th>Hình thức</th>
                                    <th class="text-end">Tổng tiền</th>
                                    <th class="text-center" style="min-width: 145px;">Trạng thái</th>
                                    <th class="text-center" style="min-width: 200px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
<%
if (bookingList != null && !bookingList.isEmpty()) {
    for (Booking b : bookingList) {
        String statusClass = "";
        if ("Đã thanh toán".equals(b.getTrangThai())) {
            statusClass = "status-paid";
        } else if ("Chờ thanh toán".equals(b.getTrangThai())) {
            statusClass = "status-wait";
        } else {
            statusClass = "status-cancel";
        }
%>
                                <tr>
                                    <td class="ps-4 fw-semibold"><span class="badge bg-secondary"><%= b.getMaDatVe() %></span></td>
                                    <td class="fw-semibold text-primary"><%= b.getTenKhachHang() %></td>
                                    <td class="fw-semibold"><%= b.getTenPhim() %></td>
                                    <td><%= b.getTenRap() %></td>
                                    <td><span class="badge bg-info text-dark"><%= b.getTenPhong() %></span></td>
                                    <td><%= b.getDanhSachGhe() %></td>
                                    <td><%= b.getNgayChieu() %></td>
                                    <td><%= b.getGioBatDau() %></td>
                                    <td><%= b.getHinhThucDat() %></td>
                                    <td class="text-end text-danger fw-bold"><%= String.format("%,.0f", b.getTongTien()) %> VNĐ</td>
                                    <td class="text-center">
                                        <span class="<%= statusClass %>"><%= b.getTrangThai() %></span>
                                    </td>
                                    <td class="text-center">
                                        <form action="${pageContext.request.contextPath}/admin/booking" method="post" class="d-flex align-items-center justify-content-center gap-1">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="maDatVe" value="<%= b.getMaDatVe() %>">
                                            <select name="trangThai" class="form-select form-select-sm" style="width: 145px;">
                                                <option value="Chờ thanh toán" <%= "Chờ thanh toán".equals(b.getTrangThai()) ? "selected" : "" %>>Chờ thanh toán</option>
                                                <option value="Đã thanh toán" <%= "Đã thanh toán".equals(b.getTrangThai()) ? "selected" : "" %>>Đã thanh toán</option>
                                                <option value="Đã hủy" <%= "Đã hủy".equals(b.getTrangThai()) ? "selected" : "" %>>Đã hủy</option>
                                            </select>
                                            <button type="submit" class="btn btn-sm btn-success btn-action"><i class="bi bi-check2"></i></button>
                                        </form>
                                    </td>
                                </tr>
<%
    }
} else {
%>
                                <tr>
                                    <td colspan="12" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                        Không có dữ liệu đặt vé.
                                    </td>
                                </tr>
<%
}
%>
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