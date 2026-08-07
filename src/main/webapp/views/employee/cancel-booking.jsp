<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Hỗ trợ hủy vé</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    background:#f4f6f9;
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
    border-radius:8px;
    margin-bottom:20px;
    box-shadow:0 2px 8px rgba(0,0,0,.08);
}

.search-box input{

    width:320px;
    padding:10px;
    border:1px solid #ccc;
    border-radius:5px;
    outline:none;

}

.search-box button{

    padding:10px 20px;
    margin-left:10px;
    border:none;
    background:#2563eb;
    color:white;
    border-radius:5px;
    cursor:pointer;

}

.search-box button:hover{

    background:#1d4ed8;

}

.message{

    margin-bottom:20px;
    padding:12px;
    background:#e8f5e9;
    border:1px solid #4caf50;
    color:#2e7d32;
    border-radius:5px;

}

table{

    width:100%;
    border-collapse:collapse;
    background:white;
    box-shadow:0 2px 8px rgba(0,0,0,.08);

}

table th{

    background:#2563eb;
    color:white;
    padding:12px;

}

table td{

    padding:12px;
    border-bottom:1px solid #ddd;
    text-align:center;

}

tr:hover{

    background:#f5f5f5;

}

.cancel-btn{

    background:#dc2626;
    color:white;
    border:none;
    padding:8px 16px;
    border-radius:5px;
    cursor:pointer;

}

.cancel-btn:hover{

    background:#b91c1c;

}

.disable{

    color:red;
    font-weight:bold;

}

.no-data{

    text-align:center;
    padding:20px;
    color:#777;

}

</style>

</head>

<body>

<div class="container">

<h2>Hỗ trợ hủy vé</h2>

<form class="search-box"
      action="${pageContext.request.contextPath}/employee/cancel-booking"
      method="get">

    <input
            type="text"
            name="keyword"
            placeholder="Nhập mã vé / SĐT / Email"
            value="${param.keyword}">

    <button type="submit">
        Tìm kiếm
    </button>

</form>

<c:if test="${not empty message}">

    <div class="message">

        ${message}

    </div>

</c:if>

<table>

<tr>

    <th>Mã vé</th>
    <th>Khách hàng</th>
    <th>SĐT</th>
    <th>Email</th>
    <th>Phim</th>
    <th>Thời gian đặt</th>
    <th>Tổng tiền</th>
    <th>Trạng thái</th>
    <th>Thao tác</th>

</tr>

<c:choose>

<c:when test="${not empty listBooking}">

<c:forEach items="${listBooking}" var="b">

<tr>

<td>${b.maDatVe}</td>

<td>${b.hoTen}</td>

<td>${b.soDienThoai}</td>

<td>${b.email}</td>

<td>${b.tenPhim}</td>

<td>${b.thoiGianDat}</td>

<td>${b.tongTien}</td>

<td>${b.trangThai}</td>

<td>

<c:choose>

<c:when test="${b.allowCancel}">

<form
action="${pageContext.request.contextPath}/employee/cancel-booking"
method="post">

<input
type="hidden"
name="maDatVe"
value="${b.maDatVe}">

<button
type="submit"
class="cancel-btn">

Hủy vé

</button>

</form>

</c:when>

<c:otherwise>

<span class="disable">

Không thể hủy

</span>

</c:otherwise>

</c:choose>

</td>

</tr>

</c:forEach>

</c:when>

<c:otherwise>

<tr>

<td colspan="9" class="no-data">

Không tìm thấy dữ liệu.

</td>

</tr>

</c:otherwise>

</c:choose>

</table>

</div>

</body>

</html>