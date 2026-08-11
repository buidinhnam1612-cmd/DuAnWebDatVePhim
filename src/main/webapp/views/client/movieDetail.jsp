<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<style>
    .movie-detail-page {
        background-color: #0f172a;
        color: #f8fafc;
        min-height: 90vh;
        padding-bottom: 60px;
    }
    .movie-detail-banner {
        position: relative;
        padding: 80px 0;
        background: linear-gradient(to bottom, rgba(15, 23, 42, 0.8), #0f172a), 
                    url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=1200') no-repeat center center;
        background-size: cover;
    }
    .movie-detail-poster {
        border: 4px solid #334155;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        width: 100%;
        max-width: 320px;
    }
    .movie-detail-title {
        font-size: 36px;
        font-weight: 800;
        margin-bottom: 15px;
        color: #fff;
    }
    .movie-detail-description {
        font-size: 16px;
        color: #cbd5e1;
        line-height: 1.6;
        margin-bottom: 25px;
    }
    .movie-info-item {
        background-color: #1e293b;
        border: 1px solid #334155;
        border-radius: 12px;
        padding: 15px 20px;
        margin-bottom: 15px;
    }
    .movie-info-label {
        font-size: 12px;
        text-transform: uppercase;
        color: #94a3b8;
        font-weight: 700;
        letter-spacing: 1px;
    }
    .movie-info-value {
        font-size: 16px;
        font-weight: 600;
        color: #fff;
        margin-top: 5px;
    }
    .section-detail-title {
        font-size: 24px;
        font-weight: 700;
        border-left: 5px solid #e11d48;
        padding-left: 15px;
        margin-bottom: 25px;
        color: #fff;
    }
    .showtime-btn:hover {
        background-color: #e11d48 !important;
        border-color: #e11d48 !important;
        box-shadow: 0 0 10px rgba(225, 29, 72, 0.3) !important;
        transform: translateY(-2px);
    }
    .comment-item {
        background: #1e293b;
        border: 1px solid #334155;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 15px;
        transition: border-color 0.2s ease;
    }
    .comment-item:hover {
        border-color: #e11d48;
    }
</style>

<main class="movie-detail-page">

    <!-- HERO / BANNER -->
    <section class="movie-detail-banner">
        <div class="container">
            <div class="row align-items-center">
                <!-- POSTER -->
                <div class="col-lg-4 text-center mb-4 mb-lg-0">
                    <img src="<c:choose>
                             <c:when test="${movie.maPhim == 'M01'}">https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=400</c:when>
                             <c:when test="${movie.maPhim == 'M02'}">https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=400</c:when>
                             <c:otherwise>https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=400</c:otherwise>
                          </c:choose>"
                         class="movie-detail-poster"
                         alt="${movie.tenPhim}">
                </div>

                <!-- INFO -->
                <div class="col-lg-8">
                    <div class="mb-3">
                        <span class="badge bg-warning text-dark me-2">IMAX</span>
                        <span class="badge border text-white">${movie.doTuoiGiaiTri}</span>
                    </div>
                    <h1 class="movie-detail-title">${movie.tenPhim}</h1>
                    <p class="movie-detail-description">${movie.moTa}</p>
                    
                    <div class="row">
                        <div class="col-md-4 col-sm-6">
                            <div class="movie-info-item">
                                <div class="movie-info-label">Thời lượng</div>
                                <div class="movie-info-value">${movie.thoiLuong} phút</div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="movie-info-item">
                                <div class="movie-info-label">Độ tuổi</div>
                                <div class="movie-info-value">${movie.doTuoiGiaiTri}</div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-6">
                            <div class="movie-info-item">
                                <div class="movie-info-label">Trạng thái</div>
                                <div class="movie-info-value">${movie.trangThai}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- BOOKING AREA (LỊCH CHIẾU VÀ SUẤT CHIẾU) -->
    <section class="container py-5">
        <h2 class="section-detail-title">📅 Chọn suất chiếu để đặt vé</h2>
        <c:choose>
            <c:when test="${empty listSuatChieu}">
                <div class="text-center py-4" style="background: #1e293b; border: 1px solid #334155; border-radius: 12px;">
                    <i class="bi bi-calendar-x" style="font-size: 32px; color: #64748b;"></i>
                    <p class="mt-2 text-muted m-0">Phim hiện tại chưa có lịch chiếu mới.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="showtime-grid" style="display: flex; flex-wrap: wrap; gap: 15px;">
                    <c:forEach var="sc" items="${listSuatChieu}">
                        <a href="${pageContext.request.contextPath}/booking?maSuatChieu=${sc.maSuatChieu}" 
                           class="showtime-btn" 
                           style="background: #1e293b; border: 1px solid #334155; color: #fff; padding: 12px 24px; border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-block; transition: all 0.2s ease;">
                            <i class="bi bi-clock me-2 text-danger"></i>${sc.gioBatDau} (${sc.ngayChieu})
                        </a>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </section>

    <!-- REVIEW / BINH LUAN -->
    <section class="container py-4">
        <div class="row g-5">
            <!-- LIST COMMENTS -->
            <div class="col-lg-7">
                <h2 class="section-detail-title">💬 Đánh giá từ khách hàng</h2>
                <c:choose>
                    <c:when test="${empty listBinhLuan}">
                        <p class="text-muted">Chưa có bình luận nào cho phim này. Hãy là người đầu tiên đánh giá!</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="bl" items="${listBinhLuan}">
                            <div class="comment-item shadow-sm">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <strong style="color: #fff; font-size: 16px;">
                                        <i class="bi bi-person-fill text-muted me-2"></i>${bl.tenKhachHang}
                                    </strong>
                                    <span style="color: #ffc107; font-size: 14px;">
                                        <c:forEach begin="1" end="${bl.soSao}">⭐</c:forEach>
                                    </span>
                                </div>
                                <p class="m-0" style="color: #cbd5e1; font-size: 15px; line-height: 1.5;">${bl.noiDung}</p>
                                <div class="text-end mt-2">
                                    <small class="text-muted" style="font-size: 11px;">${bl.ngayTao}</small>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- FORM WRITE COMMENT -->
            <div class="col-lg-5">
                <h2 class="section-detail-title">✏️ Viết bình luận của bạn</h2>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <form action="${pageContext.request.contextPath}/comment" method="post" style="background: #1e293b; border: 1px solid #334155; border-radius: 12px; padding: 25px;">
                            <input type="hidden" name="maPhim" value="${movie.maPhim}">
                            <div class="mb-3">
                                <label class="form-label" style="color: #94a3b8; font-weight: 600;">Đánh giá phim (Số sao):</label>
                                <select name="soSao" class="form-select" style="background: #0f172a; border: 1px solid #334155; color: #fff; width: 100%; border-radius: 8px; height: 45px;">
                                    <option value="5">⭐⭐⭐⭐⭐ (5 sao) - Cực phẩm</option>
                                    <option value="4">⭐⭐⭐⭐ (4 sao) - Rất hay</option>
                                    <option value="3">⭐⭐⭐ (3 sao) - Bình thường</option>
                                    <option value="2">⭐⭐ (2 sao) - Tệ</option>
                                    <option value="1">⭐ (1 sao) - Quá tệ</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label" style="color: #94a3b8; font-weight: 600;">Ý kiến đóng góp:</label>
                                <textarea name="noiDung" rows="4" class="form-control" placeholder="Chia sẻ trải nghiệm của bạn về bộ phim..." required style="background: #0f172a; border: 1px solid #334155; color: #fff; border-radius: 8px;"></textarea>
                            </div>
                            <button type="submit" class="btn btn-danger w-100" style="background: #e11d48; border: none; font-weight: 600; padding: 12px; border-radius: 8px; transition: background-color 0.2s ease;">
                                <i class="bi bi-send-fill me-2"></i>Gửi đánh giá
                            </button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5" style="background: #1e293b; border: 1px solid #334155; border-radius: 12px; padding: 30px;">
                            <i class="bi bi-lock-fill" style="font-size: 32px; color: #64748b;"></i>
                            <p class="text-muted mt-2">Vui lòng đăng nhập tài khoản thành viên để viết đánh giá và bình luận phim.</p>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-danger mt-2" style="background: #e11d48; border: none; font-weight: 600; padding: 8px 30px; border-radius: 8px;">
                                Đăng nhập ngay
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

</main>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>