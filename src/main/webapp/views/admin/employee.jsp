<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.Employee"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Quản lý nhân viên</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/employee.css">

</head>

<body>

<div class="container">

    <h2>QUẢN LÝ NHÂN VIÊN</h2>

<form action="${pageContext.request.contextPath}/admin/employee"
      method="get"
      class="search-form">

    <input type="hidden"
           name="action"
           value="search">

    <input type="text"
           name="keyword"
           placeholder="Nhập mã, tên hoặc email...">

    <button type="submit">
        Tìm kiếm
    </button>

</form>

    <table>

        <thead>

        <tr>

            <th>Mã NV</th>
            <th>Họ tên</th>
            <th>Email</th>
            <th>SĐT</th>
            <th>Vai trò</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>

        </tr>

        </thead>

        <tbody>

<%

List<Employee> employeeList =
(List<Employee>)request.getAttribute("employeeList");

if(employeeList!=null){

for(Employee e : employeeList){

%>

<tr>

<td><%=e.getMaNhanVien()%></td>

<td><%=e.getHoTen()%></td>

<td><%=e.getEmail()%></td>

<td><%=e.getSoDienThoai()%></td>

<td><%=e.getTenVaiTro()%></td>

<td><%=e.getTrangThai()%></td>

<td>

<form action="${pageContext.request.contextPath}/admin/employee" method="post">

<input
type="hidden"
name="maNhanVien"
value="<%=e.getMaNhanVien()%>">


<select name="maVaiTro">

    <option value="VT01"
        <%= "VT01".equals(e.getMaVaiTro()) ? "selected" : "" %>>
        Admin
    </option>

    <option value="VT02"
        <%= "VT02".equals(e.getMaVaiTro()) ? "selected" : "" %>>
        Nhân viên
    </option>

</select>

<button
type="submit"
name="action"
value="updateRole">

Đổi quyền

</button>

</form>

<br>

<form action="${pageContext.request.contextPath}/admin/employee" method="post">

<input
type="hidden"
name="maNhanVien"
value="<%=e.getMaNhanVien()%>">

<select name="trangThai">

    <option value="Hoạt động"
        <%= "Hoạt động".equals(e.getTrangThai()) ? "selected" : "" %>>
        Hoạt động
    </option>

    <option value="Khóa"
        <%= "Khóa".equals(e.getTrangThai()) ? "selected" : "" %>>
        Khóa
    </option>

</select>

<button
type="submit"
name="action"
value="updateStatus">

Cập nhật

</button>

</form>

</td>

</tr>

<%

}

}

%>

</tbody>

</table>

</div>

</body>
</html>