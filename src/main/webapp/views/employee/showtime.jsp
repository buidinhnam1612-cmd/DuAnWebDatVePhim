<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>

    <meta charset="UTF-8">

    <title>Tra cứu suất chiếu</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">

</head>

<body>

<div class="container mt-4">

    <h2 class="mb-4">
        <i class="bi bi-film"></i>
        Tra cứu suất chiếu
    </h2>

    <!-- Form tìm kiếm -->

    <form action="${pageContext.request.contextPath}/employee/showtime"
          method="get"
          class="row g-3 mb-4">

        <div class="col-md-6">

            <input
                    type="text"
                    name="tenPhim"
                    class="form-control"
                    placeholder="Nhập tên phim..."
                    value="${param.tenPhim}">

        </div>

        <div class="col-md-2">

            <button
                    type="submit"
                    class="btn btn-primary w-100">

                <i class="bi bi-search"></i>
                Tìm kiếm

            </button>

        </div>

    </form>

    <!-- Bảng -->

    <table class="table table-bordered table-hover">

        <thead class="table-dark">

        <tr>

            <th>Mã suất</th>

            <th>Tên phim</th>

            <th>Rạp</th>

            <th>Phòng</th>

            <th>Ngày chiếu</th>

            <th>Giờ bắt đầu</th>

            <th>Giờ kết thúc</th>

            <th>Thao tác</th>

        </tr>

        </thead>

        <tbody>

        <c:forEach var="st" items="${listShowtime}">

            <tr>

                <td>${st.maSuatChieu}</td>

                <td>${st.tenPhim}</td>

                <td>${st.tenRap}</td>

                <td>${st.tenPhong}</td>

                <td>${st.ngayChieu}</td>

                <td>${st.gioBatDau}</td>

                <td>${st.gioKetThuc}</td>

                <td>

                    <a href="#"
                       class="btn btn-success btn-sm">

                        <i class="bi bi-grid-3x3-gap-fill"></i>

                        Xem ghế

                    </a>

                </td>

            </tr>

        </c:forEach>

        </tbody>

    </table>

</div>

</body>
</html>