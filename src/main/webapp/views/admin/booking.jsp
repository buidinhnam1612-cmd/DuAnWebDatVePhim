<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>

    <meta charset="UTF-8">

    <title>Đặt vé xem phim</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

</head>

<body>

<div class="container mt-5">

    <div class="card shadow">

        <div class="card-header bg-primary text-white">

            <h3>Đặt vé xem phim</h3>

        </div>

        <div class="card-body">

            <form action="${pageContext.request.contextPath}/booking"
                  method="post">

                <input type="hidden"
                       name="maKhachHang"
                       value="${sessionScope.user.maKhachHang}">

                <input type="hidden"
                       name="maSuatChieu"
                       value="${maSuatChieu}">

                <input type="hidden"
                       id="seatIds"
                       name="seatIds">

                <input type="hidden"
                       id="tongTien"
                       name="tongTien">

                <h5>Số ghế lấy được : ${seatList.size()}</h5>

                <div class="mb-4">

                    <c:forEach var="seat" items="${seatList}">

                        <button
                                type="button"
                                class="btn btn-outline-secondary m-1 seat-btn"
                                data-id="${seat.maGhe}">

                            ${seat.hangGhe}${seat.soGhe}

                        </button>

                    </c:forEach>

                </div>

                <div class="alert alert-info">

                    Tổng tiền:
                    <strong id="totalPrice">
                        0
                    </strong>
                    VNĐ

                </div>

                <button class="btn btn-success">

                    Thanh toán

                </button>

            </form>

        </div>

    </div>

</div>

<script>

    const seatButtons =
        document.querySelectorAll(".seat-btn");

    const seatIds =
        document.getElementById("seatIds");

    const tongTien =
        document.getElementById("tongTien");

    const totalPrice =
        document.getElementById("totalPrice");

    const selected = [];

    const PRICE = 110000;

    seatButtons.forEach(button => {

        button.addEventListener("click", function () {

            const id =
                this.dataset.id;

            if (selected.includes(id)) {

                selected.splice(
                    selected.indexOf(id),
                    1
                );

                this.classList.remove("btn-success");

                this.classList.add("btn-outline-secondary");

            } else {

                selected.push(id);

                this.classList.remove("btn-outline-secondary");

                this.classList.add("btn-success");

            }

            seatIds.value =
                selected.join(",");

            tongTien.value =
                selected.length * PRICE;

            totalPrice.innerText =
                (selected.length * PRICE).toLocaleString("vi-VN");

        });

    });

</script>

</body>
</html>