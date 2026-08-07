<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Xác nhận trạng thái đặt vé</title>

<style>

body{
    margin:0;
    background:#f5f5f5;
    font-family:Arial,sans-serif;
}

.container{
    width:95%;
    margin:30px auto;
}

h2{
    color:#2563eb;
    margin-bottom:20px;
}

.search-box{
    background:#fff;
    padding:20px;
    border-radius:10px;
    margin-bottom:25px;
}

.search-box input{
    width:420px;
    padding:12px;
    border:2px solid #d1d5db;
    border-radius:8px;
    font-size:15px;
}

.search-box button{
    padding:12px 25px;
    background:#2563eb;
    color:#fff;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-size:15px;
}

.search-box button:hover{
    background:#1d4ed8;
}

.message{
    background:#dcfce7;
    color:#166534;
    padding:12px;
    border-radius:8px;
    margin-bottom:20px;
    font-weight:bold;
}

.card{
    background:#fff;
    padding:30px;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,.1);
}

.info{
    display:grid;
    grid-template-columns:220px 1fr;
    row-gap:18px;
}

.label{
    font-weight:bold;
    color:#374151;
    font-size:16px;
}

.value{
    color:#111827;
    font-size:16px;
}

.confirm-btn{

    margin-top:30px;
    background:#16a34a;
    color:#fff;
    border:none;
    padding:12px 28px;
    border-radius:8px;
    cursor:pointer;
    font-size:15px;

}

.confirm-btn:hover{

    background:#15803d;

}

.status-message{

    margin-top:25px;
    font-size:18px;
    font-weight:bold;

}

.used{

    color:#2563eb;

}

.cancel{

    color:#dc2626;

}

.wait{

    color:#dc2626;

}

</style>

</head>

<body>

<div class="container">

<h2>Xác nhận trạng thái đặt vé</h2>

<form method="get"
action="${pageContext.request.contextPath}/employee/confirm-booking"
class="search-box">

<input
type="text"
name="keyword"
placeholder="Quét mã QR hoặc nhập mã vé"
value="${param.keyword}"
autofocus>

<button>
Tra cứu
</button>

</form>

<c:if test="${not empty sessionScope.message}">

<div class="message">

${sessionScope.message}

</div>

<c:remove var="message" scope="session"/>

</c:if>

<c:if test="${not empty booking}">

<div class="card">

<div class="info">

<div class="label">Mã vé</div>
<div class="value">${booking.maDatVe}</div>

<div class="label">Khách hàng</div>
<div class="value">${booking.hoTen}</div>

<div class="label">Số điện thoại</div>
<div class="value">${booking.soDienThoai}</div>

<div class="label">Email</div>
<div class="value">${booking.email}</div>

<div class="label">Tên phim</div>
<div class="value">${booking.tenPhim}</div>

<div class="label">Ngày chiếu</div>
<div class="value">${booking.ngayChieu}</div>

<div class="label">Giờ chiếu</div>
<div class="value">${booking.gioBatDau}</div>

<div class="label">Tổng tiền</div>
<div class="value">${booking.tongTien}</div>

<div class="label">Trạng thái</div>
<div class="value">${booking.trangThai}</div>

</div>

<c:choose>

    <c:when test="${booking.trangThai=='Đã thanh toán'}">

        <form method="post"
              action="${pageContext.request.contextPath}/employee/confirm-booking">

            <input
                    type="hidden"
                    name="maDatVe"
                    value="${booking.maDatVe}">

            <button class="confirm-btn">
                Xác nhận khách đã vào rạp
            </button>

        </form>

    </c:when>

    <c:when test="${booking.trangThai=='Đã sử dụng'}">

        <div class="status-message used">
            ✅ Vé này đã được sử dụng.
        </div>

    </c:when>

    <c:when test="${booking.trangThai=='Đã hủy'}">

        <div class="status-message cancel">
            ❌ Vé đã bị hủy.
        </div>

    </c:when>

    <c:otherwise>

        <div class="status-message wait">
            ⚠ Vé chưa thanh toán, không thể xác nhận.
        </div>

    </c:otherwise>

</c:choose>

</div>

</c:if>

</div>

</body>

</html>