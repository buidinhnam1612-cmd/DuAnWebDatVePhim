<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<style>
    .promo-page {
        background: linear-gradient(180deg, #f8fafc 0%, #f1f5f9 100%);
        min-height: 90vh;
        padding-bottom: 80px;
    }

    /* Hero Banner */
    .promo-hero {
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 60%, #1e1b4b 100%);
        padding: 70px 0 90px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }

    .promo-hero::before {
        content: "";
        position: absolute;
        top: -50%;
        left: -20%;
        width: 60%;
        height: 200%;
        background: radial-gradient(circle, rgba(225, 29, 72, 0.12) 0%, transparent 70%);
        pointer-events: none;
    }

    .promo-hero::after {
        content: "";
        position: absolute;
        bottom: -50%;
        right: -20%;
        width: 60%;
        height: 200%;
        background: radial-gradient(circle, rgba(251, 191, 36, 0.1) 0%, transparent 70%);
        pointer-events: none;
    }

    .promo-hero h1 {
        font-size: 48px;
        font-weight: 800;
        color: #ffffff;
        margin-bottom: 15px;
        position: relative;
        z-index: 2;
    }

    .promo-hero h1 span {
        background: linear-gradient(135deg, #e11d48, #f97316);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }

    .promo-hero p {
        color: #94a3b8;
        font-size: 18px;
        max-width: 600px;
        margin: 0 auto;
        position: relative;
        z-index: 2;
    }

    /* Stats Bar */
    .promo-stats-bar {
        display: flex;
        justify-content: center;
        gap: 50px;
        margin-top: 40px;
        position: relative;
        z-index: 2;
    }

    .promo-stat-item {
        text-align: center;
    }

    .promo-stat-number {
        font-size: 36px;
        font-weight: 800;
        color: #fbbf24;
        display: block;
    }

    .promo-stat-label {
        font-size: 13px;
        color: #94a3b8;
        text-transform: uppercase;
        letter-spacing: 1px;
        font-weight: 600;
    }

    /* Voucher Card */
    .voucher-card {
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        overflow: hidden;
        transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    .voucher-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        border-color: #e11d48;
    }

    .voucher-card-header {
        background: linear-gradient(135deg, #e11d48 0%, #be123c 100%);
        padding: 25px 25px 30px;
        position: relative;
        text-align: center;
    }

    .voucher-card-header::after {
        content: "";
        position: absolute;
        bottom: -12px;
        left: 0;
        right: 0;
        height: 24px;
        background: #ffffff;
        border-radius: 24px 24px 0 0;
    }

    .voucher-discount-badge {
        font-size: 42px;
        font-weight: 800;
        color: #ffffff;
        line-height: 1;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }

    .voucher-discount-badge small {
        font-size: 18px;
        font-weight: 600;
        opacity: 0.9;
    }

    .voucher-card-body {
        padding: 20px 25px 25px;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }

    .voucher-name {
        font-size: 18px;
        font-weight: 700;
        color: #0f172a;
        margin-bottom: 12px;
        text-align: center;
    }

    .voucher-info-row {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 8px 0;
        border-bottom: 1px dashed #f1f5f9;
    }

    .voucher-info-row:last-child {
        border-bottom: none;
    }

    .voucher-info-icon {
        width: 32px;
        height: 32px;
        border-radius: 8px;
        background: #fef2f2;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
        font-size: 14px;
        color: #e11d48;
    }

    .voucher-info-label {
        font-size: 12px;
        color: #94a3b8;
        text-transform: uppercase;
        font-weight: 600;
        letter-spacing: 0.5px;
    }

    .voucher-info-value {
        font-size: 14px;
        color: #0f172a;
        font-weight: 600;
    }

    /* Mã code dạng dashed box */
    .voucher-code-box {
        margin-top: auto;
        padding-top: 15px;
    }

    .voucher-code {
        background: linear-gradient(135deg, #fef2f2, #fff1f2);
        border: 2px dashed #fca5a5;
        border-radius: 10px;
        padding: 12px 20px;
        text-align: center;
        font-family: 'Courier New', monospace;
        font-size: 18px;
        font-weight: 700;
        color: #e11d48;
        letter-spacing: 3px;
        cursor: pointer;
        transition: all 0.2s ease;
        position: relative;
    }

    .voucher-code:hover {
        background: linear-gradient(135deg, #ffe4e6, #fecdd3);
        border-color: #e11d48;
        transform: scale(1.02);
    }

    .voucher-code .copy-hint {
        display: block;
        font-family: 'Poppins', sans-serif;
        font-size: 10px;
        font-weight: 500;
        color: #f87171;
        letter-spacing: 0.5px;
        margin-top: 4px;
    }

    /* Status Badges */
    .voucher-status {
        position: absolute;
        top: 15px;
        right: 15px;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        z-index: 3;
    }

    .voucher-status-active {
        background: rgba(34, 197, 94, 0.15);
        color: #16a34a;
        border: 1px solid rgba(34, 197, 94, 0.3);
    }

    .voucher-status-expired {
        background: rgba(148, 163, 184, 0.15);
        color: #64748b;
        border: 1px solid rgba(148, 163, 184, 0.3);
    }

    /* Expired card overlay */
    .voucher-card.expired {
        opacity: 0.6;
        filter: grayscale(0.3);
    }

    .voucher-card.expired:hover {
        transform: none;
        box-shadow: none;
        border-color: #e2e8f0;
    }

    .voucher-card.expired .voucher-card-header {
        background: linear-gradient(135deg, #64748b 0%, #475569 100%);
    }

    /* Section Heading */
    .promo-section-heading {
        font-size: 28px;
        font-weight: 800;
        color: #ffffff !important;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .promo-section-heading .heading-icon {
        width: 45px;
        height: 45px;
        background: linear-gradient(135deg, #e11d48, #f97316);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-size: 20px;
        box-shadow: 0 4px 12px rgba(225, 29, 72, 0.25);
    }

    .promo-section-sub {
        color: #64748b;
        font-size: 15px;
        margin-bottom: 35px;
        padding-left: 57px;
    }

    /* Empty State */
    .promo-empty {
        text-align: center;
        padding: 60px 20px;
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 16px;
    }

    .promo-empty i {
        font-size: 48px;
        color: #cbd5e1;
        margin-bottom: 15px;
        display: block;
    }

    .promo-empty p {
        color: #94a3b8;
        font-size: 16px;
        margin: 0;
    }

    /* Copy success animation */
    .copy-success {
        animation: copyFlash 0.6s ease;
    }

    @keyframes copyFlash {
        0% { background: linear-gradient(135deg, #fef2f2, #fff1f2); }
        50% { background: linear-gradient(135deg, #dcfce7, #d1fae5); border-color: #22c55e; color: #16a34a; }
        100% { background: linear-gradient(135deg, #fef2f2, #fff1f2); }
    }

    /* Responsive */
    @media (max-width: 768px) {
        .promo-hero h1 {
            font-size: 32px;
        }

        .promo-stats-bar {
            gap: 25px;
        }

        .promo-stat-number {
            font-size: 28px;
        }

        .promo-section-heading {
            font-size: 22px;
        }

        .promo-section-sub {
            padding-left: 0;
        }
    }
</style>

<main class="promo-page">

    <!-- HERO BANNER -->
    <section class="promo-hero">
        <div class="container">
            <h1>Ưu Đãi <span>Đặc Biệt</span></h1>
            <p>Khám phá các chương trình khuyến mãi hấp dẫn từ FPT Cinema. Nhập mã voucher khi đặt vé để nhận ngay ưu đãi!</p>

            <div class="promo-stats-bar">
                <div class="promo-stat-item">
                    <span class="promo-stat-number">${activeVouchers.size()}</span>
                    <span class="promo-stat-label">Voucher đang có</span>
                </div>
                <div class="promo-stat-item">
                    <span class="promo-stat-number">
                        <c:set var="maxDiscount" value="0"/>
                        <c:forEach var="v" items="${activeVouchers}">
                            <c:if test="${v.phanTramGiam > maxDiscount}">
                                <c:set var="maxDiscount" value="${v.phanTramGiam}"/>
                            </c:if>
                        </c:forEach>
                        ${maxDiscount}%
                    </span>
                    <span class="promo-stat-label">Giảm cao nhất</span>
                </div>
                <div class="promo-stat-item">
                    <span class="promo-stat-number">24/7</span>
                    <span class="promo-stat-label">Hỗ trợ</span>
                </div>
            </div>
        </div>
    </section>

    <!-- DANH SÁCH VOUCHER ĐANG HOẠT ĐỘNG -->
    <section class="container" style="margin-top: -40px; position: relative; z-index: 10;">

        <div style="margin-bottom: 50px;">
            <div class="promo-section-heading">
                <div class="heading-icon"></div>
                Voucher đang hoạt động
            </div>
            <p class="promo-section-sub">Sao chép mã và sử dụng khi thanh toán để nhận ưu đãi giảm giá.</p>

            <c:choose>
                <c:when test="${empty activeVouchers}">
                    <div class="promo-empty">
                        <i class="bi bi-ticket-perforated"></i>
                        <p>Hiện tại chưa có chương trình khuyến mãi nào. Hãy quay lại sau nhé!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach var="v" items="${activeVouchers}">
                            <div class="col-lg-4 col-md-6">
                                <div class="voucher-card">
                                    <span class="voucher-status voucher-status-active">Đang hoạt động</span>

                                    <div class="voucher-card-header">
                                        <div class="voucher-discount-badge">
                                            ${v.phanTramGiam}% <small>GIẢM</small>
                                        </div>
                                    </div>

                                    <div class="voucher-card-body">
                                        <div class="voucher-name">${v.tenVoucher}</div>

                                        <div class="voucher-info-row">
                                            <div class="voucher-info-icon">
                                                <i class="bi bi-calendar-event"></i>
                                            </div>
                                            <div>
                                                <div class="voucher-info-label">Thời hạn</div>
                                                <div class="voucher-info-value">
                                                    <c:choose>
                                                        <c:when test="${not empty v.ngayBatDau && not empty v.ngayKetThuc}">
                                                            <fmt:formatDate value="${v.ngayBatDau}" pattern="dd/MM/yyyy"/>
                                                            -
                                                            <fmt:formatDate value="${v.ngayKetThuc}" pattern="dd/MM/yyyy"/>
                                                        </c:when>
                                                        <c:otherwise>17/8/2026</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="voucher-info-row">
                                            <div class="voucher-info-icon">
                                                <i class="bi bi-box-seam"></i>
                                            </div>
                                            <div>
                                                <div class="voucher-info-label">Số lượng còn</div>
                                                <div class="voucher-info-value">${v.soLuong} voucher</div>
                                            </div>
                                        </div>

                                        <c:if test="${v.giamToiDa > 0}">
                                            <div class="voucher-info-row">
                                                <div class="voucher-info-icon">
                                                    <i class="bi bi-cash-stack"></i>
                                                </div>
                                                <div>
                                                    <div class="voucher-info-label">Giảm tối đa</div>
                                                    <div class="voucher-info-value">
                                                        <fmt:formatNumber value="${v.giamToiDa}" pattern="#,###"/>đ
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>

                                        <c:if test="${v.diemDoiVoucher > 0}">
                                            <div class="voucher-info-row">
                                                <div class="voucher-info-icon">
                                                    <i class="bi bi-star-fill"></i>
                                                </div>
                                                <div>
                                                    <div class="voucher-info-label">Điểm đổi</div>
                                                    <div class="voucher-info-value">${v.diemDoiVoucher} điểm</div>
                                                </div>
                                            </div>
                                        </c:if>

                                        <div class="voucher-code-box">
                                            <div class="voucher-code" onclick="copyCode(this, '${v.maCode}')">
                                                ${v.maCode}
                                                <span class="copy-hint">
                                                    <i class="bi bi-clipboard me-1"></i>Nhấn để sao chép mã
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- VOUCHER ĐÃ HẾT HẠN (nếu có) -->
        <c:if test="${not empty expiredVouchers}">
            <div style="margin-top: 60px;">
                <div class="promo-section-heading" style="color: #64748b;">
                    <div class="heading-icon" style="background: linear-gradient(135deg, #94a3b8, #64748b); box-shadow: none;">
                        <i class="bi bi-clock-history"></i>
                    </div>
                    Voucher đã hết hạn / hết lượt
                </div>
                <p class="promo-section-sub">Các chương trình khuyến mãi đã kết thúc.</p>

                <div class="row g-4">
                    <c:forEach var="v" items="${expiredVouchers}">
                        <div class="col-lg-4 col-md-6">
                            <div class="voucher-card expired">
                                <span class="voucher-status voucher-status-expired">Hết hạn</span>

                                <div class="voucher-card-header">
                                    <div class="voucher-discount-badge">
                                        ${v.phanTramGiam}% <small>GIẢM</small>
                                    </div>
                                </div>

                                <div class="voucher-card-body">
                                    <div class="voucher-name">${v.tenVoucher}</div>

                                    <div class="voucher-info-row">
                                        <div class="voucher-info-icon" style="background: #f1f5f9; color: #94a3b8;">
                                            <i class="bi bi-calendar-x"></i>
                                        </div>
                                        <div>
                                            <div class="voucher-info-label">Thời hạn</div>
                                            <div class="voucher-info-value" style="color: #94a3b8;">
                                                <c:choose>
                                                    <c:when test="${not empty v.ngayBatDau && not empty v.ngayKetThuc}">
                                                        <fmt:formatDate value="${v.ngayBatDau}" pattern="dd/MM/yyyy"/>
                                                        -
                                                        <fmt:formatDate value="${v.ngayKetThuc}" pattern="dd/MM/yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>Đã kết thúc</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="voucher-info-row">
                                        <div class="voucher-info-icon" style="background: #f1f5f9; color: #94a3b8;">
                                            <i class="bi bi-box-seam"></i>
                                        </div>
                                        <div>
                                            <div class="voucher-info-label">Số lượng còn</div>
                                            <div class="voucher-info-value" style="color: #94a3b8;">${v.soLuong} voucher</div>
                                        </div>
                                    </div>

                                    <div class="voucher-code-box">
                                        <div class="voucher-code" style="opacity: 0.5; cursor: not-allowed; border-color: #cbd5e1; color: #94a3b8; background: #f8fafc;">
                                            ${v.maCode}
                                            <span class="copy-hint" style="color: #94a3b8;">Mã đã hết hạn sử dụng</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

    </section>

    <!-- HƯỚNG DẪN SỬ DỤNG VOUCHER -->
    <section class="container" style="padding: 60px 0;">
        <div style="background: linear-gradient(135deg, #fff1f2, #fce7f3, #fef2f2); border: 1px solid #fecdd3; border-radius: 20px; padding: 50px 40px;">
            <h3 class="text-center fw-bold mb-2" style="color: #0f172a; font-size: 26px;">
                Hướng dẫn sử dụng Voucher
            </h3>
            <p class="text-center text-muted mb-5" style="max-width: 500px; margin: 0 auto 40px;">
                Chỉ với 3 bước đơn giản để nhận ưu đãi giảm giá khi đặt vé xem phim tại FPT Cinema.
            </p>

            <div class="row g-4 justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <div style="text-align: center; padding: 30px 20px; background: rgba(255,255,255,0.7); border-radius: 16px; border: 1px solid rgba(225,29,72,0.1); transition: transform 0.3s ease;" onmouseover="this.style.transform='translateY(-5px)'" onmouseout="this.style.transform='translateY(0)'">
                        <div style="width: 65px; height: 65px; background: linear-gradient(135deg, #e11d48, #f97316); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; box-shadow: 0 8px 20px rgba(225,29,72,0.2);">
                            <span style="font-size: 28px; color: #fff; font-weight: 800;">1</span>
                        </div>
                        <h5 style="font-weight: 700; color: #0f172a; margin-bottom: 8px;">Chọn mã Voucher</h5>
                        <p style="color: #64748b; font-size: 14px; margin: 0;">Tìm và sao chép mã voucher phù hợp từ danh sách ưu đãi phía trên.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div style="text-align: center; padding: 30px 20px; background: rgba(255,255,255,0.7); border-radius: 16px; border: 1px solid rgba(225,29,72,0.1); transition: transform 0.3s ease;" onmouseover="this.style.transform='translateY(-5px)'" onmouseout="this.style.transform='translateY(0)'">
                        <div style="width: 65px; height: 65px; background: linear-gradient(135deg, #e11d48, #f97316); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; box-shadow: 0 8px 20px rgba(225,29,72,0.2);">
                            <span style="font-size: 28px; color: #fff; font-weight: 800;">2</span>
                        </div>
                        <h5 style="font-weight: 700; color: #0f172a; margin-bottom: 8px;">Đặt vé xem phim</h5>
                        <p style="color: #64748b; font-size: 14px; margin: 0;">Chọn phim yêu thích, suất chiếu và ghế ngồi mong muốn trên hệ thống.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div style="text-align: center; padding: 30px 20px; background: rgba(255,255,255,0.7); border-radius: 16px; border: 1px solid rgba(225,29,72,0.1); transition: transform 0.3s ease;" onmouseover="this.style.transform='translateY(-5px)'" onmouseout="this.style.transform='translateY(0)'">
                        <div style="width: 65px; height: 65px; background: linear-gradient(135deg, #e11d48, #f97316); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; box-shadow: 0 8px 20px rgba(225,29,72,0.2);">
                            <span style="font-size: 28px; color: #fff; font-weight: 800;">3</span>
                        </div>
                        <h5 style="font-weight: 700; color: #0f172a; margin-bottom: 8px;">Nhập mã & Giảm giá</h5>
                        <p style="color: #64748b; font-size: 14px; margin: 0;">Nhập mã voucher vào ô khuyến mãi khi thanh toán để nhận giảm giá ngay.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

<script>
    function copyCode(element, code) {
        // Kiểm tra nếu voucher hết hạn thì không cho copy
        if (element.closest('.expired')) return;

        navigator.clipboard.writeText(code).then(function() {
            // Hiệu ứng copy thành công
            element.classList.add('copy-success');
            var hintEl = element.querySelector('.copy-hint');
            var originalText = hintEl.innerHTML;
            hintEl.innerHTML = '<i class="bi bi-check-circle-fill me-1"></i>Đã sao chép mã thành công!';
            hintEl.style.color = '#16a34a';

            setTimeout(function() {
                element.classList.remove('copy-success');
                hintEl.innerHTML = originalText;
                hintEl.style.color = '';
            }, 2000);
        }).catch(function() {
            // Fallback cho trình duyệt cũ
            var textArea = document.createElement('textarea');
            textArea.value = code;
            document.body.appendChild(textArea);
            textArea.select();
            document.execCommand('copy');
            document.body.removeChild(textArea);

            var hintEl = element.querySelector('.copy-hint');
            hintEl.innerHTML = '<i class="bi bi-check-circle-fill me-1"></i>Đã sao chép!';
            hintEl.style.color = '#16a34a';
            setTimeout(function() {
                hintEl.innerHTML = '<i class="bi bi-clipboard me-1"></i>Nhấn để sao chép mã';
                hintEl.style.color = '';
            }, 2000);
        });
    }
</script>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>