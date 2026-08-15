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
    .field-error {
        color: #dc2626;
        font-size: 0.85rem;
        margin-top: 0.25rem;
        font-weight: 500;
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


                    <% if(request.getAttribute("error") != null){ %>

                    <div class="alert alert-danger">
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
                          autocomplete="off" novalidate>


                        <div class="mb-3">

                            <label class="form-label fw-semibold">
                                <i class="bi bi-envelope-fill me-2"></i>
                                Tên đăng nhập hoặc Email <span class="text-danger">*</span>
                            </label>

                            <input type="text"
                                   class="form-control <%= request.getAttribute("loginInputError") != null ? "is-invalid" : "" %>"
                                   name="loginInput"
                                   value="${loginInput != null ? loginInput : param.loginInput}"
                                   placeholder="Nhập tên đăng nhập hoặc email">

                            <% if(request.getAttribute("loginInputError") != null){ %>
                            <div class="field-error">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                <%=request.getAttribute("loginInputError")%>
                            </div>
                            <% } %>

                        </div>


                        <div class="mb-4">

                            <label class="form-label fw-semibold">
                                <i class="bi bi-lock-fill me-2"></i>
                                Mật khẩu <span class="text-danger">*</span>
                            </label>

                            <input type="password"
                                   class="form-control <%= request.getAttribute("passwordError") != null ? "is-invalid" : "" %>"
                                   name="password"
                                   placeholder="Nhập mật khẩu">

                            <% if(request.getAttribute("passwordError") != null){ %>
                            <div class="field-error">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                <%=request.getAttribute("passwordError")%>
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