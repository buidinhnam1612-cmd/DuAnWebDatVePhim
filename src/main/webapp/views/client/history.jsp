<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<section class="container" style="padding-top: 40px; padding-bottom: 80px; min-height: 80vh; max-width: 1200px;">

    <div class="row">
        <!-- Sidebar Menu -->
        <div class="col-lg-3 col-md-4 mb-4">
            <div class="p-3 text-center mb-4">
                <div style="width: 100px; height: 100px; border-radius: 50%; border: 2px solid #f59e0b; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px auto; background: #fff;">
                    <i class="bi bi-person-fill text-warning fs-1" style="font-size: 50px;"></i>
                </div>
                <div class="fw-semibold text-secondary mb-3" style="font-size: 14px;">
                    <c:out value="${sessionScope.email}" default="${sessionScope.user.email}"/>
                </div>
            </div>

            <div class="nav flex-column gap-2">
                <a href="${pageContext.request.contextPath}/history" class="btn text-start fw-bold py-2 px-3 text-white" style="background-color: #d9534f; border-radius: 8px; border: none; font-size: 14px;">
                    Lịch sử vé đã đặt
                </a>
                <a href="${pageContext.request.contextPath}/logout" class="btn text-start fw-semibold py-2 px-3 text-danger hover-bg-light" style="background: transparent; border-radius: 8px; border: none; font-size: 14px;">
                    Đăng xuất
                </a>
            </div>
        </div>

        <!-- History List Content -->
        <div class="col-lg-9 col-md-8">
            <!-- Header section -->
            <div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom border-2 border-dark">
                <h3 class="fw-bold m-0" style="font-size: 26px; color: #000;">
                    Lịch sử đặt vé
                </h3>
                <span class="badge bg-danger fs-6 px-3 py-2" style="border-radius: 6px; background-color: #dc3545 !important;">
                    Tổng cộng: ${not empty bookings ? bookings.size() : 0} giao dịch
                </span>
            </div>

            <!-- Thống báo Thành công / Thất bại -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show mb-3" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="text-center py-5">
                        <div style="font-size: 60px; color: #6c757d;" class="mb-3">
                            <i class="bi bi-ticket-perforated"></i>
                        </div>
                        <h5 class="text-dark">Bạn chưa đặt chiếc vé nào!</h5>
                        <p class="text-muted">Hãy chọn ngay bộ phim yêu thích và đặt những vị trí ghế đẹp nhất nhé.</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn btn-danger mt-3" style="border-radius: 10px; padding: 10px 25px; font-weight: 600;">
                            Đặt vé ngay
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table align-middle custom-history-table">
                            <thead>
                                <tr class="border-bottom border-2 border-secondary" style="font-size: 14px;">
                                    <th scope="col" style="width: 10%;">Mã vé</th>
                                    <th scope="col" style="width: 32%;">Thông tin phim & Suất chiếu</th>
                                    <th scope="col" class="text-center" style="width: 10%;">Ghế đặt</th>
                                    <th scope="col" class="text-end" style="width: 13%;">Tổng tiền</th>
                                    <th scope="col" class="text-center" style="width: 15%;">Trạng thái</th>
                                    <th scope="col" class="text-center" style="width: 20%;">Hành động / Lưu ý</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${bookings}">
                                    <tr class="border-bottom">
                                        <!-- Mã vé -->
                                        <td class="fw-bold" style="color: #f59e0b; font-size: 15px;">
                                            ${b.maDatVe}
                                        </td>

                                        <!-- Thông tin phim & Suất chiếu -->
                                        <td>
                                            <div class="fw-bold text-dark fs-6 mb-1">${b.tenPhim}</div>
                                            <div class="text-muted small mb-1">
                                                ${b.tenRap} - Phòng ${b.tenPhong}
                                            </div>
                                            <div class="text-muted small">
                                                ${b.ngayChieu} | ${b.gioBatDau}
                                            </div>
                                        </td>

                                        <!-- Ghế đặt -->
                                        <td class="text-center">
                                            <span class="badge bg-danger text-white px-2 py-1 fs-6" style="border-radius: 4px;">
                                                ${b.danhSachGhe}
                                            </span>
                                        </td>

                                        <!-- Tổng tiền -->
                                        <td class="text-end fw-bold text-dark fs-6">
                                            <fmt:formatNumber value="${b.tongTien}" type="number" groupingUsed="true"/>đ
                                            <c:if test="${not empty b.tenVoucher}">
                                                <div style="font-size: 11px; color: #198754;" class="mt-1">
                                                    Đã giảm giá
                                                </div>
                                            </c:if>
                                        </td>

                                        <!-- Trạng thái -->
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${b.trangThai eq 'Chờ thanh toán'}">
                                                    <span class="badge text-dark px-3 py-2 fw-semibold" style="background-color: #facc15; border-radius: 6px; font-size: 12px;">
                                                        Chờ thanh toán
                                                    </span>
                                                </c:when>
                                                <c:when test="${b.trangThai eq 'Đã thanh toán'}">
                                                    <span class="badge text-white px-3 py-2 fw-semibold" style="background-color: #198754; border-radius: 6px; font-size: 12px;">
                                                        Đã thanh toán
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary text-white px-3 py-2 fw-semibold" style="border-radius: 6px; font-size: 12px;">
                                                        Đã hủy
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <!-- Hành động / Lưu ý -->
                                        <td class="text-center">
                                            <c:choose>
                                                <c:when test="${b.trangThai eq 'Chờ thanh toán'}">
                                                    <form action="${pageContext.request.contextPath}/history" method="POST" onsubmit="return confirm('Bạn có chắc chắn muốn hủy đơn đặt vé này?');">
                                                        <input type="hidden" name="action" value="cancel">
                                                        <input type="hidden" name="maDatVe" value="${b.maDatVe}">
                                                        <button type="submit" class="btn btn-outline-danger btn-sm w-100 mb-1" style="border-radius: 6px; font-size: 12px; font-weight: 600;">
                                                            <i class="bi bi-x-circle me-1"></i>Hủy vé
                                                        </button>
                                                    </form>
                                                    <div style="font-size: 10px; color: #dc3545; line-height: 1.2;">
                                                        ⚠️ Nhận vé trước giờ chiếu 60 phút!
                                                    </div>
                                                </c:when>

                                                <c:when test="${b.trangThai eq 'Đã thanh toán'}">
                                                    <form action="${pageContext.request.contextPath}/history" method="POST" onsubmit="return confirm('Hủy vé đã thanh toán cần đáp ứng điều kiện trước suất chiếu 60 phút. Bạn vẫn muốn hủy?');">
                                                        <input type="hidden" name="action" value="cancel">
                                                        <input type="hidden" name="maDatVe" value="${b.maDatVe}">
                                                        <button type="submit" class="btn btn-outline-secondary btn-sm w-100 mb-1" style="border-radius: 6px; font-size: 12px; font-weight: 600;">
                                                            <i class="bi bi-x-circle me-1"></i>Hủy vé
                                                        </button>
                                                    </form>
                                                    <div style="font-size: 11px; color: #198754;" class="fw-semibold">
                                                        Xuất trình mã vé tại quầy!
                                                    </div>
                                                </c:when>

                                                <c:otherwise>
                                                    <span class="text-muted small">Vé đã bị hủy</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

</section>

<style>
    .custom-history-table th {
        font-weight: 700;
        color: #000;
        padding-top: 12px;
        padding-bottom: 12px;
    }
    .custom-history-table td {
        padding-top: 16px;
        padding-bottom: 16px;
    }
    .hover-bg-light:hover {
        background-color: #f8f9fa !important;
    }
</style>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>