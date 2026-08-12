<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<style>
    /* Premium Light Cinema Gradient Background */
    body {
        background: radial-gradient(circle at top, #ffffff 0%, #f1f5f9 60%, #e2e8f0 100%) !important;
        color: #0f172a !important;
    }

    /* Mockup Cinema Movie Cards */
    .mockup-movie-grid {
        display: flex;
        justify-content: center;
        gap: 20px;
        flex-wrap: wrap;
        margin-top: 40px;
    }

    .mockup-movie-card {
        width: 220px;
        background: transparent;
        border: none;
        transition: transform 0.3s ease;
        text-decoration: none !important;
        display: block;
    }

    .mockup-movie-card:hover {
        transform: translateY(-8px);
    }

    .mockup-poster-wrapper {
        position: relative;
        width: 100%;
        height: 330px;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        border: 2px solid rgba(0,0,0,0.05);
        transition: all 0.3s ease;
    }

    .mockup-movie-card:hover .mockup-poster-wrapper {
        border-color: #fbbf24;
        box-shadow: 0 8px 30px rgba(251, 191, 36, 0.3);
    }

    .mockup-poster-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .mockup-rating-badge {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 55px;
        height: 55px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.95);
        border: 2px solid #fbbf24;
        color: #0f172a;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 16px;
        box-shadow: 0 0 15px rgba(251, 191, 36, 0.4);
    }

    .mockup-movie-info {
        text-align: center;
        margin-top: 15px;
    }

    .mockup-movie-title {
        color: #0f172a;
        font-size: 16px;
        font-weight: 700;
        margin-bottom: 5px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .mockup-movie-meta {
        color: #fbbf24;
        font-size: 13px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    /* Tagline Box */
    .mockup-tagline-box {
        background: #ffffff;
        color: #0f172a;
        text-align: center;
        padding: 22px;
        font-weight: 700;
        font-size: 18px;
        border-radius: 12px;
        margin: 60px auto 40px;
        max-width: 900px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        border-left: 6px solid #fbbf24;
    }

    /* Food Menu Style */
    .food-menu-container {
        background: rgba(255, 255, 255, 0.6);
        border: 1px solid rgba(0, 0, 0, 0.08);
        border-radius: 24px;
        padding: 40px;
        backdrop-filter: blur(12px);
        margin-top: 60px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
    }

    .food-menu-item {
        background: rgba(255, 255, 255, 0.9);
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        padding: 20px;
        display: flex;
        align-items: center;
        gap: 15px;
        transition: all 0.3s ease;
    }

    .food-menu-item:hover {
        transform: translateY(-4px);
        border-color: #fbbf24;
        box-shadow: 0 8px 20px rgba(251, 191, 36, 0.15);
    }
</style>

<!-- ==========================
     HERO SLIDER
========================== -->
<div id="movieCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#movieCarousel" data-bs-slide-to="0" class="active"></button>
        <button type="button" data-bs-target="#movieCarousel" data-bs-slide-to="1"></button>
        <button type="button" data-bs-target="#movieCarousel" data-bs-slide-to="2"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1600" class="hero-image d-block w-100" alt="Avengers Endgame Banner">
            <div class="carousel-caption hero-content">
                <span class="badge bg-danger fs-6 mb-3">HOT MOVIE</span>
                <h1>THE REVENANT</h1>
                <p>Blood Lost. Life Found. Trải nghiệm điện ảnh đỉnh cao tại FPT CINEMA.</p>
                <a href="${pageContext.request.contextPath}/booking?maSuatChieu=SC01" class="btn btn-warning btn-lg me-2">Đặt vé ngay</a>
                <a href="#" class="btn btn-outline-light btn-lg">Trailer</a>
            </div>
        </div>
        <div class="carousel-item">
            <img src="https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=1600" class="hero-image d-block w-100" alt="Conan Banner">
            <div class="carousel-caption hero-content">
                <span class="badge bg-primary fs-6 mb-3">ANIME HIT</span>
                <h1>DETECTIVE CONAN</h1>
                <p>Hành trình phá án nghẹt thở của thám tử lừng danh Conan.</p>
                <a href="${pageContext.request.contextPath}/booking?maSuatChieu=SC03" class="btn btn-warning btn-lg me-2">Đặt vé ngay</a>
            </div>
        </div>
        <div class="carousel-item">
            <img src="https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=1600" class="hero-image d-block w-100" alt="Sci Fi Banner">
            <div class="carousel-caption hero-content">
                <span class="badge bg-success fs-6 mb-3">NOW SHOWING</span>
                <h1>AVATAR 3: FIRE & ASH</h1>
                <p>Kháp phá bộ tộc tro tàn kỳ bí trên hành tinh Pandora xinh đẹp.</p>
                <a href="${pageContext.request.contextPath}/booking?maSuatChieu=SC02" class="btn btn-warning btn-lg me-2">Đặt vé ngay</a>
            </div>
        </div>
    </div>
</div>

<!-- ==========================
     SEARCH BAR
========================== -->
<section class="container" style="padding: 40px 0 20px;">
    <div class="movie-search-box" style="margin-top: -80px;">
        <div class="row g-3">
            <div class="col-lg-3">
                <label class="form-label">Thể loại</label>
                <select class="form-select" name="maTheLoai">
                    <option value="">Tất cả</option>
                    <c:forEach var="tl" items="${listTheLoai}">
                        <c:if test="${not tl.tenTheLoai.contains('(Đã khóa)')}">
                            <option value="${tl.maTheLoai}">${tl.tenTheLoai}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
            <div class="col-lg-3">
                <label class="form-label">Rạp</label>
                <select class="form-select" name="maRap">
                    <option value="">Tất cả rạp</option>
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

<!-- ==========================
     MOVIES LIST (MOCKUP CINEMA STYLE)
========================== -->
<section class="container" style="padding: 40px 0;">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <h2 class="section-title m-0" style="font-weight: 800; font-size: 32px;">🎬 PHIM ĐANG CHIẾU</h2>
        <a href="${pageContext.request.contextPath}/movies" class="btn btn-outline-warning" style="border-radius: 8px; font-weight: 600; padding: 8px 20px;">Xem tất cả</a>
    </div>

    <div class="mockup-movie-grid">
        <c:forEach var="m" items="${listPhim}">
            <a href="${pageContext.request.contextPath}/movies?action=detail&id=${m.maPhim}" class="mockup-movie-card">
                <div class="mockup-poster-wrapper">
                    <img src="<c:choose>
                         <c:when test="${not empty m.poster}">${m.poster}</c:when>
                         <c:when test="${m.maPhim == 'M01'}">https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=400</c:when>
                         <c:when test="${m.maPhim == 'M02'}">https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=400</c:when>
                         <c:otherwise>https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=400</c:otherwise>
                     </c:choose>" 
                     class="mockup-poster-img" 
                     alt="${m.tenPhim}">
                    <div class="mockup-rating-badge">
                        <c:choose>
                            <c:when test="${m.maPhim == 'M01'}">⭐ 9.2</c:when>
                            <c:when test="${m.maPhim == 'M02'}">⭐ 8.8</c:when>
                            <c:otherwise>⭐ 9.0</c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="mockup-movie-info">
                    <div class="mockup-movie-title">${m.tenPhim}</div>
                    <div class="mockup-movie-meta">${m.doTuoiGiaiTri} • ${m.thoiLuong} phút</div>
                </div>
            </a>
        </c:forEach>
    </div>

    <!-- Tagline styled exactly as design requirement -->
    <div class="mockup-tagline-box">
        Độc quyền cung cấp phim Điện Ảnh Chiếu Rạp Quyền Sau Rạp
    </div>
</section>

<!-- ==========================
     FOOD & BEVERAGES MENU
========================== -->
<section class="container" style="padding: 20px 0 80px;">
    <div class="food-menu-container">
        <h2 class="text-center mb-4 fw-bold" style="color: #fbbf24; font-size: 28px;">
            <i class="bi bi-cup-straw me-2 text-warning"></i>QUẦY COMBO BẮP NƯỚC ONLINE
        </h2>
        <p class="text-center text-muted mb-5" style="max-width: 600px; margin: 0 auto 40px;">
            Hệ thống giá tiền đồ ăn thức uống được cập nhật mới nhất. Khách hàng có thể dễ dàng đặt mua kèm vé xem phim để nhận chiết khấu!
        </p>
        
        <c:choose>
            <c:when test="${empty listFoods}">
                <p class="text-center text-muted">Hiện tại chưa có menu đồ ăn uống.</p>
            </c:when>
            <c:otherwise>
                <div class="row g-4 justify-content-center">
                    <c:forEach var="food" items="${listFoods}">
                        <div class="col-lg-4 col-md-6">
                            <div class="food-menu-item">
                                <div style="width: 55px; height: 55px; background: linear-gradient(135deg, #e11d48, #f97316); border-radius: 12px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; box-shadow: 0 4px 10px rgba(225, 29, 72, 0.2);">
                                    <i class="bi bi-basket3-fill" style="font-size: 22px; color: #fff;"></i>
                                </div>
                                <div style="flex-grow: 1; min-width: 0;">
                                    <h5 style="color: #0f172a; font-size: 15px; font-weight: 600; margin: 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${food.tenDoAn}</h5>
                                    <p style="color: #ea580c; font-weight: 700; font-size: 16px; margin: 5px 0 0 0;">
                                        <fmt:formatNumber value="${food.gia}" pattern="#,###"/>đ
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>
