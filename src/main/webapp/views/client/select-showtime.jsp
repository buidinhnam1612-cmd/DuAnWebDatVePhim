<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<style>
    :root {
        --cinema-red: #e11d48;
        --cinema-red-hover: #be123c;
        --cinema-gold: #f59e0b;
        --cinema-dark: #0f172a;
        --cinema-card-bg: #ffffff;
        --cinema-border: #e2e8f0;
    }

    body {
        background: radial-gradient(circle at top, #ffffff 0%, #f8fafc 50%, #f1f5f9 100%) !important;
        color: #1e293b !important;
        min-height: 100vh;
    }

    /* Page Header */
    .booking-flow-header {
        background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
        padding: 35px 0 25px;
        color: white;
        border-bottom: 3px solid var(--cinema-red);
        margin-bottom: 30px;
    }

    /* Step Wizard Bar (Lotte Cinema style) */
    .booking-steps-bar {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 15px;
        flex-wrap: wrap;
        margin-top: 15px;
    }

    .step-item {
        display: flex;
        align-items: center;
        gap: 10px;
        color: #94a3b8;
        font-weight: 600;
        font-size: 14px;
        padding: 8px 16px;
        border-radius: 30px;
        background: rgba(255, 255, 255, 0.05);
        border: 1px solid rgba(255, 255, 255, 0.1);
        transition: all 0.3s ease;
    }

    .step-item.active {
        background: var(--cinema-red);
        color: white;
        border-color: var(--cinema-red);
        box-shadow: 0 4px 15px rgba(225, 29, 72, 0.35);
    }

    .step-item.completed {
        background: rgba(34, 197, 94, 0.15);
        color: #22c55e;
        border-color: #22c55e;
    }

    .step-number {
        width: 24px;
        height: 24px;
        border-radius: 50%;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: 700;
        background: rgba(255, 255, 255, 0.2);
    }

    .step-item.active .step-number {
        background: white;
        color: var(--cinema-red);
    }

    .step-divider {
        color: #475569;
        font-size: 18px;
    }

    /* Section Cards */
    .panel-card {
        background: white;
        border-radius: 16px;
        border: 1px solid var(--cinema-border);
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
        padding: 24px;
        margin-bottom: 25px;
    }

    .panel-title {
        font-size: 18px;
        font-weight: 800;
        color: var(--cinema-dark);
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 18px;
        padding-bottom: 12px;
        border-bottom: 2px solid #f1f5f9;
    }

    .panel-title i {
        color: var(--cinema-red);
        font-size: 20px;
    }

    /* Movie Selection Grid */
    .movie-select-scroll {
        display: flex;
        gap: 16px;
        overflow-x: auto;
        padding-bottom: 15px;
        scroll-snap-type: x mandatory;
    }

    .movie-select-scroll::-webkit-scrollbar {
        height: 6px;
    }

    .movie-select-scroll::-webkit-scrollbar-thumb {
        background: #cbd5e1;
        border-radius: 10px;
    }

    .movie-card-btn {
        flex: 0 0 170px;
        scroll-snap-align: start;
        background: #ffffff;
        border: 2px solid #e2e8f0;
        border-radius: 14px;
        padding: 10px;
        cursor: pointer;
        transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
        text-align: left;
        position: relative;
        overflow: hidden;
    }

    .movie-card-btn:hover {
        transform: translateY(-5px);
        border-color: var(--cinema-red);
        box-shadow: 0 8px 20px rgba(225, 29, 72, 0.15);
    }

    .movie-card-btn.active {
        border-color: var(--cinema-red);
        background: #fff1f2;
        box-shadow: 0 8px 25px rgba(225, 29, 72, 0.25);
    }

    .movie-card-btn.active::after {
        content: '✓';
        position: absolute;
        top: 10px;
        right: 10px;
        width: 26px;
        height: 26px;
        background: var(--cinema-red);
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        font-weight: 800;
        box-shadow: 0 2px 8px rgba(225, 29, 72, 0.4);
    }

    .movie-card-poster {
        width: 100%;
        height: 210px;
        object-fit: cover;
        border-radius: 10px;
        margin-bottom: 10px;
    }

    .movie-card-name {
        font-size: 14px;
        font-weight: 700;
        color: var(--cinema-dark);
        margin-bottom: 4px;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
        overflow: hidden;
        line-height: 1.3;
        min-height: 36px;
    }

    .movie-card-meta {
        font-size: 12px;
        color: #64748b;
        font-weight: 500;
    }

    .age-badge {
        display: inline-block;
        padding: 2px 6px;
        border-radius: 4px;
        font-size: 11px;
        font-weight: 700;
        color: white;
        margin-bottom: 4px;
    }

    .age-c18 { background: #dc2626; }
    .age-c16 { background: #ea580c; }
    .age-c13 { background: #f59e0b; }
    .age-p   { background: #16a34a; }

    /* Date Selector Pills (Lotte style) */
    .date-pill-container {
        display: flex;
        gap: 12px;
        overflow-x: auto;
        padding-bottom: 10px;
    }

    .date-pill-btn {
        flex: 0 0 100px;
        background: #f8fafc;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        padding: 12px 10px;
        text-align: center;
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .date-pill-btn:hover {
        border-color: var(--cinema-red);
        background: white;
    }

    .date-pill-btn.active {
        border-color: var(--cinema-red);
        background: var(--cinema-red);
        color: white !important;
        box-shadow: 0 4px 15px rgba(225, 29, 72, 0.25);
    }

    .date-pill-btn .day-label {
        font-size: 12px;
        font-weight: 600;
        text-transform: uppercase;
        color: #64748b;
        margin-bottom: 2px;
    }

    .date-pill-btn.active .day-label {
        color: rgba(255, 255, 255, 0.85);
    }

    .date-pill-btn .date-number {
        font-size: 18px;
        font-weight: 800;
        color: var(--cinema-dark);
    }

    .date-pill-btn.active .date-number {
        color: white;
    }

    /* Showtime Buttons Grid */
    .showtime-grid-wrap {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(170px, 1fr));
        gap: 15px;
        margin-top: 15px;
    }

    .showtime-card-btn {
        background: #ffffff;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        padding: 14px 16px;
        text-align: center;
        text-decoration: none !important;
        color: var(--cinema-dark);
        transition: all 0.25s ease;
        display: block;
        position: relative;
    }

    .showtime-card-btn:hover {
        border-color: var(--cinema-red);
        transform: translateY(-3px);
        box-shadow: 0 6px 18px rgba(225, 29, 72, 0.18);
        color: var(--cinema-dark);
    }

    .showtime-card-btn.selected {
        border-color: var(--cinema-red);
        background: #fff1f2;
        box-shadow: 0 4px 15px rgba(225, 29, 72, 0.25);
    }

    .showtime-time-start {
        font-size: 20px;
        font-weight: 800;
        color: var(--cinema-red);
        margin-bottom: 2px;
    }

    .showtime-time-end {
        font-size: 12px;
        color: #64748b;
        margin-bottom: 8px;
    }

    .showtime-room-tag {
        font-size: 11px;
        font-weight: 700;
        padding: 3px 8px;
        background: #f1f5f9;
        border-radius: 6px;
        color: #334155;
        display: inline-block;
    }

    /* Sticky Bottom Bar (Lotte Summary) */
    .sticky-booking-summary {
        position: sticky;
        bottom: 20px;
        background: rgba(15, 23, 42, 0.95);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 18px;
        padding: 16px 24px;
        color: white;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        margin-top: 30px;
        z-index: 100;
    }

    .summary-poster {
        width: 50px;
        height: 70px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .summary-info-title {
        font-size: 16px;
        font-weight: 700;
        color: #fff;
        margin-bottom: 2px;
    }

    .summary-info-detail {
        font-size: 13px;
        color: #fbbf24;
        font-weight: 600;
    }

    .btn-continue-booking {
        background: var(--cinema-red);
        color: white;
        border: none;
        padding: 12px 32px;
        border-radius: 12px;
        font-size: 16px;
        font-weight: 700;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .btn-continue-booking:hover:not(:disabled) {
        background: var(--cinema-red-hover);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(225, 29, 72, 0.4);
    }

    .btn-continue-booking:disabled {
        background: #475569;
        cursor: not-allowed;
        opacity: 0.6;
    }

    .empty-state-box {
        text-align: center;
        padding: 40px 20px;
        color: #64748b;
    }

    .empty-state-box i {
        font-size: 40px;
        color: #cbd5e1;
        margin-bottom: 12px;
    }
</style>

<!-- ==================== HEADER & STEP WIZARD ==================== -->
<div class="booking-flow-header">
    <div class="container text-center">
        <h1 class="fw-bold mb-1" style="font-size: 26px;">
            <i class="bi bi-ticket-perforated-fill text-warning me-2"></i>ĐẶT VÉ XEM PHIM TRỰC TUYẾN
        </h1>
        <p class="text-white-50 mb-3" style="font-size: 14px;">
            Chọn phim yêu thích, ngày chiếu và suất chiếu phù hợp với bạn
        </p>

        <!-- Steps Indicator (Lotte Cinema style) -->
        <div class="booking-steps-bar">
            <div class="step-item active">
                <span class="step-number">1</span>
                <span>Chọn Phim & Suất Chiếu</span>
            </div>
            <span class="step-divider"><i class="bi bi-chevron-right"></i></span>
            <div class="step-item">
                <span class="step-number">2</span>
                <span>Chọn Ghế & Combo Bắp Nước</span>
            </div>
            <span class="step-divider"><i class="bi bi-chevron-right"></i></span>
            <div class="step-item">
                <span class="step-number">3</span>
                <span>Thanh Toán & Nhận Vé</span>
            </div>
        </div>
    </div>
</div>

<!-- ==================== MAIN BOOKING CONTAINER ==================== -->
<div class="container pb-5">
    <div class="row">
        <div class="col-12">

            <!-- STEP 1: CHỌN PHIM -->
            <div class="panel-card">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="panel-title mb-0 border-0 p-0">
                        <i class="bi bi-film"></i>
                        <span>1. CHỌN BỘ PHIM BẠN MUỐN XEM</span>
                    </div>
                    <div style="max-width: 250px; width: 100%;">
                        <input type="text" id="movieSearchInput" class="form-control form-control-sm" placeholder="🔍 Lọc nhanh tên phim..." style="border-radius: 8px;">
                    </div>
                </div>

                <div class="movie-select-scroll" id="movieScrollList">
                    <c:forEach var="m" items="${listPhim}" varStatus="status">
                        <c:if test="${m.trangThai != 'Ẩn'}">
                            <div class="movie-card-btn ${ (selectedMovieId == m.maPhim || (empty selectedMovieId && status.first)) ? 'active' : '' }"
                                 data-movie-id="${m.maPhim}"
                                 data-movie-name="${m.tenPhim}"
                                 data-movie-poster="<c:choose>
                                     <c:when test="${not empty m.poster}">${m.poster}</c:when>
                                     <c:when test="${m.maPhim == 'M01'}">https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=400</c:when>
                                     <c:when test="${m.maPhim == 'M02'}">https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=400</c:when>
                                     <c:otherwise>https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=400</c:otherwise>
                                 </c:choose>"
                                 data-movie-duration="${m.thoiLuong}"
                                 data-movie-age="${m.doTuoiGiaiTri}"
                                 onclick="selectMovie('${m.maPhim}')">
                                
                                <img src="<c:choose>
                                     <c:when test="${not empty m.poster}">${m.poster}</c:when>
                                     <c:when test="${m.maPhim == 'M01'}">https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=400</c:when>
                                     <c:when test="${m.maPhim == 'M02'}">https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=400</c:when>
                                     <c:otherwise>https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=400</c:otherwise>
                                 </c:choose>"
                                     class="movie-card-poster" alt="${m.tenPhim}">

                                <div>
                                    <c:choose>
                                        <c:when test="${m.doTuoiGiaiTri == 'C18'}"><span class="age-badge age-c18">18+</span></c:when>
                                        <c:when test="${m.doTuoiGiaiTri == 'C16'}"><span class="age-badge age-c16">16+</span></c:when>
                                        <c:when test="${m.doTuoiGiaiTri == 'C13'}"><span class="age-badge age-c13">13+</span></c:when>
                                        <c:otherwise><span class="age-badge age-p">P</span></c:otherwise>
                                    </c:choose>
                                    <div class="movie-card-name" title="${m.tenPhim}">${m.tenPhim}</div>
                                    <div class="movie-card-meta">
                                        <i class="bi bi-clock me-1"></i>${m.thoiLuong} phút
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <!-- STEP 2: CHỌN NGÀY CHIẾU -->
            <div class="panel-card">
                <div class="panel-title">
                    <i class="bi bi-calendar-event"></i>
                    <span>2. CHỌN NGÀY XEM PHIM</span>
                </div>

                <div class="date-pill-container" id="datePillContainer">
                    <!-- Sẽ được tạo tự động bằng JavaScript theo các ngày chiếu có sẵn -->
                </div>
            </div>

            <!-- STEP 3: CHỌN SUẤT CHIẾU -->
            <div class="panel-card">
                <div class="panel-title">
                    <i class="bi bi-clock-history"></i>
                    <span>3. CHỌN KHUNG GIỜ & SUẤT CHIẾU</span>
                </div>

                <!-- Danh sách suất chiếu được render động -->
                <div id="showtimeContainer">
                    <div class="empty-state-box">
                        <i class="bi bi-calendar-x"></i>
                        <p class="mb-0">Đang tải suất chiếu phù hợp...</p>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<!-- ==================== STICKY BOTTOM SUMMARY BAR ==================== -->
<div class="container sticky-booking-summary" id="bottomSummaryBar">
    <div class="row align-items-center gy-3">
        <div class="col-md-7 col-12 d-flex align-items-center gap-3">
            <img id="summaryPoster" src="https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=200" class="summary-poster" alt="Movie Poster">
            <div>
                <div class="summary-info-title" id="summaryMovieName">Chưa chọn phim</div>
                <div class="summary-info-detail">
                    <span id="summaryDateTime"><i class="bi bi-clock me-1"></i>Vui lòng chọn suất chiếu</span>
                    <span class="mx-2 text-white-50">|</span>
                    <span id="summaryRoom" class="text-white-50">FPT Cinema</span>
                </div>
            </div>
        </div>
        <div class="col-md-5 col-12 text-md-end text-center">
            <button type="button" id="btnContinue" class="btn-continue-booking" disabled onclick="goToSeatSelection()">
                <span>Tiếp tục chọn ghế</span>
                <i class="bi bi-arrow-right-circle-fill"></i>
            </button>
        </div>
    </div>
</div>

<!-- ==================== JAVASCRIPT LOGIC ==================== -->
<script>
    // 1. Dữ liệu Suất Chiếu từ Database
    const allShowtimes = [
        <c:forEach var="st" items="${listSuatChieu}" varStatus="status">
        {
            maSuatChieu: '${st.maSuatChieu}',
            maPhim: '${st.maPhim}',
            maPhong: '${st.maPhong}',
            ngayChieu: '${st.ngayChieu}', // YYYY-MM-DD
            gioBatDau: '${st.gioBatDau}', // HH:mm:ss
            gioKetThuc: '${st.gioKetThuc}'
        }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    // 2. Trạng thái lựa chọn hiện tại
    let currentMovieId = '${selectedMovieId}';
    let currentDate = null;
    let selectedShowtimeId = null;

    // Khởi tạo ban đầu
    document.addEventListener("DOMContentLoaded", function() {
        // Nếu chưa có phim được chọn sẵn từ URL, chọn phim đầu tiên
        if (!currentMovieId || currentMovieId.trim() === '') {
            const firstMovieCard = document.querySelector('.movie-card-btn');
            if (firstMovieCard) {
                currentMovieId = firstMovieCard.getAttribute('data-movie-id');
            }
        }

        buildDatePills();
        updateSelectedMovieUI();
        renderShowtimes();
    });

    // Hàm chọn Phim
    function selectMovie(movieId) {
        currentMovieId = movieId;
        selectedShowtimeId = null; // reset suất chiếu khi đổi phim
        updateSelectedMovieUI();
        buildDatePills();
        renderShowtimes();
        updateSummary();
    }

    // Cập nhật giao diện thẻ phim được chọn
    function updateSelectedMovieUI() {
        document.querySelectorAll('.movie-card-btn').forEach(card => {
            if (card.getAttribute('data-movie-id') === currentMovieId) {
                card.classList.add('active');
            } else {
                card.classList.remove('active');
            }
        });
        updateSummary();
    }

    // Xây dựng danh sách Ngày Chiếu (Tạo 7 ngày từ hôm nay)
    function buildDatePills() {
        const container = document.getElementById('datePillContainer');
        container.innerHTML = '';

        const daysOfWeek = ['Chủ Nhật', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
        const today = new Date();

        // Lấy tất cả ngày chiếu có sẵn của phim hiện tại
        const movieShowtimes = allShowtimes.filter(st => st.maPhim === currentMovieId);
        const availableDates = [...new Set(movieShowtimes.map(st => st.ngayChieu))];

        let datesToRender = [];

        if (availableDates.length > 0) {
            // Sắp xếp ngày có suất chiếu
            availableDates.sort();
            datesToRender = availableDates;
        } else {
            // Nếu chưa có suất chiếu trong DB, tạo 7 ngày mẫu để giao diện luôn đầy đủ
            for (let i = 0; i < 7; i++) {
                const d = new Date();
                d.setDate(today.getDate() + i);
                const dateStr = d.toISOString().split('T')[0];
                datesToRender.push(dateStr);
            }
        }

        // Đặt ngày được chọn mặc định là ngày đầu tiên
        if (!currentDate || !datesToRender.includes(currentDate)) {
            currentDate = datesToRender[0];
        }

        datesToRender.forEach((dateStr, idx) => {
            const dateObj = new Date(dateStr + 'T00:00:00');
            const dayName = (idx === 0) ? 'Hôm nay' : daysOfWeek[dateObj.getDay()];
            const dayNum = String(dateObj.getDate()).padStart(2, '0') + '/' + String(dateObj.getMonth() + 1).padStart(2, '0');

            const pill = document.createElement('div');
            pill.className = 'date-pill-btn' + (dateStr === currentDate ? ' active' : '');
            pill.setAttribute('data-date', dateStr);
            pill.onclick = () => selectDate(dateStr);

            pill.innerHTML = `
                <div class="day-label">\${dayName}</div>
                <div class="date-number">\${dayNum}</div>
            `;

            container.appendChild(pill);
        });
    }

    // Chọn Ngày Chiếu
    function selectDate(dateStr) {
        currentDate = dateStr;
        selectedShowtimeId = null;

        document.querySelectorAll('.date-pill-btn').forEach(btn => {
            if (btn.getAttribute('data-date') === dateStr) {
                btn.classList.add('active');
            } else {
                btn.classList.remove('active');
            }
        });

        renderShowtimes();
        updateSummary();
    }

    // Render danh sách Suất Chiếu
    function renderShowtimes() {
        const container = document.getElementById('showtimeContainer');
        
        // Lọc các suất chiếu theo phim và ngày đã chọn
        const matchedShowtimes = allShowtimes.filter(st => 
            st.maPhim === currentMovieId && (st.ngayChieu === currentDate || !currentDate)
        );

        if (matchedShowtimes.length === 0) {
            container.innerHTML = `
                <div class="empty-state-box">
                    <i class="bi bi-calendar-x text-warning"></i>
                    <h6 class="fw-bold mt-2 text-dark">Chưa có lịch chiếu cho ngày này</h6>
                    <p class="mb-0 text-muted" style="font-size: 13px;">Vui lòng chọn ngày chiếu khác hoặc chọn một bộ phim khác.</p>
                </div>
            `;
            return;
        }

        let html = '<div class="showtime-grid-wrap">';
        matchedShowtimes.forEach(st => {
            const isSelected = (selectedShowtimeId === st.maSuatChieu);
            const startTimeFormatted = st.gioBatDau ? st.gioBatDau.substring(0, 5) : '--:--';
            const endTimeFormatted = st.gioKetThuc ? st.gioKetThuc.substring(0, 5) : '--:--';

            html += `
                <a href="javascript:void(0)" 
                   class="showtime-card-btn \${isSelected ? 'selected' : ''}" 
                   onclick="selectShowtime('\${st.maSuatChieu}', '\${startTimeFormatted}', '\${endTimeFormatted}', '\${st.maPhong}')">
                    <div class="showtime-time-start">\${startTimeFormatted}</div>
                    <div class="showtime-time-end">Đến \${endTimeFormatted}</div>
                    <div class="showtime-room-tag">Phòng \${st.maPhong} • 2D Phụ Đề</div>
                </a>
            `;
        });
        html += '</div>';

        container.innerHTML = html;
    }

    // Khi người dùng click vào một suất chiếu
    function selectShowtime(stId, startTime, endTime, room) {
        selectedShowtimeId = stId;

        // Cập nhật class active cho nút suất chiếu
        document.querySelectorAll('.showtime-card-btn').forEach(btn => {
            btn.classList.remove('selected');
        });
        if (event && event.currentTarget) {
            event.currentTarget.classList.add('selected');
        }

        updateSummary(startTime, endTime, room);
    }

    // Cập nhật thanh Summary bên dưới
    function updateSummary(startTime, endTime, room) {
        const activeMovieCard = document.querySelector(`.movie-card-btn[data-movie-id="\${currentMovieId}"]`);
        const btnContinue = document.getElementById('btnContinue');

        if (activeMovieCard) {
            const movieName = activeMovieCard.getAttribute('data-movie-name');
            const posterUrl = activeMovieCard.getAttribute('data-movie-poster');
            const duration = activeMovieCard.getAttribute('data-movie-duration');

            document.getElementById('summaryMovieName').textContent = movieName;
            document.getElementById('summaryPoster').src = posterUrl;

            if (selectedShowtimeId && startTime) {
                document.getElementById('summaryDateTime').innerHTML = `<i class="bi bi-clock-fill text-warning me-1"></i>\${startTime} - \${currentDate}`;
                document.getElementById('summaryRoom').textContent = `Phòng \${room || '01'} • 2D Phụ Đề`;
                btnContinue.disabled = false;
            } else {
                document.getElementById('summaryDateTime').innerHTML = `<i class="bi bi-clock me-1"></i>\${duration} phút • Vui lòng chọn giờ chiếu`;
                document.getElementById('summaryRoom').textContent = `FPT Cinema`;
                btnContinue.disabled = true;
            }
        }
    }

    // Chuyển sang bước Chọn Ghế (Gọi tới /booking?maSuatChieu=...)
    function goToSeatSelection() {
        if (!selectedShowtimeId) {
            alert('Vui lòng chọn suất chiếu trước khi tiếp tục!');
            return;
        }
        window.location.href = '${pageContext.request.contextPath}/booking?maSuatChieu=' + selectedShowtimeId;
    }

    // Lọc nhanh phim bằng input search
    document.getElementById('movieSearchInput').addEventListener('input', function(e) {
        const query = e.target.value.toLowerCase().trim();
        document.querySelectorAll('.movie-card-btn').forEach(card => {
            const name = card.getAttribute('data-movie-name').toLowerCase();
            if (name.includes(query)) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    });
</script>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>
