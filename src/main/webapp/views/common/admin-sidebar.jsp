<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    // Lấy thông tin vai trò và quyền từ session
    String sidebarRole = (String) session.getAttribute("role");
    java.util.List<String> sidebarPermissions =
            (java.util.List<String>) session.getAttribute("userPermissions");

    boolean isAdmin = "ADMIN".equals(sidebarRole);
%>
<%!
    // Phương thức kiểm tra quyền chuẩn hóa theo mã Q hệ thống
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
            <% if (isAdmin) { %>Admin Panel<% } else { %>Nhân viên quầy<% } %>
        </div>
    </div>
</div>

<div class="p-2">
    <ul class="nav flex-column">
        <!-- TẤT CẢ VAI TRÒ ĐỀU THẤY TRANG TỔNG QUAN -->
        <li class="nav-item">
            <a class="nav-link<%= "dashboard".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/dashboard">
                <i class="bi bi-grid-1x2-fill me-2"></i> Tổng quan Dashboard
            </a>
        </li>

        <%-- ===================== KHỐI 1: HẠ TẦNG & DANH MỤC (Độc quyền Admin) ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q08", "Q06", "Q09")) { %>
        <div class="menu-header">Hạ tầng & Danh mục</div>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q08")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "theater".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/theater">
                <i class="bi bi-building me-2"></i> Quản lý rạp phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q06")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "genre".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/genre">
                <i class="bi bi-tags me-2"></i> Quản lý thể loại phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q09")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "room".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/room">
                <i class="bi bi-door-open me-2"></i> Quản lý phòng phim
            </a>
        </li>
        <% } %>

        <%-- ===================== KHỐI 2: PHIM & LỊCH CHIẾU (Độc quyền Admin) ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q05", "Q07")) { %>
        <div class="menu-header">Phim & Lịch chiếu</div>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q05")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "movie".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/movie">
                <i class="bi bi-camera-reels me-2"></i> Quản lý phim
            </a>
        </li>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q07")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "showtime".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/showtime">
                <i class="bi bi-calendar3 me-2"></i> Quản lý suất chiếu
            </a>
        </li>
        <% } %>

        <%-- ===================== KHỐI 3: KINH DOANH NGHIỆP VỤ QUẦY ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q02", "Q03", "Q04", "Q10", "Q11", "Q12")) { %>
        <div class="menu-header">Kinh doanh & Thành viên</div>
        <% } %>

        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q02", "Q03")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "booking".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/booking">
                <i class="bi bi-ticket-detailed me-2"></i> Quản lý danh sách đặt vé
            </a>
        </li>
        <% } %>

        <%-- Xác nhận trạng thái vé (Dành cho Admin và Nhân viên bán vé soát vé) --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q02", "Q03")) {
            boolean isConfirmActive = "confirmBooking".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item <%= isConfirmActive ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/admin/confirm-booking"
               class="nav-link ${currentPage == 'confirm-booking' ? 'active' : ''}">
                <i class="bi bi-ticket-perforated me-2"></i> Xác nhận trạng thái vé
            </a>
        </li>
        <% } %>

        <%-- Sơ đồ ghế (Q10 - Xem tình trạng ghế trống phòng chiếu) --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q10")) {
            boolean isSeatActive = "seat".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item">
            <a class="nav-link<%= isSeatActive ? " active" : "" %>" href="${pageContext.request.contextPath}/admin/seat">
                <i class="bi bi-grid-3x3 me-2"></i> Sơ đồ ghế hệ thống
            </a>
        </li>
        <% } %>

        <%-- Quản lý đồ ăn bắp nước (Q11 - Dành cho Admin và Nhân viên quầy đồ ăn) --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q11")) {
            boolean isFoodActive = "food".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item">
            <a class="nav-link<%= isFoodActive ? " active" : "" %>" href="${pageContext.request.contextPath}/admin/food">
                <i class="bi bi-cup-straw me-2"></i> Quản lý đồ ăn bắp nước
            </a>
        </li>
        <% } %>

        <%-- Quản lý khách hàng thành viên (Q04) --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q04")) {
            boolean isUserActive = "user".equals(request.getAttribute("currentPage"));
        %>
        <li class="nav-item <%= isUserActive ? "active" : "" %>">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/user">
                <i class="bi bi-people me-2"></i> Quản lý khách hàng
            </a>
        </li>
        <% } %>

        <%-- ===================== KHỐI 4: HỆ THỐNG & THỐNG KÊ (Phần cao cấp) ===================== --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q14", "Q06", "Q13")) { %>
        <div class="menu-header">Hệ thống & Thống kê</div>
        <% } %>

        <%-- Quản lý nhân viên (Q14) --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q14")) { %>
        <li class="nav-item">
            <a class="nav-link<%= "employee".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/employee">
                <i class="bi bi-shield-lock me-2"></i> Quản lý nhân viên
            </a>
        </li>
        <% } %>

        <%-- Báo cáo doanh thu rạp (Q13 - Độc quyền Admin xem tài chính tổng) --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q13") && isAdmin) { %>
        <li class="nav-item">
            <a class="nav-link<%= "revenueReport".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/revenue-report">
                <i class="bi bi-graph-up-arrow me-2 text-success"></i> Báo cáo doanh thu rạp
            </a>
        </li>
        <% } %>

        <%-- Kiểm duyệt bình luận đánh giá (Q06 - Độc quyền Admin) --%>
        <% if (hasAnyPerm(sidebarRole, sidebarPermissions, "Q06") && isAdmin) { %>
        <li class="nav-item">
            <a class="nav-link<%= "comment".equals(request.getAttribute("currentPage")) ? " active" : "" %>"
               href="${pageContext.request.contextPath}/admin/comment">
                <i class="bi bi-chat-left-text me-2"></i> Kiểm duyệt bình luận
            </a>
        </li>
        <% } %>

        <!-- NÚT ĐĂNG XUẤT -->
        <li class="nav-item mt-4">
            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                <i class="bi bi-box-arrow-left me-2"></i> Đăng xuất hệ thống
            </a>
        </li>
    </ul>
</div>
