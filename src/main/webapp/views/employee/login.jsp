<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1">

    <title>Đăng nhập nhân viên</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
          rel="stylesheet">

</head>

<body class="bg-light">

<div class="container">

    <div class="row justify-content-center mt-5">

        <div class="col-md-4">

            <div class="card shadow">

                <div class="card-body">

                    <h3 class="text-center text-primary mb-4">

                        <i class="bi bi-person-badge-fill"></i>

                        Đăng nhập nhân viên

                    </h3>

                    <form action="${pageContext.request.contextPath}/employee/login"
                          method="post">

                        <div class="mb-3">

                            <label class="form-label">
                                Tên đăng nhập
                            </label>

                            <input
                                    type="email"
                                    name="email"
                                    class="form-control"
                                    placeholder="Nhập email"
                                    required>

                        </div>

                        <div class="mb-3">

                            <label class="form-label">
                                Mật khẩu
                            </label>

                            <input
                                    type="password"
                                    name="password"
                                    class="form-control"
                                    required>

                        </div>

                        <div class="text-danger text-center mb-3">

                            ${error}

                        </div>

                        <button
                                class="btn btn-primary w-100">

                            Đăng nhập

                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>