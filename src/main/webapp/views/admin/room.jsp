<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Phòng Chiếu - FPT CINEMA</title>
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
        .table td { vertical-align: middle; }
        .btn-action { padding: 5px 12px; font-size: 13px; border-radius: 6px; }

        /* Sơ đồ ghế */
        .seat-map-container { overflow-x: auto; padding: 20px; background: #fff; border-radius: 10px; border: 1px solid #e2e8f0; text-align: center; }
        .screen { background: linear-gradient(to bottom, #cbd5e1, #f8fafc); height: 40px; border-radius: 20px 20px 0 0; margin: 0 auto 40px auto; width: 80%; display: flex; align-items: center; justify-content: center; font-weight: bold; color: #64748b; box-shadow: 0 4px 10px rgba(0,0,0,0.05); text-transform: uppercase; letter-spacing: 2px; }
        .seat-row { display: flex; justify-content: center; margin-bottom: 10px; align-items: center; }
        .row-label { width: 30px; font-weight: bold; color: #64748b; margin-right: 15px; }
        .seat-cell { width: 35px; height: 35px; margin: 0 4px; border-radius: 8px 8px 4px 4px; cursor: pointer; display: flex; align-items: center; justify-content: center; font-size: 11px; font-weight: bold; color: white; transition: all 0.2s; user-select: none; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .seat-cell:hover { transform: scale(1.1); }
        .seat-cell.Thường { background-color: #3b82f6; }
        .seat-cell.VIP { background-color: #ef4444; }
        .seat-cell.Sweetbox { background-color: #ec4899; width: 78px; }
        .seat-cell.Trống { background-color: transparent; box-shadow: none; color: transparent; border: 1px dashed #cbd5e1; }
        .seat-cell.Trống:hover { background-color: #f1f5f9; }
        .legend { display: flex; justify-content: center; gap: 20px; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e2e8f0; }
        .legend-item { display: flex; align-items: center; font-size: 14px; color: #475569; }
        .legend-color { width: 20px; height: 20px; border-radius: 4px; margin-right: 8px; }
    </style>
</head>
<body>
<% request.setAttribute("currentPage", "room"); %>

<div class="container-fluid">
    <div class="row">
        <!-- ==================== SIDEBAR ==================== -->
        <div class="col-md-3 col-lg-2 sidebar p-0 text-white">
            <jsp:include page="/views/common/admin-sidebar.jsp" />
        </div>

        <!-- ==================== MAIN CONTENT ==================== -->
        <div class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">

            <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
                <div>
                    <h1 class="h3 fw-bold text-dark mb-1"><i class="bi bi-door-open me-2"></i>Quản Lý Phòng Chiếu</h1>
                    <p class="text-muted mb-0">Thiết kế sơ đồ ghế thực tế</p>
                </div>
            </div>

            <!-- Thông báo trạng thái -->
            <c:if test="${param.status == 'success'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle me-2"></i>Tạo phòng chiếu và sơ đồ ghế thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.status == 'fail'}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle me-2"></i>Tạo phòng chiếu thất bại! Vui lòng kiểm tra lại.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- ==================== STEP 1: FORM ==================== -->
            <div class="card content-card mb-4">
                <div class="card-header bg-white py-3">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-grid-3x3 me-2 text-primary"></i>1. Khởi tạo kích thước sơ đồ</h5>
                </div>
                <div class="card-body">
                    <div class="row g-3 align-items-end">
                        <div class="col-md-2">
                            <label class="form-label fw-semibold">Mã Phòng</label>
                            <input type="text" class="form-control" id="maPhong" placeholder="VD: P01">
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-semibold">Tên Phòng</label>
                            <input type="text" class="form-control" id="tenPhong" placeholder="VD: Phòng 1">
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-semibold">Mã Rạp</label>
                            <input type="text" class="form-control" id="maRap" placeholder="VD: R01">
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-semibold">Số Hàng (Max 26)</label>
                            <input type="number" class="form-control" id="soHang" value="10" min="1" max="26">
                        </div>
                        <div class="col-md-2">
                            <label class="form-label fw-semibold">Số Cột (Max 30)</label>
                            <input type="number" class="form-control" id="soCot" value="12" min="1" max="30">
                        </div>
                        <div class="col-md-1">
                            <button type="button" class="btn btn-primary w-100" onclick="generateGrid()">Tạo</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ==================== STEP 2: BUILDER ==================== -->
            <div class="card content-card mb-4" id="seatMapCard" style="display: none;">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-display me-2 text-info"></i>2. Thiết kế sơ đồ ghế</h5>
                    <small class="text-muted">Click vào ghế để đổi loại: Thường &rarr; VIP &rarr; Sweetbox &rarr; Lối đi</small>
                </div>
                <div class="card-body">
                    <div class="seat-map-container">
                        <div class="screen">MÀN HÌNH</div>
                        <div id="seatGrid"></div>
                        
                        <div class="legend">
                            <div class="legend-item"><div class="legend-color bg-primary"></div>Thường</div>
                            <div class="legend-item"><div class="legend-color bg-danger"></div>VIP</div>
                            <div class="legend-item"><div class="legend-color" style="background:#ec4899"></div>Sweetbox</div>
                            <div class="legend-item"><div class="legend-color" style="border:1px dashed #cbd5e1"></div>Lối đi / Trống</div>
                        </div>
                    </div>

                    <form id="saveRoomForm" action="${pageContext.request.contextPath}/admin/room" method="post" class="mt-4 text-center">
                        <input type="hidden" name="action" value="add">
                        <!-- Hidden fields -->
                        <input type="hidden" name="maPhong" id="formMaPhong">
                        <input type="hidden" name="tenPhong" id="formTenPhong">
                        <input type="hidden" name="maRap" id="formMaRap">
                        <input type="hidden" name="soHang" id="formSoHang">
                        <input type="hidden" name="soCot" id="formSoCot">
                        
                        <div id="hiddenSeatInputs"></div>

                        <button type="button" class="btn btn-success btn-lg px-5" onclick="submitRoom()">
                            <i class="bi bi-save me-2"></i>Lưu Sơ Đồ & Phòng Chiếu
                        </button>
                    </form>
                </div>
            </div>

            <!-- ==================== BẢNG DANH SÁCH ==================== -->
            <div class="card content-card">
                <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold"><i class="bi bi-list-ul me-2"></i>Danh Sách Phòng Chiếu</h5>
                    <span class="badge bg-primary rounded-pill">${roomList.size()} phòng</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead>
                                <tr>
                                    <th class="ps-4">#</th>
                                    <th>Mã Phòng</th>
                                    <th>Tên Phòng</th>
                                    <th>Tổng Số Ghế</th>
                                    <th>Mã Rạp</th>
                                    <th class="text-center">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${roomList}" varStatus="stt">
                                    <tr>
                                        <td class="ps-4 fw-semibold">${stt.index + 1}</td>
                                        <td><span class="badge bg-secondary">${r.maPhong}</span></td>
                                        <td class="fw-semibold">${r.tenPhong}</td>
                                        <td>
                                            <span class="badge bg-info text-dark">
                                                <i class="bi bi-grid-3x3 me-1"></i>${r.tongSoGhe} ghế
                                            </span>
                                        </td>
                                        <td><span class="badge bg-dark">${r.maRap}</span></td>
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/admin/seat?maPhong=${r.maPhong}" class="btn btn-outline-primary btn-action">
                                                <i class="bi bi-eye"></i> Xem ghế
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty roomList}">
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">
                                            <i class="bi bi-inbox fs-1 d-block mb-2"></i>
                                            Chưa có phòng chiếu nào trong hệ thống
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    const types = ['Thường', 'VIP', 'Sweetbox', 'Trống'];
    
    function generateGrid() {
        const rows = parseInt(document.getElementById('soHang').value);
        const cols = parseInt(document.getElementById('soCot').value);
        
        if (!rows || !cols || rows < 1 || cols < 1 || rows > 26 || cols > 30) {
            alert('Vui lòng nhập số hàng (1-26) và số cột (1-30) hợp lệ.');
            return;
        }

        const grid = document.getElementById('seatGrid');
        grid.innerHTML = '';
        
        for (let i = 0; i < rows; i++) {
            const rowLabel = String.fromCharCode(65 + i);
            const rowDiv = document.createElement('div');
            rowDiv.className = 'seat-row';
            
            const labelDiv = document.createElement('div');
            labelDiv.className = 'row-label';
            labelDiv.textContent = rowLabel;
            rowDiv.appendChild(labelDiv);

            for (let j = 1; j <= cols; j++) {
                const seatDiv = document.createElement('div');
                seatDiv.className = 'seat-cell Thường';
                seatDiv.dataset.row = rowLabel;
                seatDiv.dataset.col = j;
                seatDiv.dataset.type = 'Thường';
                seatDiv.textContent = j;

                seatDiv.onclick = function() {
                    let currentType = this.dataset.type;
                    let nextIndex = (types.indexOf(currentType) + 1) % types.length;
                    let nextType = types[nextIndex];
                    
                    this.className = 'seat-cell ' + nextType;
                    this.dataset.type = nextType;
                    this.textContent = nextType === 'Trống' ? '' : j;
                };

                rowDiv.appendChild(seatDiv);
            }
            grid.appendChild(rowDiv);
        }

        document.getElementById('seatMapCard').style.display = 'block';
    }

    function submitRoom() {
        const maPhong = document.getElementById('maPhong').value.trim();
        const tenPhong = document.getElementById('tenPhong').value.trim();
        const maRap = document.getElementById('maRap').value.trim();
        const soHang = document.getElementById('soHang').value;
        const soCot = document.getElementById('soCot').value;

        if(!maPhong || !tenPhong || !maRap) {
            alert('Vui lòng điền đầy đủ Mã phòng, Tên phòng và Mã rạp ở Bước 1.');
            return;
        }

        document.getElementById('formMaPhong').value = maPhong;
        document.getElementById('formTenPhong').value = tenPhong;
        document.getElementById('formMaRap').value = maRap;
        document.getElementById('formSoHang').value = soHang;
        document.getElementById('formSoCot').value = soCot;

        const hiddenContainer = document.getElementById('hiddenSeatInputs');
        hiddenContainer.innerHTML = ''; 

        const seats = document.querySelectorAll('.seat-cell');
        let count = 0;
        seats.forEach(seat => {
            const type = seat.dataset.type;
            if (type !== 'Trống') {
                count++;
                
                let inputRow = document.createElement('input');
                inputRow.type = 'hidden';
                inputRow.name = 'hangGhes[]';
                inputRow.value = seat.dataset.row;
                
                let inputCol = document.createElement('input');
                inputCol.type = 'hidden';
                inputCol.name = 'soGhes[]';
                inputCol.value = seat.dataset.col;

                let inputType = document.createElement('input');
                inputType.type = 'hidden';
                inputType.name = 'loaiGhes[]';
                inputType.value = type;

                hiddenContainer.appendChild(inputRow);
                hiddenContainer.appendChild(inputCol);
                hiddenContainer.appendChild(inputType);
            }
        });

        if (count === 0) {
            alert('Vui lòng thiết kế ít nhất 1 ghế cho phòng chiếu.');
            return;
        }

        if(confirm('Bạn có chắc chắn lưu phòng chiếu này với ' + count + ' ghế?')) {
            document.getElementById('saveRoomForm').submit();
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
