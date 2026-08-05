<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">

    <title>Vé xem phim</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body>

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-success text-white">

            <h3>🎫 VÉ XEM PHIM</h3>

        </div>

        <div class="card-body">

            <table class="table table-bordered">

                <tr>

                    <th>Mã đặt vé</th>

                    <td>${booking.maDatVe}</td>

                </tr>

                <tr>

                    <th>Thời gian đặt</th>

                    <td>${booking.thoiGianDat}</td>

                </tr>

                <tr>

                    <th>Tổng tiền</th>

                    <td>${booking.tongTien} VNĐ</td>

                </tr>

                <tr>

                    <th>Trạng thái</th>

                    <td>

                        <span class="badge bg-success">

                            ${booking.trangThai}

                        </span>

                    </td>

                </tr>

            </table>

            <h5 class="mt-4">

                Danh sách ghế

            </h5>

            <table class="table table-striped table-bordered">

                <thead class="table-dark">

                <tr>

                    <th>Ghế</th>

                    <th>Suất chiếu</th>

                    <th>Giá vé</th>

                    <th>Trạng thái</th>

                </tr>

                </thead>

                <tbody>

                <c:forEach items="${details}" var="d">

                    <tr>

                        <td>${d.maGhe}</td>

                        <td>${d.maSuatChieu}</td>

                        <td>${d.giaVe} VNĐ</td>

                        <td>${d.trangThai}</td>

                    </tr>

                </c:forEach>

                </tbody>

            </table>

            <form action="${pageContext.request.contextPath}/ticket"
                  method="post">

                <input type="hidden"
                       name="bookingId"
                       value="${booking.maDatVe}">

                <button class="btn btn-success">

                    📧 Gửi vé qua Email

                </button>

                <a href="${pageContext.request.contextPath}/"
                   class="btn btn-primary">

                    🏠 Trang chủ

                </a>

            </form>

        </div>

    </div>

</div>

</body>
</html>