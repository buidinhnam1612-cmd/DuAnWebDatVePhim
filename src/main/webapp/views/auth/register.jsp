<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../common/header.jsp" %>
<%@ include file="../common/navbar.jsp" %>

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