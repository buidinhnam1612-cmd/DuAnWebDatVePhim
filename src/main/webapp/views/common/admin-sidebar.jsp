<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Lấy thông tin vai trò và quyền từ session
    String sidebarRole = (String) session.getAttribute("role");
    java.util.List<String> sidebarPermissions =
            (java.util.List<String>) session.getAttribute("userPermissions");

    boolean isAdmin = "ADMIN".equals(sidebarRole);

    // Hàm kiểm tra quyền
    // Admin luôn có toàn bộ quyền
    // Nhân viên kiểm tra trong danh sách permission
%>
<%!
    // Phương thức kiểm tra quyền dùng trong JSP
    public static boolean hasAnyPerm(String role, java.util.List<String> perms, String... required) {
        if ("ADMIN".equalsIgnoreCase(role) || "VT01".equalsIgnoreCase(role)) return true;
        if (perms == null || perms.isEmpty()) return false;
        for (String r : required) {
            if (perms.contains(r)) return true;
        }
        return false;
    }
%>
<div class="sidebar-brand d-flex align-items-center gap-3">
    <div class="brand-icon"><i class="bi bi-film"></i></div>
    <div>
        <div class="text-white fw-bold" style="font-size: 15px; letter-spacing: 0.5px;">FPT CINEMA</div>
        <div style="font-size: 10px; color: #64748b; text-transform: uppercase; letter-spacing: 1px;">
            <% if (isAdmin) { %>Admin Panel<% } else { %>Nhân viên<% } %>
        </div>
    </div>
</div>

<div class="p-2">
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link<%= "dashboard".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-grid-1x2-fill me-2"></i> Tổng quan Dashboard
            </a>
        </li>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q08", "Q06", "Q09", "MANAGE_THEATER", "MANAGE_GENRE", "MANAGE_ROOM")) { %>
        <div class="menu-header">Hạ tầng & Danh mục</div>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q02", "MANAGE_THEATER")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "theater".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/theater">
                <i class="bi bi-building me-2"></i> Quản lý rạp phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q03", "MANAGE_GENRE")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "genre".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/genre">
                <i class="bi bi-tags me-2"></i> Quản lý thể loại phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q04", "MANAGE_ROOM")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "room".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/room">
                <i class="bi bi-door-open me-2"></i> Quản lý phòng phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q06", "VIEW_SHOWTIME", "MANAGE_SHOWTIME")) { %>
        <div class="menu-header">Phim & Lịch chiếu</div>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q05", "MANAGE_MOVIE")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "movie".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/movie">
                <i class="bi bi-camera-reels me-2"></i> Quản lý phim
            </a>
        </li>
        <% } %>

<% if (hasAnyPerm(sidebarRole, sidebarPermissions,
        "Q06", "VIEW_SHOWTIME", "MANAGE_SHOWTIME")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "showtime".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/showtime">
                <i class="bi bi-calendar3 me-2"></i> Quản lý suất chiếu
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q07", "VIEW_BOOKING", "CHECKIN_BOOKING",
                "CANCEL_BOOKING", "CHANGE_BOOKING", "MANAGE_BOOKING")) { %>
        <div class="menu-header">Kinh doanh & Thành viên</div>
        <% } %>

<% if (hasAnyPerm(sidebarRole, sidebarPermissions,
        "Q07", "VIEW_BOOKING", "CHECKIN_BOOKING",
        "CANCEL_BOOKING", "CHANGE_BOOKING", "MANAGE_BOOKING")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "booking".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/booking">
                <i class="bi bi-ticket-detailed me-2"></i> Quản lý đặt vé
            </a>
        </li>
        <% } %>

        <%-- ===================== XÁC NHẬN TRẠNG THÁI VÉ ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q08", "CHECKIN_BOOKING", "MANAGE_BOOKING")) {
            boolean isConfirmActive = "confirmBooking".equals(request.getAttribute("currentPage"))
                                   || request.getRequestURI().contains("confirm-booking");
        %>
        <li class="nav-item <%= isConfirmActive ? "active" : "" %>" style="position: relative;">
            <% if (isConfirmActive) { %>
                <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background-color: #ff4d4d;"></div>
            <% } %>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/confirm-booking">
                <i class="bi bi-check2-circle me-2"></i> Xác nhận trạng thái vé
            </a>
        </li>
        <% } %>

        <%-- ===================== SƠ ĐỒ GHẾ ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q09", "VIEW_SEAT")) {
            boolean isSeatActive = "seat".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item <%= isSeatActive ? "active" : "" %>" style="position: relative;">
            <% if (isSeatActive) { %>
                <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background-color: #ff4d4d;"></div>
            <% } %>
            <a class="nav-link<%= isSeatActive ? " active" : "" %>" href="${pageContext.request.contextPath}/admin/seat">
                <i class="bi bi-grid-3x3 me-2"></i> Sơ đồ ghế
            </a>
        </li>
        <% } %>

        <%-- ===================== QUẢN LÝ ĐỒ ĂN ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q10", "VIEW_FOOD", "MANAGE_FOOD")) {
            boolean isFoodActive = "food".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item <%= isFoodActive ? "active" : "" %>" style="position: relative;">
            <% if (isFoodActive) { %>
                <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background-color: #ff4d4d;"></div>
            <% } %>
            <a class="nav-link<%= isFoodActive ? " active" : "" %>" href="${pageContext.request.contextPath}/admin/food">
                <i class="bi bi-cup-straw me-2"></i> Quản lý đồ ăn
            </a>
        </li>
        <% } %>

        <%-- ===================== QUẢN LÝ NGƯỜI DÙNG ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q11", "MANAGE_USER")) {
            boolean isUserActive = "user".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item <%= isUserActive ? "active" : "" %>" style="position: relative;">
            <% if (isUserActive) { %>
                <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background-color: #ff4d4d;"></div>
            <% } %>
            <a class="nav-link<%= isUserActive ? " active" : "" %>" href="${pageContext.request.contextPath}/admin/user">
                <i class="bi bi-people me-2"></i> Quản lý người dùng
            </a>
        </li>
        <% } %>

        <%-- ===================== TIÊU ĐỀ HỆ THỐNG & BÁO CÁO ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q13", "Q14", "Q15", "MANAGE_EMPLOYEE", "VIEW_REPORT", "EXPORT_REPORT",
                "VIEW_SHIFT_REPORT", "VIEW_COMMENT", "MODERATE_COMMENT")) { %>
        <div class="menu-header">Hệ thống & Báo cáo</div>
        <% } %>

        <%-- ===================== NHÂN VIÊN & PHÂN QUYỀN ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q14", "MANAGE_EMPLOYEE")) {
            boolean isEmployeeActive = "employee".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item <%= isEmployeeActive ? "active" : "" %>" style="position: relative;">
            <% if (isEmployeeActive) { %>
                <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background-color: #ff4d4d;"></div>
            <% } %>
            <a class="nav-link<%= isEmployeeActive ? " active" : "" %>" href="${pageContext.request.contextPath}/admin/employee">
                <i class="bi bi-shield-lock me-2"></i> Nhân viên & Phân quyền
            </a>
        </li>
        <% } %>

        <%-- ===================== THỐNG KÊ & BÁO CÁO ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q13", "VIEW_REPORT", "VIEW_SHIFT_REPORT")) {
            boolean isReportActive = "report".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item <%= isReportActive ? "active" : "" %>" style="position: relative;">
            <% if (isReportActive) { %>
                <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background-color: #ff4d4d;"></div>
            <% } %>
            <a class="nav-link<%= isReportActive ? " active" : "" %>" href="${pageContext.request.contextPath}/admin/report">
                <i class="bi bi-bar-chart-line me-2"></i> Thống kê & Báo cáo
            </a>
        </li>
        <% } %>

        <%-- ===================== KIỂM DUYỆT BÌNH LUẬN (Đã sửa lỗi phân quyền ẩn menu) ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q15", "VIEW_COMMENT", "MODERATE_COMMENT")) {
            boolean isCommentActive = "comment".equals(request.getAttribute("currentPage"))
                                   || request.getRequestURI().contains("comment");
        %>
        <li class="nav-item <%= isCommentActive ? "active" : "" %>" style="position: relative;">
            <% if (isCommentActive) { %>
                <div style="position: absolute; left: 0; top: 0; bottom: 0; width: 4px; background-color: #ff4d4d;"></div>
            <% } %>
            <a class="nav-link<%= isCommentActive ? " active" : "" %>" href="${pageContext.request.contextPath}/admin/comment">
                <i class="bi bi-chat-dots me-2"></i> Kiểm duyệt bình luận
            </a>
        </li>
        <% } %>



        <li class="nav-item" style="margin-top: 12px; padding-top: 12px; border-top: 1px solid rgba(255,255,255,0.06);">
            <a class="nav-link" href="${pageContext.request.contextPath}/home" style="color: #f87171 !important;">
                <i class="bi bi-power me-2"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>
