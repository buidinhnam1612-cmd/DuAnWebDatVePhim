<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.User"%>

<%
    List<User> userList = (List<User>) request.getAttribute("userList");
    String message = (String) session.getAttribute("message");
    if (message != null) {
        session.removeAttribute("message");
    }
    String keyword = request.getParameter("keyword");
    if (keyword == null) {
        keyword = "";
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý người dùng - FPT CINEMA</title>
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
        .table td { vertical-align: middle; font-size: 14px; }
        .btn-action { padding: 5px 12px; font-size: 13px; border-radius: 6px; }
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/user"><i class="bi bi-people me-2"></i> 8. Quản lý người dùng</a></li>
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
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-people me-2"></i>Quản Lý Người Dùng</h1>
                    <p class="text-muted mb-0">Tra cứu thông tin, quản lý tài khoản và trạng thái thành viên</p>
                </div>
            </div>

            <% if(message != null){ %>
                <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i><%= message %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <% } %>

            <!-- SEARCH FORM -->
            <div class="card content-card mb-4">
                <div class="card-body">
                    <form method="get" action="<%=request.getContextPath()%>/admin/user" class="d-flex w-50">
                        <input type="hidden" name="action" value="search">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" name="keyword" class="form-control border-start-0 ps-0" value="<%= keyword %>" placeholder="Nhập mã KH, tên đăng nhập, họ tên, email hoặc SĐT...">
                            <button type="submit" class="btn btn-primary px-4"><i class="bi bi-search me-1"></i> Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- TABLE -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Thành Viên</h5>
                    <span class="badge bg-primary rounded-pill"><%= userList != null ? userList.size() : 0 %> user</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Mã KH</th>
                                    <th>Tên đăng nhập</th>
                                    <th>Họ tên</th>
                                    <th>Email</th>
                                    <th>SĐT</th>
                                    <th>Giới tính</th>
                                    <th>Ngày sinh</th>
                                    <th class="text-center">Điểm</th>
                                    <th class="text-center">Trạng thái</th>
                                    <th class="text-center" style="min-width: 150px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
<%
if (userList != null && !userList.isEmpty()) {
    for (User u : userList) {
%>
                                <tr>
                                    <td class="ps-4 fw-semibold"><span class="badge bg-secondary"><%= u.getMaKhachHang() %></span></td>
                                    <td class="fw-semibold text-primary"><%= u.getTenDangNhap() %></td>
                                    <td class="fw-semibold"><%= u.getHoTen() %></td>
                                    <td><%= u.getEmail() %></td>
                                    <td><%= u.getSoDienThoai() %></td>
                                    <td><%= u.getGioiTinh() %></td>
                                    <td><%= u.getNgaySinh() %></td>
                                    <td class="text-center text-warning fw-bold"><i class="bi bi-star-fill me-1"></i><%= u.getDiemTichLuy() %></td>
                                    <td class="text-center">
                                        <% if ("Hoạt động".equals(u.getTrangThai())) { %>
                                            <span class="badge bg-success">Hoạt động</span>
                                        <% } else { %>
                                            <span class="badge bg-danger">Khóa</span>
                                        <% } %>
                                    </td>
                                    <td class="text-center">
                                        <form method="post" action="<%=request.getContextPath()%>/admin/user" class="d-flex align-items-center justify-content-center gap-1">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="maKhachHang" value="<%= u.getMaKhachHang() %>">
                                            <select name="trangThai" class="form-select form-select-sm" style="width: 110px;">
                                                <option value="Hoạt động" <%= "Hoạt động".equals(u.getTrangThai()) ? "selected" : "" %>>Hoạt động</option>
                                                <option value="Khóa" <%= "Khóa".equals(u.getTrangThai()) ? "selected" : "" %>>Khóa</option>
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
                                    <td colspan="10" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                        Không có dữ liệu người dùng.
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