<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Báo cáo thống kê</title>

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
    margin-bottom:25px;

}

.summary{

    display:grid;
    grid-template-columns:repeat(4,1fr);
    gap:20px;
    margin-bottom:30px;

}

.card{

    background:white;
    padding:25px;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,.1);
    text-align:center;

}

.card h3{

    margin:0;
    color:#666;

}

.card h1{

    color:#2563eb;
    margin-top:15px;

}

.section{

    background:white;
    padding:20px;
    border-radius:10px;
    box-shadow:0 2px 8px rgba(0,0,0,.1);
    margin-bottom:30px;

}

.section h3{

    color:#2563eb;
    margin-bottom:20px;

}

table{

    width:100%;
    border-collapse:collapse;

}

th{

    background:#2563eb;
    color:white;
    padding:12px;

}

td{

    padding:12px;
    border-bottom:1px solid #ddd;
    text-align:center;

}

tr:hover{

    background:#f3f4f6;

}

.money{

    color:#16a34a;
    font-weight:bold;

}

</style>

</head>

<body>

<div class="container">

<h2>Báo cáo thống kê</h2>

<div class="summary">

<div class="card">

<h3>Tổng doanh thu</h3>

<h1 class="money">

${report.tongDoanhThu}

</h1>

</div>

<div class="card">

<h3>Vé đã bán</h3>

<h1>

${report.tongVeBan}

</h1>

</div>

<div class="card">

<h3>Vé đã hủy</h3>

<h1>

${report.tongVeHuy}

</h1>

</div>

<div class="card">

<h3>Khách hàng</h3>

<h1>

${report.tongKhachHang}

</h1>

</div>

</div>

<div class="section">

<h3>

Top phim bán chạy

</h3>

<table>

<tr>

<th>STT</th>

<th>Tên phim</th>

<th>Số vé</th>

<th>Doanh thu</th>

</tr>

<c:forEach items="${topMovies}" var="movie" varStatus="st">

<tr>

<td>

${st.count}

</td>

<td>

${movie.tenPhim}

</td>

<td>

${movie.soVe}

</td>

<td class="money">

${movie.doanhThu}

</td>

</tr>

</c:forEach>

</table>

</div>

<div class="section">

<h3>

Doanh thu theo ngày

</h3>

<table>

<tr>

<th>Ngày</th>

<th>Doanh thu</th>

</tr>

<c:forEach items="${dailyRevenue}" var="d">

<tr>

<td>

${d.ngay}

</td>

<td class="money">

${d.doanhThu}

</td>

</tr>

</c:forEach>

</table>

</div>

</div>

</body>

</html>