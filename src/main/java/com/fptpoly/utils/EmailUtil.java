package com.fptpoly.utils;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.io.InputStream;
import java.util.Properties;

/**
 * Tiện ích gửi email xác nhận đặt vé
 *
 * CẤU HÌNH:
 * Thêm các dòng sau vào file database.properties:
 *
 *   mail.smtp.host=smtp.gmail.com
 *   mail.smtp.port=587
 *   mail.from=your-email@gmail.com
 *   mail.password=your-app-password
 *
 * Lưu ý: Với Gmail, bạn cần tạo "App Password" tại:
 * https://myaccount.google.com/apppasswords
 */
public class EmailUtil {

    private static String smtpHost;
    private static String smtpPort;
    private static String emailFrom;
    private static String emailPassword;
    private static boolean configured = false;

    static {
        try {

            Properties props = new Properties();

            try (InputStream input =
                         EmailUtil.class
                                 .getClassLoader()
                                 .getResourceAsStream("database.properties")) {

                if (input != null) {

                    props.load(input);

                    smtpHost = props.getProperty(
                            "mail.smtp.host", "smtp.gmail.com");

                    smtpPort = props.getProperty(
                            "mail.smtp.port", "587");

                    emailFrom = props.getProperty(
                            "mail.from", "");

                    emailPassword = props.getProperty(
                            "mail.password", "");

                    configured = !emailFrom.isEmpty()
                            && !emailPassword.isEmpty();

                    if (configured) {
                        System.out.println(
                                "✅ Email đã được cấu hình!");
                    } else {
                        System.out.println(
                                "⚠️ Email chưa được cấu hình. "
                                + "Thêm mail.from và mail.password "
                                + "vào database.properties");
                    }
                }

            }

        } catch (Exception e) {
            System.out.println("⚠️ Lỗi khi đọc cấu hình email");
            e.printStackTrace();
        }
    }

    /**
     * Gửi email xác nhận đặt vé thành công
     */
    public static boolean sendBookingConfirmation(
            String toEmail,
            String hoTen,
            String maDatVe,
            String tenPhim,
            String danhSachGhe,
            String ngayChieu,
            String gioBatDau,
            double tongTien) {

        if (!configured) {
            System.out.println(
                    "⚠️ Bỏ qua gửi email - chưa cấu hình SMTP");
            return false;
        }

        try {

            // Cấu hình SMTP
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", smtpHost);
            props.put("mail.smtp.port", smtpPort);

            // Tạo session
            Session session = Session.getInstance(props,
                    new Authenticator() {
                        @Override
                        protected PasswordAuthentication
                        getPasswordAuthentication() {

                            return new PasswordAuthentication(
                                    emailFrom, emailPassword);

                        }
                    });

            // Tạo message
            Message message = new MimeMessage(session);

            message.setFrom(
                    new InternetAddress(emailFrom, "FPT CINEMA"));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject(
                    "🎬 Xác nhận đặt vé - " + maDatVe);

            // Nội dung HTML
            String htmlContent = buildEmailHtml(
                    hoTen, maDatVe, tenPhim,
                    danhSachGhe, ngayChieu,
                    gioBatDau, tongTien);

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            // Gửi email
            Transport.send(message);

            System.out.println(
                    "✅ Đã gửi email xác nhận tới: " + toEmail);

            return true;

        } catch (Exception e) {
            System.out.println(
                    "❌ Lỗi gửi email tới: " + toEmail);
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Xây dựng nội dung HTML cho email
     */
    private static String buildEmailHtml(
            String hoTen,
            String maDatVe,
            String tenPhim,
            String danhSachGhe,
            String ngayChieu,
            String gioBatDau,
            double tongTien) {

        String formattedPrice = String.format("%,.0f", tongTien);

        return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
            </head>
            <body style="margin:0; padding:0; background:#0f172a; font-family:Arial,sans-serif;">

                <div style="max-width:600px; margin:0 auto; padding:30px;">

                    <!-- Header -->
                    <div style="background:linear-gradient(135deg,#1e293b,#334155);
                                padding:30px; border-radius:15px 15px 0 0;
                                text-align:center;">

                        <h1 style="color:#ffc107; margin:0; font-size:28px;">
                            🎬 FPT CINEMA
                        </h1>

                        <p style="color:#cbd5e1; margin:10px 0 0; font-size:14px;">
                            Xác nhận đặt vé thành công
                        </p>

                    </div>

                    <!-- Body -->
                    <div style="background:#1e293b; padding:30px;">

                        <p style="color:#fff; font-size:16px; margin:0 0 20px;">
                            Xin chào <strong style="color:#ffc107;">%s</strong>,
                        </p>

                        <p style="color:#cbd5e1; font-size:14px; margin:0 0 25px;">
                            Vé của bạn đã được giữ thành công! Dưới đây là thông tin chi tiết:
                        </p>

                        <!-- Ticket Info -->
                        <div style="background:#0f172a; border:1px solid #334155;
                                    border-radius:12px; padding:25px; margin:0 0 25px;">

                            <table style="width:100%%; border-collapse:collapse;">

                                <tr>
                                    <td style="color:#94a3b8; padding:8px 0; font-size:13px;">
                                        Mã đặt vé
                                    </td>
                                    <td style="color:#ffc107; padding:8px 0; font-size:16px;
                                               font-weight:bold; text-align:right;">
                                        %s
                                    </td>
                                </tr>

                                <tr>
                                    <td style="color:#94a3b8; padding:8px 0;
                                               border-top:1px solid #334155; font-size:13px;">
                                        Phim
                                    </td>
                                    <td style="color:#fff; padding:8px 0;
                                               border-top:1px solid #334155;
                                               font-weight:bold; text-align:right;">
                                        %s
                                    </td>
                                </tr>

                                <tr>
                                    <td style="color:#94a3b8; padding:8px 0;
                                               border-top:1px solid #334155; font-size:13px;">
                                        Ghế
                                    </td>
                                    <td style="color:#fff; padding:8px 0;
                                               border-top:1px solid #334155;
                                               text-align:right;">
                                        %s
                                    </td>
                                </tr>

                                <tr>
                                    <td style="color:#94a3b8; padding:8px 0;
                                               border-top:1px solid #334155; font-size:13px;">
                                        Ngày chiếu
                                    </td>
                                    <td style="color:#fff; padding:8px 0;
                                               border-top:1px solid #334155;
                                               text-align:right;">
                                        %s
                                    </td>
                                </tr>

                                <tr>
                                    <td style="color:#94a3b8; padding:8px 0;
                                               border-top:1px solid #334155; font-size:13px;">
                                        Giờ chiếu
                                    </td>
                                    <td style="color:#fff; padding:8px 0;
                                               border-top:1px solid #334155;
                                               text-align:right;">
                                        %s
                                    </td>
                                </tr>

                                <tr>
                                    <td style="color:#94a3b8; padding:12px 0;
                                               border-top:2px solid #ffc107; font-size:14px;
                                               font-weight:bold;">
                                        TỔNG TIỀN
                                    </td>
                                    <td style="color:#ffc107; padding:12px 0;
                                               border-top:2px solid #ffc107;
                                               font-size:20px; font-weight:bold;
                                               text-align:right;">
                                        %sđ
                                    </td>
                                </tr>

                            </table>

                        </div>

                        <!-- Warning -->
                        <div style="background:rgba(220,53,69,0.1);
                                    border:1px solid rgba(220,53,69,0.3);
                                    border-radius:10px; padding:20px;">

                            <p style="color:#dc3545; font-size:14px;
                                      font-weight:bold; margin:0 0 8px;">
                                ⚠️ Lưu ý quan trọng
                            </p>

                            <p style="color:#cbd5e1; font-size:13px; margin:0;">
                                Vui lòng đến quầy vé trước giờ chiếu
                                <strong style="color:#fff;">60 phút</strong>
                                để thanh toán bằng tiền mặt hoặc quẹt thẻ
                                và nhận vé cứng. Vé chưa thanh toán sẽ bị hủy
                                tự động.
                            </p>

                        </div>

                    </div>

                    <!-- Footer -->
                    <div style="background:#0f172a; padding:20px;
                                border-radius:0 0 15px 15px;
                                text-align:center;
                                border-top:1px solid #334155;">

                        <p style="color:#64748b; font-size:12px; margin:0;">
                            © 2026 FPT CINEMA. Cảm ơn bạn đã sử dụng dịch vụ!
                        </p>

                    </div>

                </div>

            </body>
            </html>
            """.formatted(
                hoTen, maDatVe, tenPhim,
                danhSachGhe, ngayChieu,
                gioBatDau, formattedPrice);
    }
}
