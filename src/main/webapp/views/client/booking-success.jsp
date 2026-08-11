<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<section class="container" style="padding-top: 80px; padding-bottom: 80px; min-height: 70vh; display: flex; align-items: center; justify-content: center;">

    <div class="card shadow-lg text-center" style="max-width: 600px; width: 100%; border: 1px solid var(--border); background: var(--surface); border-radius: 20px; padding: 40px;">
        
        <div style="font-size: 72px; color: #2ec4b6;" class="mb-3">
            <i class="bi bi-check2-circle"></i>
        </div>

        <h2 style="color: #fff; font-weight: 700; font-size: 32px;" class="mb-3">
            Đặt vé thành công!
        </h2>

        <p style="color: var(--text-muted); font-size: 16px; line-height: 1.6;" class="mb-4">
            Cảm ơn bạn đã lựa chọn FPT Cinema. Ghế của bạn đã được hệ thống tạm thời giữ thành công.
        </p>

        <!-- Ticket Card Info -->
        <div class="p-4 mb-4" style="background: var(--bg); border: 1px dashed #ffc107; border-radius: 15px;">
            <div style="color: #ffc107; font-size: 13px; font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px; margin-bottom: 8px;">
                Mã xác nhận giữ ghế
            </div>
            <div style="color: #fff; font-size: 36px; font-weight: 800; letter-spacing: 4px;" class="mb-2">
                <c:out value="${param.maDatVe}" default="DVXX"/>
            </div>
            <div style="color: var(--text-muted); font-size: 12px;">
                (Vui lòng cung cấp mã này tại quầy vé)
            </div>
        </div>

        <!-- Warning Alert -->
        <div class="alert alert-danger d-flex align-items-start text-start p-3 mb-4" style="border-radius: 12px; background: rgba(220, 53, 69, 0.1); border: 1px solid rgba(220, 53, 69, 0.2); color: #ea868f;">
            <i class="bi bi-exclamation-triangle-fill fs-4 me-3 mt-1 text-danger"></i>
            <div>
                <strong style="color: #fff; font-size: 15px; display: block;" class="mb-1">Lưu ý quan trọng:</strong>
                <span style="font-size: 13.5px; line-height: 1.5; display: block;">
                    Bạn cần đến quầy vé tại rạp trước giờ chiếu <strong>60 phút</strong> để thanh toán bằng tiền mặt hoặc quẹt thẻ và lấy vé cứng. 
                    Sau thời gian này, các ghế chưa thanh toán sẽ tự động được giải phóng.
                </span>
            </div>
        </div>

        <div class="d-flex gap-3 justify-content-center">
            <a href="${pageContext.request.contextPath}/history" class="btn btn-warning btn-lg" style="border-radius: 12px; padding: 12px 30px; font-size: 16px; font-weight: 700;">
                <i class="bi bi-clock-history me-2"></i>Xem lịch sử đặt vé
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary btn-lg" style="border-radius: 12px; padding: 12px 30px; font-size: 16px; font-weight: 700; color: #fff; border-color: var(--border);">
                Quay lại Trang chủ
            </a>
        </div>

    </div>

</section>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>