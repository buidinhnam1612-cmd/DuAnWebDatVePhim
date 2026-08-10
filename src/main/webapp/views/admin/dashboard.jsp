<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Quản Trị Trung Tâm - FPT CINEMA</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --sidebar-bg: #0f172a;
            --sidebar-hover: #1e293b;
            --sidebar-active: #334155;
            --accent-red: #ef4444;
            --accent-blue: #3b82f6;
            --accent-green: #22c55e;
            --accent-amber: #f59e0b;
            --accent-purple: #8b5cf6;
            --accent-rose: #f43f5e;
            --accent-cyan: #06b6d4;
            --accent-indigo: #6366f1;
            --bg-main: #f1f5f9;
            --card-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 1px 2px rgba(0,0,0,0.04);
            --card-shadow-hover: 0 10px 25px rgba(0,0,0,0.08), 0 4px 10px rgba(0,0,0,0.04);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background-color: var(--bg-main);
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
            color: #1e293b;
        }

        /* ========== SIDEBAR ========== */
        .sidebar {
            min-height: 100vh;
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            box-shadow: 4px 0 20px rgba(0,0,0,0.15);
            position: sticky;
            top: 0;
        }
        .sidebar-brand {
            padding: 20px 16px;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }
        .sidebar-brand .brand-icon {
            width: 40px; height: 40px;
            background: linear-gradient(135deg, #ef4444, #f97316);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px; color: white;
            box-shadow: 0 4px 12px rgba(239,68,68,0.3);
        }
        .sidebar .nav-link {
            color: #94a3b8; border-radius: 8px;
            margin: 1px 8px; padding: 9px 14px;
            font-size: 13px; font-weight: 500;
            transition: all 0.2s ease;
            display: flex; align-items: center;
        }
        .sidebar .nav-link:hover { background-color: var(--sidebar-hover); color: #e2e8f0 !important; }
        .sidebar .nav-link.active {
            background: linear-gradient(90deg, rgba(239,68,68,0.15), transparent);
            color: #f8fafc !important;
            border-left: 3px solid var(--accent-red);
            border-radius: 0 8px 8px 0;
            margin-left: 5px;
        }
        .sidebar .nav-link i { width: 20px; text-align: center; font-size: 15px; }
        .menu-header {
            font-size: 10px; text-transform: uppercase; letter-spacing: 1.2px;
            color: #475569; font-weight: 700;
            margin-top: 18px; margin-bottom: 6px; padding-left: 22px;
        }

        /* ========== MAIN CONTENT ========== */
        .main-content { padding: 28px 32px; }

        /* ========== HEADER ========== */
        .page-header {
            background: linear-gradient(135deg, #1e293b, #334155);
            border-radius: 16px;
            padding: 28px 32px;
            color: white;
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
        }
        .page-header::before {
            content: '';
            position: absolute; top: -50%; right: -20%;
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(239,68,68,0.12) 0%, transparent 70%);
            border-radius: 50%;
        }
        .page-header::after {
            content: '';
            position: absolute; bottom: -60%; left: 30%;
            width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(59,130,246,0.1) 0%, transparent 70%);
            border-radius: 50%;
        }
        .page-header .header-content { position: relative; z-index: 1; }
        .page-header h1 { font-weight: 800; font-size: 1.6rem; margin-bottom: 6px; }
        .page-header .admin-badge {
            background: rgba(239,68,68,0.2);
            border: 1px solid rgba(239,68,68,0.3);
            color: #fca5a5; padding: 5px 14px;
            border-radius: 20px; font-size: 12px; font-weight: 600;
        }
        .header-time {
            background: rgba(255,255,255,0.08);
            border-radius: 10px; padding: 12px 18px;
            text-align: center;
        }
        .header-time .time-value { font-size: 1.8rem; font-weight: 800; }
        .header-time .time-label { font-size: 11px; color: #94a3b8; text-transform: uppercase; letter-spacing: 1px; }

        /* ========== STAT CARDS ========== */
        .stat-card {
            background: white;
            border: none; border-radius: 14px;
            padding: 22px;
            box-shadow: var(--card-shadow);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }
        .stat-card::before {
            content: '';
            position: absolute; top: 0; left: 0; right: 0;
            height: 3px;
            border-radius: 14px 14px 0 0;
        }
        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--card-shadow-hover);
        }
        .stat-card.blue::before { background: linear-gradient(90deg, #3b82f6, #60a5fa); }
        .stat-card.amber::before { background: linear-gradient(90deg, #f59e0b, #fbbf24); }
        .stat-card.green::before { background: linear-gradient(90deg, #22c55e, #4ade80); }
        .stat-card.rose::before { background: linear-gradient(90deg, #f43f5e, #fb7185); }
        .stat-card .stat-icon {
            width: 48px; height: 48px;
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 22px;
        }
        .stat-card .stat-icon.blue { background: linear-gradient(135deg, #dbeafe, #bfdbfe); color: #2563eb; }
        .stat-card .stat-icon.amber { background: linear-gradient(135deg, #fef3c7, #fde68a); color: #d97706; }
        .stat-card .stat-icon.green { background: linear-gradient(135deg, #dcfce7, #bbf7d0); color: #16a34a; }
        .stat-card .stat-icon.rose { background: linear-gradient(135deg, #ffe4e6, #fecdd3); color: #e11d48; }
        .stat-label { font-size: 12px; color: #64748b; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-value { font-size: 1.7rem; font-weight: 800; color: #0f172a; line-height: 1.2; }
        .stat-trend {
            font-size: 11px; font-weight: 600; padding: 2px 8px;
            border-radius: 6px; display: inline-flex; align-items: center; gap: 3px;
        }
        .stat-trend.up { background: #dcfce7; color: #16a34a; }
        .stat-trend.neutral { background: #f1f5f9; color: #64748b; }

        /* ========== ACTION GRID ========== */
        .section-title {
            font-size: 15px; font-weight: 700; color: #334155;
            margin-bottom: 16px; display: flex; align-items: center; gap: 8px;
        }
        .section-title .title-line {
            flex: 1; height: 1px;
            background: linear-gradient(90deg, #e2e8f0, transparent);
        }
        .action-card {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 14px;
            padding: 20px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            color: inherit;
            display: block;
            position: relative;
            overflow: hidden;
        }
        .action-card:hover {
            border-color: transparent;
            box-shadow: var(--card-shadow-hover);
            transform: translateY(-3px);
            color: inherit;
        }
        .action-card .action-icon {
            width: 44px; height: 44px;
            border-radius: 11px;
            display: flex; align-items: center; justify-content: center;
            font-size: 20px;
            margin-bottom: 14px;
            transition: transform 0.3s ease;
        }
        .action-card:hover .action-icon { transform: scale(1.1); }
        .action-card h6 { font-size: 14px; font-weight: 700; margin-bottom: 4px; }
        .action-card p { font-size: 12px; color: #94a3b8; margin: 0; line-height: 1.5; }
        .action-card .action-arrow {
            position: absolute; top: 20px; right: 20px;
            width: 28px; height: 28px;
            border-radius: 8px; background: #f8fafc;
            display: flex; align-items: center; justify-content: center;
            color: #94a3b8; font-size: 14px;
            transition: all 0.3s ease;
        }
        .action-card:hover .action-arrow { background: #e2e8f0; color: #334155; }

        /* Icon color schemes */
        .icon-blue { background: linear-gradient(135deg, #dbeafe, #bfdbfe); color: #2563eb; }
        .icon-amber { background: linear-gradient(135deg, #fef3c7, #fde68a); color: #d97706; }
        .icon-teal { background: linear-gradient(135deg, #ccfbf1, #99f6e4); color: #0d9488; }
        .icon-purple { background: linear-gradient(135deg, #ede9fe, #ddd6fe); color: #7c3aed; }
        .icon-rose { background: linear-gradient(135deg, #ffe4e6, #fecdd3); color: #e11d48; }
        .icon-green { background: linear-gradient(135deg, #dcfce7, #bbf7d0); color: #16a34a; }
        .icon-cyan { background: linear-gradient(135deg, #cffafe, #a5f3fc); color: #0891b2; }
        .icon-orange { background: linear-gradient(135deg, #ffedd5, #fed7aa); color: #ea580c; }
        .icon-indigo { background: linear-gradient(135deg, #e0e7ff, #c7d2fe); color: #4f46e5; }
        .icon-slate { background: linear-gradient(135deg, #e2e8f0, #cbd5e1); color: #475569; }

        /* ========== SUMMARY TABLE ========== */
        .summary-card {
            background: white;
            border: none; border-radius: 14px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }
        .summary-card .card-header {
            background: white;
            border-bottom: 1px solid #f1f5f9;
            padding: 18px 22px;
        }
        .summary-card .card-header h5 {
            font-size: 15px; font-weight: 700; margin: 0;
        }
        .summary-table th {
            background: #f8fafc;
            font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px;
            color: #64748b; font-weight: 700;
            padding: 12px 18px;
            border-bottom: 1px solid #e2e8f0;
        }
        .summary-table td {
            padding: 14px 18px;
            vertical-align: middle;
            font-size: 13px;
            border-bottom: 1px solid #f1f5f9;
        }
        .summary-table tbody tr:hover { background: #f8fafc; }
        .module-badge {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 4px 10px; border-radius: 6px;
            font-size: 12px; font-weight: 600;
        }
        .status-dot {
            width: 7px; height: 7px; border-radius: 50%;
            display: inline-block;
        }
        .status-dot.active { background: #22c55e; box-shadow: 0 0 6px rgba(34,197,94,0.4); }
        .status-dot.pending { background: #f59e0b; box-shadow: 0 0 6px rgba(245,158,11,0.4); }
        .status-dot.inactive { background: #94a3b8; }

        /* ========== FOOTER ========== */
        .admin-footer {
            text-align: center; padding: 20px;
            color: #94a3b8; font-size: 12px;
            margin-top: 20px;
            border-top: 1px solid #e2e8f0;
        }

        /* ========== ANIMATIONS ========== */
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(16px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .animate-in { animation: fadeInUp 0.4s ease-out forwards; }
        .delay-1 { animation-delay: 0.05s; }
        .delay-2 { animation-delay: 0.1s; }
        .delay-3 { animation-delay: 0.15s; }
        .delay-4 { animation-delay: 0.2s; }
    </style>
</head>
<body>
<% request.setAttribute("currentPage", "dashboard"); %>

<div class="container-fluid p-0">
    <div class="row g-0">
        <!-- ==================== SIDEBAR MENU ==================== -->
        <div class="col-md-3 col-lg-2 sidebar p-0">
            <jsp:include page="/views/common/admin-sidebar.jsp" />
        </div>

        <!-- ==================== MAIN CONTENT AREA ==================== -->
        <div class="col-md-9 ms-sm-auto col-lg-10 main-content">

            <%-- Hiển thị thông báo lỗi (ví dụ: từ chối quyền truy cập) --%>
            <% String dashError = (String) request.getAttribute("error"); if (dashError != null) { %>
            <div style="background: #fee2e2; color: #991b1b; padding: 12px 18px; border-radius: 10px; margin-bottom: 16px; font-size: 14px; border: 1px solid #fecaca;">
                <i class="bi bi-exclamation-triangle-fill me-2"></i><%= dashError %>
            </div>
            <% } %>
            <!-- ===== HEADER HERO ===== -->
            <div class="page-header animate-in">
                <div class="header-content d-flex justify-content-between align-items-center">
                    <div>
                        <div class="d-flex align-items-center gap-2 mb-2">
                            <h1 class="mb-0">Bảng Điều Khiển Quản Trị</h1>
                        </div>
                        <p class="mb-3" style="color: #94a3b8; font-size: 14px;">
                            Xin chào, <span style="color: #fbbf24; font-weight: 700;">${sessionScope.userName}</span>
                            — Chúc bạn có ngày làm việc hiệu quả!
                        </p>
                        <span class="admin-badge">
                            <i class="bi bi-shield-check me-1"></i>
                            <% if ("ADMIN".equals(session.getAttribute("role"))) { %>
                                Quyền quản trị viên cấp cao
                            <% } else { %>
                                Nhân viên hệ thống
                            <% } %>
                        </span>
                    </div>
                    <div class="header-time d-none d-lg-block">
                        <div class="time-label">Hệ thống đang hoạt động</div>
                        <div class="time-value text-white" id="liveTime">--:--</div>
                        <div class="time-label" id="liveDate">--</div>
                    </div>
                </div>
            </div>

            <!-- ===== 4 STAT CARDS ===== -->
            <div class="row g-3 mb-4">
                <div class="col-md-6 col-xl-3 animate-in delay-1">
                    <div class="stat-card blue">
                        <div class="d-flex align-items-start justify-content-between mb-3">
                            <div class="stat-icon blue"><i class="bi bi-building"></i></div>
                            <span class="stat-trend neutral"><i class="bi bi-database"></i> Thực tế</span>
                        </div>
                        <div class="stat-label">Chi Nhánh Rạp</div>
                        <div class="stat-value">${totalTheaters}</div>
                        <div style="font-size: 12px; color: #94a3b8; margin-top: 4px;">rạp phim đang hoạt động</div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3 animate-in delay-2">
                    <div class="stat-card amber">
                        <div class="d-flex align-items-start justify-content-between mb-3">
                            <div class="stat-icon amber"><i class="bi bi-tags"></i></div>
                            <span class="stat-trend neutral"><i class="bi bi-database"></i> Thực tế</span>
                        </div>
                        <div class="stat-label">Thể Loại Phim</div>
                        <div class="stat-value">${totalGenres}</div>
                        <div style="font-size: 12px; color: #94a3b8; margin-top: 4px;">thể loại trong danh mục</div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3 animate-in delay-3">
                    <div class="stat-card green">
                        <div class="d-flex align-items-start justify-content-between mb-3">
                            <div class="stat-icon green"><i class="bi bi-ticket-perforated"></i></div>
                            <span class="stat-trend up"><i class="bi bi-arrow-up"></i> Hôm nay</span>
                        </div>
                        <div class="stat-label">Vé Đặt Hôm Nay</div>
                        <div class="stat-value">${totalTickets}</div>
                        <div style="font-size: 12px; color: #94a3b8; margin-top: 4px;">lượt đặt vé thành công</div>
                    </div>
                </div>
                <div class="col-md-6 col-xl-3 animate-in delay-4">
                    <div class="stat-card rose">
                        <div class="d-flex align-items-start justify-content-between mb-3">
                            <div class="stat-icon rose"><i class="bi bi-wallet2"></i></div>
                            <span class="stat-trend up"><i class="bi bi-arrow-up"></i> Tháng này</span>
                        </div>
                        <div class="stat-label">Doanh Thu Tháng</div>
                        <div class="stat-value" style="font-size: 1.3rem;">${totalRevenue}</div>
                        <div style="font-size: 12px; color: #94a3b8; margin-top: 4px;">tổng thu từ bán vé</div>
                    </div>
                </div>
            </div>


            <!-- ===== FOOTER ===== -->
            <div class="admin-footer">
                <i class="bi bi-c-circle me-1"></i> 2026 FPT CINEMA — Hệ Thống Quản Trị Nội Bộ | Phát triển bởi FPT Polytechnic
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Đồng hồ thời gian thực
    function updateClock() {
        const now = new Date();
        const hours = String(now.getHours()).padStart(2, '0');
        const mins = String(now.getMinutes()).padStart(2, '0');
        const secs = String(now.getSeconds()).padStart(2, '0');
        document.getElementById('liveTime').textContent = hours + ':' + mins + ':' + secs;

        const days = ['Chủ nhật', 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7'];
        const day = days[now.getDay()];
        const date = String(now.getDate()).padStart(2, '0') + '/' + String(now.getMonth() + 1).padStart(2, '0') + '/' + now.getFullYear();
        document.getElementById('liveDate').textContent = day + ', ' + date;
    }
    updateClock();
    setInterval(updateClock, 1000);
</script>
</body>
</html>