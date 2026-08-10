<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sơ đồ ghế phòng chiếu - FPT CINEMA</title>
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

        .screen-banner {
            background: linear-gradient(180deg, #94a3b8 0%, #cbd5e1 100%);
            color: #334155; text-align: center; padding: 8px; border-radius: 6px;
            font-weight: 800; font-size: 14px; letter-spacing: 4px; margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .seat-grid {
            display: grid;
            grid-template-columns: repeat(10, 1fr);
            gap: 10px;
            max-w-600px;
            margin: 0 auto;
        }

        .seat-box {
            aspect-ratio: 1;
            border-radius: 8px;
            display: flex; align-items: center; justify-content: center;
            font-size: 12px; font-weight: 700;
            border: 1px solid rgba(0,0,0,0.1);
            user-select: none;
        }
        .seat-empty { background-color: #e2e8f0; color: #334155; }
        .seat-booked { background-color: #ef4444; color: white; }
        .seat-vip { background-color: #f59e0b; color: white; }
        .seat-holding { background-color: #3b82f6; color: white; }

        .legend-box {
            width: 18px; height: 18px; border-radius: 4px; display: inline-block;
            vertical-align: middle; margin-right: 6px;
        }
    </style>
</head>
<body>
<% request.setAttribute("currentPage", "seat"); %>

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
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-grid-3x3 me-2 text-primary"></i>Sơ Đồ Ghế Chi Tiết</h1>
                    <p class="text-muted mb-0">Tra cứu vị trí ghế trống, ghế đã đặt và tình trạng phòng chiếu</p>
                </div>
            </div>

            <!-- CHỌN PHÒNG -->
            <div class="card content-card mb-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/seat" method="get" class="d-flex align-items-center gap-3">
                        <label class="fw-bold text-dark">Chọn phòng chiếu:</label>
                        <select name="maPhong" class="form-select w-auto" onchange="this.form.submit()">
                            <option value="P01" ${selectedRoom == 'P01' ? 'selected' : ''}>Phòng 01 - IMAX</option>
                            <option value="P02" ${selectedRoom == 'P02' ? 'selected' : ''}>Phòng 02 - 3D Cinema</option>
                            <option value="P03" ${selectedRoom == 'P03' ? 'selected' : ''}>Phòng 03 - 2D Standard</option>
                        </select>
                        <noscript><button type="submit" class="btn btn-primary">Xem</button></noscript>
                    </form>
                </div>
            </div>

            <!-- CHÚ THÍCH -->
            <div class="card content-card mb-4">
                <div class="card-body d-flex justify-content-center gap-4 flex-wrap">
                    <div><span class="legend-box seat-empty"></span> Ghế trống</div>
                    <div><span class="legend-box seat-booked"></span> Đã đặt</div>
                    <div><span class="legend-box seat-vip"></span> Ghế VIP</div>
                    <div><span class="legend-box seat-holding"></span> Đang giữ ghế</div>
                </div>
            </div>

            <!-- SƠ ĐỒ GHẾ -->
            <div class="card content-card">
                <div class="card-body p-4 text-center">
                    <div class="screen-banner">MÀN HÌNH CHIẾU (SCREEN)</div>

                    <div class="seat-grid mb-4">
                        <%
                        String[] rows = {"A", "B", "C", "D", "E", "F"};
                        for (String r : rows) {
                            for (int col = 1; col <= 10; col++) {
                                String seatCode = r + col;
                                String seatClass = "seat-empty";

                                // Giả lập trạng thái ghế cho minh họa sơ đồ
                                if ("A3".equals(seatCode) || "A4".equals(seatCode) || "C5".equals(seatCode) || "C6".equals(seatCode) || "D8".equals(seatCode)) {
                                    seatClass = "seat-booked";
                                } else if ("C".equals(r) || "D".equals(r)) {
                                    seatClass = "seat-vip";
                                } else if ("B2".equals(seatCode) || "B3".equals(seatCode)) {
                                    seatClass = "seat-holding";
                                }
                        %>
                        <div class="seat-box <%= seatClass %>" title="Ghế <%= seatCode %>">
                            <%= seatCode %>
                        </div>
                        <%
                            }
                        }
                        %>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
