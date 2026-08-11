<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="/views/common/header.jsp"/>
<jsp:include page="/views/common/navbar.jsp"/>

<!-- ==========================
     BOOKING HERO
========================== -->

<section class="container" style="padding-top: 40px; padding-bottom: 40px;">

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

                <div style="color: var(--text-muted); font-size: 16px;">

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

                    <div style="color: var(--text-muted); font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
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
     SEAT MAP
========================== -->

<section class="container" style="padding-top: 0;">

    <div class="booking-step-card">

        <h2 class="booking-step-title">
            <span class="booking-step-number"></span> Chọn ghế ngồi
        </h2>

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
             style="background: var(--bg); padding: 18px; border-radius: 15px; border: 1px solid var(--border);">

            <div class="d-flex align-items-center gap-2">
                <div class="seat-legend seat-legend-standard"></div>
                <span style="color: var(--text-muted); font-size: 13px; font-weight: 600; text-transform: uppercase;">Standard</span>
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
                <span style="color: var(--text-muted); font-size: 13px; font-weight: 600; text-transform: uppercase;">Đã đặt</span>
            </div>

        </div>

    </div>

</section>

<!-- ============================
     COMBO BẮP & NƯỚC
============================= -->
<section style="max-width: 900px; margin: 30px auto 0; padding: 0 15px;">
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
                                           style="width: 100%; text-align: center; background: #1e293b; border: 1px solid #334155; color: #fff; border-radius: 8px; padding: 6px 4px; font-weight: 600; font-size: 14px;">
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <p style="color: #64748b; font-size: 12px; margin-top: 12px; margin-bottom: 0;">
                    <i class="bi bi-info-circle me-1"></i>Tiền combo sẽ được tính chung vào hóa đơn khi bạn bấm Mua vé.
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

    <input type="hidden" name="maKhachHang"
           value="${not empty sessionScope.user ? sessionScope.user.maKhachHang : 'KH01'}"/>
    <input type="hidden" name="maSuatChieu" value="${maSuatChieu}"/>
    <input type="hidden" name="maPhong" value="${maPhong}"/>
    <input type="hidden" name="seatIds" id="seatIds" value=""/>
    <input type="hidden" name="tongTien" id="tongTien" value="0"/>


    <div class="container d-flex flex-wrap justify-content-between align-items-center gap-3">

        <div class="d-flex align-items-center gap-4">
            <div>
                <div style="color: var(--text-muted); font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
                    Ghế đã chọn
                </div>
                <div id="selectedSeatsList"
                     style="color: #fff; font-size: 18px; font-weight: 700; min-height: 24px;">
                    --
                </div>
            </div>

            <div style="border-left: 1px solid var(--border); padding-left: 20px;">
                <div style="color: var(--text-muted); font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px;">
                    Tổng tiền tạm tính
                </div>
                <div class="d-flex align-items-baseline gap-2">
                    <span id="totalPriceDisplay"
                          style="color: #ffc107; font-size: 24px; font-weight: 700;">
                        0đ
                    </span>
                </div>
            </div>
        </div>

        <div class="d-flex align-items-center gap-3 flex-wrap">
            <!-- Promo Code Area -->
            <div class="d-flex align-items-center gap-2">
                <input type="text" name="maVoucher" class="form-control form-control-sm" placeholder="Nhập mã giảm giá (nếu có)" style="width: 180px; background: #1e293b; border: 1px solid var(--border); color: #fff; height: 38px; border-radius: 8px;">
            </div>

            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <button type="submit"
                            id="btnSubmit"
                            class="btn btn-danger btn-lg"
                            disabled
                            style="padding: 12px 40px; font-size: 18px; font-weight: 700; border-radius: 12px; height: 50px; display: flex; align-items: center; justify-content: center;">
                        <i class="bi bi-cart-check me-2"></i>Mua vé
                    </button>
                </c:when>
                <c:otherwise>
                    <button type="button"
                            id="btnSubmit"
                            class="btn btn-danger btn-lg"
                            disabled
                            onclick="window.location.href='${pageContext.request.contextPath}/login'"
                            style="padding: 12px 40px; font-size: 18px; font-weight: 700; border-radius: 12px; height: 50px; display: flex; align-items: center; justify-content: center;">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập để Mua vé
                    </button>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</form>

<!-- Extra CSS for booking page -->
<style>

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
        color: var(--text-muted);
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
        background: var(--surface-hover, #273449);
        border: 1px solid var(--border);
        color: transparent;
    }

    .seat-standard:hover {
        border-color: #ffc107;
        color: rgba(255, 255, 255, 0.6);
        transform: scale(1.1);
    }

    .seat-vip {
        background: var(--surface);
        border: 1px solid #ffc107;
        color: transparent;
    }

    .seat-vip:hover {
        background: rgba(255, 193, 7, 0.1);
        color: rgba(255, 193, 7, 0.7);
        transform: scale(1.1);
    }

    .seat-sweetbox {
        background: var(--surface);
        border: 1px solid #fd7e14;
        color: transparent;
    }

    .seat-sweetbox:hover {
        background: rgba(253, 126, 20, 0.1);
        color: rgba(253, 126, 20, 0.7);
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
        background: #1a1a2e !important;
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
        color: var(--text-muted);
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
        background: var(--surface-hover, #273449);
        border: 1px solid var(--border);
    }

    .seat-legend-vip {
        background: var(--surface);
        border: 1px solid #ffc107;
    }

    .seat-legend-sweetbox {
        background: var(--surface);
        border: 1px solid #fd7e14;
    }

    .seat-legend-selecting {
        background: #dc3545;
        box-shadow: 0 0 10px rgba(220, 53, 69, 0.5);
    }

    .seat-legend-occupied {
        background: #1a1a2e;
        opacity: 0.5;
        color: rgba(255, 255, 255, 0.4);
    }

    /* Bottom Bar */
    .booking-bottom-bar {
        background: rgba(17, 24, 39, 0.95);
        border-radius: 16px;
        margin: 30px auto 0;
        max-width: 900px;
        border: 1px solid var(--border);
        box-shadow: 0 4px 30px rgba(0, 0, 0, 0.2);
        padding: 18px 0;
    }

    /* Responsive seats */
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

    function renderSeats() {
        // Nhóm ghế theo hàng
        const rowMap = {};
        seatData.forEach(seat => {
            if (!rowMap[seat.hangGhe]) {
                rowMap[seat.hangGhe] = [];
            }
            rowMap[seat.hangGhe].push(seat);
        });

        // Sắp xếp các hàng theo thứ tự alphabet
        const sortedRows = Object.keys(rowMap).sort();

        let html = '';
        sortedRows.forEach(row => {
            const seats = rowMap[row].sort((a, b) => a.soGhe - b.soGhe);
            const halfCount = Math.ceil(seats.length / 2);

            html += '<div style="display:flex; align-items:center; gap:8px;">';
            html += '<div class="seat-row-label">' + row + '</div>';

            // Nửa trái
            html += '<div style="display:flex; gap:6px; margin-right:20px;">';
            for (let i = 0; i < halfCount; i++) {
                html += createSeat(seats[i]);
            }
            html += '</div>';

            // Nửa phải
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
            return '<div class="seat occupied">' +
                '<span>X</span>' +
                '</div>';
        }

        return '<div ' +
            'data-id="' + seat.maGhe + '" ' +
            'data-price="' + price + '" ' +
            'data-name="' + seat.tenGhe + '" ' +
            'class="seat ' + typeClass + '">' +
            seat.soGhe +
            '</div>';
    }

    renderSeats();

    document.querySelectorAll('.seat:not(.occupied)').forEach(seat => {
        seat.addEventListener('click', function() {
            const id = this.getAttribute('data-id');
            const price = parseInt(this.getAttribute('data-price'));
            const name = this.getAttribute('data-name');

            if(this.classList.contains('selecting')) {
                this.classList.remove('selecting');
                selectedSeats = selectedSeats.filter(s => s.id !== id);
            } else {
                if(selectedSeats.length >= 8) {
                    alert("Bạn chỉ được chọn tối đa 8 ghế.");
                    return;
                }
                this.classList.add('selecting');
                selectedSeats.push({id, price, name});
            }
            updatePanel();
        });
    });

    function updatePanel() {
        const seatsListEl = document.getElementById('selectedSeatsList');
        const totalDisplay = document.getElementById('totalPriceDisplay');
        const inputIds = document.getElementById('seatIds');
        const inputTotal = document.getElementById('tongTien');
        const btnSubmit = document.getElementById('btnSubmit');

        if(selectedSeats.length > 0) {
            const names = selectedSeats.map(s => s.name).join(', ');
            const ids = selectedSeats.map(s => s.id).join(',');
            const total = selectedSeats.reduce((sum, s) => sum + s.price, 0);

            seatsListEl.textContent = names;
            totalDisplay.textContent = total.toLocaleString('vi-VN') + 'đ';

            inputIds.value = ids;
            inputTotal.value = total;
            btnSubmit.disabled = false;
        } else {
            seatsListEl.textContent = '--';
            totalDisplay.textContent = '0đ';

            inputIds.value = '';
            inputTotal.value = '0';
            btnSubmit.disabled = true;
        }
    }
</script>

<jsp:include page="/views/common/footer.jsp"/>
<jsp:include page="/views/common/script.jsp"/>