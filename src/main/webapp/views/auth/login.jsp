<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

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
                          autocomplete="off">


                        <div class="mb-3">

                            <label class="form-label fw-semibold">
                                <i class="bi bi-envelope-fill me-2"></i>
                                Email
                            </label>

                        <input type="text"
                               class="form-control"
                               name="loginInput"
                               value="${param.loginInput}"
                               placeholder="Nhập tên đăng nhập hoặc email"
                               required>

                        </div>


                        <div class="mb-4">

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