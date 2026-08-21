<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Xác nhận trạng thái vé - FPT CINEMA</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
        rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', system-ui, sans-serif;
        }

        .sidebar {
            min-height: 100vh;
            background-color: #1e293b;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
        }

        .sidebar .nav-link {
            color: #94a3b8;
            border-radius: 8px;
            margin: 2px 0;
            padding: 10px 12px;
            font-size: 14px;
            transition: all 0.2s;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: #334155;
            color: #f8fafc !important;
        }

        .sidebar .nav-link.active {
            border-left: 4px solid #ef4444;
            border-radius: 0 8px 8px 0;
            background-color: #334155;
        }

        .menu-header {
            font-size: 11px;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 700;
            margin-top: 15px;
            margin-bottom: 5px;
            padding-left: 10px;
        }

        .content-card {
            border: none;
            border-radius: 14px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }

        .page-header {
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 5px;
        }

        .page-description {
            color: #6b7280;
            margin-bottom: 0;
            font-size: 14px;
        }

        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-input {
            height: 45px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            padding: 0 14px;
            font-size: 14px;
            outline: none;
        }

        .search-input:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 2px rgba(37,99,235,0.1);
        }

        .btn-search {
            height: 45px;
            padding: 0 22px;
            border: none;
            border-radius: 7px;
            background-color: #2563eb;
            color: white;
            font-weight: 600;
cursor: pointer;
        }

        .btn-search:hover {
            background-color: #1d4ed8;
        }

        .card-title {
            font-size: 18px;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 20px;
        }

        .booking-info {
            margin-top: 10px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 13px 0;
            border-bottom: 1px solid #e5e7eb;
            gap: 20px;
        }

        .info-label {
            color: #6b7280;
            font-size: 14px;
        }

        .info-value {
            font-weight: 600;
            color: #1f2937;
            text-align: right;
        }

        .status {
            display: inline-block;
            padding: 6px 13px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-payment {
            background-color: #dcfce7;
            color: #166534;
        }

        .status-waiting {
            background-color: #fef3c7;
            color: #92400e;
        }

        .status-used {
            background-color: #e0e7ff;
            color: #3730a3;
        }

        .status-cancelled {
            background-color: #fee2e2;
            color: #991b1b;
        }

        .status-default {
            background-color: #e5e7eb;
            color: #374151;
        }

        .status-box {
            margin-top: 22px;
            padding: 16px;
            border-radius: 9px;
            font-size: 14px;
            font-weight: 600;
            line-height: 1.6;
        }

        .status-box.success {
            background-color: #dcfce7;
            color: #166534;
            border: 1px solid #86efac;
        }

        .status-box.warning {
            background-color: #fef3c7;
            color: #92400e;
            border: 1px solid #fcd34d;
        }

        .status-box.danger {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }

        .confirm-form {
            margin-top: 20px;
        }

        .btn-confirm {
            width: 100%;
            height: 48px;
            border: none;
            border-radius: 8px;
            background-color: #16a34a;
            color: white;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
        }

        .btn-confirm:hover {
            background-color: #15803d;
        }

        .note {
            margin-top: 18px;
            padding: 15px;
            background-color: #f3f4f6;
            border-radius: 8px;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        .message {
            padding: 13px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 14px;
font-weight: 600;
        }

        .success-message {
            background-color: #dcfce7;
            color: #166534;
            border: 1px solid #86efac;
        }

        .error-message {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #fca5a5;
        }

        @media (max-width: 768px) {
            .info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 5px;
            }

            .info-value {
                text-align: left;
            }

            .search-form {
                flex-direction: column;
            }

            .btn-search {
                width: 100%;
            }
        }
    </style>
</head>

<body>

<%
    request.setAttribute("currentPage", "food");
%>

<div class="container-fluid">
    <div class="row">

        <div class="col-md-3 col-lg-2 sidebar p-0 text-white">
            <jsp:include page="/views/common/admin-sidebar.jsp" />
        </div>

        <div class="col-md-9 col-lg-10 px-md-4 py-4">

            <c:if test="${not empty sessionScope.success}">
                <div class="message success-message">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    ${sessionScope.success}
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div class="message error-message">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    ${sessionScope.error}
                </div>
                <c:remove var="error" scope="session"/>
            </c:if>

            <div class="page-header">
                <div class="page-title">
                    <i class="bi bi-cup-straw me-2"></i>
                    Quản lý Đồ ăn & Thức uống
                </div>
                <p class="page-description">
                    Cấu hình danh mục sản phẩm, cập nhật số lượng nhập kho và đơn giá bán đồ ăn tại quầy rạp phim.
                </p>
            </div>

            <div class="card content-card mb-4">
                <div class="card-body p-4">
                    <div class="card-title" style="font-size: 18px; font-weight: 700; color: #1f2937; margin-bottom: 20px;">
                        <i class="bi bi-search me-2"></i>
                        Bộ lọc sản phẩm tại quầy
                    </div>

                    <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <form method="get" action="${pageContext.request.contextPath}/admin/food" class="search-form" style="flex: 1; max-width: 500px; display: flex; gap: 10px;">
                            <input type="hidden" name="action" value="search">
                            <input
                                type="text"
name="keyword"
                                class="form-control search-input"
                                style="height: 45px; border: 1px solid #d1d5db; border-radius: 7px; padding: 0 14px; font-size: 14px;"
                                placeholder="Nhập tên bỏng ngô, nước uống hoặc combo..."
                                value="${param.keyword}"
                                autocomplete="off">

                            <button type="submit" class="btn-search" style="height: 45px; padding: 0 22px; border: none; border-radius: 7px; background-color: #2563eb; color: white; font-weight: 600; cursor: pointer;">
                                <i class="bi bi-search me-1"></i>
                                Tìm kiếm
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="card content-card">
                <div class="card-body p-4">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0" style="font-size: 14px;">
                            <thead class="table-light" style="color: #4b5563;">
                                <tr>
                                    <th>STT</th>
                                    <th>Mã Món</th>
                                    <th>Tên Món Ăn / Combo</th>
                                    <th>Phân Loại</th>
                                    <th style="width: 150px;">Số Lượng Kho</th>
                                    <th style="width: 170px;">Đơn Giá (VNĐ)</th>
                                    <th style="width: 150px;">Trạng Thái</th>
                                    <th>Hệ Thống</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty foodList}">
                                        <c:forEach var="food" items="${foodList}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td><span class="badge bg-light text-dark border px-2 py-1">${food.maDoAn}</span></td>
                                                <td><span class="fw-semibold text-dark">${food.tenDoAn}</span></td>
                                                <td>${food.loai}</td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/admin/food" method="post" class="d-flex align-items-center gap-1">
                                                        <input type="hidden" name="action" value="updateQuantity">
<input type="hidden" name="maDoAn" value="${food.maDoAn}">

                                                        <fmt:formatNumber value="${food.soLuong}" maxFractionDigits="0" pattern="#,##0" var="formattedSoLuong" />
                                                        <input type="text" name="soLuong" class="form-control form-control-sm text-center" value="${formattedSoLuong}" style="width: 75px; height: 32px;">

                                                        <button type="submit" class="btn btn-sm btn-outline-secondary" style="height: 32px;"><i class="bi bi-save"></i></button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/admin/food" method="post" class="d-flex align-items-center gap-1">
                                                        <input type="hidden" name="action" value="updatePrice">
                                                        <input type="hidden" name="maDoAn" value="${food.maDoAn}">

                                                        <fmt:formatNumber value="${food.gia}" maxFractionDigits="0" pattern="#,##0" var="formattedGia" />
                                                        <input type="text" name="gia" class="form-control form-control-sm text-danger fw-bold" value="${formattedGia}" style="width: 105px; height: 32px;">

                                                        <button type="submit" class="btn btn-sm btn-outline-danger" style="height: 32px;"><i class="bi bi-save"></i></button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/admin/food" method="post">
                                                        <input type="hidden" name="action" value="updateStatus">
                                                        <input type="hidden" name="maDoAn" value="${food.maDoAn}">
                                                        <select name="trangThai" class="form-select form-select-sm" style="font-size: 13px;" onchange="this.form.submit()">
                                                            <option value="Còn hàng" ${food.trangThai == 'Còn hàng' ? 'selected' : ''}>Còn hàng</option>
                                                            <option value="Hết hàng" ${food.trangThai == 'Hết hàng' ? 'selected' : ''}>Hết hàng</option>
                                                        </select>
                                                    </form>
                                                </td>
                                                <td>
<span class="text-muted" style="font-size: 13px;"><i class="bi bi-shield-check me-1"></i>Hệ thống quầy</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="8" class="text-center text-muted py-5">
                                                <i class="bi bi-inbox fs-2 d-block mb-2 text-secondary"></i> Chưa có dữ liệu đồ ăn nào.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
