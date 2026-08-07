<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý đặt vé</title>

<style>

body{
    font-family: Arial, sans-serif;
    background:#f5f5f5;
    margin:0;
}

.container{
    width:95%;
    margin:30px auto;
}

h2{
    color:#2563eb;
}

.search-box{
    background:#fff;
    padding:20px;
    border-radius:8px;
    margin-bottom:20px;
}

.search-box input{
    width:250px;
    padding:10px;
    border:1px solid #ccc;
    border-radius:6px;
}

.search-box button{
    padding:10px 20px;
    background:#2563eb;
    color:white;
    border:none;
    border-radius:6px;
    cursor:pointer;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
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
    background:#f2f2f2;
}

.status{
    color:green;
    font-weight:bold;
}

</style>

</head>

<body>

<div class="container">

<h2>Quản lý danh sách đặt vé</h2>

<form action="${pageContext.request.contextPath}/employee/booking-list"
      method="get"
      class="search-box">

<input
type="text"
name="keyword"
placeholder="Mã vé / SĐT / Email"
value="${param.keyword}">

<button>Tìm kiếm</button>

</form>

<table>

<tr>

<th>Mã vé</th>

<th>Khách hàng</th>

<th>SĐT</th>

<th>Email</th>

<th>Thời gian đặt</th>

<th>Tổng tiền</th>

<th>Trạng thái</th>

</tr>

<c:forEach var="b" items="${listBooking}">

<tr>

<td>${b.maDatVe}</td>

<td>${b.hoTen}</td>

<td>${b.soDienThoai}</td>

<td>${b.email}</td>

<td>${b.thoiGianDat}</td>

<td>${b.tongTien}</td>

<td class="status">${b.trangThai}</td>

</tr>

</c:forEach>

</table>

</div>

</body>
</html>