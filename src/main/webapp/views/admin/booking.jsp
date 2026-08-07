<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>

    <meta charset="UTF-8">

    <title>Quản lý đặt vé</title>

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

        .booking-container{
            width:96%;
            margin:30px auto;
            background:#fff;
            padding:25px;
            border-radius:12px;
            box-shadow:0 5px 15px rgba(0,0,0,.08);
        }

        .booking-title{
            text-align:center;
            color:#d61f26;
            font-size:30px;
            margin-bottom:25px;
        }

        .booking-search-form{
            display:flex;
            justify-content:center;
            align-items:center;
            gap:10px;
            margin-bottom:25px;
        }

        .booking-search-input{
            width:420px;
            padding:10px 15px;
            border:1px solid #ccc;
            border-radius:6px;
            outline:none;
            font-size:14px;
            transition:.3s;
        }

        .booking-search-input:focus{
            border-color:#d61f26;
            box-shadow:0 0 5px rgba(214,31,38,.25);
        }

        .booking-search-button{
            padding:10px 18px;
            background:#d61f26;
            color:#fff;
            border:none;
            border-radius:6px;
            cursor:pointer;
            font-weight:bold;
            transition:.3s;
        }

        .booking-search-button:hover{
            background:#b6171d;
        }

        .booking-table{
            width:100%;
            border-collapse:collapse;
        }

        .booking-table th{
            background:#d61f26;
            color:#fff;
            padding:12px;
            font-size:14px;
            white-space:nowrap;
        }

        .booking-table td{
            padding:10px;
            border-bottom:1px solid #e8e8e8;
            text-align:center;
            font-size:14px;
            vertical-align:middle;
            word-break:break-word;
        }

        .booking-table tr:nth-child(even){
            background:#fafafa;
        }

        .booking-table tr:hover{
            background:#f5f7fb;
        }

        .money-column{
            text-align:right !important;
            font-weight:bold;
            color:#d61f26;
            white-space:nowrap;
        }

        .booking-status-select{
            width:140px;
            padding:7px;
            border:1px solid #ccc;
            border-radius:5px;
            outline:none;
        }

        .booking-update-button{
            margin-top:8px;
            width:100%;
            padding:8px;
            background:#28a745;
            color:#fff;
            border:none;
            border-radius:5px;
            cursor:pointer;
            font-weight:bold;
            transition:.3s;
        }

        .booking-update-button:hover{
            background:#218838;
        }

        .status-paid{
            display:inline-block;
            background:#28a745;
            color:#fff;
            padding:5px 12px;
            border-radius:20px;
            font-size:13px;
            font-weight:bold;
        }

        .status-wait{
            display:inline-block;
            background:#ffc107;
            color:#000;
            padding:5px 12px;
            border-radius:20px;
            font-size:13px;
            font-weight:bold;
        }

        .status-cancel{
            display:inline-block;
            background:#dc3545;
            color:#fff;
            padding:5px 12px;
            border-radius:20px;
            font-size:13px;
            font-weight:bold;
        }

        .booking-empty{
            text-align:center;
            padding:25px;
            color:#777;
            font-style:italic;
        }

    </style>

</head>

<body>

<div class="booking-container">

    <h2 class="booking-title">
        QUẢN LÝ DANH SÁCH ĐẶT VÉ
    </h2>

    <form action="${pageContext.request.contextPath}/admin/booking"
          method="get"
          class="booking-search-form">

        <input type="hidden"
               name="action"
               value="search">

        <input type="text"
               name="keyword"
               class="booking-search-input"
               placeholder="Tìm theo mã vé, khách hàng, phim, rạp hoặc trạng thái">

        <button type="submit"
                class="booking-search-button">
            Tìm kiếm
        </button>

    </form>

    <table class="booking-table">

        <tr>

            <th>Mã vé</th>

            <th>Khách hàng</th>

            <th>Phim</th>

            <th>Rạp</th>

            <th>Phòng</th>

            <th>Ghế</th>

            <th>Ngày chiếu</th>

            <th>Giờ</th>

            <th>Hình thức</th>

            <th>Tổng tiền</th>

            <th>Trạng thái</th>

            <th>Thao tác</th>

        </tr>
        <%

        if (bookingList != null && !bookingList.isEmpty()) {

            for (Booking b : bookingList) {

        %>

        <tr>

            <td>
                <%= b.getMaDatVe() %>
            </td>

            <td>
                <%= b.getTenKhachHang() %>
            </td>

            <td>
                <%= b.getTenPhim() %>
            </td>

            <td>
                <%= b.getTenRap() %>
            </td>

            <td>
                <%= b.getTenPhong() %>
            </td>

            <td>
                <%= b.getDanhSachGhe() %>
            </td>

            <td>
                <%= b.getNgayChieu() %>
            </td>

            <td>
                <%= b.getGioBatDau() %>
            </td>

            <td>
                <%= b.getHinhThucDat() %>
            </td>

            <td class="money-column">
                <%= String.format("%,.0f", b.getTongTien()) %> VNĐ
            </td>

                <%
                String statusClass = "";

                if ("Đã thanh toán".equals(b.getTrangThai())) {
                    statusClass = "status-paid";
                } else if ("Chờ thanh toán".equals(b.getTrangThai())) {
                    statusClass = "status-wait";
                } else {
                    statusClass = "status-cancel";
                }
                %>

                <td>
                    <span class="<%= statusClass %>">
                        <%= b.getTrangThai() %>
                    </span>
                </td>

            <td>

                <form action="${pageContext.request.contextPath}/admin/booking"
                      method="post">

                    <input type="hidden"
                           name="action"
                           value="updateStatus">

                    <input type="hidden"
                           name="maDatVe"
                           value="<%= b.getMaDatVe() %>">

                    <select name="trangThai"
                            class="booking-status-select">

                        <option value="Chờ thanh toán"
                            <%= "Chờ thanh toán".equals(b.getTrangThai()) ? "selected" : "" %>>
                            Chờ thanh toán
                        </option>

                        <option value="Đã thanh toán"
                            <%= "Đã thanh toán".equals(b.getTrangThai()) ? "selected" : "" %>>
                            Đã thanh toán
                        </option>

                        <option value="Đã hủy"
                            <%= "Đã hủy".equals(b.getTrangThai()) ? "selected" : "" %>>
                            Đã hủy
                        </option>

                    </select>

                    <br><br>

                    <button type="submit"
                            class="booking-update-button">

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

            <td colspan="12"
                class="booking-empty">

                Không có dữ liệu đặt vé.

            </td>

        </tr>

        <%

        }

        %>
    </table>

</div>

</body>

</html>