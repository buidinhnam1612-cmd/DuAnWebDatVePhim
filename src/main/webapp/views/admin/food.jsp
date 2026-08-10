<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.Food"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đồ ăn & đồ uống - FPT CINEMA</title>
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
<% request.setAttribute("currentPage", "food"); %>

<div class="container-fluid">
    <div class="row">
        <!-- SIDEBAR -->
        <div class="col-md-3 col-lg-2 sidebar p-0 text-white">
            <jsp:include page="/views/common/admin-sidebar.jsp" />
        </div>

        <!-- MAIN CONTENT -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-cup-straw me-2 text-warning"></i>Quản Lý Đồ Ăn & Đồ Uống</h1>
                    <p class="text-muted mb-0">Quản lý kho hàng, cập nhật số lượng, giá và trạng thái F&B</p>
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

            <!-- FORM THÊM ĐỒ ĂN -->
            <%
            String role = (String) session.getAttribute("role");
            java.util.List<String> perms = (java.util.List<String>) session.getAttribute("userPermissions");
            boolean canManageFood = "ADMIN".equals(role) || (perms != null && perms.contains("MANAGE_FOOD"));

            if (canManageFood) {
            %>
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-plus-circle text-success me-2"></i>Thêm Sản Phẩm Mới</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/food" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="row g-3">
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Mã sản phẩm</label>
                                <input type="text" class="form-control" name="maDoAn" placeholder="VD: DA07" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Tên sản phẩm</label>
                                <input type="text" class="form-control" name="tenDoAn" placeholder="Tên bắp/nước/combo..." required>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Loại</label>
                                <select class="form-select" name="loai">
                                    <option value="Đồ ăn">Đồ ăn</option>
                                    <option value="Đồ uống">Đồ uống</option>
                                    <option value="Combo">Combo</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label fw-semibold">Giá bán (VNĐ)</label>
                                <input type="number" class="form-control" name="gia" placeholder="50000" required>
                            </div>
                            <div class="col-md-3 d-flex align-items-end justify-content-end">
                                <input type="hidden" name="soLuong" value="100">
                                <button type="submit" class="btn btn-success w-100">
                                    <i class="bi bi-plus-lg me-1"></i> Thêm Sản Phẩm
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <% } %>

            <!-- SEARCH FORM -->
            <div class="card content-card mb-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/food" method="get" class="d-flex w-50">
                        <input type="hidden" name="action" value="search">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" name="keyword" class="form-control border-start-0 ps-0" placeholder="Nhập mã, tên hoặc loại món...">
                            <button type="submit" class="btn btn-primary px-4"><i class="bi bi-search me-1"></i> Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- TABLE -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Đồ Ăn & Đồ Uống</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Mã Món</th>
                                    <th>Tên Sản Phẩm</th>
                                    <th>Loại</th>
                                    <th class="text-end">Giá Bán</th>
                                    <th class="text-center">Số Lượng Kho</th>
                                    <th class="text-center">Trạng Thái</th>
                                    <% if (canManageFood) { %>
                                    <th class="text-center" style="min-width: 320px;">Thao Tác</th>
                                    <% } %>
                                </tr>
                            </thead>
                            <tbody>
<%
List<Food> foodList = (List<Food>) request.getAttribute("foodList");
if (foodList != null && !foodList.isEmpty()) {
    for (Food f : foodList) {
%>
                                <tr>
                                    <td class="ps-4 fw-semibold"><span class="badge bg-secondary"><%= f.getMaDoAn() %></span></td>
                                    <td class="fw-semibold text-dark"><%= f.getTenDoAn() %></td>
                                    <td><span class="badge bg-primary bg-opacity-10 text-primary"><%= f.getLoai() %></span></td>
                                    <td class="text-end text-danger fw-bold"><%= String.format("%,.0f", f.getGia()) %> VNĐ</td>
                                    <td class="text-center fw-bold"><%= f.getSoLuong() %></td>
                                    <td class="text-center">
                                        <span class="badge <%= "Còn hàng".equals(f.getTrangThai()) ? "bg-success" : "bg-danger" %>"><%= f.getTrangThai() %></span>
                                    </td>
                                    <% if (canManageFood) { %>
                                    <td class="text-center">
                                        <div class="d-flex align-items-center justify-content-center gap-2">
                                            <!-- Đổi trạng thái -->
                                            <form action="${pageContext.request.contextPath}/admin/food" method="post" class="d-flex align-items-center gap-1 mb-0">
                                                <input type="hidden" name="action" value="updateStatus">
                                                <input type="hidden" name="maDoAn" value="<%= f.getMaDoAn() %>">
                                                <select name="trangThai" class="form-select form-select-sm" style="width: 110px;">
                                                    <option value="Còn hàng" <%= "Còn hàng".equals(f.getTrangThai()) ? "selected" : "" %>>Còn hàng</option>
                                                    <option value="Hết hàng" <%= "Hết hàng".equals(f.getTrangThai()) ? "selected" : "" %>>Hết hàng</option>
                                                </select>
                                                <button type="submit" class="btn btn-sm btn-outline-success btn-action" title="Lưu TT"><i class="bi bi-check2"></i></button>
                                            </form>

                                            <!-- Cập nhật kho -->
                                            <form action="${pageContext.request.contextPath}/admin/food" method="post" class="d-flex align-items-center gap-1 mb-0">
                                                <input type="hidden" name="action" value="updateQuantity">
                                                <input type="hidden" name="maDoAn" value="<%= f.getMaDoAn() %>">
                                                <input type="number" name="soLuong" value="<%= f.getSoLuong() %>" class="form-control form-control-sm" style="width: 75px;" required>
                                                <button type="submit" class="btn btn-sm btn-outline-primary btn-action" title="Cập nhật kho"><i class="bi bi-boxes"></i></button>
                                            </form>
                                        </div>
                                    </td>
                                    <% } %>
                                </tr>
<%
    }
} else {
%>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                        Không có dữ liệu đồ ăn/đồ uống.
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
