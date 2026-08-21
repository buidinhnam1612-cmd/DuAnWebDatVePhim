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

        <div class="col-lg-6">

            <div class="card shadow border-0 rounded-4">

                <div class="card-body p-5">


                    <h2 class="text-center mb-4 fw-bold">

                        <i class="bi bi-person-plus-fill me-2"></i>

                        Đăng ký

                    </h2>


                    <% if(request.getAttribute("error") != null){ %>

                    <div class="alert alert-danger">

                        <%=request.getAttribute("error")%>

                    </div>

                    <% } %>


                    <form method="post"
                          action="${pageContext.request.contextPath}/register"
                          autocomplete="off" novalidate>


                        <div class="mb-3">

                            <label class="form-label fw-semibold">
                                <i class="bi bi-person-fill me-2"></i>
                                Họ và tên <span class="text-danger">*</span>
                            </label>

                            <input type="text"
                                   class="form-control <%= request.getAttribute("fullNameError") != null ? "is-invalid" : "" %>"
                                   name="fullName"
value="${fullName != null ? fullName : param.fullName}"
                                   placeholder="Nhập họ và tên">

                            <% if(request.getAttribute("fullNameError") != null){ %>
                            <div class="field-error">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                <%=request.getAttribute("fullNameError")%>
                            </div>
                            <% } %>

                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">
                                <i class="bi bi-person-badge-fill me-2"></i>
                                Tên đăng nhập <span class="text-danger">*</span>
                            </label>
                            <input type="text"
                                   class="form-control <%= request.getAttribute("usernameError") != null ? "is-invalid" : "" %>"
                                   name="username"
                                   value="${username != null ? username : param.username}"
                                   placeholder="Nhập tên đăng nhập">
                            <% if(request.getAttribute("usernameError") != null){ %>
                            <div class="field-error">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                <%=request.getAttribute("usernameError")%>
                            </div>
                            <% } %>
                        </div>

                        <div class="mb-3">

                            <label class="form-label fw-semibold">
                                <i class="bi bi-envelope-fill me-2"></i>
                                Email <span class="text-danger">*</span>
                            </label>

                            <input type="email"
                                   class="form-control <%= request.getAttribute("emailError") != null ? "is-invalid" : "" %>"
                                   name="email"
                                   value="${email != null ? email : param.email}"
                                   placeholder="Nhập email">

                            <% if(request.getAttribute("emailError") != null){ %>
                            <div class="field-error">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                <%=request.getAttribute("emailError")%>
                            </div>
                            <% } %>

                        </div>



                        <div class="mb-3">

                            <label class="form-label fw-semibold">
                                <i class="bi bi-telephone-fill me-2"></i>
                                Số điện thoại <span class="text-danger">*</span>
                            </label>
<input type="tel"
                                   class="form-control <%= request.getAttribute("phoneError") != null ? "is-invalid" : "" %>"
                                   name="phone"
                                   value="${phone != null ? phone : param.phone}"
                                   placeholder="Nhập 10 số điện thoại (Ví dụ: 0912345678)"
                                   inputmode="numeric">

                            <% if(request.getAttribute("phoneError") != null){ %>
                            <div class="field-error">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                <%=request.getAttribute("phoneError")%>
                            </div>
                            <% } %>

                        </div>



                        <div class="mb-3">

                            <label class="form-label fw-semibold">

                                <i class="bi bi-lock-fill me-2"></i>
                                Mật khẩu  <span class="text-danger">*</span>

                            </label>

                            <input type="password"
                                   class="form-control <%= request.getAttribute("passwordError") != null ? "is-invalid" : "" %>"
                                   name="password"
                                   placeholder="Nhập mật khẩu (Ít nhất 6 ký tự)">

                            <% if(request.getAttribute("passwordError") != null){ %>
                            <div class="field-error">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                <%=request.getAttribute("passwordError")%>
                            </div>
                            <% } %>

                        </div>



                        <div class="mb-4">

                            <label class="form-label fw-semibold">

                                <i class="bi bi-shield-lock-fill me-2"></i>
                                Xác nhận mật khẩu <span class="text-danger">*</span>

                            </label>

                            <input type="password"
                                   class="form-control <%= request.getAttribute("confirmPasswordError") != null ? "is-invalid" : "" %>"
                                   name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu">

                            <% if(request.getAttribute("confirmPasswordError") != null){ %>
                            <div class="field-error">
                                <i class="bi bi-exclamation-circle me-1"></i>
                                <%=request.getAttribute("confirmPasswordError")%>
                            </div>
                            <% } %>

                        </div>



                        <button type="submit"
class="btn btn-danger w-100">

                            <i class="bi bi-check-circle-fill me-2"></i>

                            Đăng ký

                        </button>


                    </form>



                    <div class="text-center mt-4">

                        Đã có tài khoản?

                        <a href="${pageContext.request.contextPath}/login"
                           class="text-danger fw-semibold text-decoration-none">

                            Đăng nhập

                        </a>

                    </div>


                </div>

            </div>

        </div>

    </div>

</div>


<%@ include file="../common/footer.jsp" %>

<%@ include file="../common/script.jsp" %>
