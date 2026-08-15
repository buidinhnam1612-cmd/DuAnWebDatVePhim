<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<section class="container py-5">

    <div class="text-center">
        <h1 class="fw-bold">📞 Liên hệ FPT CINEMA</h1>
        <p class="text-muted">Chúng tôi luôn sẵn sàng hỗ trợ bạn</p>
    </div>

    <div class="row mt-5">

        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-body">
                    <h4>Thông tin liên hệ</h4>
                    <p>📍 Hà Nội</p>
                    <p>☎ Hotline: 1900 9999</p>
                    <p>✉ Email: support@fptcinema.com</p>
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-body">
                    <h4>Gửi phản hồi</h4>

                    <!-- Hiển thị thông báo thành công hoặc thất bại -->
                    <c:if test="${not empty messageSuccess}">
                        <div class="alert alert-success">${messageSuccess}</div>
                    </c:if>
                    <c:if test="${not empty messageError}">
                        <div class="alert alert-danger">${messageError}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/contact" method="POST">
                        <input class="form-control mb-3" name="hoTen" placeholder="Họ tên" required>
                        <input class="form-control mb-3" type="email" name="email" placeholder="Email" required>
                        <textarea class="form-control mb-3" name="noiDung" rows="4" placeholder="Nội dung" required></textarea>

                        <button type="submit" class="btn btn-danger w-100">Gửi</button>
                    </form>
                </div>
            </div>
        </div>

    </div>

</section>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>