package com.fptpoly.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebFilter("/admin/*") // Đảm bảo bộ lọc bao phủ toàn bộ phân hệ quản trị admin
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

        // Đọc URL path thuần túy loại bỏ contextPath để so sánh chính xác
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI;
        if (contextPath != null && !contextPath.isEmpty()) {
            path = requestURI.substring(contextPath.length());
        }

        // Nếu là trang Login hoặc các file tĩnh (css, js, image) thì bỏ qua không chặn
        if (path.startsWith("/login") || path.contains(".") || path.startsWith("/assets")) {
            chain.doFilter(servletRequest, servletResponse);
            return;
        }

        if (session == null || session.getAttribute("role") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("role");

        // ADMIN hoặc VT01 sở hữu toàn quyền hệ thống -> Cho qua trực tiếp
        if ("ADMIN".equalsIgnoreCase(role) || "VT01".equalsIgnoreCase(role)) {
            chain.doFilter(servletRequest, servletResponse);
            return;
        }

        // NHÂN VIÊN hoặc VT02 -> Tiến hành kiểm soát chặt chẽ danh sách mã Q
        if ("EMPLOYEE".equalsIgnoreCase(role) || "VT02".equalsIgnoreCase(role)) {

            // Trang tổng quan Dashboard luôn mở cho mọi nhân viên
            if ("/admin/dashboard".equals(path)) {
                chain.doFilter(servletRequest, servletResponse);
                return;
            }

            List<String> userPermissions = (List<String>) session.getAttribute("userPermissions");

            // Thực hiện gọi hàm kiểm tra quyền khớp nối giữa URL và mã Q
            boolean hasPermission = checkPermission(path, userPermissions);

            if (hasPermission) {
                chain.doFilter(servletRequest, servletResponse);
            } else {
                // ĐỒNG BỘ DỮ LIỆU: Đẩy thông báo lỗi sang cả Request và Session để giao diện jsp đọc không bị sót
                request.setAttribute("error", "Bạn không có quyền truy cập chức năng này!");
                session.setAttribute("error", "Bạn không có quyền truy cập chức năng này!");

                request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
            }
            return;
        }

        // Vai trò không hợp lệ
        response.sendRedirect(request.getContextPath() + "/login");
    }

    /**
     * Kiểm tra quyền dựa trên URL path và danh sách mã quyền (Q01 -> Q15)
     */
    private boolean checkPermission(String path, List<String> permissions) {

        if (permissions == null || permissions.isEmpty()) {
            return false;
        }

        // Đã sửa lỗi: Thêm đường dẫn mục số 7 gán đồng bộ vào mã quyền Q07 soát vé
        if ("/admin/confirm-booking".equals(path) || "/admin/showtime".equals(path)) {
            return permissions.contains("Q07") || permissions.contains("VIEW_SHOWTIME")
                    || permissions.contains("MANAGE_SHOWTIME");
        }

        if ("/admin/booking".equals(path)) {
            return permissions.contains("Q02") || permissions.contains("Q03")
                    // Giữ lại bộ quyền mở rộng an toàn của bạn nhóm bạn
                    || permissions.contains("VIEW_BOOKING") || permissions.contains("CHECKIN_BOOKING")
                    || permissions.contains("CANCEL_BOOKING") || permissions.contains("CHANGE_BOOKING");
        }

        if ("/admin/food".equals(path)) {
            return permissions.contains("Q11") || permissions.contains("VIEW_FOOD")
                    || permissions.contains("MANAGE_FOOD");
        }

        if ("/admin/seat".equals(path)) {
            return permissions.contains("Q10") || permissions.contains("VIEW_SEAT");
        }

        if ("/admin/report".equals(path) || "/admin/export-report".equals(path)) {
            return permissions.contains("Q13") || permissions.contains("VIEW_SHIFT_REPORT")
                    || permissions.contains("VIEW_REPORT") || permissions.contains("EXPORT_REPORT");
        }

        if ("/admin/employee".equals(path) || "/admin/employee/permission".equals(path) || path.startsWith("/admin/employee")) {
            return permissions.contains("Q14") || permissions.contains("Q15") || permissions.contains("MANAGE_EMPLOYEE");
        }

        if ("/admin/user".equals(path)) {
            return permissions.contains("Q04") || permissions.contains("MANAGE_USER");
        }

        if ("/admin/movie".equals(path)) {
            return permissions.contains("Q05") || permissions.contains("MANAGE_MOVIE");
        }

        if ("/admin/room".equals(path)) {
            return permissions.contains("Q09") || permissions.contains("MANAGE_ROOM");
        }

        if ("/theater".equals(path)) {
            return permissions.contains("Q08") || permissions.contains("MANAGE_THEATER");
        }

        if ("/genre".equals(path)) {
            return permissions.contains("Q06") || permissions.contains("MANAGE_GENRE");
        }
        // ===================== CẤU HÌNH QUYỀN TRANG KIỂM DUYỆT BÌNH LUẬN =====================
        if ("/admin/comment".equals(path)) {
            // Cho phép qua nếu tài khoản có mã quyền VIEW_COMMENT, MODERATE_COMMENT hoặc mã quyền tổng Q13, Q14, Q15
            return permissions.contains("VIEW_COMMENT") || permissions.contains("MODERATE_COMMENT")
                    || permissions.contains("Q13") || permissions.contains("Q14") || permissions.contains("Q15");
        }

        return false; // Dòng return false gốc ở cuối file của bạn
    }


    @Override
    public void destroy() {
    }
}
