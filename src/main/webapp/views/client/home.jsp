<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<!-- ==========================
     HERO SLIDER
========================== -->


<div id="movieCarousel"
     class="carousel slide carousel-fade"
     data-bs-ride="carousel">

    <div class="carousel-indicators">

        <button type="button"
                data-bs-target="#movieCarousel"
                data-bs-slide-to="0"
                class="active">
        </button>

        <button type="button"
                data-bs-target="#movieCarousel"
                data-bs-slide-to="1">
        </button>

        <button type="button"
                data-bs-target="#movieCarousel"
                data-bs-slide-to="2">
        </button>

    </div>

    <div class="carousel-inner">

        <!-- Slide 1 -->

        <div class="carousel-item active">

            <img src="https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=1600"
                 class="hero-image d-block w-100"
                 alt="Banner">

            <div class="carousel-caption hero-content">

                <span class="badge bg-danger fs-6 mb-3">
                    HOT MOVIE
                </span>

                <h1>
                    DUNE
                </h1>

                <p>
                    Trải nghiệm điện ảnh đỉnh cao tại FPT CINEMA.
                </p>

                <a href="${pageContext.request.contextPath}/booking?maSuatChieu=SC01"
                   class="btn btn-warning btn-lg me-2">

                    Đặt vé ngay

                </a>

                <a href="#"
                   class="btn btn-outline-light btn-lg">

                    Trailer

                </a>

            </div>

        </div>

        <!-- Slide 2 -->

        <div class="carousel-item">

            <img src="https://images.unsplash.com/photo-1517604931442-7e0c8ed2963c?q=80&w=1600"
                 class="hero-image d-block w-100"
                 alt="Banner">

            <div class="carousel-caption hero-content">

                <span class="badge bg-primary fs-6 mb-3">

                    NEW

                </span>

                <h1>

                    AVATAR 3

                </h1>

                <p>

                    Hành trình mới trên hành tinh Pandora.

                </p>

            </div>

        </div>

        <!-- Slide 3 -->

        <div class="carousel-item">

            <img src="https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=1600"
                 class="hero-image d-block w-100"
                 alt="Banner">

            <div class="carousel-caption hero-content">

                <span class="badge bg-success fs-6 mb-3">

                    NOW SHOWING

                </span>

                <h1>

                    SPIDER MAN

                </h1>

                <p>

                    Đặt vé nhanh - Giá tốt - Chất lượng cao.

                </p>

            </div>

        </div>

    </div>

</div>

<!-- ==========================
     SEARCH
========================== -->

<section class="container">

    <div class="movie-search-box">

        <div class="row g-3">

            <div class="col-lg-3">

                <label class="form-label">

                    Thể loại

                </label>

                <select class="form-select">

                    <option>Tất cả</option>
                    <option>Hành động</option>
                    <option>Kinh dị</option>
                    <option>Hoạt hình</option>
                    <option>Viễn tưởng</option>

                </select>

            </div>

            <div class="col-lg-3">

                <label class="form-label">

                    Rạp

                </label>

                <select class="form-select">

                    <option>FPT CINEMA</option>
                    <option>Hà Nội</option>
                    <option>Đà Nẵng</option>
                    <option>TP Hồ Chí Minh</option>

                </select>

            </div>

            <div class="col-lg-3">

                <label class="form-label">

                    Ngày chiếu

                </label>

                <input type="date"
                       class="form-control">

            </div>

            <div class="col-lg-3 d-grid">

                <label class="form-label">

                    &nbsp;

                </label>

                <button class="btn btn-danger">

                    <i class="bi bi-search me-2"></i>

                    TÌM KIẾM

                </button>

            </div>

        </div>

    </div>

</section>
<!-- ==========================
     PHIM ĐANG CHIẾU
========================== -->

<section class="container">

    <div class="d-flex justify-content-between align-items-center mb-5">

        <h2 class="section-title">

            🎬 Phim đang chiếu

        </h2>

        <a href="${pageContext.request.contextPath}/movies"
           class="btn btn-outline-warning">

            Xem tất cả

        </a>

    </div>

    <div class="row g-4">

        <div class="col-lg-3 col-md-6">

            <div class="movie-card">

                <img src="https://picsum.photos/300/450?random=1"
                     alt="Avatar 3">

                <div class="card-body">

                    <h5>

                        Avatar 3

                    </h5>

                    <p>

                        Viễn tưởng • 150 phút

                    </p>

                    <div class="d-flex justify-content-between align-items-center mb-3">

                        <span class="badge bg-warning text-dark">

                            ⭐ 9.2

                        </span>

                        <span class="text-danger fw-bold">

                            Đang chiếu

                        </span>

                    </div>

                    <a href="${pageContext.request.contextPath}/booking?maSuatChieu=SC01"
                       class="btn btn-danger w-100">

                        Đặt vé

                    </a>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="movie-card">

                <img src="https://picsum.photos/300/450?random=2"
                     alt="Spider Man">

                <div class="card-body">

                    <h5>

                        Spider Man

                    </h5>

                    <p>

                        Hành động • 135 phút

                    </p>

                    <div class="d-flex justify-content-between align-items-center mb-3">

                        <span class="badge bg-warning text-dark">

                            ⭐ 9.0

                        </span>

                        <span class="text-danger fw-bold">

                            Đang chiếu

                        </span>

                    </div>

                    <a href="${pageContext.request.contextPath}/booking?maSuatChieu=SC02"
                       class="btn btn-danger w-100">

                        Đặt vé

                    </a>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="movie-card">

                <img src="https://picsum.photos/300/450?random=3"
                     alt="Mission Impossible">

                <div class="card-body">

                    <h5>

                        Mission Impossible

                    </h5>

                    <p>

                        Phiêu lưu • 142 phút

                    </p>

                    <div class="d-flex justify-content-between align-items-center mb-3">

                        <span class="badge bg-warning text-dark">

                            ⭐ 8.8

                        </span>

                        <span class="text-danger fw-bold">

                            Đang chiếu

                        </span>

                    </div>

                    <a href="${pageContext.request.contextPath}/booking?maSuatChieu=SC03"
                       class="btn btn-danger w-100">

                        Đặt vé

                    </a>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="movie-card">

                <img src="https://picsum.photos/300/450?random=4"
                     alt="Doraemon">

                <div class="card-body">

                    <h5>

                        Doraemon

                    </h5>

                    <p>

                        Hoạt hình • 110 phút

                    </p>

                    <div class="d-flex justify-content-between align-items-center mb-3">

                        <span class="badge bg-warning text-dark">

                            ⭐ 9.5

                        </span>

                        <span class="text-danger fw-bold">

                            Đang chiếu

                        </span>

                    </div>

                    <a href="${pageContext.request.contextPath}/booking?maSuatChieu=SC04"
                       class="btn btn-danger w-100">

                        Đặt vé

                    </a>

                </div>

            </div>

        </div>

    </div>

</section>
<!-- ==========================
     PHIM SẮP CHIẾU
========================== -->

<section class="container">

    <div class="d-flex justify-content-between align-items-center mb-5">

        <h2 class="section-title">

            🍿 Phim sắp chiếu

        </h2>

        <a href="#"
           class="btn btn-outline-warning">

            Xem tất cả

        </a>

    </div>

    <div class="row g-4">

        <div class="col-lg-3 col-md-6">

            <div class="movie-card">

                <img src="https://picsum.photos/300/450?random=5"
                     alt="Kung Fu Panda">

                <div class="card-body">

                    <h5>

                        Kung Fu Panda 5

                    </h5>

                    <p>

                        Hoạt hình • Khởi chiếu 15/09

                    </p>

                    <span class="badge bg-primary">

                        Coming Soon

                    </span>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="movie-card">

                <img src="https://picsum.photos/300/450?random=6"
                     alt="Fast X">

                <div class="card-body">

                    <h5>

                        Fast X 2

                    </h5>

                    <p>

                        Hành động • Khởi chiếu 20/09

                    </p>

                    <span class="badge bg-primary">

                        Coming Soon

                    </span>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="movie-card">

                <img src="https://picsum.photos/300/450?random=7"
                     alt="Frozen">

                <div class="card-body">

                    <h5>

                        Frozen 3

                    </h5>

                    <p>

                        Hoạt hình • Khởi chiếu 01/10

                    </p>

                    <span class="badge bg-primary">

                        Coming Soon

                    </span>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="movie-card">

                <img src="https://picsum.photos/300/450?random=8"
                     alt="Batman">

                <div class="card-body">

                    <h5>

                        The Batman 2

                    </h5>

                    <p>

                        Hành động • Khởi chiếu 10/10

                    </p>

                    <span class="badge bg-primary">

                        Coming Soon

                    </span>

                </div>

            </div>

        </div>

    </div>

</section>

<!-- ==========================
     MEMBER
========================== -->

<section class="container">

    <div class="member-box">

        <span>

            THÀNH VIÊN FPT CINEMA

        </span>

        <h2 class="mt-3">

            NHẬN ƯU ĐÃI ĐỘC QUYỀN

        </h2>

        <p>

            Đăng ký tài khoản để tích điểm, nhận voucher giảm giá,
            ưu tiên đặt vé và nhiều chương trình hấp dẫn khác.

        </p>

        <div class="row justify-content-center mt-4">

            <div class="col-lg-5">

                <input type="email"
                       class="form-control"
                       placeholder="Nhập email của bạn">

            </div>

            <div class="col-lg-2 d-grid">

                <button class="btn btn-warning">

                    Đăng ký

                </button>

            </div>

        </div>

    </div>

</section>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>