<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.User"%>

<%
    List<User> userList = (List<User>) request.getAttribute("userList");

    String message = (String) session.getAttribute("message");

    if (message != null) {
        session.removeAttribute("message");
    }

    String keyword = request.getParameter("keyword");

    if (keyword == null) {
        keyword = "";
    }
%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <title>Quản lý người dùng</title>

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:Arial,sans-serif;
        }

        body{
            background:#eef2f7;
        }

        .user-container{
            width:96%;
            margin:30px auto;
            background:#ffffff;
            padding:25px;
            border-radius:12px;
            box-shadow:0 5px 15px rgba(0,0,0,.08);
        }

        .user-title{
            text-align:center;
            color:#d61f26;
            font-size:30px;
            margin-bottom:25px;
        }

        .success-message{
            width:60%;
            margin:0 auto 20px;
            padding:12px;
            background:#d4edda;
            color:#155724;
            border:1px solid #c3e6cb;
            border-radius:6px;
            text-align:center;
        }

        .search-form{
            display:flex;
            justify-content:center;
            align-items:center;
            gap:10px;
            margin-bottom:25px;
        }

        .search-input{
            width:420px;
            padding:10px 15px;
            border:1px solid #ccc;
            border-radius:6px;
            outline:none;
            font-size:14px;
        }

        .search-input:focus{
            border-color:#d61f26;
            box-shadow:0 0 5px rgba(214,31,38,.25);
        }

        .search-button{
            padding:10px 18px;
            background:#d61f26;
            color:white;
            border:none;
            border-radius:6px;
            cursor:pointer;
            font-weight:bold;
        }

        .search-button:hover{
            background:#b6171d;
        }

        .user-table{
            width:100%;
            border-collapse:collapse;
        }

        .user-table th{
            background:#d61f26;
            color:#fff;
            padding:12px;
            border:1px solid #ddd;
            white-space:nowrap;
        }

        .user-table td{
            padding:10px;
            border-bottom:1px solid #e5e5e5;
            text-align:center;
            vertical-align:middle;
        }

        .user-table tr:nth-child(even){
            background:#fafafa;
        }

        .user-table tr:hover{
            background:#f5f7fb;
        }

        .status-active{
            display:inline-block;
            background:#28a745;
            color:#fff;
            padding:5px 12px;
            border-radius:20px;
            font-size:13px;
            font-weight:bold;
        }

        .status-lock{
            display:inline-block;
            background:#dc3545;
            color:#fff;
            padding:5px 12px;
            border-radius:20px;
            font-size:13px;
            font-weight:bold;
        }

        .status-select{
            width:120px;
            padding:7px;
            border:1px solid #ccc;
            border-radius:5px;
        }

        .update-button{
            margin-top:8px;
            width:100%;
            padding:8px;
            background:#28a745;
            color:#fff;
            border:none;
            border-radius:5px;
            cursor:pointer;
            font-weight:bold;
        }

        .update-button:hover{
            background:#218838;
        }

        .user-empty{
            text-align:center;
            padding:20px;
            color:#777;
            font-style:italic;
        }
        .user-table td:nth-child(4){
            max-width:220px;
            word-break:break-word;
        }

        .user-table td:nth-child(5){
            white-space:nowrap;
        }

        .status-select{
            margin-bottom:8px;
        }

        .update-button{
            margin-top:0;
        }

        .search-input{
            transition:0.3s;
        }

        .search-button{
            transition:0.3s;
        }

    </style>

</head>

<body>

<div class="user-container">

    <h2 class="user-title">
        QUẢN LÝ NGƯỜI DÙNG
    </h2>

    <% if(message != null){ %>

    <div class="success-message">

        <%= message %>

    </div>

    <% } %>

    <form
            class="search-form"
            method="get"
            action="<%=request.getContextPath()%>/admin/user">

        <input
                type="hidden"
                name="action"
                value="search">

        <input
                type="text"
                name="keyword"
                class="search-input"
                value="<%= keyword %>"
                placeholder="Nhập mã KH, tên đăng nhập, họ tên, email hoặc SĐT">

        <button
                type="submit"
                class="search-button">

            Tìm kiếm

        </button>

    </form>

    <table class="user-table">

        <thead>

        <tr>

            <th>Mã KH</th>

            <th>Tên đăng nhập</th>

            <th>Họ tên</th>

            <th>Email</th>

            <th>SĐT</th>

            <th>Giới tính</th>

            <th>Ngày sinh</th>

            <th>Điểm</th>

            <th>Trạng thái</th>

            <th>Thao tác</th>

        </tr>

        </thead>

        <tbody>
        <%

        if (userList != null && !userList.isEmpty()) {

            for (User u : userList) {

        %>

        <tr>

            <td>
                <%= u.getMaKhachHang() %>
            </td>

            <td>
                <%= u.getTenDangNhap() %>
            </td>

            <td>
                <%= u.getHoTen() %>
            </td>

            <td>
                <%= u.getEmail() %>
            </td>

            <td>
                <%= u.getSoDienThoai() %>
            </td>

            <td>
                <%= u.getGioiTinh() %>
            </td>

            <td>
                <%= u.getNgaySinh() %>
            </td>

            <td>
                <%= u.getDiemTichLuy() %>
            </td>

            <td>

                <% if ("Hoạt động".equals(u.getTrangThai())) { %>

                    <span class="status-active">

                        Hoạt động

                    </span>

                <% } else { %>

                    <span class="status-lock">

                        Khóa

                    </span>

                <% } %>

            </td>

            <td>

                <form
                        method="post"
                        action="<%=request.getContextPath()%>/admin/user">

                    <input
                            type="hidden"
                            name="action"
                            value="updateStatus">

                    <input
                            type="hidden"
                            name="maKhachHang"
                            value="<%= u.getMaKhachHang() %>">

                    <select
                            name="trangThai"
                            class="status-select">

                        <option
                                value="Hoạt động"
                                <%= "Hoạt động".equals(u.getTrangThai()) ? "selected" : "" %>>

                            Hoạt động

                        </option>

                        <option
                                value="Khóa"
                                <%= "Khóa".equals(u.getTrangThai()) ? "selected" : "" %>>

                            Khóa

                        </option>

                    </select>

                    <br><br>

                    <button
                            type="submit"
                            class="update-button">

                        Cập nhật

                    </button>

                </form>

            </td>

        </tr>

        <%

            }

        } else {

        %>

        <tr>

            <td
                    colspan="10"
                    class="user-empty">

                Không có dữ liệu người dùng.

            </td>

        </tr>

        <%

        }

        %>
           </tbody>

       </table>

   </div>

   </body>

   </html>