<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.Comment"%>

<!DOCTYPE html>
<html lang="vi">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Quản lý đánh giá - FPT CINEMA</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
          rel="stylesheet">

    <style>

        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', system-ui, sans-serif;
        }

        .sidebar {
            min-height: 100vh;
            background-color: #1e293b;
            box-shadow: 2px 0 10px rgba(0,0,0,0.05);
        }

        .sidebar .nav-link {
            color: #94a3b8;
            border-radius: 8px;
            margin: 2px 0;
            padding: 10px 12px;
            font-size: 14px;
            transition: all 0.2s;
        }

        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background-color: #334155;
            color: #f8fafc !important;
        }

        .sidebar .nav-link.active {
            border-left: 4px solid #ef4444;
            border-radius: 0 8px 8px 0;
            background-color: #334155;
        }

        .menu-header {
            font-size: 11px;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 700;
            margin-top: 15px;
            margin-bottom: 5px;
            padding-left: 10px;
        }

        .content-card {
            border: none;
            border-radius: 14px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
        }

        .table th {
            background-color: #f8fafc;
            font-size: 13px;
            text-transform: uppercase;
            color: #64748b;
            font-weight: 700;
            white-space: nowrap;
        }

        .table td {
            vertical-align: middle;
            font-size: 14px;
        }

        .btn-action {
            padding: 5px 12px;
            font-size: 13px;
            border-radius: 6px;
        }

        .comment-content {
            max-width: 300px;
            line-height: 1.5;
        }

        .star {
            color: #f59e0b;
        }

        .empty-data {
            padding: 50px !important;
        }

    </style>

</head>

<body>

<%
    // BẢO MẬT: Kiểm tra nếu không có quyền Q06 thì đá tài khoản nhân viên ra ngoài
    java.util.List<String> checkPerms = (java.util.List<String>) session.getAttribute("userPermissions");

    if (checkPerms == null || !checkPerms.contains("Q15")) {
        session.setAttribute("error", "Hành động bị từ chối! Chức năng này thuộc quyền quản trị tối cao.");
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        return; // Dừng không cho load tiếp giao diện HTML bên dưới
    }

    // Nếu là Admin có quyền Q06 thì tiếp tục load trang bình thường
    request.setAttribute("currentPage", "comment");
%>

<div class="container-fluid">

    <div class="row">

        <!-- ================= SIDEBAR ================= -->

        <div class="col-md-3 col-lg-2 sidebar p-0 text-white">

            <jsp:include page="/views/common/admin-sidebar.jsp" />

        </div>


        <!-- ================= MAIN CONTENT ================= -->

        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">


            <!-- HEADER -->

            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">

                <div>

                    <h1 class="h3 fw-bold text-dark mb-1">

                        <i class="bi bi-chat-left-text me-2 text-danger"></i>

                        Quản Lý Đánh Giá

                    </h1>

                    <p class="text-muted mb-0">

                        Kiểm duyệt và quản lý đánh giá của khách hàng

                    </p>

                </div>

            </div>


            <!-- ================= MESSAGE ================= -->

            <%

                String success =
                        (String) session.getAttribute("success");

                String error =
                        (String) session.getAttribute("error");


                if (success != null) {

            %>

                <div class="alert alert-success alert-dismissible fade show"
                     role="alert">

                    <i class="bi bi-check-circle-fill me-2"></i>

                    <%= success %>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert">
                    </button>

                </div>

            <%

                    session.removeAttribute("success");

                }


                if (error != null) {

            %>

                <div class="alert alert-danger alert-dismissible fade show"
                     role="alert">

                    <i class="bi bi-exclamation-triangle-fill me-2"></i>

                    <%= error %>

                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert">
                    </button>

                </div>

            <%

                    session.removeAttribute("error");

                }

            %>


            <!-- ================= STATISTICS ================= -->

            <div class="row g-3 mb-4">


                <!-- CHỜ DUYỆT -->

                <div class="col-md-4">

                    <div class="card content-card">

                        <div class="card-body">

                            <div class="d-flex justify-content-between align-items-center">

                                <div>

                                    <p class="text-muted mb-1">
                                        Chờ duyệt
                                    </p>

                                    <h3 class="fw-bold mb-0 text-warning">

                                        <%= request.getAttribute("pendingCount") != null
                                                ? request.getAttribute("pendingCount")
                                                : 0 %>

                                    </h3>

                                </div>

                                <div class="text-warning fs-2">

                                    <i class="bi bi-hourglass-split"></i>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- ĐÃ DUYỆT -->

                <div class="col-md-4">

                    <div class="card content-card">

                        <div class="card-body">

                            <div class="d-flex justify-content-between align-items-center">

                                <div>

                                    <p class="text-muted mb-1">
                                        Đã duyệt
                                    </p>

                                    <h3 class="fw-bold mb-0 text-success">

                                        <%= request.getAttribute("approvedCount") != null
                                                ? request.getAttribute("approvedCount")
                                                : 0 %>

                                    </h3>

                                </div>

                                <div class="text-success fs-2">

                                    <i class="bi bi-check-circle"></i>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>


                <!-- ĐÃ TỪ CHỐI -->

                <div class="col-md-4">

                    <div class="card content-card">

                        <div class="card-body">

                            <div class="d-flex justify-content-between align-items-center">

                                <div>

                                    <p class="text-muted mb-1">
                                        Đã từ chối
                                    </p>

                                    <h3 class="fw-bold mb-0 text-danger">

                                        <%= request.getAttribute("rejectedCount") != null
                                                ? request.getAttribute("rejectedCount")
                                                : 0 %>

                                    </h3>

                                </div>

                                <div class="text-danger fs-2">

                                    <i class="bi bi-x-circle"></i>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>


            <!-- ================= SEARCH ================= -->

            <div class="card content-card mb-4">

                <div class="card-body">

                    <form action="${pageContext.request.contextPath}/admin/comment"
                          method="get"
                          class="d-flex w-50">

                        <input type="hidden"
                               name="action"
                               value="search">

                        <div class="input-group">

                            <span class="input-group-text bg-white">

                                <i class="bi bi-search text-muted"></i>

                            </span>

                            <input type="text"
                                   name="keyword"
                                   value="<%= request.getAttribute("keyword") != null
                                           ? request.getAttribute("keyword")
                                           : "" %>"
                                   class="form-control border-start-0 ps-0"
                                   placeholder="Nhập mã, khách hàng, phim hoặc nội dung...">

                            <button type="submit"
                                    class="btn btn-primary px-4">

                                <i class="bi bi-search me-1"></i>

                                Tìm kiếm

                            </button>

                        </div>

                    </form>

                </div>

            </div>


            <!-- ================= COMMENT TABLE ================= -->

            <div class="card content-card">

                <div class="card-header bg-white py-3">

                    <h5 class="mb-0 fw-bold">

                        <i class="bi bi-list-ul me-2"></i>

                        Danh Sách Đánh Giá

                    </h5>

                </div>


                <div class="card-body p-0">

                    <div class="table-responsive">

                        <table class="table table-hover mb-0">

                            <thead>

                                <tr>

                                    <th class="ps-4">
                                        Mã
                                    </th>

                                    <th>
                                        Khách hàng
                                    </th>

                                    <th>
                                        Phim
                                    </th>

                                    <th>
                                        Đánh giá
                                    </th>

                                    <th>
                                        Nội dung
                                    </th>

                                    <th>
                                        Ngày tạo
                                    </th>

                                    <th class="text-center">
                                        Trạng thái
                                    </th>

                                    <th class="text-center"
                                        style="min-width: 260px;">

                                        Thao tác

                                    </th>

                                </tr>

                            </thead>


                            <tbody>

<%

    List<Comment> comments =
            (List<Comment>) request.getAttribute("comments");


    if (comments != null && !comments.isEmpty()) {

        for (Comment c : comments) {

%>

                                <tr>


                                    <!-- MÃ -->

                                    <td class="ps-4 fw-semibold">

                                        <span class="badge bg-secondary">

                                            <%= c.getMaBinhLuan() %>

                                        </span>

                                    </td>


                                    <!-- KHÁCH HÀNG -->

                                    <td>

                                        <div class="fw-semibold">

                                            <%= c.getTenKhachHang() %>

                                        </div>

                                        <small class="text-muted">

                                            <%= c.getMaKhachHang() %>

                                        </small>

                                    </td>


                                    <!-- PHIM -->

                                    <td class="fw-semibold">

                                        <%= c.getTenPhim() %>

                                    </td>


                                    <!-- SAO -->

                                    <td>

                                        <%

                                            int stars =
                                                    c.getSoSao();

                                            for (int i = 1; i <= 5; i++) {

                                                if (i <= stars) {

                                        %>

                                                    <i class="bi bi-star-fill star"></i>

                                        <%

                                                } else {

                                        %>

                                                    <i class="bi bi-star text-muted"></i>

                                        <%

                                                }

                                            }

                                        %>

                                    </td>


                                    <!-- NỘI DUNG -->

                                    <td>

                                        <div class="comment-content">

                                            <%= c.getNoiDung() %>

                                        </div>

                                    </td>


                                    <!-- NGÀY -->

                                    <td>

                                        <%= c.getNgayTao() %>

                                    </td>


                                    <!-- TRẠNG THÁI -->

                                    <td class="text-center">

                                        <%

                                            String status =
                                                    c.getTrangThai();

                                            if ("Chờ duyệt".equals(status)) {

                                        %>

                                            <span class="badge bg-warning text-dark">

                                                Chờ duyệt

                                            </span>

                                        <%

                                            } else if ("Đã duyệt".equals(status)) {

                                        %>

                                            <span class="badge bg-success">

                                                Đã duyệt

                                            </span>

                                        <%

                                            } else if ("Từ chối".equals(status)) {

                                        %>

                                            <span class="badge bg-danger">

                                                Từ chối

                                            </span>

                                        <%

                                            } else if ("Đã ẩn".equals(status)) {

                                        %>

                                            <span class="badge bg-secondary">

                                                Đã ẩn

                                            </span>

                                        <%

                                            } else {

                                        %>

                                            <span class="badge bg-secondary">

                                                <%= status %>

                                            </span>

                                        <%

                                            }

                                        %>

                                    </td>


                                    <!-- ================= THAO TÁC ================= -->

                                    <td class="text-center">

                                        <div class="d-flex justify-content-center gap-2 flex-wrap">


<%

    /*
     * =====================================================
     * CHỜ DUYỆT
     * =====================================================
     */

    if ("Chờ duyệt".equals(status)) {

%>

                                            <!-- DUYỆT -->

                                            <form action="${pageContext.request.contextPath}/admin/comment"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="action"
                                                       value="update-status">

                                                <input type="hidden"
                                                       name="maBinhLuan"
                                                       value="<%= c.getMaBinhLuan() %>">

                                                <input type="hidden"
                                                       name="trangThai"
                                                       value="Đã duyệt">

                                                <button type="submit"
                                                        class="btn btn-sm btn-success btn-action">

                                                    <i class="bi bi-check-lg"></i>

                                                    Duyệt

                                                </button>

                                            </form>


                                            <!-- TỪ CHỐI -->

                                            <form action="${pageContext.request.contextPath}/admin/comment"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="action"
                                                       value="update-status">

                                                <input type="hidden"
                                                       name="maBinhLuan"
                                                       value="<%= c.getMaBinhLuan() %>">

                                                <input type="hidden"
                                                       name="trangThai"
                                                       value="Từ chối">

                                                <button type="submit"
                                                        class="btn btn-sm btn-danger btn-action">

                                                    <i class="bi bi-x-lg"></i>

                                                    Từ chối

                                                </button>

                                            </form>

<%

    /*
     * =====================================================
     * ĐÃ DUYỆT
     * =====================================================
     */

    } else if ("Đã duyệt".equals(status)) {

%>

                                            <!-- ẨN -->

                                            <form action="${pageContext.request.contextPath}/admin/comment"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="action"
                                                       value="update-status">

                                                <input type="hidden"
                                                       name="maBinhLuan"
                                                       value="<%= c.getMaBinhLuan() %>">

                                                <input type="hidden"
                                                       name="trangThai"
                                                       value="Đã ẩn">

                                                <button type="submit"
                                                        class="btn btn-sm btn-warning btn-action">

                                                    <i class="bi bi-eye-slash"></i>

                                                    Ẩn

                                                </button>

                                            </form>


                                            <!-- XÓA -->

                                            <form action="${pageContext.request.contextPath}/admin/comment"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="action"
                                                       value="delete">

                                                <input type="hidden"
                                                       name="maBinhLuan"
                                                       value="<%= c.getMaBinhLuan() %>">

                                                <button type="submit"
                                                        class="btn btn-sm btn-outline-danger btn-action">

                                                    <i class="bi bi-trash"></i>

                                                    Xóa

                                                </button>

                                            </form>

<%

    /*
     * =====================================================
     * TỪ CHỐI
     * =====================================================
     */

    } else if ("Từ chối".equals(status)) {

%>

                                            <!-- DUYỆT LẠI -->

                                            <form action="${pageContext.request.contextPath}/admin/comment"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="action"
                                                       value="update-status">

                                                <input type="hidden"
                                                       name="maBinhLuan"
                                                       value="<%= c.getMaBinhLuan() %>">

                                                <input type="hidden"
                                                       name="trangThai"
                                                       value="Đã duyệt">

                                                <button type="submit"
                                                        class="btn btn-sm btn-success btn-action">

                                                    <i class="bi bi-check-lg"></i>

                                                    Duyệt lại

                                                </button>

                                            </form>


                                            <!-- XÓA -->

                                            <form action="${pageContext.request.contextPath}/admin/comment"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="action"
                                                       value="delete">

                                                <input type="hidden"
                                                       name="maBinhLuan"
                                                       value="<%= c.getMaBinhLuan() %>">

                                                <button type="submit"
                                                        class="btn btn-sm btn-outline-danger btn-action">

                                                    <i class="bi bi-trash"></i>

                                                    Xóa

                                                </button>

                                            </form>

<%

    /*
     * =====================================================
     * ĐÃ ẨN
     * =====================================================
     */

    } else if ("Đã ẩn".equals(status)) {

%>

                                            <!-- HIỆN LẠI -->

                                            <form action="${pageContext.request.contextPath}/admin/comment"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="action"
                                                       value="update-status">

                                                <input type="hidden"
                                                       name="maBinhLuan"
                                                       value="<%= c.getMaBinhLuan() %>">

                                                <input type="hidden"
                                                       name="trangThai"
                                                       value="Đã duyệt">

                                                <button type="submit"
                                                        class="btn btn-sm btn-success btn-action">

                                                    <i class="bi bi-eye"></i>

                                                    Hiện lại

                                                </button>

                                            </form>


                                            <!-- XÓA -->

                                            <form action="${pageContext.request.contextPath}/admin/comment"
                                                  method="post"
                                                  class="m-0">

                                                <input type="hidden"
                                                       name="action"
                                                       value="delete">

                                                <input type="hidden"
                                                       name="maBinhLuan"
                                                       value="<%= c.getMaBinhLuan() %>">

                                                <button type="submit"
                                                        class="btn btn-sm btn-outline-danger btn-action">

                                                    <i class="bi bi-trash"></i>

                                                    Xóa

                                                </button>

                                            </form>

<%

    }

%>

                                        </div>

                                    </td>

                                </tr>

<%

        }

    } else {

%>

                                <tr>

                                    <td colspan="8"
                                        class="text-center text-muted empty-data">

                                        <i class="bi bi-chat-square-text fs-1 d-block mb-2"></i>

                                        Không có bình luận nào.

                                    </td>

                                </tr>

<%

    }

%>

                            </tbody>

                        </table>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>
