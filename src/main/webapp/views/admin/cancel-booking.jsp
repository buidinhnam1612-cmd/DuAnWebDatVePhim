<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Hỗ trợ hủy vé - FPT CINEMA</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
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

        .page-title {
            font-weight: 700;
            color: #1e293b;
        }

        .search-box {
            border-radius: 10px;
            border: 1px solid #d1d5db;
            height: 48px;
        }

        .search-box:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 0.2rem rgba(37,99,235,0.1);
        }

        .btn-search {
            height: 48px;
            border-radius: 8px;
            padding: 0 25px;
            font-weight: 600;
        }

        .btn-cancel {
            height: 48px;
            border-radius: 8px;
            font-weight: 600;
        }

        .booking-info {
            border-radius: 10px;
            overflow: hidden;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 18px;
            border-bottom: 1px solid #e5e7eb;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #64748b;
            font-size: 14px;
        }

        .info-value {
            color: #1e293b;
            font-weight: 600;
            text-align: right;
        }

        .status {
            display: inline-block;
            padding: 7px 14px;
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
            background-color: #dbeafe;
            color: #1e40af;
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
            margin-top: 20px;
            padding: 18px;
            border-radius: 10px;
            font-size: 14px;
            line-height: 1.6;
        }

        .status-box.success {
            background-color: #dcfce7;
            border: 1px solid #86efac;
            color: #166534;
        }

        .status-box.warning {
            background-color: #fef3c7;
            border: 1px solid #fcd34d;
            color: #92400e;
        }

        .status-box.danger {
            background-color: #fee2e2;
            border: 1px solid #fca5a5;
            color: #991b1b;
        }

        .status-box.info {
            background-color: #dbeafe;
            border: 1px solid #93c5fd;
            color: #1e40af;
        }

        .note-box {
            background-color: #f8fafc;
            border-radius: 10px;
            padding: 16px;
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        .booking-icon {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            background-color: #fee2e2;
            color: #ef4444;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
        }

        .cancel-icon {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            background-color: #fee2e2;
            color: #dc2626;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 25px;
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

        }

    </style>

</head>


<body>

<%
    request.setAttribute("currentPage", "cancel-booking");
%>


<div class="container-fluid">

    <div class="row">

        <div class="col-md-3 col-lg-2 sidebar p-0 text-white">

            <jsp:include page="/views/common/admin-sidebar.jsp" />

        </div>


        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">


            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">

                <div>

                    <h1 class="h3 page-title mb-1">

                        <i class="bi bi-x-circle me-2 text-danger"></i>

                        Hỗ Trợ Hủy Vé

                    </h1>

                    <p class="text-muted mb-0">

                        Tra cứu và hỗ trợ khách hàng hủy vé đã đặt

                    </p>

                </div>

            </div>


            <c:if test="${not empty sessionScope.success}">

                <div class="alert alert-success alert-dismissible fade show"
                     role="alert">

                    <i class="bi bi-check-circle-fill me-2"></i>

                    ${sessionScope.success}

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert">
                    </button>

                </div>

                <c:remove var="success" scope="session"/>

            </c:if>


            <c:if test="${not empty sessionScope.error}">

                <div class="alert alert-danger alert-dismissible fade show"
                     role="alert">

                    <i class="bi bi-exclamation-triangle-fill me-2"></i>

                    ${sessionScope.error}

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert">
                    </button>

                </div>

                <c:remove var="error" scope="session"/>

            </c:if>


            <div class="card content-card mb-4">

                <div class="card-body p-4">

                    <div class="d-flex align-items-center mb-4">

                        <div class="cancel-icon me-3">

                            <i class="bi bi-search"></i>

                        </div>

                        <div>

                            <h5 class="fw-bold mb-1">
                                Tra cứu vé
                            </h5>

                            <p class="text-muted mb-0">
                                Nhập mã đặt vé để kiểm tra thông tin và trạng thái vé.
                            </p>

                        </div>

                    </div>


                    <form method="get"
                          action="${pageContext.request.contextPath}/admin/cancel-booking">

                        <div class="row g-2">

                            <div class="col-md-9">

                                <input type="text"
                                       name="maDatVe"
                                       class="form-control search-box"
                                       placeholder="Nhập mã đặt vé, ví dụ: DV01"
                                       value="${param.maDatVe}"
                                       autocomplete="off"
                                       required>

                            </div>

                            <div class="col-md-3">

                                <button type="submit"
                                        class="btn btn-primary btn-search w-100">

                                    <i class="bi bi-search me-2"></i>

                                    Tra cứu vé

                                </button>

                            </div>

                        </div>

                    </form>


                    <div class="note-box mt-3">

                        <i class="bi bi-info-circle me-2"></i>

                        Nhập chính xác mã đặt vé được hiển thị trên vé.
                        Hệ thống sẽ kiểm tra trạng thái và điều kiện trước khi cho phép hủy.

                    </div>

                </div>

            </div>


            <c:if test="${not empty booking}">

                <div class="card content-card">

                    <div class="card-header bg-white py-3">

                        <h5 class="mb-0 fw-bold">

                            <i class="bi bi-ticket-detailed me-2"></i>

                            Thông Tin Đặt Vé

                        </h5>

                    </div>


                    <div class="card-body p-4">

                        <div class="booking-info border">


                            <div class="info-row">

                                <span class="info-label">
                                    Mã đặt vé
                                </span>

                                <span class="info-value">
                                    ${booking.maDatVe}
                                </span>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Khách hàng
                                </span>

                                <span class="info-value">
                                    ${booking.tenKhachHang}
                                </span>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Số điện thoại
                                </span>

                                <span class="info-value">
                                    ${booking.soDienThoai}
                                </span>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Email
                                </span>

                                <span class="info-value">
                                    ${booking.email}
                                </span>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Phim
                                </span>

                                <span class="info-value">
                                    ${booking.tenPhim}
                                </span>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Ngày chiếu
                                </span>

                                <span class="info-value">
                                    ${booking.ngayChieu}
                                </span>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Giờ bắt đầu
                                </span>

                                <span class="info-value">
                                    ${booking.gioBatDau}
                                </span>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Tổng tiền
                                </span>

                                <span class="info-value text-danger">
                                    ${booking.tongTien} VNĐ
                                </span>

                            </div>


                            <div class="info-row">

                                <span class="info-label">
                                    Trạng thái
                                </span>

                                <span class="info-value">

                                    <c:choose>

                                        <c:when test="${booking.trangThai == 'Đã thanh toán'}">

                                            <span class="status status-payment">

                                                <i class="bi bi-check-circle me-1"></i>

                                                Đã thanh toán

                                            </span>

                                        </c:when>

                                        <c:when test="${booking.trangThai == 'Chờ thanh toán'}">

                                            <span class="status status-waiting">

                                                <i class="bi bi-clock me-1"></i>

                                                Chờ thanh toán

                                            </span>

                                        </c:when>

                                        <c:when test="${booking.trangThai == 'Đã sử dụng'}">

                                            <span class="status status-used">

                                                <i class="bi bi-check2-all me-1"></i>

                                                Đã sử dụng

                                            </span>

                                        </c:when>

                                        <c:when test="${booking.trangThai == 'Đã hủy'}">

                                            <span class="status status-cancelled">

                                                <i class="bi bi-x-circle me-1"></i>

                                                Đã hủy

                                            </span>

                                        </c:when>

                                        <c:otherwise>

                                            <span class="status status-default">

                                                ${booking.trangThai}

                                            </span>

                                        </c:otherwise>

                                    </c:choose>

                                </span>

                            </div>


                        </div>


                        <c:choose>

                            <c:when test="${booking.trangThai == 'Đã thanh toán'}">

                                <div class="status-box warning">

                                    <div class="mb-3">

                                        <i class="bi bi-exclamation-triangle-fill me-2"></i>

                                        Vé đang ở trạng thái có thể hủy.

                                    </div>

                                    <div class="mb-3">

                                        <strong>Lưu ý:</strong>

                                        Hệ thống chỉ cho phép hủy vé trong thời gian quy định.

                                    </div>

                                    <form method="post"
                                          action="${pageContext.request.contextPath}/admin/cancel-booking">

                                        <input type="hidden"
                                               name="maDatVe"
                                               value="${booking.maDatVe}">

                                        <button type="submit"
                                                class="btn btn-danger btn-cancel w-100">

                                            <i class="bi bi-x-circle me-2"></i>

                                            Hủy vé

                                        </button>

                                    </form>

                                </div>

                            </c:when>


                            <c:when test="${booking.trangThai == 'Chờ thanh toán'}">

                                <div class="status-box warning">

                                    <i class="bi bi-clock-fill me-2"></i>

                                    Vé này đang chờ thanh toán.

                                    <br>

                                    Không thể hủy vé ở trạng thái này.

                                </div>

                            </c:when>


                            <c:when test="${booking.trangThai == 'Đã sử dụng'}">

                                <div class="status-box danger">

                                    <i class="bi bi-check2-all me-2"></i>

                                    Vé này đã được sử dụng.

                                    <br>

                                    Không thể hủy vé đã sử dụng.

                                </div>

                            </c:when>


                            <c:when test="${booking.trangThai == 'Đã hủy'}">

                                <div class="status-box danger">

                                    <i class="bi bi-x-circle-fill me-2"></i>

                                    Vé này đã được hủy.

                                    <br>

                                    Không thể hủy lại vé này.

                                </div>

                            </c:when>


                            <c:otherwise>

                                <div class="status-box danger">

                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>

                                    Trạng thái vé không hợp lệ.

                                    <br>

                                    Không thể thực hiện hủy vé này.

                                </div>

                            </c:otherwise>

                        </c:choose>

                    </div>

                </div>

            </c:if>


        </div>

    </div>

</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>