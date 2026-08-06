<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.Employee"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhân viên - FPT CINEMA</title>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/user"><i class="bi bi-people me-2"></i> 8. Quản lý người dùng</a></li>
                <div class="menu-header">Hệ thống & Báo cáo</div>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/employee"><i class="bi bi-shield-lock me-2"></i> 9. Nhân viên & Phân quyền</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/report"><i class="bi bi-bar-chart-line me-2"></i> 10. Thống kê & Báo cáo</a></li>
                <hr class="text-secondary my-3">
                <li class="nav-item"><a class="nav-link text-danger fw-bold" href="${pageContext.request.contextPath}/home"><i class="bi bi-box-arrow-left me-2"></i> Trở về Trang chủ Website</a></li>
            </ul>
        </div>

        <!-- MAIN CONTENT -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-shield-lock me-2"></i>Quản Lý Nhân Viên</h1>
                    <p class="text-muted mb-0">Theo dõi danh sách, phân quyền và trạng thái nhân viên</p>
                </div>
            </div>

            <%
            String success = (String) session.getAttribute("success");
            String error = (String) session.getAttribute("error");

            if (success != null) {
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <%= success %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <%
                session.removeAttribute("success");
            }

            if (error != null) {
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <%
                session.removeAttribute("error");
            }
            %>

            <!-- ==================== FORM THÊM NHÂN VIÊN ==================== -->
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-person-plus text-success me-2"></i>Thêm Tài Khoản Quản Trị</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/employee" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Mã NV</label>
                                <input type="text" class="form-control" name="maNhanVien" placeholder="VD: NV01" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Họ Tên</label>
                                <input type="text" class="form-control" name="hoTen" placeholder="Tên nhân viên..." required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Tên đăng nhập</label>
                                <input type="text" class="form-control" name="tenDangNhap" placeholder="Tên đăng nhập..." required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Email</label>
                                <input type="email" class="form-control" name="email" placeholder="example@email.com" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="text" class="form-control" name="soDienThoai" placeholder="0123456789" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Mật khẩu</label>
                                <input type="password" class="form-control" name="matKhau" placeholder="Nhập mật khẩu..." required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Giới tính</label>
                                <select class="form-select" name="gioiTinh">
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                    <option value="Khác">Khác</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Vai trò</label>
                                <select class="form-select" name="maVaiTro">
                                    <option value="VT02">Nhân viên</option>
                                    <option value="VT01">Admin</option>
                                </select>
                            </div>
                            <div class="col-12 d-flex align-items-end justify-content-end mt-4">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-plus-lg me-1"></i> Thêm Tài Khoản
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- SEARCH FORM -->
            <div class="card content-card mb-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/employee" method="get" class="d-flex w-50">
                        <input type="hidden" name="action" value="search">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" name="keyword" class="form-control border-start-0 ps-0" placeholder="Nhập mã, tên hoặc email...">
                            <button type="submit" class="btn btn-primary px-4"><i class="bi bi-search me-1"></i> Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- TABLE -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Nhân Viên</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Mã NV</th>
                                    <th>Họ tên</th>
                                    <th>Email</th>
                                    <th>SĐT</th>
                                    <th class="text-center">Vai trò</th>
                                    <th class="text-center">Trạng thái</th>
                                    <th class="text-center" style="min-width: 320px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
<%
List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
if(employeeList!=null && !employeeList.isEmpty()){
    for(Employee e : employeeList){
%>
                                <tr>
                                    <td class="ps-4 fw-semibold"><span class="badge bg-secondary"><%=e.getMaNhanVien()%></span></td>
                                    <td class="fw-semibold text-primary"><%=e.getHoTen()%></td>
                                    <td><%=e.getEmail()%></td>
                                    <td><%=e.getSoDienThoai()%></td>
                                    <td class="text-center">
                                        <span class="badge <%= "VT01".equals(e.getMaVaiTro()) ? "bg-danger" : "bg-info text-dark" %>"><%=e.getTenVaiTro()%></span>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge <%= "Hoạt động".equals(e.getTrangThai()) ? "bg-success" : "bg-danger" %>"><%=e.getTrangThai()%></span>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex align-items-center justify-content-center gap-2">
                                            <form action="${pageContext.request.contextPath}/admin/employee" method="post" class="d-flex align-items-center gap-1 mb-0">
                                                <input type="hidden" name="maNhanVien" value="<%=e.getMaNhanVien()%>">
                                                <select name="maVaiTro" class="form-select form-select-sm" style="width: 100px;">
                                                    <option value="VT01" <%= "VT01".equals(e.getMaVaiTro()) ? "selected" : "" %>>Admin</option>
                                                    <option value="VT02" <%= "VT02".equals(e.getMaVaiTro()) ? "selected" : "" %>>Nhân viên</option>
                                                </select>
                                                <button type="submit" name="action" value="updateRole" class="btn btn-sm btn-outline-primary btn-action" title="Đổi quyền"><i class="bi bi-person-gear"></i></button>
                                            </form>

                                            <form action="${pageContext.request.contextPath}/admin/employee" method="post" class="d-flex align-items-center gap-1 mb-0">
                                                <input type="hidden" name="maNhanVien" value="<%=e.getMaNhanVien()%>">
                                                <select name="trangThai" class="form-select form-select-sm" style="width: 105px;">
                                                    <option value="Hoạt động" <%= "Hoạt động".equals(e.getTrangThai()) ? "selected" : "" %>>Hoạt động</option>
                                                    <option value="Khóa" <%= "Khóa".equals(e.getTrangThai()) ? "selected" : "" %>>Khóa</option>
                                                </select>
                                                <button type="submit" name="action" value="updateStatus" class="btn btn-sm btn-outline-success btn-action" title="Cập nhật TT"><i class="bi bi-check2-circle"></i></button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
<%
    }
} else {
%>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                        Không có dữ liệu nhân viên.
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