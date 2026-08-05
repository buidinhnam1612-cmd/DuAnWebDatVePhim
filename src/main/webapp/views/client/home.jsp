<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- THÊM DÒNG KHAI BÁO THƯ VIỆN JSTL DƯỚI ĐÂY --%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<!-- ==========================
     HERO SLIDER
========================== -->
<div id="movieCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
    <!-- Giữ nguyên toàn bộ phần slider của bạn không thay đổi -->
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#movieCarousel" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#movieCarousel" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#movieCarousel" data-bs-slide-to="2"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=1600" class="hero-image d-block w-100" alt="Banner">
            <div class="carousel-caption hero-content">
                <span class="badge bg-danger fs-6 mb-3">HOT MOVIE</span>
                <h1>DUNE</h1>
                <p>Trải nghiệm điện ảnh đỉnh cao tại FPT CINEMA.</p>
                <a href="#" class="btn btn-warning btn-lg me-2">Đặt vé ngay</a>
                <a href="#" class="btn btn-outline-light btn-lg">Trailer</a>
            </div>
        </div>
        <div class="carousel-item">
            <img src="https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?q=80&w=1600" class="hero-image d-block w-100" alt="Banner">
            <div class="carousel-caption hero-content">
                <span class="badge bg-primary fs-6 mb-3">NEW</span>
                <h1>AVATAR 3</h1>
                <p>Hành trình mới trên hành tinh Pandora.</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1600" class="hero-image d-block w-100" alt="Banner">
            <div class="carousel-caption hero-content">
                <span class="badge bg-success fs-6 mb-3">NOW SHOWING</span>
                <h1>SPIDER MAN</h1>
                <p>Đặt vé nhanh - Giá tốt - Chất lượng cao.</p>
            </div>
        </div>
    </div>
</div>

<!-- ==========================
     SEARCH (ĐÃ SỬA THÀNH DỮ LIỆU ĐỘNG)
========================== -->
<section class="container">
    <div class="movie-search-box">
        <div class="row g-3">

            <!-- Ô CHỌN THỂ LOẠI PHIM -->
            <div class="col-lg-3">
                <label class="form-label">Thể loại</label>
                <select class="form-select" name="maTheLoai">
                    <option value="">Tất cả</option>
                    <%-- Duyệt danh sách thể loại từ Database --%>
                    <c:forEach var="tl" items="${listTheLoai}">
                        <%-- Loại bỏ những thể loại đã bị gắn thẻ (Đã khóa) --%>
                        <c:if test="${not tl.tenTheLoai.contains('(Đã khóa)')}">
                            <option value="${tl.maTheLoai}">${tl.tenTheLoai}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>

            <!-- Ô CHỌN RẠP CHIẾU PHIM -->
            <div class="col-lg-3">
                <label class="form-label">Rạp</label>
                <select class="form-select" name="maRap">
                    <option value="">Tất cả rạp</option>
                    <%-- Duyệt danh sách rạp từ Database --%>
                    <c:forEach var="r" items="${listRap}">
                        <option value="${r.maRap}">${r.tenRap}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="col-lg-3">
                <label class="form-label">Ngày chiếu</label>
                <input type="date" class="form-control">
            </div>

            <div class="col-lg-3 d-grid">
                <label class="form-label">&nbsp;</label>
                <button class="btn btn-danger">
                    <i class="bi bi-search me-2"></i> TÌM KIẾM
                </button>
            </div>

        </div>
    </div>
</section>

<!-- Giữ nguyên toàn bộ phần danh sách Phim đang chiếu ở phía bên dưới của bạn -->
<section class="container">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <h2 class="section-title">🎬 Phim đang chiếu</h2>
        <a href="${pageContext.request.contextPath}/movies" class="btn btn-outline-warning">Xem tất cả</a>
    </div>
    <div class="row g-4">
        <!-- Các thẻ phim tĩnh giữ nguyên -->
        <div class="col-lg-3 col-md-6">
            <div class="movie-card">
                <img src="https://picsum.photos/300/450?random=1" alt="Avatar 3">
                <div class="card-body">
                    <h5>Avatar 3</h5>
                    <p>Viễn tưởng • 150 phút</p>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="badge bg-warning text-dark">⭐ 9.2</span>
                        <span class="text-danger fw-bold">Đang chiếu</span>
                    </div>
                    <a href="#" class="btn btn-danger w-100">Đặt vé</a>
                </div>
            </div>
        </div>
        <!-- Thẻ phim số 2 -->
        <div class="col-lg-3 col-md-6">
            <div class="movie-card">
                <img src="https://picsum.photos/300/450?random=2" alt="Spider Man">
                <div class="card-body">
                    <h5>Spider Man</h5>
                    <p>Hành động • 135 phút</p>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="badge bg-warning text-dark">⭐ 9.0</span>
                        <span class="text-danger fw-bold">Đang chiếu</span>
                    </div>
                    <a href="#" class="btn btn-danger w-100">Đặt vé</a>
                </div>
            </div>
        </div>
        <!-- Thẻ phim số 3 -->
        <div class="col-lg-3 col-md-6">
            <div class="movie-card">
                <img src="https://picsum.photos/300/450?random=3" alt="Mission Impossible">
                <div class="card-body">
                    <h5>Mission Impossible</h5>
                    <p>Phiêu lưu • 142 phút</p>
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <span class="badge bg-warning text-dark">⭐ 8.8</span>
                        <span class="text-danger fw-bold">Đang chiếu</span>
                    </div>
                    <a href="#" class="btn btn-danger w-100">Đặt vé</a>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
