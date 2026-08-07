package com.fptpoly.service;

import com.fptpoly.model.User;
import com.fptpoly.repository.UserRepository;

import java.util.List;

public class UserService {

    private final UserRepository userRepository;

    public UserService() {
        userRepository = new UserRepository();
    }

    /**
     * Lấy toàn bộ danh sách khách hàng
     */
    public List<User> getAllUsers() {
        return userRepository.getAll();
    }

    /**
     * Lấy thông tin khách hàng theo mã
     */
    public User getUserById(String maKhachHang) {

        if (maKhachHang == null || maKhachHang.trim().isEmpty()) {
            return null;
        }

        return userRepository.getById(maKhachHang);
    }

    /**
     * Tìm kiếm khách hàng
     */
    public List<User> searchUsers(String keyword) {

        if (keyword == null) {
            keyword = "";
        }

        keyword = keyword.trim();

        return userRepository.search(keyword);
    }

    /**
     * Cập nhật trạng thái tài khoản
     */
    public boolean updateStatus(String maKhachHang, String trangThai) {

        if (maKhachHang == null || maKhachHang.trim().isEmpty()) {
            return false;
        }

        if (trangThai == null || trangThai.trim().isEmpty()) {
            return false;
        }

        return userRepository.updateStatus(maKhachHang, trangThai);
    }

}