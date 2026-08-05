<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>

    <meta charset="UTF-8">

    <title>Thanh toán</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container mt-5">

    <div class="row justify-content-center">

        <div class="col-lg-7">

            <div class="card shadow">

                <div class="card-header bg-primary text-white">

                    <h3 class="mb-0">

                        💳 Thanh toán vé xem phim

                    </h3>

                </div>

                <div class="card-body">

                    <table class="table table-bordered">

                        <tr>

                            <th width="35%">Mã đặt vé</th>

                            <td>${booking.maDatVe}</td>

                        </tr>

                        <tr>

                            <th>Thời gian đặt</th>

                            <td>${booking.thoiGianDat}</td>

                        </tr>

                        <tr>

                            <th>Tổng tiền</th>

                            <td class="text-danger fw-bold">

                                ${booking.tongTien} VNĐ

                            </td>

                        </tr>

                        <tr>

                            <th>Trạng thái</th>

                            <td>

                                <span class="badge bg-warning text-dark">

                                    ${booking.trangThai}

                                </span>

                            </td>

                        </tr>

                    </table>

                    <h5 class="mt-4">

                        Danh sách vé

                    </h5>

                    <table class="table table-striped table-bordered">

                        <thead class="table-dark">

                        <tr>

                            <th>Ghế</th>

                            <th>Suất chiếu</th>

                            <th>Giá vé</th>

                        </tr>

                        </thead>

                        <tbody>

                        <c:forEach items="${details}" var="d">

                            <tr>

                                <td>${d.maGhe}</td>

                                <td>${d.maSuatChieu}</td>

                                <td>${d.giaVe} VNĐ</td>

                            </tr>

                        </c:forEach>

                        </tbody>

                    </table>

                    <form method="post"
                          action="${pageContext.request.contextPath}/payment">

                        <input type="hidden"
                               name="bookingId"
                               value="${booking.maDatVe}">

                        <button type="submit"
                                class="btn btn-success w-100 mb-2">

                            ✅ Xác nhận thanh toán

                        </button>

                    </form>

                    <a href="${pageContext.request.contextPath}/booking"
                       class="btn btn-secondary w-100">

                        ← Quay lại

                    </a>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>