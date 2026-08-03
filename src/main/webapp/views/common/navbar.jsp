<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<nav class="navbar navbar-expand-lg navbar-dark sticky-top">

    <div class="container">

        <!-- Logo -->

        <a class="navbar-brand"
           href="${pageContext.request.contextPath}/home">

            <i class="bi bi-film text-warning me-2"></i>

            FPT CINEMA

        </a>

        <!-- Mobile -->

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNavbar">

            <span class="navbar-toggler-icon"></span>

        </button>

        <div class="collapse navbar-collapse"
             id="mainNavbar">

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
                       href="#">

                        Khuyến mãi

                    </a>

                </li>

                <li class="nav-item">

                    <a class="nav-link"
                       href="#">

                        Liên hệ

                    </a>

                </li>

            </ul>

            <!-- Search -->

            <form class="d-flex me-3"
                  action="${pageContext.request.contextPath}/movies"
                  method="get">

                <input class="form-control"
                       type="search"
                       name="keyword"
                       placeholder="Tìm phim...">

            </form>

            <!-- Login -->

            <a href="${pageContext.request.contextPath}/login"
               class="btn btn-outline-warning me-2">

                Đăng nhập

            </a>

            <!-- Register -->

            <a href="${pageContext.request.contextPath}/register"
               class="btn btn-warning">

                Đăng ký

            </a>

        </div>

    </div>

</nav>