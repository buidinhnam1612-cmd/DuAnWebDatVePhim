package com.fptpoly.validator;

import com.fptpoly.utils.ValidateUtil;

import java.util.HashMap;
import java.util.Map;

public class UserValidator {

    public static Map<String, String> validateRegister(String fullName, String email, String phone, String password, String confirmPassword) {
        Map<String, String> errors = new HashMap<>();

        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullNameError", "Vui lòng nhập họ và tên!");
        } else if (!ValidateUtil.isValidMinLength(fullName, 2)) {
            errors.put("fullNameError", "Họ và tên phải chứa ít nhất 2 ký tự!");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.put("emailError", "Vui lòng nhập email!");
        } else if (!ValidateUtil.isValidEmail(email)) {
            errors.put("emailError", "Định dạng email không hợp lệ (Ví dụ: example@gmail.com)!");
        }

        if (phone == null || phone.trim().isEmpty()) {
            errors.put("phoneError", "Vui lòng nhập số điện thoại!");
        } else if (!ValidateUtil.isValidPhone(phone)) {
            errors.put("phoneError", "Số điện thoại không hợp lệ (phải đủ 10 số, bắt đầu bằng đầu số 03, 05, 07, 08, 09)!");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("passwordError", "Vui lòng nhập mật khẩu!");
        } else if (!ValidateUtil.isValidMinLength(password, 6)) {
            errors.put("passwordError", "Mật khẩu phải chứa ít nhất 6 ký tự!");
        }

        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPasswordError", "Vui lòng nhập xác nhận mật khẩu!");
        } else if (password != null && !password.equals(confirmPassword)) {
            errors.put("confirmPasswordError", "Mật khẩu xác nhận không trùng khớp!");
        }

        return errors;
    }

    public static Map<String, String> validateLogin(String loginInput, String password) {
        Map<String, String> errors = new HashMap<>();

        if (loginInput == null || loginInput.trim().isEmpty()) {
            errors.put("loginInputError", "Vui lòng nhập tên đăng nhập hoặc email!");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("passwordError", "Vui lòng nhập mật khẩu!");
        }

        return errors;
    }
}
