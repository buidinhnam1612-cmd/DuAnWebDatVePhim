<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<!-- ==========================
     BOOKING HERO
========================== -->
<section class="container" style="padding-top: 40px; padding-bottom: 20px;">
    <div class="booking-step-card">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="booking-step-title mb-2" style="font-size: 32px;">
                    <i class="bi bi-ticket-perforated text-warning me-2"></i>
                    <c:choose>
                        <c:when test="${not empty movie}">${movie.tenPhim}</c:when>
                        <c:otherwise>Chọn ghế</c:otherwise>
                    </c:choose>
                </h1>
                <div style="color: #94a3b8; font-size: 16px;">
                    <i class="bi bi-clock me-1"></i>
                    <c:choose>
                        <c:when test="${not empty showtime}">
                            ${showtime.gioBatDau} - ${showtime.gioKetThuc}
                        </c:when>
                        <c:otherwise>--:-- - --:--</c:otherwise>
                    </c:choose>
                    <span class="mx-2" style="opacity: 0.4;">|</span>
                    <i class="bi bi-geo-alt me-1"></i>
                    FPT CINEMA - Phòng ${maPhong}
                </div>
            </div>

            <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                <div style="background: var(--bg); padding: 15px 20px; border-radius: 15px; border: 1px solid var(--border); display: inline-block;">
                    <div style="color: #94a3b8; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
                        Standard / VIP
                    </div>
                    <div style="color: #ffc107; font-size: 24px; font-weight: 700;">
                        75,000đ - 90,000đ
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ==========================
     SELECTION BAR
========================== -->
<section class="container" style="padding-top: 0;">
    <div class="booking-step-card mb-4" style="background: #ffffff; color: #333333; border-radius: 12px; padding: 25px 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
        <!-- Hàng 1: Chọn Số lượng vé -->
        <div class="row align-items-center pb-3 border-bottom border-secondary-subtle">
            <div class="col-12 d-flex align-items-center gap-3">
                <label for="qtySoLuongVe" class="fw-bold fs-6 text-dark mb-0">Số lượng vé:</label>
                <select id="qtySoLuongVe" class="form-select ticket-qty-select" style="width: 100px;" onchange="onTicketCountChange()">
                    <option value="0" selected>0</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                </select>
            </div>
        </div>

        <!-- Hàng 2: Chọn ghế liền nhau -->
        <div id="slotSelectionRow" class="d-flex align-items-center flex-wrap gap-4 pt-3" style="display: none;">
            <div class="fw-bold fs-6 text-dark d-flex align-items-center me-2">
                Chọn ghế liền nhau
                <i class="bi bi-info-circle-fill text-secondary ms-1" style="font-size: 14px;" title="Tự động chọn các ghế kế tiếp nhau khi click"></i>
            </div>

            <div class="d-flex align-items-center gap-4 flex-wrap">
                <label class="lotte-radio-label slot-option" data-slot="1">
                    <input type="radio" id="radioSlot1" name="seatQtyRadio" value="1" checked onclick="setSelectQty(1)">
                    <span class="custom-radio"></span>
                    <span class="seat-icon-group"><span class="seat-box"></span></span>
                </label>

                <label class="lotte-radio-label slot-option" data-slot="2">
                    <input type="radio" id="radioSlot2" name="seatQtyRadio" value="2" onclick="setSelectQty(2)">
                    <span class="custom-radio"></span>
                    <span class="seat-icon-group">
                        <span class="seat-box"></span><span class="seat-box"></span>
                    </span>
                </label>

                <label class="lotte-radio-label slot-option" data-slot="3">
                    <input type="radio" id="radioSlot3" name="seatQtyRadio" value="3" onclick="setSelectQty(3)">
                    <span class="custom-radio"></span>
                    <span class="seat-icon-group">
                        <span class="seat-box"></span><span class="seat-box"></span><span class="seat-box"></span>
                    </span>
                </label>

                <label class="lotte-radio-label slot-option" data-slot="4">
                    <input type="radio" id="radioSlot4" name="seatQtyRadio" value="4" onclick="setSelectQty(4)">
                    <span class="custom-radio"></span>
                    <span class="seat-icon-group">
                        <span class="seat-box"></span><span class="seat-box"></span><span class="seat-box"></span><span class="seat-box"></span>
                    </span>
                </label>
            </div>
        </div>
    </div>
</section>

<!-- ==========================
     SEAT MAP
========================== -->
<section class="container" style="padding-top: 0;">
    <div class="booking-step-card">
        <!-- Screen -->
        <div class="screen-curve">
            <div class="screen-bar">
                <span>SCREEN</span>
            </div>
        </div>

        <!-- Seat Map -->
        <div style="overflow-x: auto; padding-bottom: 20px;">
            <div id="seat-map" style="display: flex; flex-direction: column; gap: 8px; align-items: center; min-width: max-content;">
            </div>
        </div>

        <!-- Legend -->
        <div class="d-flex flex-wrap justify-content-center gap-4 mt-4"
             style="background: var(--bg); padding: 18px; border-radius: 15px; border: 1px solid var(--border);">
            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-standard"></div>
                <span style="color: #94a3b8; font-size: 13px; font-weight: 600; text-transform: uppercase;">Standard</span>
            </div>
            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-vip"></div>
                <span style="color: #ffc107; font-size: 13px; font-weight: 600; text-transform: uppercase;">VIP</span>
            </div>
            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-sweetbox"></div>
                <span style="color: #fd7e14; font-size: 13px; font-weight: 600; text-transform: uppercase;">Sweetbox (Đôi)</span>
            </div>
            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-selecting"></div>
                <span style="color: #dc3545; font-size: 13px; font-weight: 600; text-transform: uppercase;">Đang chọn</span>
            </div>
            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-occupied">X</div>
                <span style="color: #94a3b8; font-size: 13px; font-weight: 600; text-transform: uppercase;">Đã đặt</span>
            </div>
        </div>
    </div>
</section>

<!-- ============================
     COMBO BẮP & NƯỚC
============================= -->
<section style="max-width: 1100px; margin: 30px auto 0; padding: 0 15px;">
    <div style="background: var(--surface, #1e293b); border: 1px solid var(--border, #334155); border-radius: 16px; padding: 30px;">
        <h3 style="color: #fff; font-weight: 700; margin-bottom: 20px; font-size: 20px;">
            <i class="bi bi-cup-straw me-2 text-warning"></i>Chọn Combo Bắp & Nước
        </h3>
        <c:choose>
            <c:when test="${empty listFoods}">
                <p style="color: #94a3b8;">Hiện tại chưa có combo bắp nước nào.</p>
            </c:when>
            <c:otherwise>
                <div class="row g-3">
                    <c:forEach var="food" items="${listFoods}">
                        <div class="col-md-6">
                            <div style="background: #0f172a; border: 1px solid #334155; border-radius: 12px; padding: 15px; display: flex; align-items: center; gap: 15px;">
                                <div style="width: 55px; height: 55px; background: linear-gradient(135deg, #e11d48, #f97316); border-radius: 12px; display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                                    <i class="bi bi-basket3-fill" style="font-size: 22px; color: #fff;"></i>
                                </div>
                                <div style="flex-grow: 1; min-width: 0;">
                                    <div style="color: #fff; font-weight: 600; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${food.tenDoAn}</div>
                                    <div style="color: #ffc107; font-weight: 700; font-size: 15px; margin-top: 3px;">
                                        <fmt:formatNumber value="${food.gia}" pattern="#,###"/>đ
                                    </div>
                                </div>
                                <div style="flex-shrink: 0; width: 65px;">
                                    <input type="number" name="food_${food.maDoAn}" form="bookingForm" min="0" max="10" value="0"
                                           data-price="${food.gia}"
                                           class="food-qty-input"
                                           onchange="validateFoodQuantity(this)"
                                           style="width: 100%; text-align: center; background: #1e293b; border: 1px solid #334155; color: #fff; border-radius: 8px; padding: 6px 4px; font-weight: 600; font-size: 14px;">
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <p style="color: #94a3b8; font-size: 12px; margin-top: 12px; margin-bottom: 0;">
                    <i class="bi bi-info-circle me-1"></i>Mỗi ghế được chọn tối đa 2 món. Tiền combo sẽ tự động cộng vào tổng thanh toán.
                </p>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<div style="margin-top: 100px; margin-bottom: 50px;"></div>

<!-- ==========================
     BOTTOM BAR (Fixed)
========================== -->
<form id="bookingForm" action="${pageContext.request.contextPath}/booking" method="POST" class="booking-bottom-bar">
    <input type="hidden" name="maKhachHang" value="${not empty sessionScope.user ? sessionScope.user.maKhachHang : 'KH01'}"/>
    <input type="hidden" name="maSuatChieu" value="${maSuatChieu}"/>
    <input type="hidden" name="maPhong" value="${maPhong}"/>
    <input type="hidden" name="seatIds" id="seatIds" value=""/>
    <input type="hidden" name="tongTien" id="tongTien" value="0"/>

    <!-- HIDDEN INPUT ĐỂ GỬI MÃ GIẢM GIÁ SANG SERVER -->
    <input type="hidden" name="maVoucherSubmit" id="maVoucherSubmit" value=""/>

    <div class="container d-flex flex-wrap justify-content-between align-items-center gap-3">
        <div class="d-flex align-items-center gap-4">
            <div>
                <div style="color: #cbd5e1; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
                    Ghế đã chọn
                </div>
                <div id="selectedSeatsList" style="color: #fff; font-size: 18px; font-weight: 700; min-height: 24px;">
                    --
                </div>
            </div>

            <div style="border-left: 1px solid var(--border); padding-left: 20px;">
                <div style="color: #cbd5e1; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
                    Tổng tiền tạm tính
                </div>
                <div id="totalPriceDisplay" class="d-flex flex-column justify-content-center">
                    <div style="color: #ffc107 !important; font-size: 26px; font-weight: 800; line-height: 1.2;">
                        0đ
                    </div>
                </div>
            </div>
        </div>

        <div class="d-flex align-items-center gap-3 flex-wrap">
            <!-- VOUCHER INPUT + NÚT ÁP DỤNG -->
            <div class="d-flex align-items-center gap-2">
                <input type="text" id="maVoucherInput" class="form-control form-control-sm" placeholder="Nhập mã giảm giá" style="width: 170px; background: #ffffff; border: 1px solid #cbd5e1; color: #0f172a; height: 42px; border-radius: 8px; font-weight: 500;">
                <button type="button" id="btnApplyVoucher" onclick="handleVoucherToggle()" class="btn btn-warning" style="height: 42px; font-weight: 600; border-radius: 8px; padding: 0 15px; white-space: nowrap;">
                    Áp dụng
                </button>
            </div>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <button type="submit" id="btnSubmit" class="btn btn-danger btn-lg" disabled style="padding: 12px 40px; font-size: 18px; font-weight: 700; border-radius: 12px; height: 50px; display: flex; align-items: center; justify-content: center;">
                        <i class="bi bi-cart-check me-2"></i>Mua vé
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button" id="btnSubmit" class="btn btn-danger btn-lg" disabled onclick="window.location.href='${pageContext.request.contextPath}/login'" style="padding: 12px 40px; font-size: 18px; font-weight: 700; border-radius: 12px; height: 50px; display: flex; align-items: center; justify-content: center;">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập để Mua vé
                    </button>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</form>

<!-- CSS TÙY CHỈNH -->
<style>
    .ticket-qty-select { border: 1px solid #ced4da; border-radius: 6px; font-weight: 600; text-align: center; padding: 4px 8px; }
    .lotte-radio-label { display: inline-flex; align-items: center; cursor: pointer; user-select: none; gap: 6px; }
    .lotte-radio-label input[type="radio"] { display: none; }
    .custom-radio { width: 16px; height: 16px; border: 2px solid #aaa; border-radius: 50%; display: inline-block; position: relative; transition: all 0.2s; }
    .lotte-radio-label input[type="radio"]:checked + .custom-radio { border-color: #333; }
    .lotte-radio-label input[type="radio"]:checked + .custom-radio::after { content: ''; width: 8px; height: 8px; background: #333; border-radius: 50%; position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); }
    .seat-icon-group { display: inline-flex; gap: 2px; }
    .seat-box { width: 16px; height: 16px; background-color: #e2e8f0; border: 1px solid #cbd5e1; border-radius: 3px; display: inline-block; }
    .lotte-radio-label input[type="radio"]:checked ~ .seat-icon-group .seat-box { background-color: #ffc107; border-color: #d97706; }

    .screen-curve { width: 80%; margin: 0 auto 50px auto; perspective: 500px; }
    .screen-bar { height: 8px; border-radius: 50% 50% 0 0; background: linear-gradient(to bottom, rgba(255, 193, 7, 0.6), transparent); box-shadow: 0 0 25px rgba(255, 193, 7, 0.15); position: relative; transform: rotateX(-15deg); }
    .screen-bar span { position: absolute; top: 18px; left: 50%; transform: translateX(-50%); font-size: 12px; font-weight: 700; color: #94a3b8; letter-spacing: 6px; text-transform: uppercase; }

    .seat { width: 36px; height: 36px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-size: 11px; font-weight: 600; cursor: pointer; transition: all 0.25s ease; user-select: none; }
    .seat-standard { background: var(--surface-hover, #273449); border: 1px solid var(--border); color: transparent; }
    .seat-standard:hover { border-color: #ffc107; color: rgba(255, 255, 255, 0.6); transform: scale(1.1); }
    .seat-vip { background: var(--surface); border: 1px solid #ffc107; color: transparent; }
    .seat-vip:hover { background: rgba(255, 193, 7, 0.1); color: rgba(255, 193, 7, 0.7); transform: scale(1.1); }
    .seat-sweetbox { background: var(--surface); border: 1px solid #fd7e14; color: transparent; }
    .seat-sweetbox:hover { background: rgba(253, 126, 20, 0.1); color: rgba(253, 126, 20, 0.7); transform: scale(1.1); }

    .seat.selecting { background: #dc3545 !important; border-color: #dc3545 !important; color: #fff !important; box-shadow: 0 0 12px rgba(220, 53, 69, 0.5); transform: scale(1.1); }
    .seat.occupied { background: #1a1a2e !important; border-color: transparent !important; opacity: 0.4; cursor: not-allowed; color: rgba(255, 255, 255, 0.3); }
    .seat-row-label { width: 32px; text-align: center; font-size: 13px; font-weight: 700; color: #94a3b8; }

    .seat-legend { width: 24px; height: 24px; border-radius: 6px; display: flex; align-items: center; justify-content: center; font-size: 10px; font-weight: 700; }
    .seat-legend-standard { background: var(--surface-hover, #273449); border: 1px solid var(--border); }
    .seat-legend-vip { background: var(--surface); border: 1px solid #ffc107; }
    .seat-legend-sweetbox { background: var(--surface); border: 1px solid #fd7e14; }
    .seat-legend-selecting { background: #dc3545; box-shadow: 0 0 10px rgba(220, 53, 69, 0.5); }
    .seat-legend-occupied { background: #1a1a2e; opacity: 0.5; color: rgba(255, 255, 255, 0.4); }

    .booking-bottom-bar { background: rgba(17, 24, 39, 0.98); border-radius: 16px; margin: 30px auto 0; max-width: 1100px; width: 95%; border: 1px solid var(--border); box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4); padding: 18px 24px; }

    @media (max-width: 768px) {
        .seat { width: 28px; height: 28px; font-size: 9px; }
        .screen-curve { width: 95%; }
        .booking-step-title { font-size: 20px !important; }
    }
</style>

<!-- SCRIPT LOGIC -->
<script>
    const soHang = ${room != null ? room.soHang : 0};
    const soCot = ${room != null ? room.soCot : 0};

    const seatMapData = {};
    <c:forEach var="seat" items="${seatList}">
        seatMapData['${seat.hangGhe}_${seat.soGhe}'] = {
            maGhe: '${seat.maGhe}',
            hangGhe: '${seat.hangGhe}',
            soGhe: ${seat.soGhe},
            loaiGhe: '${seat.loaiGhe}',
            tenGhe: '${seat.tenGhe}'
        };
    </c:forEach>

    const bookedSeats = [];
    <c:forEach var="booked" items="${bookedSeat}">
        bookedSeats.push('${booked}');
    </c:forEach>

    const priceStandard = 75000;
    const priceVIP = 90000;
    const priceSweetbox = 120000;
    const seatMapEl = document.getElementById('seat-map');

    let selectedGroups = [];
    let currentQtyToSelect = 1;

    // QUẢN LÝ TRẠNG THÁI VOUCHER
    let appliedVoucher = {
        applied: false,
        code: '',
        discountPercent: 0.10 // 10%
    };

    function setSelectQty(qty) {
        currentQtyToSelect = qty;
    }

    function getTotalTicketsTarget() {
        return parseInt(document.getElementById('qtySoLuongVe').value) || 0;
    }

    function getCurrentlySelectedCount() {
        return selectedGroups.reduce((sum, group) => sum + group.length, 0);
    }

    // XỬ LÝ ÁP DỤNG / HỦY VOUCHER
    function handleVoucherToggle() {
        const inputEl = document.getElementById('maVoucherInput');
        const submitInputEl = document.getElementById('maVoucherSubmit');
        const btnEl = document.getElementById('btnApplyVoucher');

        if (appliedVoucher.applied) {
            appliedVoucher.applied = false;
            appliedVoucher.code = '';
            submitInputEl.value = '';

            inputEl.readOnly = false;
            inputEl.value = '';
            btnEl.textContent = 'Áp dụng';
            btnEl.className = 'btn btn-warning';

            alert('Đã hủy áp dụng mã giảm giá.');
            updatePanel();
            return;
        }

        const code = inputEl.value.trim();
        if (!code) {
            alert('Vui lòng nhập mã giảm giá!');
            return;
        }

        const qtySelect = document.getElementById('qtySoLuongVe');
        let currentQty = parseInt(qtySelect.value) || 0;

        if (currentQty <= 0) {
            alert('Vui lòng chọn số lượng vé trước khi áp dụng mã!');
            return;
        }

        appliedVoucher.applied = true;
        appliedVoucher.code = code;
        submitInputEl.value = code;

        inputEl.readOnly = true;
        btnEl.textContent = 'Hủy mã';
        btnEl.className = 'btn btn-danger';

        alert('Áp dụng mã "' + code + '" thành công!\n- Bạn được giảm 10% TRÊN TIỀN GHẾ.');
        updatePanel();
    }

    function updateSlotUI() {
        const totalTickets = getTotalTicketsTarget();
        const slotRowContainer = document.getElementById('slotSelectionRow');
        const slotLabels = document.querySelectorAll('.slot-option');

        if (totalTickets <= 0) {
            if (slotRowContainer) slotRowContainer.style.setProperty('display', 'none', 'important');
            return;
        }

        if (slotRowContainer) slotRowContainer.style.setProperty('display', 'flex', 'important');

        slotLabels.forEach(label => {
            const slotValue = parseInt(label.getAttribute('data-slot'));
            if (slotValue > totalTickets) {
                label.style.setProperty('display', 'none', 'important');
            } else {
                label.style.setProperty('display', 'inline-flex', 'important');
            }
        });

        if (currentQtyToSelect > totalTickets) {
            currentQtyToSelect = 1;
            const defaultRadio = document.getElementById('radioSlot1');
            if (defaultRadio) defaultRadio.checked = true;
        }
    }

    function onTicketCountChange() {
        updateSlotUI();
        const target = getTotalTicketsTarget();
        if (getCurrentlySelectedCount() > target) {
            resetAllSelectedSeats();
        }
    }

    function resetAllSelectedSeats() {
        selectedGroups = [];
        document.querySelectorAll('.seat.selecting').forEach(el => {
            el.classList.remove('selecting');
        });
        resetFoodSelection();
        updatePanel();
    }

    function resetFoodSelection() {
        document.querySelectorAll('.food-qty-input').forEach(input => {
            input.value = 0;
        });
    }

    function validateFoodQuantity(changedInput, isAutoReset = false) {
        const seatCount = getCurrentlySelectedCount();
        const maxAllowedFood = seatCount * 2;

        if (seatCount === 0) {
            changedInput.value = 0;
            if (!isAutoReset) {
                alert("Vui lòng chọn ghế trước khi chọn đồ ăn!");
            }
            updatePanel();
            return;
        }

        let totalFood = 0;
        document.querySelectorAll('.food-qty-input').forEach(input => {
            totalFood += parseInt(input.value) || 0;
        });

        if (totalFood > maxAllowedFood) {
            if (!isAutoReset) {
                alert("Bạn chỉ được chọn tối đa " + maxAllowedFood + " món ăn/nước uống (" + seatCount + " ghế x 2 món)!");
            }
            const overCount = totalFood - maxAllowedFood;
            const currentVal = parseInt(changedInput.value) || 0;
            changedInput.value = Math.max(0, currentVal - overCount);
        }

        updatePanel();
    }

    function getTotalFoodPrice() {
        let foodTotal = 0;
        document.querySelectorAll('.food-qty-input').forEach(input => {
            const qty = parseInt(input.value) || 0;
            const price = parseInt(input.getAttribute('data-price')) || 0;
            foodTotal += qty * price;
        });
        return foodTotal;
    }

    function renderSeats() {
        if (soHang === 0 || soCot === 0) {
            seatMapEl.innerHTML = '<p style="color:white;">Không thể tải cấu trúc sơ đồ ghế phòng chiếu.</p>';
            return;
        }

        let html = '';
        for (let i = 0; i < soHang; i++) {
            const rowLabel = String.fromCharCode(65 + i);

            html += '<div style="display:flex; align-items:center; justify-content:center; gap:8px;">';
            html += '<div class="seat-row-label">' + rowLabel + '</div>';

            for (let j = 1; j <= soCot; j++) {
                const key = rowLabel + '_' + j;
                const seat = seatMapData[key];

                if (seat) {
                    html += createSeat(seat);
                } else {
                    html += '<div style="width:36px; height:36px; margin:0; pointer-events:none;"></div>';
                }
            }

            html += '<div class="seat-row-label">' + rowLabel + '</div>';
            html += '</div>';
        }

        seatMapEl.innerHTML = html;
    }

    function createSeat(seat) {
        const isOccupied = bookedSeats.includes(seat.maGhe);
        const isVip = seat.loaiGhe === 'VIP';
        const isSweetbox = seat.loaiGhe === 'Sweetbox';

        let price = priceStandard;
        let typeClass = 'seat-standard';

        if (isVip) {
            price = priceVIP;
            typeClass = 'seat-vip';
        } else if (isSweetbox) {
            price = priceSweetbox;
            typeClass = 'seat-sweetbox';
        }

        if (isOccupied) {
            return '<div class="seat occupied"><span>X</span></div>';
        }

        return '<div ' +
            'data-id="' + seat.maGhe + '" ' +
            'data-price="' + price + '" ' +
            'data-name="' + seat.tenGhe + '" ' +
            'data-row="' + seat.hangGhe + '" ' +
            'data-col="' + seat.soGhe + '" ' +
            'class="seat ' + typeClass + '">' +
            seat.soGhe +
            '</div>';
    }

    renderSeats();

    document.querySelectorAll('.seat:not(.occupied)').forEach(seatEl => {
        seatEl.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            const targetTotal = getTotalTicketsTarget();

            if (targetTotal <= 0) {
                alert("Vui lòng chọn số lượng vé trước khi chọn ghế!");
                return;
            }

            if (this.classList.contains('selecting')) {
                const groupIndex = selectedGroups.findIndex(group => group.some(s => s.id === id));
                if (groupIndex !== -1) {
                    const groupToRemove = selectedGroups[groupIndex];
                    groupToRemove.forEach(seatData => {
                        const el = document.querySelector('.seat[data-id="' + seatData.id + '"]');
                        if (el) el.classList.remove('selecting');
                    });
                    selectedGroups.splice(groupIndex, 1);

                    document.querySelectorAll('.food-qty-input').forEach(input => validateFoodQuantity(input, true));
                    updatePanel();
                }
                return;
            }

            const currentSelectedCount = getCurrentlySelectedCount();

            if (currentSelectedCount + currentQtyToSelect > targetTotal) {
                alert('Bạn chọn vượt quá tổng số vé đăng ký (' + targetTotal + ' vé). Hệ thống sẽ hủy các ghế đã chọn để bạn chọn lại!');
                resetAllSelectedSeats();
                return;
            }

            const row = this.getAttribute('data-row');
            const startCol = parseInt(this.getAttribute('data-col'));

            let newGroup = [];
            let isValidGroup = true;

            for (let c = startCol; c < startCol + currentQtyToSelect; c++) {
                const targetKey = row + '_' + c;
                const targetSeatData = seatMapData[targetKey];

                if (!targetSeatData) {
                    isValidGroup = false;
                    break;
                }

                const targetEl = document.querySelector('.seat[data-id="' + targetSeatData.maGhe + '"]');

                if (targetEl && !targetEl.classList.contains('occupied') && !targetEl.classList.contains('selecting')) {
                    newGroup.push({
                        el: targetEl,
                        data: {
                            id: targetSeatData.maGhe,
                            price: parseInt(targetEl.getAttribute('data-price')),
                            name: targetSeatData.tenGhe
                        }
                    });
                } else {
                    isValidGroup = false;
                    break;
                }
            }

            if (!isValidGroup || newGroup.length < currentQtyToSelect) {
                alert("Không đủ " + currentQtyToSelect + " ghế trống liên tiếp tính từ vị trí chọn.");
                return;
            }

            let groupSeatData = [];
            newGroup.forEach(item => {
                item.el.classList.add('selecting');
                groupSeatData.push(item.data);
            });

            selectedGroups.push(groupSeatData);
            updatePanel();
        });
    });

    // CẬP NHẬT TỔNG TIỀN (VOUCHER CHỈ GIẢM TRÊN TIỀN GHẾ)
    function updatePanel() {
        const seatsListEl = document.getElementById('selectedSeatsList');
        const totalDisplay = document.getElementById('totalPriceDisplay');
        const inputIds = document.getElementById('seatIds');
        const inputTotal = document.getElementById('tongTien');
        const btnSubmit = document.getElementById('btnSubmit');

        const allSelectedSeats = selectedGroups.flat();
        const foodTotalPrice = getTotalFoodPrice();

        if (allSelectedSeats.length > 0) {
            allSelectedSeats.sort((a, b) => a.name.localeCompare(b.name));

            const names = allSelectedSeats.map(s => s.name).join(', ');
            const ids = allSelectedSeats.map(s => s.id).join(',');

            // 1. Tính tổng tiền ghế
            const seatTotal = allSelectedSeats.reduce((sum, s) => sum + s.price, 0);

            // 2. Tính số tiền được giảm (CHỈ TÍNH TRÊN TIỀN GHẾ)
            let discountAmount = 0;
            if (appliedVoucher.applied) {
                discountAmount = seatTotal * appliedVoucher.discountPercent;
            }

            // 3. Tính tổng thanh toán cuối cùng: (Tiền ghế - Giảm giá) + Tiền đồ ăn
            let grandTotal = Math.max(0, (seatTotal - discountAmount) + foodTotalPrice);

            seatsListEl.textContent = names;

            if (appliedVoucher.applied) {
                totalDisplay.innerHTML =
                    '<div style="color: #ffc107 !important; font-size: 26px; font-weight: 800; line-height: 1.2;">' +
                        grandTotal.toLocaleString('vi-VN') + 'đ' +
                    '</div>' +
                    '<div style="color: #4ade80 !important; font-size: 13px; font-weight: 600; white-space: nowrap; margin-top: 2px;">' +
                        '(Đã giảm 10% ghế - ' + discountAmount.toLocaleString('vi-VN') + 'đ)' +
                    '</div>';
            } else {
                totalDisplay.innerHTML =
                    '<div style="color: #ffc107 !important; font-size: 26px; font-weight: 800; line-height: 1.2;">' +
                        grandTotal.toLocaleString('vi-VN') + 'đ' +
                    '</div>';
            }

            inputIds.value = ids;
            inputTotal.value = grandTotal;

            // Kích hoạt nút bấm đặt vé nếu đủ số lượng vé yêu cầu
            const targetTotal = getTotalTicketsTarget();
            if (allSelectedSeats.length === targetTotal) {
                btnSubmit.disabled = false;
            } else {
                btnSubmit.disabled = true;
            }
        } else {
            seatsListEl.textContent = '--';
            totalDisplay.innerHTML =
                '<div style="color: #ffc107 !important; font-size: 26px; font-weight: 800; line-height: 1.2;">0đ</div>';

            inputIds.value = '';
            inputTotal.value = '0';
            btnSubmit.disabled = true;
        }
    }
</script>

<jsp:include page="/views/common/footer.jsp"/>