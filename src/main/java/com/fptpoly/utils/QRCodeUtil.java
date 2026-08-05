package com.fptpoly.utils;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.util.HashMap;
import java.util.Map;

public class QRCodeUtil {

    public static String generateQRCode(String bookingId) {

        try {

            String folder = "qrcode";

            java.io.File dir = new java.io.File(folder);

            if (!dir.exists()) {
                dir.mkdirs();
            }

            String filePath = folder + "/" + bookingId + ".png";

            Map<EncodeHintType, Object> hints = new HashMap<>();

            hints.put(
                    EncodeHintType.CHARACTER_SET,
                    "UTF-8"
            );

            BitMatrix matrix =
                    new MultiFormatWriter().encode(
                            bookingId,
                            BarcodeFormat.QR_CODE,
                            300,
                            300,
                            hints
                    );

            Path path =
                    FileSystems.getDefault()
                            .getPath(filePath);

            MatrixToImageWriter.writeToPath(
                    matrix,
                    "PNG",
                    path
            );

            return filePath;

        } catch (Exception e) {

            e.printStackTrace();

            return null;

        }

    }

}