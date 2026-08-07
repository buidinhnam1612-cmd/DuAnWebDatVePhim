<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Kiểm duyệt bình luận</title>

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
}

.search-box{
    background:white;
    padding:20px;
    border-radius:8px;
    margin-bottom:20px;
}

.search-box input{
    width:320px;
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

.message{
    padding:12px;
    margin-bottom:20px;
    background:#dcfce7;
    color:#166534;
    border-radius:6px;
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
    background:#f8fafc;
}

.approve{
    background:#16a34a;
    color:white;
    border:none;
    padding:8px 15px;
    border-radius:5px;
    cursor:pointer;
    margin:2px;
}

.reject{
    background:#dc2626;
    color:white;
    border:none;
    padding:8px 15px;
    border-radius:5px;
    cursor:pointer;
    margin:2px;
}

.hide{
    background:#f59e0b;
    color:white;
    border:none;
    padding:8px 15px;
    border-radius:5px;
    cursor:pointer;
    margin:2px;
}

.delete{
    background:#7f1d1d;
    color:white;
    border:none;
    padding:8px 15px;
    border-radius:5px;
    cursor:pointer;
    margin:2px;
}

.status-pending{
    color:#f59e0b;
    font-weight:bold;
}

.status-approved{
    color:#16a34a;
    font-weight:bold;
}

.status-hidden{
    color:#6b7280;
    font-weight:bold;
}

.status-rejected{
    color:#dc2626;
    font-weight:bold;
}

.action-form{
    display:inline-block;
}

</style>

</head>

<body>

<div class="container">

<h2>Kiểm duyệt bình luận đánh giá</h2>

<form method="get"
action="${pageContext.request.contextPath}/employee/comment-management"
class="search-box">

<input
type="text"
name="keyword"
placeholder="Mã bình luận / Khách hàng / Phim"
value="${param.keyword}">

<button>Tìm kiếm</button>

</form>

<c:if test="${not empty sessionScope.message}">

<div class="message">

${sessionScope.message}

</div>

<c:remove var="message" scope="session"/>

</c:if>

<table>

<tr>

<th>Mã BL</th>

<th>Khách hàng</th>

<th>Phim</th>

<th>Số sao</th>

<th>Nội dung</th>

<th>Ngày tạo</th>

<th>Trạng thái</th>

<th>Thao tác</th>

</tr>

<c:choose>

<c:when test="${not empty listComment}">

<c:forEach items="${listComment}" var="c">
<tr>

<td>${c.maBinhLuan}</td>

<td>${c.hoTen}</td>

<td>${c.tenPhim}</td>

<td>${c.soSao} ⭐</td>

<td style="text-align:left;">
${c.noiDung}
</td>

<td>${c.ngayTao}</td>

<td>

<c:choose>

<c:when test="${c.trangThai=='Chờ duyệt'}">

<span class="status-pending">
${c.trangThai}
</span>

</c:when>

<c:when test="${c.trangThai=='Đã duyệt'}">

<span class="status-approved">
${c.trangThai}
</span>

</c:when>

<c:when test="${c.trangThai=='Đã ẩn'}">

<span class="status-hidden">
${c.trangThai}
</span>

</c:when>

<c:otherwise>

<span class="status-rejected">
${c.trangThai}
</span>

</c:otherwise>

</c:choose>

</td>

<td>

<c:choose>

<c:when test="${c.trangThai=='Chờ duyệt'}">

<form class="action-form"
      method="post"
      action="${pageContext.request.contextPath}/employee/comment-management">

<input type="hidden"
       name="action"
       value="approve">

<input type="hidden"
       name="maBinhLuan"
       value="${c.maBinhLuan}">

<button class="approve">
Duyệt
</button>

</form>

<form class="action-form"
      method="post"
      action="${pageContext.request.contextPath}/employee/comment-management">

<input type="hidden"
       name="action"
       value="reject">

<input type="hidden"
       name="maBinhLuan"
       value="${c.maBinhLuan}">

<button class="reject">
Từ chối
</button>

</form>

</c:when>

<c:when test="${c.trangThai=='Đã duyệt'}">

<form class="action-form"
      method="post"
      action="${pageContext.request.contextPath}/employee/comment-management">

<input type="hidden"
       name="action"
       value="hide">

<input type="hidden"
       name="maBinhLuan"
       value="${c.maBinhLuan}">

<button class="hide">
Ẩn
</button>

</form>

<form class="action-form"
      method="post"
      action="${pageContext.request.contextPath}/employee/comment-management">

<input type="hidden"
       name="action"
       value="delete">

<input type="hidden"
       name="maBinhLuan"
       value="${c.maBinhLuan}">

<button class="delete">
Xóa
</button>

</form>

</c:when>

<c:otherwise>

<form class="action-form"
      method="post"
      action="${pageContext.request.contextPath}/employee/comment-management">

<input type="hidden"
       name="action"
       value="delete">

<input type="hidden"
       name="maBinhLuan"
       value="${c.maBinhLuan}">

<button class="delete">
Xóa
</button>

</form>

</c:otherwise>

</c:choose>

</td>

</tr>

</c:forEach>

</c:when>

<c:otherwise>

<tr>

<td colspan="8">

Không có bình luận nào.

</td>

</tr>

</c:otherwise>

</c:choose>

</table>

</div>

</body>

</html>