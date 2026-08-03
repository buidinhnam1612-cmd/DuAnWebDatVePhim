<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>


<main class="movie-detail-page">


<!-- =========================
     MOVIE HERO
========================= -->

<section class="movie-detail-banner">


    <div class="movie-detail-overlay"></div>


    <div class="container movie-detail-content">


        <div class="row align-items-end">


            <!-- POSTER -->

            <div class="col-md-3">

                <img src="https://picsum.photos/400/600"
                     class="movie-detail-poster"
                     alt="Movie Poster">

            </div>



            <!-- INFO -->

            <div class="col-md-9">


                <div class="movie-tag-list">

                    <span class="badge bg-warning text-dark">
                        IMAX
                    </span>


                    <span class="badge border text-white">
                        T13
                    </span>


                    <span class="text-warning">

                        ⭐ 4.8

                    </span>


                </div>



                <h1 class="movie-detail-title">

                    Avatar 3

                </h1>



                <p class="movie-detail-description">

                    Hành trình mới tại hành tinh Pandora.
                    Một cuộc chiến mới bắt đầu giữa các thế lực
                    để bảo vệ thế giới tương lai.

                </p>



                <div class="row movie-information">


                    <div class="col-md-3">

                        <small>
                            THỜI LƯỢNG
                        </small>

                        <p>
                            160 phút
                        </p>

                    </div>



                    <div class="col-md-3">

                        <small>
                            THỂ LOẠI
                        </small>

                        <p>
                            Viễn tưởng
                        </p>

                    </div>



                    <div class="col-md-3">

                        <small>
                            ĐỘ TUỔI
                        </small>

                        <p>
                            T13
                        </p>

                    </div>



                    <div class="col-md-3">

                        <small>
                            ĐẠO DIỄN
                        </small>

                        <p>
                            James Cameron
                        </p>

                    </div>


                </div>



                <button class="btn trailer-button">

                    ▶ Xem Trailer

                </button>



            </div>


        </div>


    </div>


</section>




<!-- =========================
     BOOKING AREA
========================= -->


<section class="container booking-container">


<div class="row g-4">



<!-- LEFT -->

<div class="col-lg-8">



<!-- STEP 1 -->

<div class="booking-step">


<h3>

<span>
1.
</span>

Chọn rạp

</h3>



<div class="row g-3">


<div class="col-md-6">


<div class="cinema-card active">


<h5>

FPT Cinema Hà Nội

</h5>


<p>

📍 Hai Bà Trưng, Hà Nội

</p>


<span>

IMAX

</span>


</div>


</div>



<div class="col-md-6">


<div class="cinema-card">


<h5>

FPT Cinema Hồ Chí Minh

</h5>


<p>

📍 Quận 1, TP.HCM

</p>


<span>

4DX

</span>


</div>


</div>


</div>


</div>





<!-- STEP 2 -->


<div class="booking-step">


<h3>

<span>
2.
</span>

Chọn ngày

</h3>



<div class="date-list">


<button class="date-card active">

<span>

HÔM NAY

</span>

<strong>

14

</strong>


<small>

08

</small>


</button>



<button class="date-card">


<span>

THỨ 3

</span>

<strong>

15

</strong>


<small>

08

</small>


</button>



<button class="date-card">


<span>

THỨ 4

</span>

<strong>

16

</strong>


<small>

08

</small>


</button>



</div>


</div>





<!-- STEP 3 -->


<div class="booking-step">


<h3>

<span>
3.
</span>

Chọn suất chiếu

</h3>



<h5>

IMAX 2D

</h5>


<div class="showtime-list">


<button>
09:00
</button>


<button class="active">
14:30
</button>


<button>
19:00
</button>


</div>



<h5 class="mt-4">

STANDARD 2D

</h5>



<div class="showtime-list">


<button>
10:00
</button>


<button>
15:30
</button>


<button>
21:00
</button>


</div>



</div>


</div>





<!-- RIGHT SUMMARY -->


<div class="col-lg-4">


<div class="booking-summary">


<h4>

Booking Summary

</h4>



<div class="summary-item">

<span>
Rạp
</span>


<strong>

FPT Cinema Hà Nội

</strong>


</div>



<div class="summary-item">


<span>
Ngày
</span>


<strong>

14/08/2026

</strong>


</div>



<div class="summary-item">


<span>
Suất
</span>


<strong>

14:30 IMAX

</strong>


</div>



<a href="${pageContext.request.contextPath}/booking"
class="btn booking-button">


Chọn ghế →

</a>


</div>


</div>


</div>


</section>





<!-- REVIEW -->


<section class="container review-section">


<h2>

Đánh giá khách hàng

</h2>



<div class="row g-4">


<div class="col-md-4">


<div class="review-card">


<h5>

Nguyễn Văn A

</h5>


<div class="text-warning">

⭐⭐⭐⭐⭐

</div>


<p>

Phim rất hay, kỹ xảo tuyệt vời.

</p>


</div>


</div>



<div class="col-md-4">


<div class="review-card">


<h5>

Trần Minh

</h5>


<div class="text-warning">

⭐⭐⭐⭐

</div>


<p>

Âm thanh IMAX rất đã.

</p>


</div>


</div>


</div>


</section>


</main>



<jsp:include page="/views/common/footer.jsp"/>

<jsp:include page="/views/common/script.jsp"/>