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

    /* ========== BỘ LỌC PHIM ========== */
    .filter-section {
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        padding: 24px 28px;
        margin-bottom: 32px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }
    .filter-section-title {
        font-size: 15px;
        font-weight: 700;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 16px;
    }
    .filter-form-row {
        display: flex;
        flex-wrap: wrap;
        gap: 16px;
        align-items: flex-end;
    }
    .filter-group {
        flex: 1;
        min-width: 200px;
    }
    .filter-group label {
        display: block;
        font-size: 13px;
        font-weight: 600;
        color: #475569;
        margin-bottom: 6px;
    }
    .filter-group select,
    .filter-group input[type="text"] {
        width: 100%;
        padding: 10px 14px;
        border: 1px solid #cbd5e1;
        border-radius: 8px;
        font-size: 14px;
        color: #0f172a;
        background-color: #f8fafc;
        outline: none;
        transition: border-color 0.2s ease;
    }
    .filter-group select:focus,
    .filter-group input[type="text"]:focus {
        border-color: #e11d48;
    }
    .filter-btn-group {
        display: flex;
        gap: 8px;
        align-items: flex-end;
    }
    .filter-btn {
        padding: 10px 24px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-block;
        text-align: center;
        transition: background-color 0.2s ease;
    }
    .filter-btn-primary {
        background-color: #e11d48;
        color: #fff;
    }
    .filter-btn-primary:hover {
        background-color: #be123c;
    }
    .filter-btn-secondary {
        background-color: #e2e8f0;
        color: #475569;
    }
    .filter-btn-secondary:hover {
        background-color: #cbd5e1;
        color: #0f172a;
    }

    /* ========== HIỂN THỊ DANH SÁCH RẠP ========== */
    .theater-list-section {
        background: #ffffff;
        border: 1px solid #e2e8f0;
        border-radius: 14px;
        padding: 24px 28px;
        margin-bottom: 32px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }
    .theater-list-title {
        font-size: 15px;
        font-weight: 700;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 16px;
    }
    .theater-list-grid {
        display: flex;
        flex-wrap: wrap;
        gap: 12px;
    }
    .theater-item {
        background: #f1f5f9;
        border: 1px solid #e2e8f0;
        border-radius: 10px;
        padding: 12px 18px;
        display: flex;
        align-items: center;
        gap: 10px;
        transition: all 0.2s ease;
        min-width: 220px;
        flex: 1;
        max-width: 320px;
    }
    .theater-item:hover {
        border-color: #fbbf24;
        background: #fffbeb;
    }
    .theater-icon {
        width: 36px;
        height: 36px;
        background: linear-gradient(135deg, #e11d48, #f97316);
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #fff;
        font-weight: 700;
        font-size: 14px;
        flex-shrink: 0;
    }
    .theater-info {
        min-width: 0;
    }
    .theater-name {
        font-size: 14px;
        font-weight: 600;
        color: #0f172a;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .theater-address {
        font-size: 12px;
        color: #94a3b8;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
</style>

<div class="movie-list-page">
    <div class="container">

        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
            <div>
                <h1 class="search-result-title m-0">
                    <c:choose>
                        <c:when test="${not empty keyword && not empty selectedGenre}">
                            🔍 Kết quả: "${keyword}" trong thể loại đã chọn
                        </c:when>
                        <c:when test="${not empty keyword}">
                            🔍 Kết quả tìm kiếm cho: "${keyword}"
                        </c:when>
                        <c:when test="${not empty selectedGenre}">
                            🎬 Phim theo thể loại đã chọn
                        </c:when>
                        <c:otherwise>
                            🎬 Danh sách phim đang chiếu
                        </c:otherwise>
                    </c:choose>
                </h1>
            </div>
        </div>

        <%-- ==================== BỘ LỌC THỂ LOẠI PHIM ==================== --%>
        <div class="filter-section">
            <div class="filter-section-title">🎭 Bộ lọc phim</div>
            <form action="${pageContext.request.contextPath}/movies" method="get">
                <div class="filter-form-row">
                    <div class="filter-group">
                        <label for="genre">Thể loại phim</label>
                        <select id="genre" name="genre">
                            <option value="">-- Tất cả thể loại --</option>
                            <c:forEach var="tl" items="${listTheLoai}">
                                <c:if test="${!tl.tenTheLoai.contains('(Đã khóa)')}">
                                    <option value="${tl.maTheLoai}"
                                        ${selectedGenre == tl.maTheLoai ? 'selected' : ''}>
                                            ${tl.tenTheLoai}
                                    </option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="keyword">Tìm kiếm tên phim</label>
                        <input type="text" id="keyword" name="keyword" value="${keyword}"
                               placeholder="Nhập tên phim cần tìm...">
                    </div>

                    <div class="filter-btn-group">
                        <button type="submit" class="filter-btn filter-btn-primary">Lọc phim</button>
                        <a href="${pageContext.request.contextPath}/movies" class="filter-btn filter-btn-secondary">Xóa lọc</a>
                    </div>
                </div>
            </form>
        </div>

        <%-- ==================== HIỂN THỊ DANH SÁCH RẠP CHIẾU ==================== --%>
        <c:if test="${not empty listRap}">
            <div class="theater-list-section">
                <div class="theater-list-title">🏢 Hệ thống rạp chiếu phim</div>
                <div class="theater-list-grid">
                    <c:forEach var="rap" items="${listRap}">
                        <div class="theater-item">
                            <div class="theater-icon">
                                <c:out value="${rap.tenRap.substring(0,1)}"/>
                            </div>
                            <div class="theater-info">
                                <div class="theater-name">${rap.tenRap}</div>
                                <div class="theater-address">${rap.diaChi}</div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <%-- ==================== DANH SÁCH PHIM ==================== --%>
        <c:choose>
            <c:when test="${empty listPhim}">
                <div class="text-center py-5">
                    <i class="bi bi-camera-reels" style="font-size: 48px; color: #64748b;"></i>
                    <p class="mt-3 text-muted" style="font-size: 18px;">Không tìm thấy bộ phim nào phù hợp.</p>
                    <a href="${pageContext.request.contextPath}/movies" class="filter-btn filter-btn-primary" style="display: inline-block; margin-top: 8px;">Xem tất cả phim</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="m" items="${listPhim}">
                        <c:if test="${m.trangThai != 'Ẩn'}">
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
                        </c:if>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
</div>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>