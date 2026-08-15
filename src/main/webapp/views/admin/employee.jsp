<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.fptpoly.model.Employee"%>
<%@ page import="com.fptpoly.model.Permission"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhân viên - FPT CINEMA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --sidebar-bg: #0f172a;
            --sidebar-hover: #1e293b;
            --accent-red: #ef4444;
            --bg-main: #f1f5f9;
        }
        body { background-color: var(--bg-main); font-family: 'Segoe UI', system-ui, sans-serif; }
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            box-shadow: 4px 0 20px rgba(0,0,0,0.15);
            position: sticky; top: 0;
        }
        .sidebar-brand { padding: 20px 16px; border-bottom: 1px solid rgba(255,255,255,0.06); }
        .sidebar-brand .brand-icon {
            width: 40px; height: 40px;
            background: linear-gradient(135deg, #ef4444, #f97316);
            border-radius: 10px; display: flex; align-items: center; justify-content: center;
            font-size: 20px; color: white; box-shadow: 0 4px 12px rgba(239,68,68,0.3);
        }
        .sidebar .nav-link {
            color: #94a3b8; border-radius: 8px;
            margin: 1px 8px; padding: 9px 14px;
            font-size: 13px; font-weight: 500;
            transition: all 0.2s ease; display: flex; align-items: center;
        }
        .sidebar .nav-link:hover { background-color: var(--sidebar-hover); color: #e2e8f0 !important; }
        .sidebar .nav-link.active {
            background: linear-gradient(90deg, rgba(239,68,68,0.15), transparent);
            color: #f8fafc !important; border-left: 3px solid var(--accent-red);
            border-radius: 0 8px 8px 0; margin-left: 5px;
        }
        .sidebar .nav-link i { width: 20px; text-align: center; font-size: 15px; }
        .menu-header {
            font-size: 10px; text-transform: uppercase; letter-spacing: 1.2px;
            color: #475569; font-weight: 700;
            margin-top: 18px; margin-bottom: 6px; padding-left: 22px;
        }
        .content-card { border: none; border-radius: 14px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05); }
        .table th { background-color: #f8fafc; font-size: 13px; text-transform: uppercase; color: #64748b; font-weight: 700; }
        .table td { vertical-align: middle; font-size: 14px; }
        .btn-action { padding: 5px 12px; font-size: 13px; border-radius: 6px; }

        /* Permission section styles */
        .perm-section {
            background: white; border-radius: 14px;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.05);
            margin-bottom: 20px; overflow: hidden;
        }
        .perm-header {
            background: linear-gradient(135deg, #1e293b, #334155);
            color: white; padding: 18px 22px;
        }
        .perm-group-title {
            font-size: 12px; font-weight: 700; text-transform: uppercase;
            letter-spacing: 0.5px; color: #64748b; margin-top: 16px; margin-bottom: 8px;
            padding-left: 4px;
        }
        .perm-item {
            display: flex; align-items: center; gap: 10px;
            padding: 10px 16px; border-bottom: 1px solid #f1f5f9;
            transition: background 0.2s;
        }
        .perm-item:hover { background: #f8fafc; }
        .perm-item input[type="checkbox"] {
            width: 18px; height: 18px; accent-color: #22c55e; cursor: pointer;
        }
        .perm-item label { cursor: pointer; font-size: 14px; flex: 1; }
        .perm-item .perm-desc { font-size: 12px; color: #94a3b8; }
    </style>
</head>
<body>
<% request.setAttribute("currentPage", "employee"); %>

<div class="container-fluid">
    <div class="row">
        <!-- SIDEBAR -->
        <div class="col-md-3 col-lg-2 sidebar p-0">
            <jsp:include page="/views/common/admin-sidebar.jsp" />
        </div>

        <!-- MAIN CONTENT -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-shield-lock me-2"></i>Quản Lý Nhân Viên</h1>
                    <p class="text-muted mb-0">Theo dõi danh sách, phân quyền và trạng thái nhân viên</p>
                </div>
            </div>

            <%
            String success = (String) session.getAttribute("success");
            String error = (String) session.getAttribute("error");

            if (success != null) {
            %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>
                <%= success %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <%
                session.removeAttribute("success");
            }

            if (error != null) {
            %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <%
                session.removeAttribute("error");
            }
            %>

            <!-- ==================== FORM THÊM NHÂN VIÊN ==================== -->
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-person-plus text-success me-2"></i>Thêm Tài Khoản Quản Trị</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/employee" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Mã NV</label>
                                <input type="text" class="form-control" name="maNhanVien" placeholder="VD: NV01" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Họ Tên</label>
                                <input type="text" class="form-control" name="hoTen" placeholder="Tên nhân viên..." required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Tên đăng nhập</label>
                                <input type="text" class="form-control" name="tenDangNhap" placeholder="Tên đăng nhập..." required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Email</label>
                                <input type="email" class="form-control" name="email" placeholder="example@email.com" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Số điện thoại</label>
                                <input type="text" class="form-control" name="soDienThoai" placeholder="0123456789" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Mật khẩu</label>
                                <input type="password" class="form-control" name="matKhau" placeholder="Nhập mật khẩu..." required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Giới tính</label>
                                <select class="form-select" name="gioiTinh">
                                    <option value="Nam">Nam</option>
                                    <option value="Nữ">Nữ</option>
                                    <option value="Khác">Khác</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-semibold">Vai trò</label>
                                <select class="form-select" name="maVaiTro">
                                    <option value="VT04">Nhân viên quầy</option>
                                    <option value="VT02">Nhân viên rạp</option>
                                </select>
                            </div>
                            <div class="col-12 d-flex align-items-end justify-content-end mt-4">
                                <button type="submit" class="btn btn-success">
                                    <i class="bi bi-plus-lg me-1"></i> Thêm Tài Khoản
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- SEARCH FORM -->
            <div class="card content-card mb-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/employee" method="get" class="d-flex w-50">
                        <input type="hidden" name="action" value="search">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" name="keyword" class="form-control border-start-0 ps-0" placeholder="Nhập mã, tên hoặc email...">
                            <button type="submit" class="btn btn-primary px-4"><i class="bi bi-search me-1"></i> Tìm kiếm</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- TABLE -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Nhân Viên</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">Mã NV</th>
                                    <th>Họ tên</th>
                                    <th>Email</th>
                                    <th>SĐT</th>
                                    <th class="text-center">Vai trò</th>
                                    <th class="text-center">Trạng thái</th>
                                    <th class="text-center" style="min-width: 400px;">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
<%
List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
String loggedInMaNV = (String) session.getAttribute("maNhanVien");
if(employeeList!=null && !employeeList.isEmpty()){
    for(Employee e : employeeList){
        boolean isSelf = e.getMaNhanVien().equals(loggedInMaNV) || "NV01".equalsIgnoreCase(e.getMaNhanVien());
%>
                                <tr>
                                    <td class="ps-4 fw-semibold"><span class="badge bg-secondary"><%=e.getMaNhanVien()%></span></td>
                                    <td class="fw-semibold text-primary"><%=e.getHoTen()%></td>
                                    <td><%=e.getEmail()%></td>
                                    <td><%=e.getSoDienThoai()%></td>
                                    <td class="text-center">
                                        <span class="badge <%= "VT01".equals(e.getMaVaiTro()) ? "bg-danger" : "bg-info text-dark" %>"><%=e.getTenVaiTro() != null ? e.getTenVaiTro() : ("VT04".equals(e.getMaVaiTro()) ? "Nhân viên quầy" : ("VT02".equals(e.getMaVaiTro()) ? "Nhân viên rạp" : "Admin"))%></span>
                                    </td>
                                    <td class="text-center">
                                        <span class="badge <%= ("Hoạt động".equals(e.getTrangThai()) || "Đang làm việc".equals(e.getTrangThai())) ? "bg-success" : "bg-danger" %>"><%= "Hoạt động".equals(e.getTrangThai()) ? "Đang làm việc" : e.getTrangThai() %></span>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex align-items-center justify-content-center gap-2">
                                            <form action="${pageContext.request.contextPath}/admin/employee" method="post" class="d-flex align-items-center gap-1 mb-0">
                                                <input type="hidden" name="maNhanVien" value="<%=e.getMaNhanVien()%>">
                                                <select name="maVaiTro"
                                                        class="form-select form-select-sm"
                                                        style="width: 140px;"
                                                        <%= isSelf ? "disabled" : "" %>>

                                                    <%-- Không cho Admin cấp VT01 cho nhân viên --%>

                                                    <option value="VT04"
                                                        <%= "VT04".equals(e.getMaVaiTro()) ? "selected" : "" %>>
                                                        Nhân viên quầy
                                                    </option>

                                                    <option value="VT02"
                                                        <%= "VT02".equals(e.getMaVaiTro()) ? "selected" : "" %>>
                                                        Nhân viên rạp
                                                    </option>
                                                </select>
                                                <button type="submit" name="action" value="updateRole" class="btn btn-sm btn-outline-primary btn-action" title="Lưu" <%= isSelf ? "disabled" : "" %>><i class="bi bi-person-gear"></i> Lưu</button>
                                            </form>

                                            <form action="${pageContext.request.contextPath}/admin/employee" method="post" class="d-flex align-items-center gap-1 mb-0">
                                                <input type="hidden" name="maNhanVien" value="<%=e.getMaNhanVien()%>">
                                                <select name="trangThai" class="form-select form-select-sm" style="width: 130px;" <%= isSelf ? "disabled" : "" %>>
                                                    <option value="Hoạt động" <%= ("Hoạt động".equals(e.getTrangThai()) || "Đang làm việc".equals(e.getTrangThai())) ? "selected" : "" %>>Đang làm việc</option>
                                                    <option value="Khóa" <%= "Khóa".equals(e.getTrangThai()) ? "selected" : "" %>>Khóa</option>
                                                </select>
                                                <button type="submit" name="action" value="updateStatus" class="btn btn-sm btn-outline-success btn-action" title="Cập nhật TT" <%= isSelf ? "disabled" : "" %>><i class="bi bi-check2-circle"></i> Lưu</button>
                                            </form>

                                            <% if (!"VT01".equals(e.getMaVaiTro()) && !isSelf) { %>
                                            <a href="${pageContext.request.contextPath}/admin/employee/permission?maNhanVien=<%=e.getMaNhanVien()%>"
                                               class="btn btn-sm btn-outline-warning btn-action" title="Phân quyền">
                                                <i class="bi bi-key"></i> Phân quyền
                                            </a>
                                            <% } %>
                                        </div>
                                    </td>
                                </tr>
<%
    }
} else {
%>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">
                                        <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                        Không có dữ liệu nhân viên.
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

            <!-- ==================== PHÂN QUYỀN CHO NHÂN VIÊN ==================== -->
<%
    Employee editEmployee = (Employee) request.getAttribute("editEmployee");
    List<String> empPermissions = (List<String>) request.getAttribute("empPermissions");
    List<Permission> allPermissions = (List<Permission>) request.getAttribute("allPermissions");

    if (editEmployee != null && allPermissions != null) {
%>
            <div class="perm-section mt-4">
                <div class="perm-header">
                    <h5 class="mb-1" style="font-weight: 700;">
                        <i class="bi bi-key-fill me-2"></i>Phân Quyền Cho Nhân Viên: <%= editEmployee.getHoTen() %>
                    </h5>
                    <p class="mb-0" style="font-size: 13px; color: #94a3b8;">
                        Mã NV: <strong><%= editEmployee.getMaNhanVien() %></strong> —
                        Vai trò: <strong><%= editEmployee.getTenVaiTro() != null ? editEmployee.getTenVaiTro() : editEmployee.getChucVu() %></strong>
                    </p>
                </div>
                <div class="p-4">
                    <form action="${pageContext.request.contextPath}/admin/employee" method="post">
                        <input type="hidden" name="action" value="updatePermissions">
                        <input type="hidden" name="maNhanVien" value="<%= editEmployee.getMaNhanVien() %>">

                        <%
                            String currentGroup = "";
                            for (Permission p : allPermissions) {
                                if ("Q12".equals(p.getMaQuyen())) continue;
                                String group = p.getNhomQuyen() != null ? p.getNhomQuyen() : "Khác";
                                if (!group.equals(currentGroup)) {
                                    currentGroup = group;
                        %>
                        <div class="perm-group-title"><%= group %></div>
                        <%
                                }
                                boolean checked = (empPermissions != null && empPermissions.contains(p.getMaQuyen()));

                                // Auto-check mặc định theo vai trò khi chưa có dữ liệu quyền riêng
                                if (empPermissions == null || empPermissions.isEmpty()) {
                                    String maVT = editEmployee.getMaVaiTro();
                                    String maQ = p.getMaQuyen();
                                    if ("VT04".equals(maVT) && ("Q01".equals(maQ) || "Q08".equals(maQ) || "Q09".equals(maQ) || "Q10".equals(maQ) || "Q15".equals(maQ))) {
                                        checked = true;
                                    } else if ("VT02".equals(maVT) && ("Q01".equals(maQ) || "Q09".equals(maQ))) {
                                        checked = true;
                                    }
                                }

                                String cleanTenQuyen = p.getTenQuyen() != null ? p.getTenQuyen().replaceAll("^\\d+\\.\\s*", "") : "";
                        %>
                        <div class="perm-item">
                            <input type="checkbox" name="permissions" value="<%= p.getMaQuyen() %>"
                                   id="perm_<%= p.getMaQuyen() %>"
                                   <%= checked ? "checked" : "" %>>
                            <label for="perm_<%= p.getMaQuyen() %>">
                                <strong><%= cleanTenQuyen %></strong>
                                <br><span class="perm-desc"><%= p.getMoTa() != null ? p.getMoTa() : "" %></span>
                            </label>
                        </div>
                        <%
                            }
                        %>

                        <div class="mt-4 d-flex gap-2">
                            <button type="submit" class="btn btn-success">
                                <i class="bi bi-check-lg me-1"></i> Lưu Quyền
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/employee" class="btn btn-outline-secondary">
                                <i class="bi bi-x-lg me-1"></i> Hủy
                            </a>
                        </div>
                    </form>
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
