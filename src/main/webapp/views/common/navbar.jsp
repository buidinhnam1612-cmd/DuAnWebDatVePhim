<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg custom-navbar">

    <div class="container">

        <!-- Logo -->
        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/home">

            <i class="bi bi-film text-warning me-2"></i>

            FPT CINEMA

        </a>

        <!-- Menu Mobile -->
        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNavbar"
                aria-controls="mainNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse" id="mainNavbar">

            <!-- Menu -->
            <ul class="navbar-nav mx-auto">

                <li class="nav-item">
                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/home">
                        Trang chủ
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/movies">
                        Phim
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/booking">
                        Đặt vé
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/promotion">
                        Khuyến mãi
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/contact">
                        Liên hệ
                    </a>
                </li>

            </ul>


            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!-- Đăng nhập rồi -> Menu chào mừng dropdown -->
                    <div class="dropdown">
                        <button class="btn btn-login dropdown-toggle"
                                type="button"
                                id="userNavbarMenu"
                                data-bs-toggle="dropdown"
                                aria-expanded="false">
                            <i class="bi bi-person-circle me-1"></i>
                            ${sessionScope.userName}
                        </button>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end"
                            aria-labelledby="userNavbarMenu"
                            style="border: 1px solid var(--border); background: var(--surface);">
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/profile">
                                    <i class="bi bi-person-circle me-2 text-warning"></i>
                                    Thông tin cá nhân
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item"
                                   href="${pageContext.request.contextPath}/history">
                                    <i class="bi bi-clock-history me-2 text-warning"></i>
                                    Lịch sử đặt vé
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider" style="border-color: var(--border);">
                            </li>
                            <li>
                                <a class="dropdown-item text-danger"
                                   href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-left me-2"></i>
                                    Đăng xuất
                                </a>
                            </li>
                        </ul>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- Chưa đăng nhập -> Nút đăng nhập/đăng ký -->
                    <a href="${pageContext.request.contextPath}/login"
                       class="btn btn-login me-2">
                        Đăng nhập
                    </a>
                    <a href="${pageContext.request.contextPath}/register"
                       class="btn btn-register">
                        Đăng ký
                    </a>
                </c:otherwise>
            </c:choose>

        </div>

    </div>

</nav>

<!-- ALERT BANNER CHO VÉ CHỜ THANH TOÁN -->
<%@ page import="com.fptpoly.repository.BookingRepository" %>
<%@ page import="com.fptpoly.model.Booking" %>
<%@ page import="com.fptpoly.model.User" %>
<%@ page import="java.util.List" %>
<%
    User currentUser = (User) session.getAttribute("user");
    Booking pendingBooking = null;
    if (currentUser != null) {
        try {
            BookingRepository bookingRepo = new BookingRepository();
            List<Booking> bookings = bookingRepo.getByKhachHang(currentUser.getMaKhachHang());
            for (Booking b : bookings) {
                if ("Chờ thanh toán".equals(b.getTrangThai())) {
                    pendingBooking = b;
                    break;
                }
            }
        } catch (Exception e) {
            // Tránh lỗi khi khởi tạo Repository ngoài luồng servlet chính
        }
    }
    request.setAttribute("pendingBooking", pendingBooking);
%>
<c:if test="${not empty pendingBooking}">
    <div class="alert alert-warning alert-dismissible fade show text-center m-0" role="alert" style="background: linear-gradient(135deg, #ff9f1c, #ffbf69); border: none; color: #000; font-weight: 600; font-size: 14px; border-radius: 0; padding: 10px 30px;">
        <i class="bi bi-exclamation-triangle-fill me-2 text-dark"></i>
        Bạn có mã giữ ghế chờ thanh toán: <strong>${pendingBooking.maDatVe}</strong> (Phim: <em>${pendingBooking.tenPhim}</em>).
        Vui lòng đến quầy vé tại rạp trước giờ chiếu <strong>60 phút</strong> để thanh toán và nhận vé!
        <a href="${pageContext.request.contextPath}/history" class="btn btn-dark btn-sm ms-3" style="border-radius: 6px; font-weight: 600; font-size: 12px; padding: 2px 12px;">Xem chi tiết</a>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" style="padding: 12px;"></button>
    </div>
</c:if>