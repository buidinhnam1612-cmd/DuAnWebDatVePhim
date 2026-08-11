<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<section class="container" style="padding-top: 50px; padding-bottom: 80px; min-height: 80vh;">

    <div class="row">
        <!-- Sidebar Menu -->
        <div class="col-lg-3 mb-4">
            <div class="card p-4" style="background: var(--surface); border: 1px solid var(--border); border-radius: 15px;">
                <div class="text-center mb-4">
                    <div style="width: 80px; height: 80px; background: var(--bg); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px auto; border: 2px solid #ffc107;">
                        <i class="bi bi-person-fill text-warning fs-1"></i>
                    </div>
                    <h5 class="text-white mb-1"><c:out value="${sessionScope.userName}" default="Khách hàng"/></h5>
                    <p class="text-muted small mb-0"><c:out value="${sessionScope.email}" default="support@fptcinema.vn"/></p>
                </div>
                
                <hr style="border-color: var(--border); margin: 20px 0;">

                <div class="nav flex-column nav-pills" role="tablist">
                    <a href="${pageContext.request.contextPath}/history" class="nav-link active p-3 mb-2" style="background: #ef4444; color: #fff; border-radius: 10px; font-weight: 600;">
                        <i class="bi bi-clock-history me-2"></i>Lịch sử vé đã đặt
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="nav-link text-danger p-3" style="border-radius: 10px; font-weight: 600;">
                        <i class="bi bi-box-arrow-left me-2"></i>Đăng xuất
                    </a>
                </div>
            </div>
        </div>

        <!-- History List Content -->
        <div class="col-lg-9">
            <div class="card p-4" style="background: var(--surface); border: 1px solid var(--border); border-radius: 15px;">
                <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom" style="border-color: var(--border) !important;">
                    <h2 class="text-white fw-bold mb-0" style="font-size: 24px;">
                        <i class="bi bi-ticket-detailed text-warning me-2"></i>Lịch sử đặt vé
                    </h2>
                    <span class="badge bg-dark text-muted p-2" style="border: 1px solid var(--border);">
                        Tổng cộng: ${bookings.size()} giao dịch
                    </span>
                </div>

                <c:choose>
                    <c:when test="${empty bookings}">
                        <div class="text-center py-5">
                            <div style="font-size: 60px; color: var(--text-muted);" class="mb-3">
                                <i class="bi bi-ticket-perforated"></i>
                            </div>
                            <h5 class="text-white">Bạn chưa đặt chiếc vé nào!</h5>
                            <p class="text-muted">Hãy chọn ngay bộ phim yêu thích và đặt những vị trí ghế đẹp nhất nhé.</p>
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-danger mt-3" style="border-radius: 10px; padding: 10px 25px; font-weight: 600;">
                                Đặt vé ngay
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table align-middle" style="color: #cbd5e1; border-color: var(--border);">
                                <thead style="background: var(--bg); border-bottom: 2px solid var(--border);">
                                    <tr>
                                        <th class="text-white py-3" style="font-size: 13px;">Mã vé</th>
                                        <th class="text-white py-3" style="font-size: 13px;">Thông tin phim & Suất chiếu</th>
                                        <th class="text-white py-3" style="font-size: 13px;">Ghế đặt</th>
                                        <th class="text-white py-3" style="font-size: 13px;">Tổng tiền</th>
                                        <th class="text-white py-3" style="font-size: 13px;">Trạng thái</th>
                                        <th class="text-white py-3 text-center" style="font-size: 13px;">Hành động / Lưu ý</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="b" items="${bookings}">
                                        <tr style="border-bottom: 1px solid var(--border);">
                                            <td class="fw-bold text-warning py-3" style="font-size: 15px;">
                                                ${b.maDatVe}
                                            </td>
                                            <td class="py-3">
                                                <div class="text-white fw-bold" style="font-size: 15px;">${b.tenPhim}</div>
                                                <div class="small text-muted mt-1">
                                                    <i class="bi bi-geo-alt-fill me-1 text-warning"></i>${b.tenRap} - Phòng ${b.tenPhong}
                                                </div>
                                                <div class="small text-muted mt-1">
                                                    <i class="bi bi-calendar-event me-1"></i>${b.ngayChieu} | <i class="bi bi-clock"></i> ${b.gioBatDau}
                                                </div>
                                            </td>
                                            <td class="py-3">
                                                <span class="badge bg-dark text-light p-2" style="border: 1px solid var(--border); font-size: 13px;">
                                                    ${b.danhSachGhe}
                                                </span>
                                            </td>
                                            <td class="fw-bold text-white py-3" style="font-size: 16px;">
                                                <fmt:formatNumber value="${b.tongTien}" type="number" groupingUsed="true"/>đ
                                                <c:if test="${not empty b.tenVoucher}">
                                                    <div style="font-size: 11px; color: #2ec4b6;" class="mt-1">
                                                        <i class="bi bi-tag-fill"></i> Đã giảm giá
                                                    </div>
                                                </c:if>
                                            </td>
                                            <td class="py-3">
                                                <c:choose>
                                                    <c:when test="${b.trangThai eq 'Đã thanh toán'}">
                                                        <span class="badge bg-success text-white p-2" style="border-radius: 6px; font-size: 12px; font-weight: 600;">
                                                            <i class="bi bi-check-circle me-1"></i>Đã thanh toán
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${b.trangThai eq 'Chờ thanh toán'}">
                                                        <span class="badge bg-warning text-dark p-2" style="border-radius: 6px; font-size: 12px; font-weight: 600;">
                                                            <i class="bi bi-hourglass-split me-1"></i>Chờ thanh toán
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary text-muted p-2" style="border-radius: 6px; font-size: 12px; font-weight: 600; color: #64748b !important;">
                                                            <i class="bi bi-x-circle me-1"></i>Đã hủy
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center py-3">
                                                <c:choose>
                                                    <c:when test="${b.trangThai eq 'Chờ thanh toán'}">
                                                        <div class="small p-2 text-danger" style="background: rgba(220, 53, 69, 0.05); border: 1px solid rgba(220, 53, 69, 0.15); border-radius: 8px; max-width: 200px; margin: 0 auto; font-size: 12px; line-height: 1.4;">
                                                            ⚠️ Cần đến quầy trước giờ chiếu <strong>60 phút</strong> để nhận vé cứng!
                                                        </div>
                                                    </c:when>
                                                    <c:when test="${b.trangThai eq 'Đã thanh toán'}">
                                                        <div class="text-success small fw-bold">
                                                            <i class="bi bi-ticket-detailed-fill"></i> Hãy xuất trình mã vé tại quầy soát vé!
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted small">Vé đã hết hiệu lực</span>
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
    </div>

</section>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>
