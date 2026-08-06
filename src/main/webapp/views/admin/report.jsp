<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.Report"%>
<%
    List<Report> reports = (List<Report>) request.getAttribute("reports");
    List<Report> topCinema = (List<Report>) request.getAttribute("topCinema");
    List<Report> revenueByMonth = (List<Report>) request.getAttribute("revenueByMonth");
    List<Report> revenueByYear = (List<Report>) request.getAttribute("revenueByYear");
    List<Report> bookingStatus = (List<Report>) request.getAttribute("bookingStatus");
    List<Report> seatOccupancy = (List<Report>) request.getAttribute("seatOccupancy");

    Double doanhThu = (Double) request.getAttribute("doanhThu");
    Integer tongVe = (Integer) request.getAttribute("tongVe");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê & Báo cáo - FPT CINEMA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', system-ui, sans-serif; }
        .sidebar { min-height: 100vh; background-color: #1e293b; box-shadow: 2px 0 10px rgba(0,0,0,0.05); }
        .sidebar .nav-link { color: #94a3b8; border-radius: 8px; margin: 2px 0; padding: 10px 12px; font-size: 14px; transition: all 0.2s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #334155; color: #f8fafc !important; }
        .sidebar .nav-link.active { border-left: 4px solid #ef4444; border-radius: 0 8px 8px 0; background-color: #334155; }
        .menu-header { font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-top: 15px; margin-bottom: 5px; padding-left: 10px; }
        .content-card { border: none; border-radius: 14px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); margin-bottom: 24px; }
        .table th { background-color: #f8fafc; font-size: 13px; text-transform: uppercase; color: #64748b; font-weight: 700; }
        .table td { vertical-align: middle; font-size: 14px; }
        .stat-card { background: white; border: none; border-radius: 14px; padding: 22px; box-shadow: 0 1px 3px rgba(0,0,0,0.06); position: relative; overflow: hidden; }
        .stat-card::before { content: ''; position: absolute; top: 0; left: 0; right: 0; height: 3px; border-radius: 14px 14px 0 0; }
        .stat-card.blue::before { background: linear-gradient(90deg, #3b82f6, #60a5fa); }
        .stat-card.green::before { background: linear-gradient(90deg, #22c55e, #4ade80); }
        .stat-card.amber::before { background: linear-gradient(90deg, #f59e0b, #fbbf24); }
        .stat-value { font-size: 1.8rem; font-weight: 800; color: #0f172a; line-height: 1.2; margin-top: 10px; }
        .stat-label { font-size: 13px; color: #64748b; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
        .metric-bar { background: rgba(59,130,246,0.1); border-radius: 8px; padding: 10px 15px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
        .metric-bar:hover { background: rgba(59,130,246,0.15); }
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/booking"><i class="bi bi-ticket-detailed me-2"></i> 6. Quản lý danh sách đặt vé</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/booking"><i class="bi bi-check2-circle me-2"></i> 7. Xác nhận trạng thái vé</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/user"><i class="bi bi-people me-2"></i> 8. Quản lý người dùng</a></li>
                <div class="menu-header">Hệ thống & Báo cáo</div>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/employee"><i class="bi bi-shield-lock me-2"></i> 9. Nhân viên & Phân quyền</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/report"><i class="bi bi-bar-chart-line me-2"></i> 10. Thống kê & Báo cáo</a></li>
                <hr class="text-secondary my-3">
                <li class="nav-item"><a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/home"><i class="bi bi-box-arrow-left me-2"></i> Trở về Trang chủ Website</a></li>
            </ul>
        </div>

        <!-- MAIN CONTENT -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-bar-chart-line me-2"></i>Báo Cáo Doanh Thu</h1>
                    <p class="text-muted mb-0">Thống kê doanh thu, vé bán và phân tích số liệu</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/export-report" class="btn btn-success">
                    <i class="bi bi-file-earmark-excel me-2"></i>Xuất Excel
                </a>
            </div>

            <!-- TỔNG QUAN -->
            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stat-card blue">
                        <div class="stat-label"><i class="bi bi-wallet2 me-2"></i>Tổng doanh thu toàn hệ thống</div>
                        <div class="stat-value text-primary">
                            <%= doanhThu != null ? String.format("%,.0f", doanhThu) : "0" %> VNĐ
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stat-card green">
                        <div class="stat-label"><i class="bi bi-ticket-perforated me-2"></i>Tổng số vé đã bán</div>
                        <div class="stat-value text-success">
                            <%= tongVe %> vé
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <%
                    Double doanhThuHomNay = (Double) request.getAttribute("doanhThuHomNay");
                    %>

                    <div class="stat-card amber">
                        <div class="stat-label">
                            <i class="bi bi-calendar2-day me-2"></i>Doanh thu hôm nay
                        </div>
                        <div class="stat-value text-warning">
                            <%= String.format("%,.0f", doanhThuHomNay) %> VNĐ
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <!-- TOP PHIM -->
                <div class="col-lg-12">
                    <div class="card content-card">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold"><i class="bi bi-trophy me-2 text-warning"></i>Top phim bán chạy</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th class="ps-4">STT</th>
                                            <th>Tên phim</th>
                                            <th>Rạp</th>
                                            <th class="text-center">Số vé</th>
                                            <th class="text-end pe-4">Doanh thu</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<%
if(reports != null && !reports.isEmpty()){
    int stt = 1;
    for(Report report : reports){
%>
                                        <tr>
                                            <td class="ps-4 fw-semibold"><%= stt++ %></td>
                                            <td class="fw-semibold"><%= report.getTenPhim()%></td>
                                            <td><%= report.getTenRap()%></td>
                                            <td class="text-center"><span class="badge bg-secondary"><%= report.getSoVe()%></span></td>
                                            <td class="text-end pe-4 fw-bold text-danger"><%= report.getDoanhThu()%> VNĐ</td>
                                        </tr>
<%
    }
} else {
%>
                                        <tr><td colspan="5" class="text-center text-muted py-4">Chưa có dữ liệu</td></tr>
<%
}
%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- TOP RẠP -->
                <div class="col-lg-6">
                    <div class="card content-card">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold"><i class="bi bi-buildings me-2 text-primary"></i>Top rạp doanh thu cao</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th class="ps-4">STT</th>
                                            <th>Tên rạp</th>
                                            <th class="text-center">Tổng vé</th>
                                            <th class="text-end pe-4">Doanh thu</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<%
if(topCinema != null && !topCinema.isEmpty()){
    int stt = 1;
    for(Report cinema : topCinema){
%>
                                        <tr>
                                            <td class="ps-4 fw-semibold"><%=stt++%></td>
                                            <td class="fw-semibold"><%=cinema.getTenRap()%></td>
                                            <td class="text-center"><span class="badge bg-secondary"><%=cinema.getTongVe()%></span></td>
                                            <td class="text-end pe-4 fw-bold text-danger"><%=cinema.getDoanhThu()%> VNĐ</td>
                                        </tr>
<%
    }
} else {
%>
                                        <tr><td colspan="4" class="text-center text-muted py-4">Chưa có dữ liệu</td></tr>
<%
}
%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- TRẠNG THÁI VÉ -->
                <div class="col-lg-6">
                    <div class="card content-card">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold"><i class="bi bi-check2-square me-2 text-success"></i>Thống kê trạng thái vé</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th class="ps-4">Trạng thái</th>
                                            <th class="text-center pe-4">Số lượng</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<%
if(bookingStatus != null){
    for(Report status : bookingStatus){
%>
                                        <tr>
                                            <td class="ps-4 fw-semibold"><%=status.getTrangThai()%></td>
                                            <td class="text-center pe-4"><span class="badge bg-secondary"><%=status.getSoLuong()%></span></td>
                                        </tr>
<%
    }
} else {
%>
                                        <tr><td colspan="2" class="text-center text-muted py-4">Chưa có dữ liệu</td></tr>
<%
}
%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- TỶ LỆ LẤP ĐẦY -->
                <div class="col-lg-12">
                    <div class="card content-card">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold"><i class="bi bi-pie-chart-fill me-2 text-warning"></i>Tỷ lệ lấp đầy ghế</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover mb-0">
                                    <thead>
                                        <tr>
                                            <th class="ps-4">Phim</th>
                                            <th class="text-center">Ghế đã đặt</th>
                                            <th class="text-center">Tổng ghế</th>
                                            <th class="text-end pe-4">Tỷ lệ</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<%
if(seatOccupancy != null){
    for(Report seat : seatOccupancy){
%>
                                        <tr>
                                            <td class="ps-4 fw-semibold"><%=seat.getTenPhim()%></td>
                                            <td class="text-center"><%=seat.getGheDaDat()%></td>
                                            <td class="text-center"><%=seat.getTongGhe()%></td>
                                            <td class="text-end pe-4 fw-bold text-primary">
                                                <div class="d-flex align-items-center justify-content-end gap-2">
                                                    <div class="progress" style="width: 100px; height: 8px;">
                                                        <div class="progress-bar bg-warning" role="progressbar" style="width: <%=String.format(java.util.Locale.US, "%.0f", seat.getTiLeLapDay())%>%;"></div>
                                                    </div>
                                                    <span><%=String.format("%.2f", seat.getTiLeLapDay())%> %</span>
                                                </div>
                                            </td>
                                        </tr>
<%
    }
} else {
%>
                                        <tr><td colspan="4" class="text-center text-muted py-4">Chưa có dữ liệu</td></tr>
<%
}
%>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- DOANH THU THÁNG -->
                <div class="col-lg-6">
                    <div class="card content-card">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold"><i class="bi bi-calendar-check me-2 text-info"></i>Doanh thu theo tháng</h5>
                        </div>
                        <div class="card-body p-4">
<%
if(revenueByMonth != null && !revenueByMonth.isEmpty()){
    for(Report month : revenueByMonth){
%>
                                <div class="metric-bar">
                                    <span class="fw-semibold text-secondary">Tháng <%=month.getThang()%></span>
                                    <span class="fw-bold text-primary"><%=month.getDoanhThu()%> VNĐ</span>
                                </div>
<%
    }
} else {
%>
                                <div class="text-center text-muted py-4">Chưa có dữ liệu</div>
<%
}
%>
                        </div>
                    </div>
                </div>

                <!-- DOANH THU NĂM -->
                <div class="col-lg-6">
                    <div class="card content-card">
                        <div class="card-header bg-white py-3">
                            <h5 class="mb-0 fw-bold"><i class="bi bi-graph-up me-2 text-danger"></i>Doanh thu theo năm</h5>
                        </div>
                        <div class="card-body p-4">
<%
if(revenueByYear != null && !revenueByYear.isEmpty()){
    for(Report year : revenueByYear){
%>
                                <div class="metric-bar" style="background: rgba(239,68,68,0.1);">
                                    <span class="fw-semibold text-secondary">Năm <%=year.getNam()%></span>
                                    <span class="fw-bold text-danger"><%=year.getDoanhThu()%> VNĐ</span>
                                </div>
<%
    }
} else {
%>
                                <div class="text-center text-muted py-4">Chưa có dữ liệu</div>
<%
}
%>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>