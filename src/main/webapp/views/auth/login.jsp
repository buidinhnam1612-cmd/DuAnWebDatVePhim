<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

<style>
    body {
        background-color: #f8fafc !important;
        color: #0f172a !important;
    }
    .card {
        background-color: #ffffff !important;
        border: 1px solid #e2e8f0 !important;
        color: #0f172a !important;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05) !important;
    }
    .card h2 {
        color: #0f172a !important;
    }
    .form-label {
        color: #475569 !important;
    }
    .form-control {
        background-color: #ffffff !important;
        border: 1px solid #cbd5e1 !important;
        color: #0f172a !important;
    }
    .form-control:focus {
        background-color: #ffffff !important;
        border-color: #e11d48 !important;
        color: #0f172a !important;
        box-shadow: 0 0 0 0.25rem rgba(225, 29, 72, 0.25) !important;
    }
    .btn-danger {
        background-color: #e11d48 !important;
        border: none !important;
        font-weight: 600 !important;
        padding: 10px !important;
    }
    .btn-danger:hover {
        background-color: #be123c !important;
        box-shadow: 0 0 15px rgba(225, 29, 72, 0.2) !important;
    }
    a.text-danger {
        color: #e11d48 !important;
    }
    a.text-danger:hover {
        color: #be123c !important;
    }
</style>

<div class="container py-5">

    <div class="row justify-content-center">

        <div class="col-lg-5">

            <div class="card shadow border-0 rounded-4">

                <div class="card-body p-5">

                    <h2 class="text-center mb-4 fw-bold">
                        <i class="bi bi-person-circle me-2"></i>
                        Đăng nhập
                    </h2>


                    <%-- Khối lỗi hệ thống dùng chung (Chờ duyệt, Bị khóa) --%>
                    <% if(request.getAttribute("error") != null){ %>

                    <div class="alert alert-danger" style="background-color: #fff1f2; color: #e11d48; padding: 12px; border-radius: 6px; margin-bottom: 20px; font-size: 14px; font-weight: 600; border: 1px solid #ffe4e6;">
                        <%=request.getAttribute("error")%>
                    </div>

                    <% } %>


                    <% if(request.getAttribute("success") != null){ %>

                    <div class="alert alert-success">
                        <%=request.getAttribute("success")%>
                    </div>

                    <% } %>


                    <form method="post"
                          action="${pageContext.request.contextPath}/login"
                          autocomplete="off">


                        <%-- Ô NHẬP TÀI KHOẢN HOẶC EMAIL --%>
                        <div class="mb-3">

                            <label class="form-label fw-semibold">
                                <i class="bi bi-envelope-fill me-2"></i>
                                Email <span style="color: #e11d48;">*</span>
                            </label>

                            <input type="text"
                                   class="form-control"
                                   name="loginInput"
                                   value="${oldLoginInput}"
                                   placeholder="Nhập tên đăng nhập hoặc email"
                                   required>

                            <%-- Dòng báo lỗi riêng cho Tài khoản không tồn tại --%>
                            <% if(request.getAttribute("emailError") != null){ %>
                                <div style="color: #e11d48; font-size: 13px; margin-top: 6px; font-weight: 500;">
                                    ⚠ <%=request.getAttribute("emailError")%>
                                </div>
                            <% } %>

                        </div>


                        <%-- Ô NHẬP MẬT KHẨU (ĐÃ SỬA: Chỉ giữ lại duy nhất 1 ô này) --%>
                        <div class="mb-4">

                            <label class="form-label fw-semibold">
                                <i class="bi bi-lock-fill me-2"></i>
                                Mật khẩu <span style="color: #e11d48;">*</span>
                            </label>

                            <input type="password"
                                   class="form-control"
                                   name="password"
                                   placeholder="Nhập mật khẩu"
                                   required>

                            <%-- Dòng báo lỗi riêng cho Sai Mật Khẩu --%>
                            <% if(request.getAttribute("passwordError") != null){ %>
                                <div style="color: #e11d48; font-size: 13px; margin-top: 6px; font-weight: 500;">
                                    ⚠ <%=request.getAttribute("passwordError")%>
                                </div>
                            <% } %>

                        </div>


                        <button type="submit"
                                class="btn btn-danger w-100">

                            <i class="bi bi-box-arrow-in-right me-2"></i>
                            Đăng nhập

                        </button>


                    </form>


                    <div class="text-center mt-4">

                        Chưa có tài khoản?

                        <a href="${pageContext.request.contextPath}/register"
                           class="text-danger fw-semibold text-decoration-none">

                            Đăng ký ngay

                        </a>

                    </div>


                </div>

            </div>

        </div>

    </div>

</div>


<%@ include file="../common/footer.jsp" %>

<%@ include file="../common/script.jsp" %>
