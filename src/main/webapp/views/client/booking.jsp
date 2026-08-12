<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<!-- Container chứa thông báo (Toast Alert) -->
<div id="toastNotification" style="display: none; position: fixed; top: 20px; right: 20px; z-index: 10000; background: #ef4444; color: #fff; padding: 14px 20px; border-radius: 10px; font-weight: 600; box-shadow: 0 10px 25px rgba(0,0,0,0.3); align-items: center; gap: 10px; animation: slideIn 0.3s ease-out;">
    <i class="bi bi-exclamation-triangle-fill" style="font-size: 20px;"></i>
    <span id="toastMessage"></span>
</div>

<!-- ==========================
     BOOKING HERO
========================== -->

<section class="container" style="padding-top: 40px; padding-bottom: 40px;">

    <div class="booking-step-card" style="background: #1e293b; border: 1px solid #334155; border-radius: 16px; padding: 25px;">

        <div class="row align-items-center">

            <div class="col-lg-8">

                <h1 class="booking-step-title mb-2" style="font-size: 32px; color: #ffffff !important;">
                    <i class="bi bi-ticket-perforated text-warning me-2"></i>
                    <c:choose>
                        <c:when test="${not empty movie}">${movie.tenPhim}</c:when>
                        <c:otherwise>Chọn ghế</c:otherwise>
                    </c:choose>
                </h1>

                <div style="color: #cbd5e1 !important; font-size: 16px;">

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

                <div style="background: #0f172a; padding: 15px 20px; border-radius: 15px; border: 1px solid #334155; display: inline-block;">

                    <div style="color: #cbd5e1 !important; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
                        STANDARD / VIP / SWEETBOX
                    </div>

                    <div style="color: #ffc107 !important; font-size: 20px; font-weight: 700;">
                        75,000đ - 120,000đ
                    </div>

                </div>

            </div>

        </div>

    </div>

</section>

<!-- ==========================
     SEAT MAP
========================== -->

<section class="container" style="padding-top: 0;">

    <div class="booking-step-card" style="background: #1e293b; border: 1px solid #334155; border-radius: 16px; padding: 25px;">

        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3 mb-4">
            <h2 class="booking-step-title m-0" style="color: #ffffff !important;">
                <span class="booking-step-number"></span> Chọn ghế ngồi
            </h2>

            <!-- KHỐI CHỌN SLOT SỐ LƯỢNG VÉ -->
            <div class="d-flex align-items-center gap-2 px-3 py-2" style="background: #0f172a; border: 1px solid #334155; border-radius: 12px;">
                <span style="color: #ffffff !important; font-size: 14px; font-weight: 600;">Số lượng vé:</span>
                <button type="button" class="btn btn-sm btn-outline-warning text-white fw-bold px-2 py-0" onclick="changeTicketSlot(-1)" style="font-size: 16px;">-</button>
                <span id="slotCountDisplay" class="fw-bold px-2" style="color: #ffc107 !important; font-size: 18px;">1</span>
                <button type="button" class="btn btn-sm btn-outline-warning text-white fw-bold px-2 py-0" onclick="changeTicketSlot(1)" style="font-size: 16px;">+</button>
                <span style="color: #cbd5e1 !important;" class="small ms-1">(Tối đa 8)</span>
            </div>
        </div>

        <!-- Screen -->
        <div class="screen-curve">
            <div class="screen-bar">
                <span>SCREEN</span>
            </div>
        </div>

        <!-- Seat Map -->
        <div style="overflow-x: auto; padding-bottom: 20px;">

            <div id="seat-map" style="display: flex; flex-direction: column; gap: 8px; align-items: center; min-width: max-content;">
                <!-- Ghế sẽ được render bởi JavaScript từ dữ liệu DB -->
            </div>

        </div>

        <!-- Legend -->
        <div class="d-flex flex-wrap justify-content-center gap-4 mt-4"
             style="background: #0f172a; padding: 18px; border-radius: 15px; border: 1px solid #334155;">

            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-standard"></div>
                <span style="color: #ffffff !important; font-size: 13px; font-weight: 600; text-transform: uppercase;">Standard</span>
            </div>

            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-vip"></div>
                <span style="color: #ffc107 !important; font-size: 13px; font-weight: 600; text-transform: uppercase;">VIP</span>
            </div>

            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-sweetbox"></div>
                <span style="color: #fd7e14 !important; font-size: 13px; font-weight: 600; text-transform: uppercase;">Sweetbox (Đôi)</span>
            </div>

            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-selecting"></div>
                <span style="color: #dc3545 !important; font-size: 13px; font-weight: 600; text-transform: uppercase;">Đang chọn</span>
            </div>

            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-occupied">X</div>
                <span style="color: #94a3b8 !important; font-size: 13px; font-weight: 600; text-transform: uppercase;">Đã đặt</span>
            </div>

        </div>

    </div>

</section>

<!-- ============================
     COMBO BẮP & NƯỚC
============================= -->
<section style="max-width: 900px; margin: 30px auto 0; padding: 0 15px;">
    <div style="background: #1e293b; border: 1px solid #334155; border-radius: 16px; padding: 30px;">
        <h3 style="color: #fff !important; font-weight: 700; margin-bottom: 20px; font-size: 20px;">
            <i class="bi bi-cup-straw me-2 text-warning"></i>Chọn Combo Bắp & Nước
        </h3>
        <c:choose>
            <c:when test="${empty listFoods}">
                <p style="color: #94a3b8 !important;">Hiện tại chưa có combo bắp nước nào.</p>
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
                                    <div style="color: #fff !important; font-weight: 600; font-size: 14px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${food.tenDoAn}</div>
                                    <div style="color: #ffc107 !important; font-weight: 700; font-size: 15px; margin-top: 3px;">
                                        <fmt:formatNumber value="${food.gia}" pattern="#,###"/>đ
                                    </div>
                                </div>
                                <div style="flex-shrink: 0; display: flex; align-items: center; gap: 4px;">
                                    <button type="button" class="btn-qty" onclick="changeFoodQty('${food.maDoAn}', -1, '${food.tenDoAn}')" style="width:28px; height:28px; background:#334155; color:#fff; border:none; border-radius:6px; font-weight:bold; cursor:pointer;">-</button>
                                    <input type="number"
                                           id="food_input_${food.maDoAn}"
                                           name="food_${food.maDoAn}"
                                           form="bookingForm"
                                           min="0"
                                           value="0"
                                           data-price="${food.gia}"
                                           data-name="${food.tenDoAn}"
                                           class="food-qty-input"
                                           oninput="validateFoodInput(this)"
                                           onblur="onFoodInputBlur(this)"
                                           style="width: 45px; text-align: center; background: #1e293b; border: 1px solid #334155; color: #fff; border-radius: 8px; padding: 4px; font-weight: 600; font-size: 14px; -moz-appearance: textfield;">
                                    <button type="button" class="btn-qty" onclick="changeFoodQty('${food.maDoAn}', 1, '${food.tenDoAn}')" style="width:28px; height:28px; background:#334155; color:#fff; border:none; border-radius:6px; font-weight:bold; cursor:pointer;">+</button>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <p style="color: #94a3b8 !important; font-size: 12px; margin-top: 12px; margin-bottom: 0;">
                    <i class="bi bi-info-circle me-1"></i>Số lượng combo tối đa bằng 2 lần số ghế đã chọn.
                </p>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- Khoảng cách đẩy footer xuống -->
<div style="margin-top: 100px; margin-bottom: 50px;"></div>

<!-- ==========================
     BOTTOM BAR (Fixed)
========================== -->

<form id="bookingForm"
      action="${pageContext.request.contextPath}/booking"
      method="POST"
      class="booking-bottom-bar">

    <input type="hidden" name="maKhachHang" id="maKhachHang"
           value="${not empty sessionScope.user ? sessionScope.user.maKhachHang : ''}"/>
    <input type="hidden" name="maSuatChieu" value="${maSuatChieu}"/>
    <input type="hidden" name="maPhong" value="${maPhong}"/>
    <input type="hidden" name="seatIds" id="seatIds" value=""/>
    <input type="hidden" name="tongTien" id="tongTien" value="0"/>

    <input type="hidden" name="isGuest" id="isGuest" value="false"/>
    <input type="hidden" name="guestName" id="guestName" value=""/>
    <input type="hidden" name="guestEmail" id="guestEmail" value=""/>
    <input type="hidden" name="guestPhone" id="guestPhone" value=""/>

    <div class="container d-flex flex-wrap justify-content-between align-items-center gap-3">

        <div class="d-flex align-items-center gap-4">
            <div>
                <div style="color: #ffffff !important; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
                    GHẾ ĐÃ CHỌN
                </div>
                <div id="selectedSeatsList"
                     style="color: #ffffff !important; font-size: 18px; font-weight: 700; min-height: 24px;">
                    --
                </div>
            </div>

            <div style="border-left: 1px solid rgba(255, 255, 255, 0.2); padding-left: 20px;">
                <div style="color: #ffffff !important; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
                    TỔNG TIỀN TẠM TÍNH
                </div>
                <div class="d-flex align-items-baseline gap-2">
                    <span id="totalPriceDisplay"
                          style="color: #ffc107 !important; font-size: 24px; font-weight: 700;">
                        0đ
                    </span>
                </div>
            </div>
        </div>

        <div class="d-flex align-items-center gap-3 flex-wrap">
            <div class="d-flex align-items-center gap-2">
                <input type="text" name="maVoucher" class="form-control form-control-sm promo-input" placeholder="Nhập mã giảm giá (nếu có)" style="width: 190px; background: rgba(255, 255, 255, 0.1) !important; border: 1px solid rgba(255, 255, 255, 0.3) !important; color: #ffffff !important; height: 38px; border-radius: 8px;">
            </div>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <button type="submit"
                            id="btnSubmit"
                            class="btn btn-danger btn-lg"
                            disabled
                            style="padding: 12px 30px; font-size: 16px; font-weight: 700; border-radius: 12px; height: 50px; display: flex; align-items: center; justify-content: center; color: #ffffff;">
                        <i class="bi bi-cart-check me-2"></i>Mua vé
                    </button>
                </c:when>

                <c:otherwise>
                    <div style="display: flex; gap: 10px;">
                        <button type="button"
                                id="btnGuestSubmit"
                                class="btn btn-warning btn-lg"
                                disabled
                                onclick="openGuestModal()"
                                style="padding: 12px 20px; font-size: 15px; font-weight: 700; border-radius: 12px; height: 50px; display: flex; align-items: center; justify-content: center; color: #000000;">
                            <i class="bi bi-person-fill-gear me-2"></i>Vé Khách Vãng Lai
                        </button>

                        <button type="button"
                                id="btnLoginSubmit"
                                class="btn btn-outline-light btn-lg"
                                onclick="window.location.href='${pageContext.request.contextPath}/login'"
                                style="padding: 12px 20px; font-size: 15px; font-weight: 700; border-radius: 12px; height: 50px; display: flex; align-items: center; justify-content: center; color: #ffffff;">
                            <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</form>

<!-- ==========================
     MODAL KHÁCH VẮNG LAI
========================== -->
<div id="guestModal" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.8); z-index: 9999; justify-content: center; align-items: center;">
    <div style="background: #1e293b; border: 1px solid #334155; border-radius: 16px; padding: 25px; width: 90%; max-width: 420px; color: #fff; box-shadow: 0 10px 25px rgba(0,0,0,0.5);">
        <h4 style="margin-top: 0; color: #ffc107; font-size: 20px; font-weight: 700; margin-bottom: 15px;">
            <i class="bi bi-person-lines-fill me-2"></i>Thông tin Khách Vãng Lai
        </h4>
        <p style="font-size: 13px; color: #94a3b8; margin-bottom: 20px;">Vui lòng nhập thông tin để nhận thông tin vé qua Email/SĐT:</p>

        <div style="margin-bottom: 12px;">
            <label style="display: block; font-size: 13px; margin-bottom: 5px; color: #cbd5e1;">Họ và tên <span style="color:#ef4444;">*</span></label>
            <input type="text" id="modalGuestName" placeholder="Nguyễn Văn A" style="width: 100%; padding: 10px; background: #0f172a; border: 1px solid #334155; border-radius: 8px; color: #fff; box-sizing: border-box;">
        </div>

        <div style="margin-bottom: 12px;">
            <label style="display: block; font-size: 13px; margin-bottom: 5px; color: #cbd5e1;">Số điện thoại <span style="color:#ef4444;">*</span></label>
            <input type="tel" id="modalGuestPhone" placeholder="0987654321" style="width: 100%; padding: 10px; background: #0f172a; border: 1px solid #334155; border-radius: 8px; color: #fff; box-sizing: border-box;">
        </div>

        <div style="margin-bottom: 20px;">
            <label style="display: block; font-size: 13px; margin-bottom: 5px; color: #cbd5e1;">Email nhận vé <span style="color:#ef4444;">*</span></label>
            <input type="email" id="modalGuestEmail" placeholder="example@gmail.com" style="width: 100%; padding: 10px; background: #0f172a; border: 1px solid #334155; border-radius: 8px; color: #fff; box-sizing: border-box;">
        </div>

        <div style="display: flex; gap: 10px; justify-content: flex-end;">
            <button type="button" onclick="closeGuestModal()" style="padding: 10px 18px; background: #475569; border: none; color: #fff; border-radius: 8px; cursor: pointer; font-weight: 600;">Hủy</button>
            <button type="button" onclick="submitGuestBooking()" style="padding: 10px 18px; background: #dc3545; border: none; color: #fff; border-radius: 8px; cursor: pointer; font-weight: 600;">Xác nhận đặt vé</button>
        </div>
    </div>
</div>

<style>
    @keyframes slideIn {
        from { transform: translateY(-20px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .promo-input::placeholder {
        color: rgba(255, 255, 255, 0.7) !important;
    }

    /* Screen */
    .screen-curve {
        width: 80%;
        margin: 0 auto 50px auto;
        perspective: 500px;
    }

    .screen-bar {
        height: 8px;
        border-radius: 50% 50% 0 0;
        background: linear-gradient(to bottom, rgba(255, 193, 7, 0.6), transparent);
        box-shadow: 0 0 25px rgba(255, 193, 7, 0.15);
        position: relative;
        transform: rotateX(-15deg);
    }

    .screen-bar span {
        position: absolute;
        top: 18px;
        left: 50%;
        transform: translateX(-50%);
        font-size: 12px;
        font-weight: 700;
        color: #cbd5e1 !important;
        letter-spacing: 6px;
        text-transform: uppercase;
    }

    /* Seats */
    .seat {
        width: 36px;
        height: 36px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.25s ease;
        user-select: none;
    }

    .seat-standard {
        background: #273449;
        border: 1px solid #334155;
        color: #ffffff;
    }

    .seat-standard:hover {
        border-color: #ffc107;
        color: #ffffff;
        transform: scale(1.1);
    }

    .seat-vip {
        background: #1e293b;
        border: 1px solid #ffc107;
        color: #ffc107;
    }

    .seat-vip:hover {
        background: rgba(255, 193, 7, 0.2);
        color: #ffc107;
        transform: scale(1.1);
    }

    .seat-sweetbox {
        background: #1e293b;
        border: 1px solid #fd7e14;
        color: #fd7e14;
    }

    .seat-sweetbox:hover {
        background: rgba(253, 126, 20, 0.2);
        color: #fd7e14;
        transform: scale(1.1);
    }

    .seat.selecting {
        background: #dc3545 !important;
        border-color: #dc3545 !important;
        color: #fff !important;
        box-shadow: 0 0 12px rgba(220, 53, 69, 0.5);
        transform: scale(1.1);
    }

    .seat.occupied {
        background: #0f172a !important;
        border-color: transparent !important;
        opacity: 0.4;
        cursor: not-allowed;
        color: rgba(255, 255, 255, 0.3);
    }

    .seat-row-label {
        width: 32px;
        text-align: center;
        font-size: 13px;
        font-weight: 700;
        color: #ffffff !important;
    }

    /* Legend */
    .seat-legend {
        width: 24px;
        height: 24px;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 10px;
        font-weight: 700;
    }

    .seat-legend-standard {
        background: #273449;
        border: 1px solid #334155;
    }

    .seat-legend-vip {
        background: #1e293b;
        border: 1px solid #ffc107;
    }

    .seat-legend-sweetbox {
        background: #1e293b;
        border: 1px solid #fd7e14;
    }

    .seat-legend-selecting {
        background: #dc3545;
        box-shadow: 0 0 10px rgba(220, 53, 69, 0.5);
    }

    .seat-legend-occupied {
        background: #0f172a;
        opacity: 0.5;
        color: rgba(255, 255, 255, 0.4);
    }

    /* Bottom Bar CSS */
    .booking-bottom-bar {
        background: #1f222e !important;
        border-radius: 16px;
        margin: 30px auto 0;
        max-width: 900px;
        border: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.5);
        padding: 18px 0;
        color: #ffffff !important;
    }

    input[type=number]::-webkit-inner-spin-button,
    input[type=number]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }

    @media (max-width: 768px) {
        .seat {
            width: 28px;
            height: 28px;
            font-size: 9px;
        }

        .screen-curve {
            width: 95%;
        }

        .booking-step-title {
            font-size: 20px !important;
        }
    }
</style>

<script>
    // ===== Dữ liệu ghế từ Database =====
    const seatData = [];
    <c:forEach var="seat" items="${seatList}">
        seatData.push({
            maGhe: '${seat.maGhe}',
            hangGhe: '${seat.hangGhe}',
            soGhe: ${seat.soGhe},
            loaiGhe: '${seat.loaiGhe}',
            tenGhe: '${seat.tenGhe}'
        });
    </c:forEach>

    // ===== Danh sách ghế đã đặt =====
    const bookedSeats = [];
    <c:forEach var="booked" items="${bookedSeat}">
        bookedSeats.push('${booked}');
    </c:forEach>

    const priceStandard = 75000;
    const priceVIP = 90000;
    const priceSweetbox = 120000;
    const seatMapEl = document.getElementById('seat-map');

    let selectedSeats = [];
    let maxTicketSlots = 1;
    let rowMap = {};
    let toastTimeout = null;

    function changeTicketSlot(delta) {
        let newSlot = maxTicketSlots + delta;
        if (newSlot >= 1 && newSlot <= 8) {
            maxTicketSlots = newSlot;
            document.getElementById('slotCountDisplay').innerText = maxTicketSlots;

            if (selectedSeats.length > maxTicketSlots) {
                clearAllSelectedSeats();
                showNotification("Đã đặt lại vị trí ghế do thay đổi số lượng vé!");
            }
        }
    }

    function clearAllSelectedSeats() {
        selectedSeats = [];
        document.querySelectorAll('.seat.selecting').forEach(s => s.classList.remove('selecting'));
        adjustFoodQuantities();
        updatePanel();
    }

    function showNotification(msg) {
        const toast = document.getElementById('toastNotification');
        const toastMsg = document.getElementById('toastMessage');

        toastMsg.textContent = msg;
        toast.style.display = 'flex';

        if(toastTimeout) clearTimeout(toastTimeout);
        toastTimeout = setTimeout(() => {
            toast.style.display = 'none';
        }, 3000);
    }

    function getMaxAllowedFood() {
        return selectedSeats.length * 2;
    }

    function renderSeats() {
        rowMap = {};
        seatData.forEach(seat => {
            if (!rowMap[seat.hangGhe]) {
                rowMap[seat.hangGhe] = [];
            }
            rowMap[seat.hangGhe].push(seat);
        });

        const sortedRows = Object.keys(rowMap).sort();

        let html = '';
        sortedRows.forEach(row => {
            const seats = rowMap[row].sort((a, b) => a.soGhe - b.soGhe);
            const halfCount = Math.ceil(seats.length / 2);

            html += '<div style="display:flex; align-items:center; gap:8px;">';
            html += '<div class="seat-row-label">' + row + '</div>';

            html += '<div style="display:flex; gap:6px; margin-right:20px;">';
            for (let i = 0; i < halfCount; i++) {
                html += createSeat(seats[i]);
            }
            html += '</div>';

            html += '<div style="display:flex; gap:6px;">';
            for (let i = halfCount; i < seats.length; i++) {
                html += createSeat(seats[i]);
            }
            html += '</div>';

            html += '<div class="seat-row-label">' + row + '</div>';
            html += '</div>';
        });

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
            'class="seat ' + typeClass + '">' +
            seat.soGhe +
            '</div>';
    }

    renderSeats();

    function validateSeatSlotRule(targetSeatEl) {
        const row = targetSeatEl.getAttribute('data-row');
        const targetId = targetSeatEl.getAttribute('data-id');
        const isSelecting = !targetSeatEl.classList.contains('selecting');

        const rowSeats = rowMap[row].sort((a, b) => a.soGhe - b.soGhe);

        const simulatedStatus = rowSeats.map(s => {
            if (s.maGhe === targetId) {
                return isSelecting ? 'selecting' : 'available';
            }
            const seatEl = document.querySelector(`.seat[data-id="${s.maGhe}"]`);
            if (bookedSeats.includes(s.maGhe)) return 'occupied';
            if (seatEl && seatEl.classList.contains('selecting')) return 'selecting';
            return 'available';
        });

        for (let i = 0; i < simulatedStatus.length; i++) {
            if (simulatedStatus[i] === 'available') {
                const leftTaken = (i === 0) || (simulatedStatus[i - 1] === 'occupied' || simulatedStatus[i - 1] === 'selecting');
                const rightTaken = (i === simulatedStatus.length - 1) || (simulatedStatus[i + 1] === 'occupied' || simulatedStatus[i + 1] === 'selecting');

                if (leftTaken && rightTaken) {
                    showNotification("⚠️ Không thể để trống 1 ghế đơn độc ở giữa hoặc đầu hàng. Vui lòng chọn ghế liên tiếp!");
                    return false;
                }
            }
        }
        return true;
    }

    document.querySelectorAll('.seat:not(.occupied)').forEach(seat => {
        seat.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            const price = parseInt(this.getAttribute('data-price'));
            const name = this.getAttribute('data-name');

            if(this.classList.contains('selecting')) {
                if (!validateSeatSlotRule(this)) {
                    return;
                }
                this.classList.remove('selecting');
                selectedSeats = selectedSeats.filter(s => s.id !== id);
            } else {
                if(selectedSeats.length >= maxTicketSlots) {
                    showNotification("Bạn chỉ được chọn tối đa " + maxTicketSlots + " ghế theo số lượng vé đã chọn.");
                    return;
                }
                if (!validateSeatSlotRule(this)) {
                    return;
                }

                this.classList.add('selecting');
                selectedSeats.push({id, price, name});
            }

            adjustFoodQuantities();
            updatePanel();
        });
    });

    function adjustFoodQuantities() {
        const maxAllowed = getMaxAllowedFood();
        const foodInputs = document.querySelectorAll('.food-qty-input');

        foodInputs.forEach(input => {
            let val = parseInt(input.value) || 0;
            if (val > maxAllowed) {
                input.value = maxAllowed;
            }
        });
    }

    function changeFoodQty(maDoAn, delta, foodName) {
        if (selectedSeats.length === 0) {
            showNotification("Vui lòng chọn ghế trước khi đặt đồ ăn!");
            return;
        }

        const input = document.getElementById('food_input_' + maDoAn);
        if (input) {
            const maxAllowed = getMaxAllowedFood();
            let currentVal = parseInt(input.value) || 0;
            let newVal = currentVal + delta;

            if (newVal > maxAllowed) {
                showNotification("Bạn chọn " + selectedSeats.length + " ghế nên chỉ được mua tối đa " + maxAllowed + " " + foodName + "!");
                newVal = maxAllowed;
            }
            if (newVal < 0) {
                newVal = 0;
            }

            input.value = newVal;
            updatePanel();
        }
    }

    function validateFoodInput(input) {
        if (selectedSeats.length === 0) {
            showNotification("Vui lòng chọn ghế trước khi đặt đồ ăn!");
            input.value = 0;
            updatePanel();
            return;
        }

        const maxAllowed = getMaxAllowedFood();
        const foodName = input.getAttribute('data-name') || 'combo này';

        input.value = input.value.replace(/[^0-9]/g, '');

        let val = parseInt(input.value);

        if (isNaN(val)) {
            updatePanel();
            return;
        }

        if (val > maxAllowed) {
            showNotification("Bạn chọn " + selectedSeats.length + " ghế nên chỉ được mua tối đa " + maxAllowed + " " + foodName + "!");
            input.value = maxAllowed;
        } else if (val < 0) {
            input.value = 0;
        }

        updatePanel();
    }

    function onFoodInputBlur(input) {
        if (input.value === '' || isNaN(parseInt(input.value))) {
            input.value = 0;
            updatePanel();
        }
    }

    function updatePanel() {
        const seatsListEl = document.getElementById('selectedSeatsList');
        const totalPriceEl = document.getElementById('totalPriceDisplay');
        const seatIdsInput = document.getElementById('seatIds');
        const tongTienInput = document.getElementById('tongTien');
        const btnSubmit = document.getElementById('btnSubmit');
        const btnGuestSubmit = document.getElementById('btnGuestSubmit');

        let totalSeatPrice = 0;
        let seatNames = [];
        let seatIds = [];

        selectedSeats.forEach(s => {
            totalSeatPrice += s.price;
            seatNames.push(s.name);
            seatIds.push(s.id);
        });

        let totalFoodPrice = 0;
        document.querySelectorAll('.food-qty-input').forEach(input => {
            const qty = parseInt(input.value) || 0;
            const price = parseFloat(input.getAttribute('data-price')) || 0;
            totalFoodPrice += qty * price;
        });

        const totalAll = totalSeatPrice + totalFoodPrice;

        if (seatsListEl) {
            seatsListEl.innerText = seatNames.length > 0 ? seatNames.join(', ') : '--';
        }
        if (totalPriceEl) {
            totalPriceEl.innerText = totalAll.toLocaleString('vi-VN') + 'đ';
        }
        if (seatIdsInput) {
            seatIdsInput.value = seatIds.join(',');
        }
        if (tongTienInput) {
            tongTienInput.value = totalAll;
        }

        const isEnable = selectedSeats.length > 0;
        if (btnSubmit) btnSubmit.disabled = !isEnable;
        if (btnGuestSubmit) btnGuestSubmit.disabled = !isEnable;
    }

    function openGuestModal() {
        document.getElementById('guestModal').style.display = 'flex';
    }

    function closeGuestModal() {
        document.getElementById('guestModal').style.display = 'none';
    }

    function submitGuestBooking() {
        const name = document.getElementById('modalGuestName').value.trim();
        const phone = document.getElementById('modalGuestPhone').value.trim();
        const email = document.getElementById('modalGuestEmail').value.trim();

        if (!name || !phone || !email) {
            showNotification("Vui lòng nhập đầy đủ thông tin khách vãng lai!");
            return;
        }

        document.getElementById('isGuest').value = 'true';
        document.getElementById('guestName').value = name;
        document.getElementById('guestPhone').value = phone;
        document.getElementById('guestEmail').value = email;

        document.getElementById('bookingForm').submit();
    }
</script>

<jsp:include page="/views/common/footer.jsp"/>