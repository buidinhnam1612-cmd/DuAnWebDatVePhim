package com.fptpoly.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebFilter(urlPatterns = {
        "/admin/*",
        "/theater",
        "/genre"
})
public class AuthorizationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    @SuppressWarnings("unchecked")
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        HttpSession session = request.getSession(false);

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();

        String path = requestURI;

        if (contextPath != null && !contextPath.isEmpty()
                && requestURI.startsWith(contextPath)) {
            path = requestURI.substring(contextPath.length());
        }

        /*
         * =========================================================
         * 1. KIỂM TRA SESSION ĐĂNG NHẬP
         * =========================================================
         */

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        String role = String.valueOf(session.getAttribute("role"));

        /*
         * =========================================================
         * 2. ADMIN / VT01
         *
         * Admin có toàn quyền hệ thống.
         * Không cần kiểm tra từng Q01 -> Q15.
         * =========================================================
         */

        if ("ADMIN".equalsIgnoreCase(role) || "VT01".equalsIgnoreCase(role)) {
            chain.doFilter(servletRequest, servletResponse);
            return;
        }

        /*
         * =========================================================
         * 3. KHÁCH HÀNG KHÔNG ĐƯỢC TRUY CẬP KHU VỰC ADMIN
         * =========================================================
         */

        if ("CUSTOMER".equalsIgnoreCase(role)) {
            response.sendRedirect(contextPath + "/home");
            return;
        }

        /*
         * =========================================================
         * 4. NHÂN VIÊN
         *
         * Lấy danh sách quyền đã bật trong Session.
         * =========================================================
         */

        List<String> userPermissions = (List<String>) session.getAttribute("userPermissions");

        if ("/admin/dashboard".equals(path)) {
            chain.doFilter(servletRequest, servletResponse);
            return;
        }

        /*
         * =========================================================
         * 5. KIỂM TRA QUYỀN THEO URL VỚI MAPPING CHUẨN TỪ SQL DB
         * =========================================================
         */

        boolean hasPermission = checkPermission(path, userPermissions);

        if (hasPermission) {
            chain.doFilter(servletRequest, servletResponse);
        } else {
            request.setAttribute("error", "Bạn không có quyền truy cập chức năng này!");
            request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
        }
    }

    /**
     * KIỂM TRA QUYỀN THEO MAPPING DATABASE GỐC SQL Q01 -> Q15:
     * Q01 = Tổng quan Dashboard (/admin/dashboard)
     * Q02 = Quản lý rạp phim (/theater)
     * Q03 = Quản lý thể loại phim (/genre)
     * Q04 = Quản lý phòng phim (/admin/room)
     * Q05 = Quản lý phim (/admin/movie)
     * Q06 = Quản lý suất chiếu (/admin/showtime)
     * Q07 = Quản lý đặt vé (/admin/booking)
     * Q08 = Xác nhận trạng thái vé (/admin/confirm-booking)
     * Q09 = Sơ đồ ghế (/admin/seat)
     * Q10 = Quản lý đồ ăn (/admin/food)
     * Q11 = Quản lý người dùng (/admin/user)
     * Q12 = Quản lý voucher (/admin/voucher)
     * Q13 = Thống kê & Báo cáo (/admin/report, /admin/export-report)
     * Q14 = Nhân viên & Phân quyền (/admin/employee, /admin/employee/*)
     * Q15 = Kiểm duyệt bình luận (/admin/comment)
     */
    private boolean checkPermission(String path, List<String> permissions) {
        if (permissions == null || permissions.isEmpty()) {
            return false;
        }

        if ("/theater".equals(path)) {
            return permissions.contains("Q02");
        }

        if ("/genre".equals(path)) {
            return permissions.contains("Q03");
        }

        if ("/admin/room".equals(path)) {
            return permissions.contains("Q04");
        }

        if ("/admin/movie".equals(path)) {
            return permissions.contains("Q05");
        }

        if ("/admin/showtime".equals(path)) {
            return permissions.contains("Q06");
        }

        if ("/admin/booking".equals(path)) {
            return permissions.contains("Q07");
        }

        if ("/admin/confirm-booking".equals(path)) {
            return permissions.contains("Q08");
        }

        if ("/admin/seat".equals(path)) {
            return permissions.contains("Q09");
        }

        if ("/admin/food".equals(path)) {
            return permissions.contains("Q10");
        }

        if ("/admin/user".equals(path)) {
            return permissions.contains("Q11");
        }

        if ("/admin/voucher".equals(path)) {
            return permissions.contains("Q12");
        }

        if ("/admin/report".equals(path) || "/admin/export-report".equals(path)) {
            return permissions.contains("Q13");
        }

        if (path.equals("/admin/employee")
                || path.equals("/admin/employee/permission")
                || path.startsWith("/admin/employee/")) {
            return permissions.contains("Q14");
        }

        if ("/admin/comment".equals(path)) {
            return permissions.contains("Q15");
        }
        if ("/admin/cancel-booking".equals(path)) {
            return permissions.contains("Q02");
        }

        return false;
    }

    @Override
    public void destroy() {
    }
}