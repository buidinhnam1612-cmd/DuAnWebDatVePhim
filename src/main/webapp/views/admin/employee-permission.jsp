<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.Employee"%>
<%@ page import="com.fptpoly.model.EmployeePermission"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phân quyền nhân viên - FPT CINEMA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', system-ui, sans-serif; }
        .sidebar { min-height: 100vh; background-color: #1e293b; box-shadow: 2px 0 10px rgba(0,0,0,0.05); }
        .sidebar .nav-link { color: #94a3b8; border-radius: 8px; margin: 2px 0; padding: 10px 12px; font-size: 14px; transition: all 0.2s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color: #334155; color: #f8fafc !important; }
        .sidebar .nav-link.active { border-left: 4px solid #ef4444; border-radius: 0 8px 8px 0; background-color: #334155; }
        .menu-header { font-size: 11px; text-transform: uppercase; color: #64748b; font-weight: 700; margin-top: 15px; margin-bottom: 5px; padding-left: 10px; }
        .content-card { border: none; border-radius: 14px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .table th { background-color: #f8fafc; font-size: 13px; text-transform: uppercase; color: #64748b; font-weight: 700; }
        .table td { vertical-align: middle; font-size: 14px; }
        .btn-action { padding: 5px 12px; font-size: 13px; border-radius: 6px; }
        /* ===== Fix layout lệch hàng khi toggle quyền ===== */
        .table tbody tr {
            display: flex;
            align-items: center;
            box-sizing: border-box;
            min-height: 56px;
            height: 56px;
        }
        .table tbody tr td {
            box-sizing: border-box;
            height: 56px;
            display: flex;
            align-items: center;
            overflow: hidden;
        }
        .table tbody tr td:nth-child(1) { flex: 0 0 130px; }
        .table tbody tr td:nth-child(2) { flex: 0 0 230px; }
        .table tbody tr td:nth-child(3) { flex: 1 1 auto; }
        .table tbody tr td:nth-child(4) { flex: 0 0 140px; justify-content: center; }
        .table tbody tr td:nth-child(5) { flex: 0 0 140px; justify-content: center; }

        .table thead tr {
            display: flex;
            align-items: center;
        }
        .table thead tr th:nth-child(1) { flex: 0 0 130px; }
        .table thead tr th:nth-child(2) { flex: 0 0 230px; }
        .table thead tr th:nth-child(3) { flex: 1 1 auto; }
        .table thead tr th:nth-child(4) { flex: 0 0 140px; justify-content: center; }
        .table thead tr th:nth-child(5) { flex: 0 0 140px; justify-content: center; }

        .table td .badge,
        .table td .btn,
        .table td form {
            box-sizing: border-box;
            line-height: 1;
        }
        .permission-form {
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .permission-toggle {
            position: relative;
            width: 44px;
            height: 22px;
            padding: 0;
            border: none;
            border-radius: 999px;
            cursor: pointer;
            box-sizing: border-box;
            transition: 0.2s ease;
        }

        .permission-toggle-on {
            background-color: #198754;
        }

        .permission-toggle-off {
            background-color: #adb5bd;
        }

        .permission-toggle-slider {
            position: absolute;
            top: 3px;
            left: 3px;
            width: 16px;
            height: 16px;
            border-radius: 50%;
            background-color: #ffffff;
            box-sizing: border-box;
            transition: 0.2s ease;
        }

        .permission-toggle-on .permission-toggle-slider {
            left: 25px;
        }
    </style>
</head>
<body>
<% request.setAttribute("currentPage", "employee"); %>

<div class="container-fluid">
    <div class="row">
        <!-- SIDEBAR -->
        <div class="col-md-3 col-lg-2 sidebar p-0 text-white">
            <jsp:include page="/views/common/admin-sidebar.jsp" />
        </div>

        <!-- MAIN CONTENT -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-shield-lock me-2 text-primary"></i>Phân Quyền Nhân Viên</h1>
                    <p class="text-muted mb-0">Bật hoặc tắt từng quyền truy cập chi tiết cho tài khoản nhân viên</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/employee" class="btn btn-outline-secondary btn-sm shadow-sm">
                    <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách nhân viên
                </a>
            </div>

            <%
                String success = (String) session.getAttribute("success");
                String error = (String) session.getAttribute("error");

                if (success != null) {
            %>
            <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i><%= success %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                    session.removeAttribute("success");
                }

                if (error != null) {
            %>
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i><%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <%
                    session.removeAttribute("error");
                }
            %>

<%
    Employee employee = (Employee) request.getAttribute("employee");
    List<EmployeePermission> employeePermissions = (List<EmployeePermission>) request.getAttribute("employeePermissions");

    if (employee != null) {
        String roleName = employee.getTenVaiTro() != null ? employee.getTenVaiTro() : (employee.getChucVu() != null ? employee.getChucVu() : "Nhân viên");
%>
            <!-- INFO CARD -->
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold text-primary"><i class="bi bi-person-lines-fill me-2"></i>Thông Tin Nhân Viên</h5>
                </div>
                <div class="card-body">
                    <div class="row g-3 align-items-center">
                        <div class="col-md-2">
                            <span class="text-muted d-block small">Mã Nhân Viên</span>
                            <span class="badge bg-secondary fs-6"><%= employee.getMaNhanVien() %></span>
                        </div>
                        <div class="col-md-3">
                            <span class="text-muted d-block small">Họ Và Tên</span>
                            <span class="fw-bold text-dark fs-6"><%= employee.getHoTen() %></span>
                        </div>
                        <div class="col-md-3">
                            <span class="text-muted d-block small">Chức Vụ / Vai Trò</span>
                            <span class="badge bg-info bg-opacity-10 text-info border border-info border-opacity-25 px-2 py-1"><%= roleName %></span>
                        </div>
                        <div class="col-md-4">
                            <span class="text-muted d-block small">Email</span>
                            <span class="text-dark"><%= employee.getEmail() != null ? employee.getEmail() : "N/A" %></span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- TABLE PERMISSIONS -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-shield-check text-success me-2"></i>Danh Sách Quyền Hệ Thống & Thao Tác Bật / Tắt</h5>
                    <span class="badge bg-primary rounded-pill"><%= employeePermissions != null ? employeePermissions.size() : 0 %> quyền</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4" style="width: 130px;">Mã Quyền</th>
                                    <th style="width: 230px;">Tên Quyền</th>
                                    <th>Mô Tả Quyền</th>
                                    <th class="text-center" style="width: 140px;">Trạng Thái</th>
                                    <th class="text-center" style="width: 140px;">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
<%
    if (employeePermissions != null && !employeePermissions.isEmpty()) {
        for (EmployeePermission ep : employeePermissions) {
            if ("Q12".equals(ep.getMaQuyen())) continue;
            boolean isEnabled = (ep.getTrangThai() == 1);
            String cleanTenQuyen = ep.getTenQuyen() != null ? ep.getTenQuyen().replaceAll("^\\d+\\.\\s*", "") : "";
%>
                                <tr>
                                    <td class="ps-4 fw-bold"><span class="badge bg-dark"><%= ep.getMaQuyen() %></span></td>
                                    <td class="fw-semibold text-dark"><%= cleanTenQuyen %></td>
                                    <td class="text-muted"><%= ep.getMoTa() != null ? ep.getMoTa() : "" %></td>
                                    <td class="text-center">
                                        <% if (isEnabled) { %>
                                            <span class="badge bg-success px-3 py-2 fw-bold">BẬT</span>
                                        <% } else { %>
                                            <span class="badge bg-secondary px-3 py-2 fw-bold">TẮT</span>
                                        <% } %>
                                    </td>
                                    <td class="text-center">
                                        <form method="post"
                                              action="${pageContext.request.contextPath}/admin/employee/permission"
                                              class="permission-form">

                                            <input type="hidden"
                                                   name="maNhanVien"
                                                   value="<%= employee.getMaNhanVien() %>">

                                            <input type="hidden"
                                                   name="maQuyen"
                                                   value="<%= ep.getMaQuyen() %>">

                                            <input type="hidden"
                                                   name="trangThai"
                                                   value="<%= isEnabled ? "0" : "1" %>">

                                            <button type="submit"
                                                    name="permissionToggle"
                                                    value="<%= isEnabled ? "0" : "1" %>"
                                                    class="permission-toggle <%= isEnabled ? "permission-toggle-on" : "permission-toggle-off" %>"
                                                    aria-label="<%= isEnabled ? "Tắt quyền" : "Bật quyền" %>">
                                                <span class="permission-toggle-slider"></span>
                                            </button>
                                        </form>
                                    </td>
                                </tr>
<%
        }
    } else {
%>
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                        Không có dữ liệu quyền.
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
<%
    }
%>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
