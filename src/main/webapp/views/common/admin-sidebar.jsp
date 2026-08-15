<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    String sidebarRole = (String) session.getAttribute("role");

    java.util.List<String> sidebarPermissions =
            (java.util.List<String>) session.getAttribute("userPermissions");

    boolean isAdmin =
            "ADMIN".equalsIgnoreCase(sidebarRole)
            || "VT01".equalsIgnoreCase(sidebarRole);
%>

<%!
    public static boolean hasPerm(
            String role,
            java.util.List<String> permissions,
            String requiredPermission) {

        // Admin / VT01 có toàn quyền
        if ("ADMIN".equalsIgnoreCase(role)
                || "VT01".equalsIgnoreCase(role)) {
            return true;
        }

        if (permissions == null || permissions.isEmpty()) {
            return false;
        }

        return permissions.contains(requiredPermission);
    }
%>

<div class="sidebar-brand d-flex align-items-center gap-3">
    <div class="brand-icon">
        <i class="bi bi-film"></i>
    </div>

    <div>
        <div class="text-white fw-bold"
             style="font-size: 15px; letter-spacing: 0.5px;">
            FPT CINEMA
        </div>

        <div style="font-size: 10px;
                    color: #64748b;
                    text-transform: uppercase;
                    letter-spacing: 1px;">

            <% if (isAdmin) { %>
                Admin Panel
            <% } else { %>
                Nhân viên
            <% } %>

        </div>
    </div>
</div>


<div class="p-2">

    <ul class="nav flex-column">


        <!-- =====================================================
             Q01 - DASHBOARD
             Dashboard được mở cho nhân viên theo test.
        ====================================================== -->

        <li class="nav-item">

            <a class="nav-link<%= "dashboard".equals(request.getAttribute("currentPage"))
                    ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/dashboard">

                <i class="bi bi-grid-1x2-fill me-2"></i>
                Tổng quan Dashboard

            </a>

        </li>


        <!-- =====================================================
             HẠ TẦNG & DANH MỤC
        ====================================================== -->

        <%
            boolean showInfrastructure =
                    hasPerm(sidebarRole, sidebarPermissions, "Q02")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q03")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q04");
        %>

        <% if (showInfrastructure) { %>

            <div class="menu-header">
                Hạ tầng & Danh mục
            </div>

        <% } %>


        <!-- Q02 - QUẢN LÝ RẠP -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q02")) { %>

            <li class="nav-item">

                <a class="nav-link<%= "theater".equals(request.getAttribute("currentPage"))
                        ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/theater">

                    <i class="bi bi-building me-2"></i>
                    Quản lý rạp phim

                </a>

            </li>

        <% } %>


        <!-- Q03 - QUẢN LÝ THỂ LOẠI -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q03")) { %>

            <li class="nav-item">

                <a class="nav-link<%= "genre".equals(request.getAttribute("currentPage"))
                        ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/genre">

                    <i class="bi bi-tags me-2"></i>
                    Quản lý thể loại phim

                </a>

            </li>

        <% } %>


        <!-- Q04 - QUẢN LÝ PHÒNG -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q04")) { %>

            <li class="nav-item">

                <a class="nav-link<%= "room".equals(request.getAttribute("currentPage"))
                        ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/room">

                    <i class="bi bi-door-open me-2"></i>
                    Quản lý phòng phim

                </a>

            </li>

        <% } %>



        <!-- =====================================================
             PHIM & LỊCH CHIẾU
        ====================================================== -->

        <%
            boolean showMovieSection =
                    hasPerm(sidebarRole, sidebarPermissions, "Q05")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q06");
        %>

        <% if (showMovieSection) { %>

            <div class="menu-header">
                Phim & Lịch chiếu
            </div>

        <% } %>


        <!-- Q05 - QUẢN LÝ PHIM -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q05")) { %>

            <li class="nav-item">

                <a class="nav-link<%= "movie".equals(request.getAttribute("currentPage"))
                        ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/movie">

                    <i class="bi bi-camera-reels me-2"></i>
                    Quản lý phim

                </a>

            </li>

        <% } %>


        <!-- Q06 - QUẢN LÝ SUẤT CHIẾU -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q06")) { %>

            <li class="nav-item">

                <a class="nav-link<%= "showtime".equals(request.getAttribute("currentPage"))
                        ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/showtime">

                    <i class="bi bi-calendar3 me-2"></i>
                    Quản lý suất chiếu

                </a>

            </li>

        <% } %>



        <!-- =====================================================
             KINH DOANH & THÀNH VIÊN
        ====================================================== -->

        <%
            boolean showBusinessSection =
                    hasPerm(sidebarRole, sidebarPermissions, "Q07")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q08")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q09")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q10")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q11");
        %>

        <% if (showBusinessSection) { %>

            <div class="menu-header">
                Kinh doanh & Thành viên
            </div>

        <% } %>


        <!-- Q07 - QUẢN LÝ ĐẶT VÉ -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q07")) { %>

            <li class="nav-item">

                <a class="nav-link<%= "booking".equals(request.getAttribute("currentPage"))
                        ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/booking">

                    <i class="bi bi-ticket-detailed me-2"></i>
                    Quản lý đặt vé

                </a>

            </li>

        <% } %>


        <!-- Q08 - XÁC NHẬN TRẠNG THÁI VÉ -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q08")) {

            boolean isConfirmActive =
                    "confirmBooking".equals(request.getAttribute("currentPage"))
                    || request.getRequestURI().contains("confirm-booking");

        %>

            <li class="nav-item <%= isConfirmActive ? "active" : "" %>"
                style="position: relative;">

                <% if (isConfirmActive) { %>

                    <div style="position: absolute;
                                left: 0;
                                top: 0;
                                bottom: 0;
                                width: 4px;
                                background-color: #ff4d4d;">
                    </div>

                <% } %>

                <a class="nav-link<%= isConfirmActive ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/confirm-booking">

                    <i class="bi bi-check2-circle me-2"></i>
                    Xác nhận trạng thái vé

                </a>

            </li>

        <% } %>


        <!-- Q09 - SƠ ĐỒ GHẾ -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q09")) {

            boolean isSeatActive =
                    "seat".equals(request.getAttribute("currentPage"));

        %>

            <li class="nav-item <%= isSeatActive ? "active" : "" %>"
                style="position: relative;">

                <% if (isSeatActive) { %>

                    <div style="position: absolute;
                                left: 0;
                                top: 0;
                                bottom: 0;
                                width: 4px;
                                background-color: #ff4d4d;">
                    </div>

                <% } %>

                <a class="nav-link<%= isSeatActive ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/seat">

                    <i class="bi bi-grid-3x3 me-2"></i>
                    Sơ đồ ghế

                </a>

            </li>

        <% } %>


        <!-- Q10 - QUẢN LÝ ĐỒ ĂN -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q10")) {

            boolean isFoodActive =
                    "food".equals(request.getAttribute("currentPage"));

        %>

            <li class="nav-item <%= isFoodActive ? "active" : "" %>"
                style="position: relative;">

                <% if (isFoodActive) { %>

                    <div style="position: absolute;
                                left: 0;
                                top: 0;
                                bottom: 0;
                                width: 4px;
                                background-color: #ff4d4d;">
                    </div>

                <% } %>

                <a class="nav-link<%= isFoodActive ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/food">

                    <i class="bi bi-cup-straw me-2"></i>
                    Quản lý đồ ăn

                </a>

            </li>

        <% } %>


        <!-- Q11 - QUẢN LÝ NGƯỜI DÙNG -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q11")) {

            boolean isUserActive =
                    "user".equals(request.getAttribute("currentPage"));

        %>

            <li class="nav-item <%= isUserActive ? "active" : "" %>"
                style="position: relative;">

                <% if (isUserActive) { %>

                    <div style="position: absolute;
                                left: 0;
                                top: 0;
                                bottom: 0;
                                width: 4px;
                                background-color: #ff4d4d;">
                    </div>

                <% } %>

                <a class="nav-link<%= isUserActive ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/user">

                    <i class="bi bi-people me-2"></i>
                    Quản lý người dùng

                </a>

            </li>

        <% } %>



        <!-- =====================================================
             HỆ THỐNG & BÁO CÁO
        ====================================================== -->

        <%
            boolean showSystemSection =
                    hasPerm(sidebarRole, sidebarPermissions, "Q12")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q13")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q14")
                    || hasPerm(sidebarRole, sidebarPermissions, "Q15");
        %>

        <% if (showSystemSection) { %>

            <div class="menu-header">
                Hệ thống & Báo cáo
            </div>

        <% } %>


        <!-- Q13 - THỐNG KÊ & BÁO CÁO (Q13 theo Mapping DB SQL) -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q13")) {

            boolean isReportActive =
                    "report".equals(request.getAttribute("currentPage"));

        %>

            <li class="nav-item <%= isReportActive ? "active" : "" %>"
                style="position: relative;">

                <% if (isReportActive) { %>

                    <div style="position: absolute;
                                left: 0;
                                top: 0;
                                bottom: 0;
                                width: 4px;
                                background-color: #ff4d4d;">
                    </div>

                <% } %>

                <a class="nav-link<%= isReportActive ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/report">

                    <i class="bi bi-bar-chart-line me-2"></i>
                    Thống kê & Báo cáo

                </a>

            </li>

        <% } %>


        <!-- Q14 - NHÂN VIÊN & PHÂN QUYỀN -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q14")) {

            boolean isEmployeeActive =
                    "employee".equals(request.getAttribute("currentPage"))
                    || request.getRequestURI().contains("/admin/employee");

        %>

            <li class="nav-item <%= isEmployeeActive ? "active" : "" %>"
                style="position: relative;">

                <% if (isEmployeeActive) { %>

                    <div style="position: absolute;
                                left: 0;
                                top: 0;
                                bottom: 0;
                                width: 4px;
                                background-color: #ff4d4d;">
                    </div>

                <% } %>

                <a class="nav-link<%= isEmployeeActive ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/employee">

                    <i class="bi bi-shield-lock me-2"></i>
                    Nhân viên & Phân quyền

                </a>

            </li>

        <% } %>


        <!-- Q15 - KIỂM DUYỆT BÌNH LUẬN -->

        <% if (hasPerm(sidebarRole, sidebarPermissions, "Q15")) {

            boolean isCommentActive =
                    "comment".equals(request.getAttribute("currentPage"))
                    || request.getRequestURI().contains("comment");

        %>

            <li class="nav-item <%= isCommentActive ? "active" : "" %>"
                style="position: relative;">

                <% if (isCommentActive) { %>

                    <div style="position: absolute;
                                left: 0;
                                top: 0;
                                bottom: 0;
                                width: 4px;
                                background-color: #ff4d4d;">
                    </div>

                <% } %>

                <a class="nav-link<%= isCommentActive ? " active" : "" %>"
                   href="${pageContext.request.contextPath}/admin/comment">

                    <i class="bi bi-chat-dots me-2"></i>
                    Kiểm duyệt bình luận

                </a>

            </li>

        <% } %>



        <!-- =====================================================
             ĐĂNG XUẤT
        ====================================================== -->

        <li class="nav-item"
            style="margin-top: 12px;
                   padding-top: 12px;
                   border-top: 1px solid rgba(255,255,255,0.06);">

            <a class="nav-link"
               href="${pageContext.request.contextPath}/home"
               style="color: #f87171 !important;">

                <i class="bi bi-power me-2"></i>
                Đăng xuất

            </a>

        </li>

    </ul>

</div>