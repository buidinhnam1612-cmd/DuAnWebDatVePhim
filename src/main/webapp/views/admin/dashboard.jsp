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

<div class="container-fluid p-0">
    <div class="row g-0">
        <!-- ==================== SIDEBAR MENU ==================== -->
        <div class="col-md-3 col-lg-2 sidebar p-0">
            <div class="sidebar-brand d-flex align-items-center gap-3">
                <div class="brand-icon"><i class="bi bi-film"></i></div>
                <div>
                    <div class="text-white fw-bold" style="font-size: 15px; letter-spacing: 0.5px;">FPT CINEMA</div>
                    <div style="font-size: 10px; color: #64748b; text-transform: uppercase; letter-spacing: 1px;">Admin Panel</div>
                </div>
            </div>

            <div class="p-2">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="bi bi-grid-1x2-fill me-2"></i> Tổng quan Dashboard
                        </a>
                    </li>

                    <div class="menu-header">Hạ tầng & Danh mục</div>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/theater">
                            <i class="bi bi-building me-2"></i> 1. Quản lý rạp phim
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/genre">
                            <i class="bi bi-tags me-2"></i> 2. Quản lý thể loại phim
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/room">
                            <i class="bi bi-door-open me-2"></i> 3. Quản lý phòng phim
                        </a>
                    </li>

                    <div class="menu-header">Phim & Lịch chiếu</div>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/movie">
                            <i class="bi bi-camera-reels me-2"></i> 4. Quản lý phim
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/showtime">
                            <i class="bi bi-calendar3 me-2"></i> 5. Quản lý suất chiếu
                        </a>
                    </li>

                    <div class="menu-header">Kinh doanh & Thành viên</div>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/booking">
                            <i class="bi bi-ticket-detailed me-2"></i> 6. Quản lý danh sách đặt vé
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/booking">
                            <i class="bi bi-check2-circle me-2"></i> 7. Xác nhận trạng thái vé
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/user">
                            <i class="bi bi-people me-2"></i> 8. Quản lý người dùng
                        </a>
                    </li>

                    <div class="menu-header">Hệ thống & Báo cáo</div>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/employee">
                            <i class="bi bi-shield-lock me-2"></i> 9. Nhân viên & Phân quyền
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/report">
                            <i class="bi bi-bar-chart-line me-2"></i> 10. Thống kê & Báo cáo
                        </a>
                    </li>

                    <li class="nav-item" style="margin-top: 12px; padding-top: 12px; border-top: 1px solid rgba(255,255,255,0.06);">
                        <a class="nav-link" href="${pageContext.request.contextPath}/home" style="color: #f87171 !important;">
                            <i class="bi bi-box-arrow-left me-2"></i> Trở về Trang chủ
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- ==================== MAIN CONTENT AREA ==================== -->
        <div class="col-md-9 ms-sm-auto col-lg-10 main-content">

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
                            <i class="bi bi-shield-check me-1"></i> Quyền quản trị viên cấp cao
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

            <!-- ===== LỐI TẮT THAO TÁC NHANH ===== -->
            <div class="section-title">
                <i class="bi bi-lightning-charge-fill" style="color: var(--accent-amber);"></i>
                Truy Cập Nhanh Các Chức Năng
                <span class="title-line"></span>
            </div>

            <div class="row g-3 mb-4">
                <!-- 1. Quản lý rạp phim -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/theater" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-blue"><i class="bi bi-building"></i></div>
                        <h6>Quản lý rạp phim</h6>
                        <p>Thêm, sửa chi nhánh rạp và thông tin liên hệ</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #dbeafe; color: #2563eb;">
                                ${totalTheaters} chi nhánh
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 2. Quản lý thể loại -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/genre" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-amber"><i class="bi bi-tags"></i></div>
                        <h6>Quản lý thể loại phim</h6>
                        <p>Phân loại phim theo thể loại: hành động, tình cảm...</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #fef3c7; color: #d97706;">
                                ${totalGenres} thể loại
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 3. Quản lý phòng chiếu -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/admin/room" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-teal"><i class="bi bi-door-open"></i></div>
                        <h6>Quản lý phòng chiếu</h6>
                        <p>Thiết lập phòng chiếu và ma trận ghế ngồi</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #ccfbf1; color: #0d9488;">
                                ${totalRooms} phòng
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 4. Quản lý phim -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/admin/movie" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-purple"><i class="bi bi-camera-reels"></i></div>
                        <h6>Quản lý phim</h6>
                        <p>Thêm phim mới, cập nhật thông tin và poster</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #ede9fe; color: #7c3aed;">
                                ${totalMovies} phim
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 5. Quản lý suất chiếu -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/admin/showtime" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-rose"><i class="bi bi-calendar3"></i></div>
                        <h6>Quản lý suất chiếu</h6>
                        <p>Xếp lịch chiếu phim, kiểm tra trùng lịch</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #ffe4e6; color: #e11d48;">
                                ${totalShowtimes} suất
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 6. Quản lý đặt vé -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/admin/booking" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-green"><i class="bi bi-ticket-detailed"></i></div>
                        <h6>Quản lý danh sách đặt vé</h6>
                        <p>Xem và quản lý tất cả giao dịch đặt vé</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #dcfce7; color: #16a34a;">
                                ${totalTickets} lượt
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 7. Xác nhận vé -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/admin/booking" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-cyan"><i class="bi bi-check2-circle"></i></div>
                        <h6>Xác nhận trạng thái vé</h6>
                        <p>Duyệt, xác nhận hoặc hủy vé đặt</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #cffafe; color: #0891b2;">
                                Kiểm duyệt
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 8. Quản lý người dùng -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/admin/user" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-orange"><i class="bi bi-people"></i></div>
                        <h6>Quản lý người dùng</h6>
                        <p>Quản lý tài khoản khách hàng đã đăng ký</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #ffedd5; color: #ea580c;">
                                ${totalUsers} thành viên
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 9. Nhân viên & Phân quyền -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/admin/employee" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-indigo"><i class="bi bi-shield-lock"></i></div>
                        <h6>Nhân viên & Phân quyền</h6>
                        <p>Quản lý nhân viên, vai trò và quyền hạn</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #e0e7ff; color: #4f46e5;">
                                ${totalStaffs} nhân viên
                            </span>
                        </div>
                    </a>
                </div>

                <!-- 10. Thống kê & Báo cáo -->
                <div class="col-md-6 col-lg-4 col-xl-3">
                    <a href="${pageContext.request.contextPath}/admin/report" class="action-card">
                        <div class="action-arrow"><i class="bi bi-arrow-right"></i></div>
                        <div class="action-icon icon-slate"><i class="bi bi-bar-chart-line"></i></div>
                        <h6>Thống kê & Báo cáo</h6>
                        <p>Biểu đồ doanh thu, phân tích xu hướng</p>
                        <div class="mt-2">
                            <span class="module-badge" style="background: #e2e8f0; color: #475569;">
                                ${totalRevenue}
                            </span>
                        </div>
                    </a>
                </div>
            </div>

            <!-- ===== BẢNG TỔNG HỢP TRẠNG THÁI MODULE ===== -->
            <div class="section-title">
                <i class="bi bi-clipboard-data-fill" style="color: var(--accent-blue);"></i>
                Tổng Hợp Trạng Thái Hệ Thống
                <span class="title-line"></span>
            </div>

            <div class="row g-3 mb-4">
                <div class="col-lg-7">
                    <div class="summary-card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5><i class="bi bi-activity me-2 text-primary"></i>Trạng thái các module</h5>
                        </div>
                        <div class="table-responsive">
                            <table class="table summary-table mb-0">
                                <thead>
                                    <tr>
                                        <th>Module</th>
                                        <th>Số lượng</th>
                                        <th>Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><i class="bi bi-building me-2 text-primary"></i><strong>Rạp phim</strong></td>
                                        <td><span class="badge bg-primary bg-opacity-10 text-primary">${totalTheaters} rạp</span></td>
                                        <td><span class="status-dot active"></span> <span style="font-size: 12px; color: #16a34a;">Hoạt động</span></td>
                                    </tr>
                                    <tr>
                                        <td><i class="bi bi-tags me-2 text-warning"></i><strong>Thể loại</strong></td>
                                        <td><span class="badge bg-warning bg-opacity-10 text-warning">${totalGenres} loại</span></td>
                                        <td><span class="status-dot active"></span> <span style="font-size: 12px; color: #16a34a;">Hoạt động</span></td>
                                    </tr>
                                    <tr>
                                        <td><i class="bi bi-door-open me-2" style="color: #0d9488;"></i><strong>Phòng chiếu</strong></td>
                                        <td><span class="badge" style="background: rgba(13,148,136,0.1); color: #0d9488;">${totalRooms} phòng</span></td>
                                        <td><span class="status-dot active"></span> <span style="font-size: 12px; color: #16a34a;">Hoạt động</span></td>
                                    </tr>
                                    <tr>
                                        <td><i class="bi bi-camera-reels me-2" style="color: #7c3aed;"></i><strong>Phim</strong></td>
                                        <td><span class="badge" style="background: rgba(124,58,237,0.1); color: #7c3aed;">${totalMovies} phim</span></td>
                                        <td><span class="status-dot active"></span> <span style="font-size: 12px; color: #16a34a;">Hoạt động</span></td>
                                    </tr>
                                    <tr>
                                        <td><i class="bi bi-calendar3 me-2 text-danger"></i><strong>Suất chiếu</strong></td>
                                        <td><span class="badge bg-danger bg-opacity-10 text-danger">${totalShowtimes} suất</span></td>
                                        <td><span class="status-dot active"></span> <span style="font-size: 12px; color: #16a34a;">Hoạt động</span></td>
                                    </tr>
                                    <tr>
                                        <td><i class="bi bi-ticket-detailed me-2 text-success"></i><strong>Đặt vé</strong></td>
                                        <td><span class="badge bg-success bg-opacity-10 text-success">${totalTickets} vé</span></td>
                                        <td><span class="status-dot pending"></span> <span style="font-size: 12px; color: #d97706;">Đang phát triển</span></td>
                                    </tr>
                                    <tr>
                                        <td><i class="bi bi-people me-2" style="color: #ea580c;"></i><strong>Người dùng</strong></td>
                                        <td><span class="badge" style="background: rgba(234,88,12,0.1); color: #ea580c;">${totalUsers} user</span></td>
                                        <td><span class="status-dot pending"></span> <span style="font-size: 12px; color: #d97706;">Đang phát triển</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="summary-card" style="height: 100%;">
                        <div class="card-header">
                            <h5><i class="bi bi-info-circle me-2" style="color: var(--accent-cyan);"></i>Thông tin hệ thống</h5>
                        </div>
                        <div class="p-4">
                            <div class="d-flex align-items-center gap-3 mb-4 pb-3" style="border-bottom: 1px solid #f1f5f9;">
                                <div style="width: 50px; height: 50px; border-radius: 12px; background: linear-gradient(135deg, #ef4444, #f97316); display: flex; align-items: center; justify-content: center; color: white; font-size: 22px;">
                                    <i class="bi bi-film"></i>
                                </div>
                                <div>
                                    <div style="font-size: 16px; font-weight: 800; color: #0f172a;">FPT CINEMA</div>
                                    <div style="font-size: 12px; color: #94a3b8;">Hệ thống quản trị rạp chiếu phim</div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="d-flex justify-content-between mb-2">
                                    <span style="font-size: 13px; color: #64748b;"><i class="bi bi-person-badge me-2"></i>Quản trị viên</span>
                                    <span style="font-size: 13px; font-weight: 600; color: #0f172a;">${sessionScope.userName}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span style="font-size: 13px; color: #64748b;"><i class="bi bi-envelope me-2"></i>Email</span>
                                    <span style="font-size: 13px; font-weight: 600; color: #0f172a;">${sessionScope.email}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span style="font-size: 13px; color: #64748b;"><i class="bi bi-shield-check me-2"></i>Vai trò</span>
                                    <span class="badge" style="background: linear-gradient(135deg, #fef3c7, #fde68a); color: #92400e; font-size: 11px;">Admin</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span style="font-size: 13px; color: #64748b;"><i class="bi bi-hdd-stack me-2"></i>Phiên bản</span>
                                    <span style="font-size: 13px; font-weight: 600; color: #0f172a;">v1.0.0</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span style="font-size: 13px; color: #64748b;"><i class="bi bi-gear me-2"></i>Nền tảng</span>
                                    <span style="font-size: 13px; font-weight: 600; color: #0f172a;">Java Servlet + JSP</span>
                                </div>
                            </div>

                            <div class="mt-4 p-3" style="background: linear-gradient(135deg, #f0fdf4, #dcfce7); border-radius: 10px; border: 1px solid #bbf7d0;">
                                <div class="d-flex align-items-center gap-2">
                                    <span class="status-dot active"></span>
                                    <span style="font-size: 13px; font-weight: 600; color: #166534;">Hệ thống đang hoạt động bình thường</span>
                                </div>
                            </div>
                        </div>
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