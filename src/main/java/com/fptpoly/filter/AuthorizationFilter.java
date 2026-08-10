package com.fptpoly.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

// Filter đăng ký trong web.xml để đảm bảo thứ tự chạy sau AuthenticationFilter
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

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");

        if (role == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Admin có toàn bộ quyền -> cho đi tiếp
        if ("ADMIN".equals(role)) {
            chain.doFilter(servletRequest, servletResponse);
            return;
        }

        // Nhân viên -> kiểm tra quyền theo URL
        if ("EMPLOYEE".equals(role)) {

            String requestURI = request.getRequestURI();
            String contextPath = request.getContextPath();

            // Bỏ contextPath để lấy path thuần
            String path = requestURI;
            if (contextPath != null && !contextPath.isEmpty()) {
                path = requestURI.substring(contextPath.length());
            }

            // Dashboard luôn được truy cập
            if ("/admin/dashboard".equals(path)) {
                chain.doFilter(servletRequest, servletResponse);
                return;
            }

            // Lấy danh sách quyền từ session
            List<String> userPermissions =
                    (List<String>) session.getAttribute("userPermissions");

            // Kiểm tra quyền dựa theo URL
            boolean hasPermission = checkPermission(path, userPermissions);

            if (hasPermission) {
                chain.doFilter(servletRequest, servletResponse);
            } else {
                // Không có quyền -> redirect về dashboard kèm thông báo lỗi
                session.setAttribute("error",
                        "Bạn không có quyền truy cập chức năng này!");
                response.sendRedirect(
                        request.getContextPath() + "/admin/dashboard"
                );
            }
            return;
        }

        // Role không xác định
        response.sendRedirect(request.getContextPath() + "/login");
    }

    /**
     * Kiểm tra quyền dựa trên URL path và danh sách permission
     */
    private boolean checkPermission(String path,
                                    List<String> permissions) {

        if (permissions == null || permissions.isEmpty()) {
            return false;
        }

        // Mapping URL -> các quyền cần thiết
        // Chỉ cần CÓ MỘT trong các quyền là được truy cập

        if ("/admin/booking".equals(path)) {
            return permissions.contains("VIEW_BOOKING")
                    || permissions.contains("CHECKIN_BOOKING")
                    || permissions.contains("CANCEL_BOOKING")
                    || permissions.contains("CHANGE_BOOKING");
        }

        if ("/admin/showtime".equals(path)) {
            return permissions.contains("VIEW_SHOWTIME")
                    || permissions.contains("MANAGE_SHOWTIME");
        }

        if ("/admin/food".equals(path)) {
            return permissions.contains("VIEW_FOOD")
                    || permissions.contains("MANAGE_FOOD");
        }

        if ("/admin/seat".equals(path)) {
            return permissions.contains("VIEW_SEAT");
        }

        if ("/admin/report".equals(path)) {
            return permissions.contains("VIEW_SHIFT_REPORT")
                    || permissions.contains("VIEW_REPORT");
        }

        // Các trang quản trị nặng -> cần quyền quản lý tương ứng
        if ("/admin/employee".equals(path)) {
            return permissions.contains("MANAGE_EMPLOYEE");
        }

        if ("/admin/user".equals(path)) {
            return permissions.contains("MANAGE_USER");
        }

        if ("/admin/movie".equals(path)) {
            return permissions.contains("MANAGE_MOVIE");
        }

        if ("/admin/room".equals(path)) {
            return permissions.contains("MANAGE_ROOM");
        }

        if ("/theater".equals(path)) {
            return permissions.contains("MANAGE_THEATER");
        }

        if ("/genre".equals(path)) {
            return permissions.contains("MANAGE_GENRE");
        }

        if ("/admin/export-report".equals(path)) {
            return permissions.contains("EXPORT_REPORT");
        }

        // Mặc định từ chối
        return false;
    }

    @Override
    public void destroy() {
    }
}
