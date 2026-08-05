<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<section class="container py-5">

    <div class="text-center mb-5">

        <h1 class="fw-bold">
            🎬 Danh sách phim
        </h1>

        <p class="text-muted">
            Khám phá những bộ phim hot nhất tại FPT CINEMA
        </p>

    </div>

    <div class="row g-4">

        <!-- Avengers -->
        <div class="col-lg-3 col-md-6">

            <div class="movie-card shadow">

                <img src="https://picsum.photos/300/450?random=10"
                     class="w-100"
                     alt="Movie">

                <div class="card-body">

                    <h5 class="fw-bold">
                        Avengers Endgame
                    </h5>

                    <p class="text-muted">
                        Hành động • 181 phút
                    </p>

                    <span class="badge bg-danger">
                        Đang chiếu
                    </span>

                    <a href="${pageContext.request.contextPath}/booking?maPhong=P01&maSuatChieu=SC01"
                       class="btn btn-warning w-100 mt-3">

                        Đặt vé ngay

                    </a>

                </div>

            </div>

        </div>

        <!-- Conan -->
        <div class="col-lg-3 col-md-6">

            <div class="movie-card shadow">

                <img src="https://picsum.photos/300/450?random=11"
                     class="w-100"
                     alt="Movie">

                <div class="card-body">

                    <h5 class="fw-bold">
                        Conan Movie
                    </h5>

                    <p class="text-muted">
                        Trinh thám • 110 phút
                    </p>

                    <span class="badge bg-danger">
                        Đang chiếu
                    </span>

                    <a href="${pageContext.request.contextPath}/booking?maPhong=P02&maSuatChieu=SC03"
                       class="btn btn-warning w-100 mt-3">

                        Đặt vé ngay

                    </a>

                </div>

            </div>

        </div>

    </div>

</section>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>