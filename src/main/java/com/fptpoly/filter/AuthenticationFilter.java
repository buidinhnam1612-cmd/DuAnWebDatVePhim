package com.fptpoly.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// Filter đăng ký trong web.xml để đảm bảo thứ tự chạy trước AuthorizationFilter
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest servletRequest,
                         ServletResponse servletResponse,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        HttpSession session = request.getSession(false);

        // Kiểm tra đã đăng nhập chưa (employee hoặc user)
        boolean isLoggedIn = false;

        if (session != null) {
            Object employee = session.getAttribute("employee");
            if (employee != null) {
                isLoggedIn = true;
            }
        }

        if (!isLoggedIn) {
            // Chưa đăng nhập -> chuyển hướng về trang login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Đã đăng nhập -> cho đi tiếp
        chain.doFilter(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {
    }
}
