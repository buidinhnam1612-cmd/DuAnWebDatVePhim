<!DOCTYPE html><html lang="vi"><head>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>CineManage - Trang nhân viên</title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
      tailwind.config = {
        darkMode: "class",
        theme: {
          extend: {
            "colors": {
              "surface-container-highest": "#d8e3fb",
              "on-secondary-fixed": "#001e2c",
              "outline": "#737686",
              "secondary": "#00668a",
              "on-tertiary-fixed": "#360f00",
              "primary-fixed": "#dbe1ff",
              "tertiary-container": "#bc4800",
              "surface-container-high": "#dee8ff",
              "on-primary-container": "#ffffff",
              "on-secondary": "#ffffff",
              "on-primary": "#ffffff",
              "primary": "#2563eb",
              "surface": "#f0f3ff",
              "error": "#ba1a1a",
              "on-surface": "#111c2d",
              "secondary-fixed": "#c4e7ff",
              "inverse-surface": "#263143",
              "secondary-container": "#40c2fd",
              "error-container": "#ffdad6",
              "tertiary-fixed": "#ffdbcd",
              "tertiary": "#943700",
              "inverse-primary": "#b4c5ff",
              "on-secondary-fixed-variant": "#004c69",
              "tertiary-fixed-dim": "#ffb596",
              "primary-container": "#2563eb",
              "on-primary-fixed": "#00174b",
              "surface-container": "#e7eeff",
              "on-surface-variant": "#434655",
              "inverse-on-surface": "#ecf1ff",
              "on-background": "#111c2d",
              "surface-container-lowest": "#ffffff",
              "on-tertiary": "#ffffff",
              "primary-fixed-dim": "#b4c5ff",
              "on-tertiary-container": "#ffede6",
              "surface-container-low": "#f9f9ff",
              "on-error-container": "#93000a",
              "on-primary-fixed-variant": "#003ea8",
              "surface-tint": "#0053db",
              "surface-dim": "#cfdaf2",
              "outline-variant": "#c3c6d7",
              "background": "#f0f3ff",
              "secondary-fixed-dim": "#7bd0ff",
              "surface-variant": "#ffffff",
              "on-secondary-container": "#004d6a",
              "on-tertiary-fixed-variant": "#7d2d00",
              "on-error": "#ffffff",
              "surface-bright": "#f9f9ff"
            },
            "borderRadius": {
              "DEFAULT": "0.5rem",
              "lg": "0.75rem",
              "xl": "1rem",
              "full": "9999px"
            },
            "spacing": {
              "container-margin": "40px",
              "sm": "8px",
              "lg": "24px",
              "md": "16px",
              "xl": "32px",
              "gutter": "20px",
              "base": "4px",
              "xs": "4px",
              "margin-page": "40px",
              "stack-md": "16px",
              "stack-sm": "8px",
              "stack-lg": "32px",
              "sidebar-width": "280px",
              "container-max": "1440px"
            },
            "fontFamily": {
              "body-md": ["Inter"],
              "label-sm": ["Inter"],
              "title-md": ["Inter"],
              "headline-lg": ["Inter"],
              "headline-lg-mobile": ["Inter"],
              "display-lg": ["Inter"]
            },
            "fontSize": {
              "body-md": ["16px", { "lineHeight": "24px", "fontWeight": "400" }],
              "label-sm": ["13px", { "lineHeight": "18px", "letterSpacing": "0.01em", "fontWeight": "500" }],
              "title-md": ["20px", { "lineHeight": "28px", "fontWeight": "600" }],
              "headline-lg": ["32px", { "lineHeight": "40px", "letterSpacing": "-0.01em", "fontWeight": "600" }],
              "headline-lg-mobile": ["24px", { "lineHeight": "32px", "fontWeight": "600" }],
              "display-lg": ["48px", { "lineHeight": "56px", "letterSpacing": "-0.02em", "fontWeight": "700" }]
            }
          }
        }
      }
    </script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet">
<style>
        body {
            background-color: #f0f3ff;
            color: #111c2d;
            font-family: 'Inter', sans-serif;
            overflow-x: hidden;
        }

        .employee-panel {
            background-color: #ffffff;
            border-right: 1px solid #e7eeff;
        }

        .employee-card {
            background-color: #ffffff;
            border: 1px solid #e7eeff;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
            transition: all 0.3s ease;
        }

        .employee-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            border-color: #dbe1ff;
        }

        .employee-table-row-hover:hover {
            background-color: #f9f9ff;
        }

        /* Status Badges */
        .badge-success { background-color: #dcfce7; color: #166534; }
        .badge-warning { background-color: #fef9c3; color: #854d0e; }
        .badge-error { background-color: #fee2e2; color: #991b1b; }
        .badge-info { background-color: #e0f2fe; color: #075985; }

        /* Webkit Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f0f3ff;
        }
        ::-webkit-scrollbar-thumb {
            background: #c3c6d7;
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #737686;
        }
    </style>
</head>
<body class="flex h-screen overflow-hidden text-body-md font-body-md bg-background">
<!-- SideNavBar -->
<aside class="fixed left-0 top-0 h-screen w-sidebar-width employee-panel shadow-sm flex flex-col py-margin-page z-50 rounded-none">
<!-- Logo Area -->
<div class="px-gutter mb-stack-lg flex items-center gap-stack-sm">
<span class="material-symbols-outlined text-4xl text-primary">movie</span>
<div>
<h1 class="font-title-md text-title-md font-bold text-on-surface">FPT Cinema</h1>
<p class="font-label-sm text-label-sm text-outline">Trang nhân viên</p>
</div>
</div>
<!-- Navigation Links -->
<nav class="flex-1 overflow-y-auto px-4 space-y-1">
<!-- Active State -->
<a class="flex items-center gap-stack-md py-3 px-4 border-l-4 border-primary bg-primary/10 text-primary rounded-r-lg group" href="#">
<span class="material-symbols-outlined group-active:scale-95 duration-150" style="font-variation-settings: 'FILL' 1;">dashboard</span>
<span class="font-title-md text-sm font-semibold">Dashboard</span>
</a>
<!-- Inactive States -->
<a class="flex items-center gap-stack-md py-3 px-4
text-on-surface-variant
hover:bg-surface-container-highest/50
hover:text-on-surface
transition-all duration-300 rounded-lg group"
href="${pageContext.request.contextPath}/employee/showtime">
<span class="material-symbols-outlined group-active:scale-95 duration-150">movie</span>
<span class="font-body-md text-sm">Tra cứu xuất chiếu</span>
</a>

<a class="flex items-center gap-stack-md py-3 px-4 text-on-surface-variant hover:bg-surface-container-highest/50 hover:text-on-surface transition-all duration-300 rounded-lg group"
   href="${pageContext.request.contextPath}/employee/booking-list">
    <span class="material-symbols-outlined group-active:scale-95 duration-150">event_seat</span>
    <span class="font-body-md text-sm">Quản lý danh sách đặt vé</span>
</a>
<a class="flex items-center gap-stack-md py-3 px-4 text-on-surface-variant hover:bg-surface-container-highest/50 hover:text-on-surface transition-all duration-300 rounded-lg group"
    href="${pageContext.request.contextPath}/employee/confirm-booking">
<span class="material-symbols-outlined group-active:scale-95 duration-150">check_circle</span>
<span class="font-body-md text-sm">Xác nhận</span>
</a>
<a class="flex items-center gap-stack-md py-3 px-4 text-on-surface-variant hover:bg-surface-container-highest/50 hover:text-on-surface transition-all duration-300 rounded-lg group" href="#">
<span class="material-symbols-outlined group-active:scale-95 duration-150">fastfood</span>
<span class="font-body-md text-sm">F&amp;B</span>
</a>
<a class="flex items-center gap-stack-md py-3 px-4 text-on-surface-variant hover:bg-surface-container-highest/50 hover:text-on-surface transition-all duration-300 rounded-lg group"
href="${pageContext.request.contextPath}/employee/cancel-booking">
<span class="material-symbols-outlined group-active:scale-95 duration-150">cancel</span>
<span class="font-body-md text-sm">Hủy vé</span>
</a>
<a class="flex items-center gap-stack-md py-3 px-4 text-on-surface-variant hover:bg-surface-container-highest/50 hover:text-on-surface transition-all duration-300 rounded-lg group"
href="${pageContext.request.contextPath}/employee/comment-management">
<span class="material-symbols-outlined group-active:scale-95 duration-150">rate_review</span>
<span class="font-body-md text-sm">Đánh giá</span>
</a>
<a class="flex items-center gap-stack-md py-3 px-4 text-on-surface-variant hover:bg-surface-container-highest/50 hover:text-on-surface transition-all duration-300 rounded-lg group"
    href="${pageContext.request.contextPath}/employee/report">
<span class="material-symbols-outlined group-active:scale-95 duration-150">bar_chart</span>
<span class="font-body-md text-sm">Báo cáo</span>
</a>
<div class="pt-stack-md mt-stack-md border-t border-outline-variant/20">
<a class="flex items-center gap-stack-md py-3 px-4 text-on-surface-variant hover:bg-surface-container-highest/50 hover:text-on-surface transition-all duration-300 rounded-lg group" href="#">
<span class="material-symbols-outlined group-active:scale-95 duration-150">settings</span>
<span class="font-body-md text-sm">Cài đặt</span>
</a>
</div>
</nav>
<!-- CTA Button -->
<div class="px-gutter mt-auto pt-stack-md">
<button class="w-full flex items-center justify-center gap-2 bg-primary hover:bg-primary/90 text-on-primary-container font-title-md text-sm py-3 rounded-xl transition-all shadow-md">
<span class="material-symbols-outlined text-sm">add</span>
                New Booking
            </button>
</div>
</aside>
<!-- Main Content Area -->
<main class="ml-sidebar-width flex-1 flex flex-col h-screen relative z-10 w-[calc(100%-280px)]">
<!-- TopAppBar -->
<header class="h-20 bg-surface-container-lowest border-b border-surface-container-highest flex justify-between items-center px-margin-page sticky top-0 z-40 shadow-sm">
<div>
<h2 class="font-title-md text-title-md font-bold text-on-surface">Tổng quan ca trực</h2>
</div>
<div class="flex items-center gap-stack-lg">
<!-- Actions -->
<div class="flex items-center gap-4 text-on-surface-variant">
<button class="hover:text-primary transition-colors focus-within:ring-2 focus-within:ring-primary/30 rounded-full p-2 relative">
<span class="material-symbols-outlined">notifications</span>
<span class="absolute top-2 right-2 w-2 h-2 bg-error rounded-full"></span>
</button>
<button class="hover:text-primary transition-colors focus-within:ring-2 focus-within:ring-primary/30 rounded-full p-2">
<span class="material-symbols-outlined">help</span>
</button>
</div>
<!-- Profile -->
<div class="flex items-center gap-3 border-l border-surface-container-highest pl-stack-lg cursor-pointer hover:opacity-80 transition-opacity">
<div class="text-right">
<p class="font-title-md text-sm font-semibold text-on-surface">Nguyễn Văn A</p>
<p class="font-label-sm text-xs text-outline">Nhân viên trực ca</p>
</div>
<div class="w-10 h-10 rounded-full border border-surface-container-highest overflow-hidden">
<img alt="Employee Avatar" class="w-full h-full object-cover" data-alt="Portrait of a young, professional Asian male cinema employee in a neat dark uniform, soft studio lighting, modern corporate portrait style." src="https://lh3.googleusercontent.com/aida-public/AB6AXuBMxEMxBPTQnlVEgNxhjmP7DkpqG_flhEfzGt53UAu16NuUgDou6nFro2VM_D-KgX4Ve0t656DEB8HmSE04VB277zxC-jSg5vRD9IfnpuoLZbrJm5uKRzyksE7RjwO5p9Quljhr_nQo3A8lyCMIdcCB_oH45AsdWU0VXwPstDO8f0vU93n0OIOzgO2zlJ1IJl5PC5Beii-VqZdxIINcRmIHgEfk8D4J8MFMILaEmLZe8djOjSb2U-w">
</div>
</div>
</div>
</header>
<!-- Dashboard Canvas -->
<div class="flex-1 overflow-y-auto p-margin-page pb-12">
<div class="max-w-container-max mx-auto space-y-stack-lg">
<!-- Stats Row -->
<section class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-gutter">
<!-- Stat Card 1 -->
<div class="employee-card rounded-lg p-6 relative overflow-hidden flex flex-col justify-between h-40">
<div class="flex justify-between items-start z-10">
<div>
<p class="font-label-sm text-outline uppercase tracking-wider">Vé bán hôm nay</p>
<p class="font-headline-lg text-headline-lg text-on-surface mt-1">1,245</p>
</div>
<div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">confirmation_number</span>
</div>
</div>
<div class="flex items-center gap-1 text-xs font-label-sm text-green-600 z-10">
<span class="material-symbols-outlined text-[14px]">trending_up</span>
<span class="">+12% so với hôm qua</span>
</div>
</div>
<!-- Stat Card 2 -->
<div class="employee-card rounded-lg p-6 relative overflow-hidden flex flex-col justify-between h-40">
<div class="flex justify-between items-start z-10">
<div>
<p class="font-label-sm text-outline uppercase tracking-wider">Doanh thu ca (VND)</p>
<p class="font-headline-lg text-headline-lg text-on-surface mt-1">45.2M</p>
</div>
<div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">payments</span>
</div>
</div>
<div class="flex items-center gap-1 text-xs font-label-sm text-green-600 z-10">
<span class="material-symbols-outlined text-[14px]">trending_up</span>
<span class="">+5.4% so với ca trước</span>
</div>
</div>
<!-- Stat Card 3 -->
<div class="employee-card rounded-lg p-6 relative overflow-hidden flex flex-col justify-between h-40">
<div class="flex justify-between items-start z-10">
<div>
<p class="font-label-sm text-outline uppercase tracking-wider">Đơn F&amp;B chờ</p>
<p class="font-headline-lg text-headline-lg text-on-surface mt-1">18</p>
</div>
<div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">local_dining</span>
</div>
</div>
<div class="flex items-center gap-1 text-xs font-label-sm text-yellow-600 z-10">
<span class="material-symbols-outlined text-[14px]">schedule</span>
<span class="">Đang giờ cao điểm</span>
</div>
</div>
<!-- Stat Card 4 -->
<div class="employee-card rounded-lg p-6 relative overflow-hidden flex flex-col justify-between h-40">
<div class="flex justify-between items-start z-10">
<div>
<p class="font-label-sm text-outline uppercase tracking-wider">Tỷ lệ lấp đầy</p>
<p class="font-headline-lg text-headline-lg text-on-surface mt-1">78%</p>
</div>
<div class="w-10 h-10 rounded-lg bg-primary/10 flex items-center justify-center text-primary">
<span class="material-symbols-outlined" style="font-variation-settings: 'FILL' 1;">chair</span>
</div>
</div>
<div class="flex items-center gap-1 text-xs font-label-sm text-outline z-10">
<span class="">Phòng chiếu 3, 5 sắp đầy</span>
</div>
</div>
</section>
<!-- Functional Grid Section (Bento Style) -->
<section>
<h3 class="font-title-md text-lg text-on-surface mb-stack-md flex items-center gap-2">
<span class="material-symbols-outlined text-primary">apps</span>
                        Tác vụ nhanh
                    </h3>
<div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-gutter">
<!-- Action Card 1 -->
<div class="employee-card p-5 flex flex-col items-center text-center group cursor-pointer rounded-lg">
<div class="w-14 h-14 rounded-full bg-surface-container-highest flex items-center justify-center mb-3 group-hover:bg-primary/10 transition-colors">
<span class="material-symbols-outlined text-3xl text-on-surface group-hover:text-primary">movie</span>
</div>
<h4 class="font-title-md text-sm text-on-surface mb-1">Xuất chiếu</h4>
<p class="font-label-sm text-xs text-outline font-normal mb-4">Kiểm tra lịch chiếu phim</p>
<button class="font-label-sm text-xs text-primary opacity-0 group-hover:opacity-100 transition-opacity">Truy cập →</button>
</div>
<!-- Action Card 2 -->
<div class="employee-card p-5 flex flex-col items-center text-center group cursor-pointer rounded-lg">
<div class="w-14 h-14 rounded-full bg-surface-container-highest flex items-center justify-center mb-3 group-hover:bg-primary/10 transition-colors">
<span class="material-symbols-outlined text-3xl text-on-surface group-hover:text-primary">event_seat</span>
</div>
<h4 class="font-title-md text-sm text-on-surface mb-1">Đặt vé mới</h4>
<p class="font-label-sm text-xs text-outline font-normal mb-4">Mở form đặt vé tại quầy</p>
<button class="font-label-sm text-xs text-primary opacity-0 group-hover:opacity-100 transition-opacity">Truy cập →</button>
</div>
<!-- Action Card 3 -->
<div class="employee-card p-5 flex flex-col items-center text-center group cursor-pointer lg:col-span-2 lg:row-span-1 bg-gradient-to-br from-surface to-primary/5 rounded-lg">
<div class="flex flex-row items-center justify-between w-full h-full">
<div class="text-left">
<h4 class="font-title-md text-base text-on-surface mb-2">Kiểm soát vé cổng</h4>
<p class="font-label-sm text-xs text-outline font-normal mb-4 max-w-[200px]">Quét mã QR hoặc nhập mã vé thủ công để cho khách vào rạp.</p>
<button class="bg-primary text-on-primary-container px-4 py-2 rounded-lg font-title-md text-xs hover:bg-primary/90 transition-colors shadow-sm">Quét vé ngay</button>
</div>
<div class="w-20 h-20 rounded-full bg-surface-container-highest/50 flex items-center justify-center group-hover:scale-110 transition-transform">
<span class="material-symbols-outlined text-5xl text-primary">qr_code_scanner</span>
</div>
</div>
</div>
</div>
</section>
<!-- Data Table Section -->
<section class="employee-card rounded-lg overflow-hidden">
<div class="p-6 border-b border-surface-container-highest flex justify-between items-center">
<h3 class="font-title-md text-lg text-on-surface flex items-center gap-2">
<span class="material-symbols-outlined text-primary">list_alt</span>
                            Giao dịch vé gần đây
                        </h3>
<button class="font-label-sm text-xs text-primary hover:text-primary/80 transition-colors">Xem tất cả</button>
</div>
<div class="overflow-x-auto">
<table class="w-full text-left border-collapse">
<thead>
<tr class="bg-surface-container-low border-b border-surface-container-highest">
<th class="py-4 px-6 font-label-sm text-outline">MÃ VÉ</th>
<th class="py-4 px-6 font-label-sm text-outline">KHÁCH HÀNG</th>
<th class="py-4 px-6 font-label-sm text-outline">PHIM</th>
<th class="py-4 px-6 font-label-sm text-outline">XUẤT CHIẾU</th>
<th class="py-4 px-6 font-label-sm text-outline">TRẠNG THÁI</th>
<th class="py-4 px-6 font-label-sm text-outline text-right">THAO TÁC</th>
</tr>
</thead>
<tbody class="font-body-md text-sm">
<!-- Row 1 -->
<tr class="employee-table-row-hover border-b border-surface-container-highest transition-colors">
<td class="py-4 px-6 text-primary font-mono text-xs">#TKT-8901</td>
<td class="py-4 px-6 text-on-surface">Trần Thị B</td>
<td class="py-4 px-6 text-on-surface font-medium">Dune: Part Two</td>
<td class="py-4 px-6 text-outline">19:30 - Rạp 1</td>
<td class="py-4 px-6">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold badge-success">Xác nhận</span>
</td>
<td class="py-4 px-6 text-right">
<button class="text-outline hover:text-on-surface transition-colors"><span class="material-symbols-outlined text-lg">more_vert</span></button>
</td>
</tr>
<!-- Row 2 -->
<tr class="employee-table-row-hover border-b border-surface-container-highest transition-colors">
<td class="py-4 px-6 text-primary font-mono text-xs">#TKT-8902</td>
<td class="py-4 px-6 text-on-surface">Lê Văn C</td>
<td class="py-4 px-6 text-on-surface font-medium">Kung Fu Panda 4</td>
<td class="py-4 px-6 text-outline">18:15 - Rạp 3</td>
<td class="py-4 px-6">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold badge-warning">Đang xử lý</span>
</td>
<td class="py-4 px-6 text-right">
<button class="text-outline hover:text-on-surface transition-colors"><span class="material-symbols-outlined text-lg">more_vert</span></button>
</td>
</tr>
<!-- Row 3 -->
<tr class="employee-table-row-hover border-b border-surface-container-highest transition-colors">
<td class="py-4 px-6 text-primary font-mono text-xs">#TKT-8903</td>
<td class="py-4 px-6 text-on-surface">Phạm K</td>
<td class="py-4 px-6 text-on-surface font-medium">Mai</td>
<td class="py-4 px-6 text-outline">20:00 - Rạp 2</td>
<td class="py-4 px-6">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold badge-error">Đã hủy</span>
</td>
<td class="py-4 px-6 text-right">
<button class="text-outline hover:text-on-surface transition-colors"><span class="material-symbols-outlined text-lg">more_vert</span></button>
</td>
</tr>
<!-- Row 4 -->
<tr class="employee-table-row-hover border-b border-surface-container-highest transition-colors">
<td class="py-4 px-6 text-primary font-mono text-xs">#TKT-8904</td>
<td class="py-4 px-6 text-on-surface">Khách vãng lai</td>
<td class="py-4 px-6 text-on-surface font-medium">Dune: Part Two</td>
<td class="py-4 px-6 text-outline">19:30 - Rạp 1</td>
<td class="py-4 px-6">
<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-semibold badge-success">Xác nhận</span>
</td>
<td class="py-4 px-6 text-right">
<button class="text-outline hover:text-on-surface transition-colors"><span class="material-symbols-outlined text-lg">more_vert</span></button>
</td>
</tr>
</tbody>
</table>
</div>
</section>
<!-- Footer -->
<footer class="mt-stack-lg pt-stack-md border-t border-surface-container-highest text-center pb-8">
<p class="font-label-sm text-outline font-normal">FPT Cinema Management System © 2026. Phân hệ Nhân viên.</p>
</footer>
</div>
</div>
</main>


</body></html>