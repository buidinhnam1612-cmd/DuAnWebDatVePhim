<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đặt vé thành công</title>

    <style>
        body{
            font-family: Arial, sans-serif;
            background:#f5f5f5;
            display:flex;
            justify-content:center;
            align-items:center;
            height:100vh;
        }

        .box{
            width:500px;
            background:white;
            padding:40px;
            border-radius:10px;
            text-align:center;
            box-shadow:0 0 15px rgba(0,0,0,.2);
        }

        h2{
            color:#c30017;
            margin-bottom:20px;
        }

        p{
            font-size:18px;
            line-height:30px;
        }

        a{
            display:inline-block;
            margin-top:30px;
            padding:12px 30px;
            background:#c30017;
            color:white;
            text-decoration:none;
            border-radius:5px;
        }

        a:hover{
            background:#990011;
        }

    </style>

</head>

<body>

<div class="box">

    <h2>🎉 Đặt vé thành công</h2>

    <p>
        Vé của bạn đã được giữ thành công.
    </p>

    <p>
        <b>Vui lòng ra quầy thanh toán để hoàn tất giao dịch.</b>
    </p>

    <p>
        Sau khi thanh toán, nhân viên sẽ xác nhận vé cho bạn.
    </p>

    <a href="${pageContext.request.contextPath}/home">
        Về trang chủ
    </a>

</div>

</body>
</html>