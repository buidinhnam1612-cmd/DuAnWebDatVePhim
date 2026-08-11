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

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q08", "MANAGE_THEATER")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "theater".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/theater">
                <i class="bi bi-building me-2"></i> 1. Quản lý rạp phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q06", "MANAGE_GENRE")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "genre".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/genre">
                <i class="bi bi-tags me-2"></i> 2. Quản lý thể loại phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q09", "MANAGE_ROOM")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "room".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/room">
                <i class="bi bi-door-open me-2"></i> 3. Quản lý phòng phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q05", "Q07", "MANAGE_MOVIE", "MANAGE_SHOWTIME", "VIEW_SHOWTIME")) { %>
        <div class="menu-header">Phim & Lịch chiếu</div>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q05", "MANAGE_MOVIE")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "movie".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/movie">
                <i class="bi bi-camera-reels me-2"></i> 4. Quản lý phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q07", "VIEW_SHOWTIME", "MANAGE_SHOWTIME")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "showtime".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/showtime">
                <i class="bi bi-calendar3 me-2"></i> 5. Quản lý suất chiếu
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q02", "Q03", "Q04", "Q10", "Q11", "Q12",
                "VIEW_BOOKING", "CHECKIN_BOOKING", "CANCEL_BOOKING", "CHANGE_BOOKING",
                "MANAGE_BOOKING", "MANAGE_USER", "VIEW_SEAT",
                "VIEW_FOOD", "MANAGE_FOOD")) { %>
        <div class="menu-header">Kinh doanh & Thành viên</div>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q02", "Q03", "VIEW_BOOKING", "CHECKIN_BOOKING", "CANCEL_BOOKING",
                "CHANGE_BOOKING", "MANAGE_BOOKING")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "booking".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/booking">
                <i class="bi bi-ticket-detailed me-2"></i> 6. Quản lý đặt vé
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q02", "Q03", "CHECKIN_BOOKING", "MANAGE_BOOKING")) { %>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/confirm-booking">
                <i class="bi bi-check2-circle me-2"></i> 7. Xác nhận trạng thái vé
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q10", "VIEW_SEAT")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "seat".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/seat">
                <i class="bi bi-grid-3x3 me-2"></i> Sơ đồ ghế
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q11", "VIEW_FOOD", "MANAGE_FOOD")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "food".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/food">
                <i class="bi bi-cup-straw me-2"></i> Quản lý đồ ăn
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q04", "MANAGE_USER")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "user".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/user">
                <i class="bi bi-people me-2"></i> 8. Quản lý người dùng
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q13", "Q14", "Q15", "MANAGE_EMPLOYEE", "VIEW_REPORT", "EXPORT_REPORT",
                "VIEW_SHIFT_REPORT", "VIEW_COMMENT", "MODERATE_COMMENT")) { %>
        <div class="menu-header">Hệ thống & Báo cáo</div>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q14", "Q15", "MANAGE_EMPLOYEE")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "employee".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/employee">
                <i class="bi bi-shield-lock me-2"></i> 9. Nhân viên & Phân quyền
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "Q13", "VIEW_REPORT", "VIEW_SHIFT_REPORT")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "report".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/report">
                <i class="bi bi-bar-chart-line me-2"></i> 10. Thống kê & Báo cáo
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions,
                "VIEW_COMMENT", "MODERATE_COMMENT")) { %>

        <li class="nav-item">
            <a class="nav-link<%= "comment".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/comment">

                <i class="bi bi-chat-dots me-2"></i>
                Kiểm duyệt bình luận

            </a>
        </li>

        <% } %>

        <li class="nav-item" style="margin-top: 12px; padding-top: 12px; border-top: 1px solid rgba(255,255,255,0.06);">
            <a class="nav-link" href="${pageContext.request.contextPath}/home" style="color: #f87171 !important;">
                <i class="bi bi-box-arrow-left me-2"></i> Trở về Trang chủ
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="${pageContext.request.contextPath}/logout" style="color: #f87171 !important;">
                <i class="bi bi-power me-2"></i> Đăng xuất
            </a>
        </li>
    </ul>
</div>
