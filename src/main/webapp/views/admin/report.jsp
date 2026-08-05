
    <%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.util.List"%>
    <%@ page import="com.fptpoly.model.Report"%>

    <%

        List<Report> reports =
                (List<Report>) request.getAttribute("reports");

        List<Report> topCinema =
                (List<Report>) request.getAttribute("topCinema");

        List<Report> revenueByMonth =
                (List<Report>) request.getAttribute("revenueByMonth");

        List<Report> revenueByYear =
                (List<Report>) request.getAttribute("revenueByYear");

        List<Report> bookingStatus =
                (List<Report>) request.getAttribute("bookingStatus");

        List<Report> seatOccupancy =
                (List<Report>) request.getAttribute("seatOccupancy");


        Double doanhThu =
                (Double) request.getAttribute("doanhThu");

        Integer tongVe =
                (Integer) request.getAttribute("tongVe");

    %>


    <!DOCTYPE html>
    <html lang="vi">

    <head>

    <meta charset="UTF-8">

    <title>Báo cáo doanh thu</title>


    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
          rel="stylesheet">


    <style>


    .report-container{

        width:90%;

        margin:30px auto;

    }


    .report-title{

        text-align:center;

        font-weight:bold;

        margin-bottom:30px;

    }


    .summary-card{

        background:white;

        border-radius:10px;

        padding:25px;

        text-align:center;

        box-shadow:0 2px 8px rgba(0,0,0,0.1);

    }


    .summary-value{

        font-size:24px;

        font-weight:bold;

        color:#d61f26;

    }


    .section-title{

        margin-top:40px;

        margin-bottom:20px;

        font-weight:bold;

    }


    .revenue-text{

        color:#d61f26;

        font-weight:bold;

    }


    </style>


    </head>


    <body>


    <div class="container report-container">


    <h2 class="report-title">

    BÁO CÁO DOANH THU FPT CINEMA

    </h2>

    <div class="text-end mb-4">

        <a href="${pageContext.request.contextPath}/admin/export-report"
           class="btn btn-success">

            Xuất Excel

        </a>

    </div>

    <!-- Tổng quan -->

    <div class="row g-4">


    <div class="col-md-6">

    <div class="summary-card">


    <h5>
    Tổng doanh thu
    </h5>


<p class="summary-value">

<%= doanhThu != null
        ? String.format("%,.0f", doanhThu)
        : "0" %> VNĐ

</p>


    </div>

    </div>



    <div class="col-md-6">

    <div class="summary-card">


    <h5>
    Tổng số vé đã bán
    </h5>


    <p class="summary-value">

    <%= tongVe %>

    </p>


    </div>

    </div>


    </div>




    <!-- TOP PHIM -->


    <h3 class="section-title">

    Top phim bán chạy

    </h3>


    <table class="table table-bordered table-hover">


    <thead class="table-dark">

    <tr>

    <th>STT</th>

    <th>Tên phim</th>

    <th>Rạp</th>

    <th>Số vé</th>

    <th>Doanh thu</th>

    </tr>

    </thead>


    <tbody>


    <%

    if(reports != null && !reports.isEmpty()){


    int stt = 1;


    for(Report report : reports){

    %>


    <tr>


    <td>
    <%= stt++ %>
    </td>


    <td>
    <%= report.getTenPhim()%>
    </td>


    <td>
    <%= report.getTenRap()%>
    </td>


    <td>
    <%= report.getSoVe()%>
    </td>


    <td class="revenue-text">

    <%= report.getDoanhThu()%> VNĐ

    </td>


    </tr>


    <%

    }

    }else{

    %>


    <tr>

    <td colspan="5" class="text-center">

    Chưa có dữ liệu

    </td>

    </tr>


    <%

    }

    %>


    </tbody>


    </table>





    <!-- TOP RẠP -->


    <h3 class="section-title">

    Top rạp doanh thu cao nhất

    </h3>



    <table class="table table-bordered table-hover">


    <thead class="table-dark">

    <tr>

    <th>STT</th>

    <th>Tên rạp</th>

    <th>Tổng vé</th>

    <th>Doanh thu</th>

    </tr>

    </thead>


    <tbody>


    <%

    if(topCinema != null && !topCinema.isEmpty()){


    int stt = 1;


    for(Report cinema : topCinema){

    %>


    <tr>


    <td>
    <%=stt++%>
    </td>


    <td>
    <%=cinema.getTenRap()%>
    </td>


    <td>
    <%=cinema.getTongVe()%>
    </td>


    <td class="revenue-text">

    <%=cinema.getDoanhThu()%> VNĐ

    </td>


    </tr>


    <%

    }

    }else{

    %>


    <tr>

    <td colspan="4" class="text-center">

    Chưa có dữ liệu

    </td>

    </tr>


    <%

    }

    %>


    </tbody>


    </table>






    <!-- DOANH THU THÁNG -->


    <h3 class="section-title">

    Doanh thu theo tháng

    </h3>


    <table class="table table-bordered">


    <thead class="table-dark">

    <tr>

    <th>STT</th>

    <th>Tháng</th>

    <th>Doanh thu</th>

    </tr>


    </thead>


    <tbody>


    <%

    if(revenueByMonth != null){


    int stt = 1;


    for(Report month : revenueByMonth){

    %>


    <tr>


    <td>
    <%=stt++%>
    </td>


    <td>
    <%=month.getThang()%>
    </td>


    <td class="revenue-text">

    <%=month.getDoanhThu()%> VNĐ

    </td>


    </tr>


    <%

    }

    }

    %>


    </tbody>


    </table>







    <!-- DOANH THU NĂM -->


    <h3 class="section-title">

    Doanh thu theo năm

    </h3>


    <table class="table table-bordered">


    <thead class="table-dark">

    <tr>

    <th>STT</th>

    <th>Năm</th>

    <th>Doanh thu</th>

    </tr>


    </thead>


    <tbody>


    <%

    if(revenueByYear != null){


    int stt = 1;


    for(Report year : revenueByYear){

    %>


    <tr>


    <td>
    <%=stt++%>
    </td>


    <td>
    <%=year.getNam()%>
    </td>


    <td class="revenue-text">

    <%=year.getDoanhThu()%> VNĐ

    </td>


    </tr>


    <%

    }

    }

    %>


    </tbody>


    </table>







    <!-- TRẠNG THÁI VÉ -->


    <h3 class="section-title">

    Thống kê trạng thái vé

    </h3>


    <table class="table table-bordered">


    <thead class="table-dark">

    <tr>

    <th>Trạng thái</th>

    <th>Số lượng</th>

    </tr>


    </thead>


    <tbody>


    <%

    if(bookingStatus != null){


    for(Report status : bookingStatus){

    %>


    <tr>


    <td>

    <%=status.getTrangThai()%>

    </td>


    <td>

    <%=status.getSoLuong()%>

    </td>


    </tr>


    <%

    }

    }

    %>


    </tbody>


    </table>







    <!-- TỶ LỆ LẤP ĐẦY -->


    <h3 class="section-title">

    Tỷ lệ lấp đầy ghế

    </h3>


    <table class="table table-bordered">


    <thead class="table-dark">


    <tr>

    <th>Phim</th>

    <th>Ghế đã đặt</th>

    <th>Tổng ghế</th>

    <th>Tỷ lệ</th>


    </tr>


    </thead>


    <tbody>


    <%

    if(seatOccupancy != null){


    for(Report seat : seatOccupancy){

    %>


    <tr>


    <td>
    <%=seat.getTenPhim()%>
    </td>


    <td>
    <%=seat.getGheDaDat()%>
    </td>


    <td>
    <%=seat.getTongGhe()%>
    </td>


    <td>

    <%=String.format("%.2f", seat.getTiLeLapDay())%> %

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

