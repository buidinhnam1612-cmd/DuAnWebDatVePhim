package com.fptpoly.utils;

import java.util.regex.Pattern;

public class ValidateUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$");

    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^0[3|5|7|8|9][0-9]{8}$");

    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        return PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    public static boolean isValidMinLength(String input, int minLength) {
        if (input == null) {
            return false;
        }
        return input.trim().length() >= minLength;
    }
}
