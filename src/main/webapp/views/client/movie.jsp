<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<style>
    .movie-list-page {
        background-color: #f8fafc;
        color: #0f172a;
        min-height: 90vh;
        padding: 60px 0;
    }
    .movie-grid-card {
        background-color: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 16px;
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        height: 100%;
        display: flex;
        flex-direction: column;
    }
    .movie-grid-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        border-color: #e11d48;
    }
    .movie-grid-img {
        height: 380px;
        object-fit: cover;
        width: 100%;
    }
    .movie-grid-body {
        padding: 20px;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }
    .movie-grid-title {
        font-size: 18px;
        font-weight: 700;
        margin-bottom: 8px;
        color: #0f172a;
    }
    .movie-grid-meta {
        font-size: 14px;
        color: #94a3b8;
        margin-bottom: 12px;
    }
    .movie-grid-badge {
        background-color: #e11d48;
        color: #fff;
        padding: 4px 10px;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 600;
        display: inline-block;
        margin-bottom: 15px;
    }
    .movie-grid-btn {
        margin-top: auto;
        background-color: #e11d48;
        color: #fff;
        border: none;
        border-radius: 8px;
        padding: 10px;
        font-weight: 600;
        text-align: center;
        text-decoration: none;
        display: block;
        transition: background-color 0.2s ease;
    }
    .movie-grid-btn:hover {
        background-color: #be123c;
        color: #fff;
    }
    .search-result-title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 30px;
    }
</style>

<div class="movie-list-page">
    <div class="container">

        <div class="d-flex justify-content-between align-items-center mb-5 flex-wrap gap-3">
            <div>
                <h1 class="search-result-title m-0">
                    <c:choose>
                        <c:when test="${not empty keyword}">
                            🔍 Kết quả tìm kiếm cho: "${keyword}"
                        </c:when>
                        <c:otherwise>
                            🎬 Danh sách phim đang chiếu
                        </c:otherwise>
                    </c:choose>
                </h1>
            </div>
            
            <form action="${pageContext.request.contextPath}/movies" method="get" class="d-flex" style="max-width: 400px; width: 100%;">
                <input type="text" name="keyword" value="${keyword}" class="form-control" placeholder="Nhập tên phim cần tìm..." style="background: #ffffff; border: 1px solid #e2e8f0; color: #0f172a; border-radius: 8px 0 0 8px;">
                <button type="submit" class="btn btn-danger" style="border-radius: 0 8px 8px 0; background: #e11d48; border: none;">Tìm</button>
            </form>
        </div>

        <c:choose>
            <c:when test="${empty listPhim}">
                <div class="text-center py-5">
                    <i class="bi bi-camera-reels" style="font-size: 48px; color: #64748b;"></i>
                    <p class="mt-3 text-muted" style="font-size: 18px;">Không tìm thấy bộ phim nào phù hợp.</p>
                    <a href="${pageContext.request.contextPath}/movies" class="btn btn-outline-danger mt-2">Xem tất cả phim</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="m" items="${listPhim}">
                        <div class="col-lg-3 col-md-6 col-sm-12">
                            <div class="movie-grid-card shadow">
                                <a href="${pageContext.request.contextPath}/movies?action=detail&id=${m.maPhim}">
                                    <img src="<c:choose>
                                         <c:when test="${not empty m.poster}">${m.poster}</c:when>
                                         <c:when test="${m.maPhim == 'M01'}">https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=300</c:when>
                                         <c:when test="${m.maPhim == 'M02'}">https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=300</c:when>
                                         <c:otherwise>https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=300</c:otherwise>
                                     </c:choose>" 
                                     class="movie-grid-img" 
                                     alt="${m.tenPhim}">
                                </a>
                                <div class="movie-grid-body">
                                    <h5 class="movie-grid-title">${m.tenPhim}</h5>
                                    <p class="movie-grid-meta">${m.doTuoiGiaiTri} • ${m.thoiLuong} phút</p>
                                    <div>
                                        <span class="movie-grid-badge">Đang chiếu</span>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/movies?action=detail&id=${m.maPhim}" class="movie-grid-btn">
                                        Chi tiết & Đặt vé
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>