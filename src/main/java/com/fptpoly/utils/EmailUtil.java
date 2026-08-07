package com.fptpoly.utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

import java.io.File;
import java.util.Properties;

public class EmailUtil {

    private static final String EMAIL = "your_email@gmail.com";
    private static final String PASSWORD = "your_app_password";

    public static boolean sendTicket(String to,
                                     String maDatVe,
                                     String qrImage) {

        try {

            Properties props = new Properties();

            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props,
                    new Authenticator() {
                        @Override
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(EMAIL, PASSWORD);
                        }
                    });

            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(EMAIL));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(to)
            );

            message.setSubject("Vé xem phim - " + maDatVe);

            MimeBodyPart textPart = new MimeBodyPart();

            textPart.setText("""
                    Cảm ơn bạn đã đặt vé.

                    Mã đặt vé: %s

                    QR Code được đính kèm trong email.
                    """.formatted(maDatVe));

            MimeBodyPart imagePart = new MimeBodyPart();

            imagePart.attachFile(new File(qrImage));

            Multipart multipart = new MimeMultipart();

            multipart.addBodyPart(textPart);
            multipart.addBodyPart(imagePart);

            message.setContent(multipart);

            Transport.send(message);

            return true;

        } catch (Exception e) {

            e.printStackTrace();

            return false;

        }

    }

}