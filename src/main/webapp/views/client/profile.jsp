<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<style>
    .profile-page {
        background-color: #0f172a;
        color: #f8fafc;
        min-height: 90vh;
        padding: 50px 0 80px;
        font-family: 'Inter', system-ui, -apple-system, sans-serif;
    }

    .profile-container {
        max-width: 1100px;
        margin: 0 auto;
        padding: 0 15px;
    }

    .profile-header-card {
        background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        border: 1px solid #334155;
        border-radius: 20px;
        padding: 30px;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        gap: 25px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
    }

    .profile-avatar-wrapper {
        position: relative;
        width: 90px;
        height: 90px;
        background: linear-gradient(135deg, #e11d48, #f97316);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 36px;
        color: #fff;
        font-weight: 700;
        box-shadow: 0 4px 15px rgba(225, 29, 72, 0.4);
    }

    .profile-info-summary h2 {
        font-size: 24px;
        font-weight: 700;
        margin-bottom: 5px;
        color: #fff;
    }

    .points-badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        background: rgba(251, 191, 36, 0.1);
        border: 1px solid rgba(251, 191, 36, 0.3);
        color: #fbbf24;
        padding: 6px 14px;
        border-radius: 9999px;
        font-size: 14px;
        font-weight: 600;
        margin-top: 5px;
    }

    /* CSS Tabs Logic (No JS required) */
    .tab-system {
        display: flex;
        flex-direction: column;
        gap: 30px;
    }

    .tab-navigation {
        display: flex;
        border-bottom: 1px solid #334155;
        gap: 20px;
        padding-bottom: 2px;
    }

    .tab-label {
        color: #94a3b8;
        font-size: 16px;
        font-weight: 600;
        padding: 12px 10px;
        cursor: pointer;
        transition: all 0.3s ease;
        position: relative;
        border-bottom: 2px solid transparent;
    }

    .tab-label:hover {
        color: #fff;
    }

    .tab-input {
        display: none;
    }

    .tab-panel {
        display: none;
        animation: fadeIn 0.4s ease;
    }

    /* CSS selectors to toggle tabs */
    #tab-info-input:checked ~ .tab-navigation label[for="tab-info-input"],
    #tab-password-input:checked ~ .tab-navigation label[for="tab-password-input"],
    #tab-vouchers-input:checked ~ .tab-navigation label[for="tab-vouchers-input"] {
        color: #e11d48;
        border-bottom-color: #e11d48;
    }

    #tab-info-input:checked ~ .tab-content #panel-info,
    #tab-password-input:checked ~ .tab-content #panel-password,
    #tab-vouchers-input:checked ~ .tab-content #panel-vouchers {
        display: block;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .profile-card {
        background: #1e293b;
        border: 1px solid #334155;
        border-radius: 16px;
        padding: 30px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-label {
        display: block;
        color: #94a3b8;
        font-size: 14px;
        font-weight: 600;
        margin-bottom: 8px;
    }

    .form-input {
        width: 100%;
        background-color: #0f172a;
        border: 1px solid #334155;
        border-radius: 10px;
        padding: 12px 16px;
        color: #fff;
        font-size: 15px;
        transition: all 0.3s ease;
    }

    .form-input:focus {
        border-color: #e11d48;
        outline: none;
        box-shadow: 0 0 0 3px rgba(225, 29, 72, 0.2);
    }

    .form-select {
        appearance: none;
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%2394a3b8' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 16px center;
        background-size: 12px 12px;
    }

    .btn-submit {
        background: #e11d48;
        color: #fff;
        font-weight: 600;
        border: none;
        border-radius: 10px;
        padding: 12px 30px;
        transition: all 0.3s ease;
    }

    .btn-submit:hover {
        background: #f43f5e;
        transform: translateY(-2px);
    }

    /* Voucher styles */
    .voucher-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 20px;
    }

    .voucher-card {
        background: #0f172a;
        border: 1px solid #334155;
        border-radius: 16px;
        padding: 20px;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        position: relative;
        overflow: hidden;
        transition: all 0.3s ease;
    }

    .voucher-card::before {
        content: '';
        position: absolute;
        left: 0;
        top: 0;
        bottom: 0;
        width: 6px;
        background: linear-gradient(to bottom, #e11d48, #f97316);
    }

    .voucher-card:hover {
        transform: translateY(-4px);
        border-color: #475569;
    }

    .voucher-badge {
        align-self: flex-start;
        background: rgba(225, 29, 72, 0.1);
        color: #f43f5e;
        border: 1px solid rgba(225, 29, 72, 0.2);
        padding: 4px 10px;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 700;
        margin-bottom: 15px;
    }

    .voucher-title {
        color: #fff;
        font-size: 18px;
        font-weight: 700;
        margin-bottom: 8px;
    }

    .voucher-desc {
        color: #94a3b8;
        font-size: 13px;
        line-height: 1.5;
        margin-bottom: 15px;
    }

    .voucher-footer {
        display: flex;
        align-items: center;
        justify-content: space-between;
        border-top: 1px solid #334155;
        padding-top: 15px;
        margin-top: auto;
    }

    .voucher-points {
        display: flex;
        flex-direction: column;
    }

    .voucher-points-label {
        font-size: 11px;
        color: #64748b;
        text-transform: uppercase;
        font-weight: 700;
    }

    .voucher-points-value {
        font-size: 16px;
        color: #fbbf24;
        font-weight: 700;
    }

    .btn-redeem {
        background: #fbbf24;
        color: #0f172a;
        font-weight: 700;
        border: none;
        border-radius: 8px;
        padding: 8px 18px;
        font-size: 13px;
        transition: all 0.3s ease;
    }

    .btn-redeem:hover:not(:disabled) {
        background: #f59e0b;
        transform: scale(1.05);
    }

    .btn-redeem:disabled {
        background: #334155;
        color: #64748b;
        cursor: not-allowed;
    }
</style>

<main class="profile-page">
    <div class="profile-container">

        <!-- Status Alerts -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" style="background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); color: #f87171; border-radius: 12px; padding: 15px 20px;">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close" style="top: 50%; transform: translateY(-50%);"></button>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert" style="background: rgba(16, 185, 129, 0.1); border: 1px solid rgba(16, 185, 129, 0.3); color: #34d399; border-radius: 12px; padding: 15px 20px;">
                <i class="bi bi-check-circle-fill me-2"></i>${success}
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close" style="top: 50%; transform: translateY(-50%);"></button>
            </div>
        </c:if>

        <!-- User Summary Card -->
        <div class="profile-header-card">
            <div class="profile-avatar-wrapper">
                <i class="bi bi-person-fill"></i>
            </div>
            <div class="profile-info-summary">
                <h2>${user.hoTen}</h2>
                <div style="color: #94a3b8; font-size: 14px;">
                    <i class="bi bi-envelope me-2"></i>${user.email}
                </div>
                <div class="points-badge">
                    <i class="bi bi-gem"></i>
                    <span>Điểm Tích Lũy: ${user.diemTichLuy}</span>
                </div>
            </div>
        </div>

        <!-- Tab Panel System -->
        <div class="tab-system">
            <input type="radio" name="profile-tabs" id="tab-info-input" class="tab-input" checked>
            <input type="radio" name="profile-tabs" id="tab-password-input" class="tab-input">
            <input type="radio" name="profile-tabs" id="tab-vouchers-input" class="tab-input">

            <div class="tab-navigation">
                <label for="tab-info-input" class="tab-label">
                    <i class="bi bi-person-badge me-2"></i>Thông Tin Cá Nhân
                </label>
                <label for="tab-password-input" class="tab-label">
                    <i class="bi bi-shield-lock me-2"></i>Đổi Mật Khẩu
                </label>
                <label for="tab-vouchers-input" class="tab-label">
                    <i class="bi bi-ticket-perforated me-2"></i>Đổi Voucher
                </label>
            </div>

            <div class="tab-content">
                <!-- Panel 1: Update Info -->
                <div class="tab-panel" id="panel-info">
                    <div class="profile-card">
                        <h4 style="color: #fff; font-weight: 700; margin-bottom: 25px;">Cập Nhật Thông Tin Cá Nhân</h4>
                        <form action="${pageContext.request.contextPath}/profile" method="POST">
                            <input type="hidden" name="action" value="updateInfo">

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="fullName">Họ và Tên</label>
                                        <input type="text" id="fullName" name="fullName" class="form-input" value="${user.hoTen}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="phone">Số Điện Thoại</label>
                                        <input type="tel" id="phone" name="phone" class="form-input" value="${user.soDienThoai}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label class="form-label" for="email">Địa Chỉ Email</label>
                                        <input type="email" id="email" name="email" class="form-input" value="${user.email}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="ngaySinh">Ngày Sinh</label>
                                        <input type="date" id="ngaySinh" name="ngaySinh" class="form-input" value="${user.ngaySinh}">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label class="form-label" for="gioiTinh">Giới Tính</label>
                                        <select id="gioiTinh" name="gioiTinh" class="form-input form-select">
                                            <option value="Nam" ${user.gioiTinh == 'Nam' ? 'selected' : ''}>Nam</option>
                                            <option value="Nữ" ${user.gioiTinh == 'Nữ' ? 'selected' : ''}>Nữ</option>
                                            <option value="Khác" ${user.gioiTinh == 'Khác' ? 'selected' : ''}>Khác</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="text-end mt-4">
                                <button type="submit" class="btn-submit">Lưu Thay Đổi</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Panel 2: Change Password -->
                <div class="tab-panel" id="panel-password">
                    <div class="profile-card">
                        <h4 style="color: #fff; font-weight: 700; margin-bottom: 25px;">Đổi Mật Khẩu Tài Khoản</h4>
                        <form action="${pageContext.request.contextPath}/profile" method="POST">
                            <input type="hidden" name="action" value="changePassword">

                            <div class="form-group">
                                <label class="form-label" for="currentPassword">Mật Khẩu Hiện Tại</label>
                                <input type="password" id="currentPassword" name="currentPassword" class="form-input" placeholder="••••••••" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="newPassword">Mật Khẩu Mới</label>
                                <input type="password" id="newPassword" name="newPassword" class="form-input" placeholder="••••••••" required>
                            </div>

                            <div class="form-group">
                                <label class="form-label" for="confirmPassword">Xác Nhận Mật Khẩu Mới</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" placeholder="••••••••" required>
                            </div>

                            <div class="text-end mt-4">
                                <button type="submit" class="btn-submit">Đổi Mật Khẩu</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Panel 3: Redeem Vouchers -->
                <div class="tab-panel" id="panel-vouchers">
                    <div class="profile-card">
                        <h4 style="color: #fff; font-weight: 700; margin-bottom: 10px;">Quy Đổi Điểm Thưởng</h4>
                        <p style="color: #94a3b8; font-size: 14px; margin-bottom: 30px;">
                            Hãy quy đổi điểm tích lũy của bạn lấy các voucher ưu đãi hấp dẫn áp dụng trực tiếp cho hóa đơn vé & combo bắp nước!
                        </p>

                        <c:choose>
                            <c:when test="${empty listVouchers}">
                                <div class="text-center py-5" style="border: 1px dashed #334155; border-radius: 12px;">
                                    <i class="bi bi-ticket-detailed" style="font-size: 40px; color: #475569;"></i>
                                    <p class="text-muted mt-2">Hiện tại không có chương trình ưu đãi đổi voucher nào khả dụng.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="voucher-grid">
                                    <c:forEach var="v" items="${listVouchers}">
                                        <div class="voucher-card">
                                            <div>
                                                <div class="voucher-badge">GIẢM ${v.phanTramGiam}%</div>
                                                <div class="voucher-title">${v.tenVoucher}</div>
                                                <div class="voucher-desc">
                                                    Giảm tối đa lên tới <strong><fmt:formatNumber value="${v.giamToiDa}" pattern="#,###"/>đ</strong>. 
                                                    Hạn sử dụng: từ <fmt:formatDate value="${v.ngayBatDau}" pattern="dd/MM/yyyy"/> đến <fmt:formatDate value="${v.ngayKetThuc}" pattern="dd/MM/yyyy"/>.
                                                </div>
                                            </div>
                                            <div class="voucher-footer">
                                                <div class="voucher-points">
                                                    <span class="voucher-points-label">Điểm Quy Đổi</span>
                                                    <span class="voucher-points-value">${v.diemDoiVoucher} Điểm</span>
                                                </div>
                                                <form action="${pageContext.request.contextPath}/profile" method="POST" style="margin: 0;">
                                                    <input type="hidden" name="action" value="redeemVoucher">
                                                    <input type="hidden" name="maVoucher" value="${v.maVoucher}">
                                                    <button type="submit" class="btn-redeem" ${user.diemTichLuy < v.diemDoiVoucher ? 'disabled' : ''}>
                                                        ${user.diemTichLuy < v.diemDoiVoucher ? 'Chưa đủ điểm' : 'Đổi Ngay'}
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

    </div>
</main>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>
