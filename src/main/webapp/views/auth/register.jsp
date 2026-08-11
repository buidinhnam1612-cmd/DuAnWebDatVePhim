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
                          autocomplete="off">


                        <div class="mb-3">

                            <label class="form-label fw-semibold">

                                <i class="bi bi-person-fill me-2"></i>
                                Họ và tên

                            </label>

                            <input type="text"
                                   class="form-control"
                                   name="fullName"
                                   value="${param.fullName}"
                                   placeholder="Nhập họ và tên"
                                   required>

                        </div>



                        <div class="mb-3">

                            <label class="form-label fw-semibold">

                                <i class="bi bi-envelope-fill me-2"></i>
                                Email

                            </label>

                            <input type="email"
                                   class="form-control"
                                   name="email"
                                   value="${param.email}"
                                   placeholder="Nhập email"
                                   required>

                        </div>



                        <div class="mb-3">

                            <label class="form-label fw-semibold">

                                <i class="bi bi-telephone-fill me-2"></i>
                                Số điện thoại

                            </label>

                            <input type="text"
                                   class="form-control"
                                   name="phone"
                                   value="${param.phone}"
                                   placeholder="Nhập số điện thoại"
                                   required>

                        </div>



                        <div class="mb-3">

                            <label class="form-label fw-semibold">

                                <i class="bi bi-lock-fill me-2"></i>
                                Mật khẩu

                            </label>

                            <input type="password"
                                   class="form-control"
                                   name="password"
                                   placeholder="Nhập mật khẩu"
                                   required>

                        </div>



                        <div class="mb-4">

                            <label class="form-label fw-semibold">

                                <i class="bi bi-shield-lock-fill me-2"></i>
                                Xác nhận mật khẩu

                            </label>

                            <input type="password"
                                   class="form-control"
                                   name="confirmPassword"
                                   placeholder="Nhập lại mật khẩu"
                                   required>

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