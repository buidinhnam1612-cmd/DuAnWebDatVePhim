<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="employee-sidebar">

    <div class="employee-logo">
        <div class="logo-icon">
            🎬
        </div>

        <div class="logo-text">
            <h2>Cinema</h2>
            <span>Employee Panel</span>
        </div>
    </div>

    <ul class="employee-menu">

        <li class="active">
            <a href="dashboard.jsp">
                <span class="menu-icon">🏠</span>
                <span>Dashboard</span>
            </a>
        </li>

        <li>
            <a href="checkin.jsp">
                <span class="menu-icon">🎥</span>
                <span>Tra cứu xuất chiếu</span>
            </a>
        </li>

        <li>
            <a href="booking-list.jsp">
                <span class="menu-icon">🎫</span>
                <span>Danh sách đặt vé</span>
            </a>
        </li>

        <li>
            <a href="#">
                <span class="menu-icon">✅</span>
                <span>Xác nhận đặt vé</span>
            </a>
        </li>

        <li>
            <a href="food-management.jsp">
                <span class="menu-icon">🍿</span>
                <span>Đồ ăn đồ uống</span>
            </a>
        </li>

        <li>
            <a href="#">
                <span class="menu-icon">❌</span>
                <span>Hỗ trợ hủy vé</span>
            </a>
        </li>

        <li>
            <a href="#">
                <span class="menu-icon">⭐</span>
                <span>Kiểm duyệt đánh giá</span>
            </a>
        </li>

        <li>
            <a href="report.jsp">
                <span class="menu-icon">📊</span>
                <span>Báo cáo doanh thu</span>
            </a>
        </li>

    </ul>

    <div class="employee-sidebar-footer">

        <div class="employee-user">

            <div class="employee-avatar">
                NV
            </div>

            <div class="employee-info">
                <h4>Nhân viên</h4>
                <span>Ca sáng</span>
            </div>

        </div>

        <a href="../auth/login.jsp" class="logout-btn">

            🚪 Đăng xuất

        </a>

    </div>

</aside>
