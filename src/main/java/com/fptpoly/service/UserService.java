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

    /**
     * Đăng ký tài khoản khách hàng mới
     */
    public boolean register(User user) {
        if (user == null || user.getEmail() == null || user.getEmail().isBlank()) {
            return false;
        }

        // Kiểm tra trùng email
        if (userRepository.findByEmail(user.getEmail()) != null) {
            return false;
        }

        // Thiết lập giá trị mặc định
        user.setMaKhachHang(userRepository.generateUserId());

        // SỬA LỖI CÚ PHÁP: Bổ sung index [0] sau khi split để lấy chính xác phần tên trước ký tự @ làm tên đăng nhập
        user.setTenDangNhap(user.getEmail().split("@")[0]);
        user.setDiemTichLuy(0);

        // === ĐÃ ĐỒNG BỘ: Thay "Hoạt động" thành "Chờ duyệt" để tự động đưa vào danh sách phê duyệt của Admin ===
        user.setTrangThai("Chờ duyệt");
        user.setMaVaiTro("VT03"); // Vai trò khách hàng

        return userRepository.add(user);
    }

    /**
     * Xác thực thông tin đăng nhập của khách hàng
     */
    public User login(String loginInput, String password) {
        if (loginInput == null || loginInput.isBlank() || password == null || password.isBlank()) {
            return null;
        }
        // === ĐÃ ĐỒNG BỘ: Gọi findByUsernameAndPassword để đăng nhập được bằng cả Tên đăng nhập và Email ===
        return userRepository.findByUsernameAndPassword(loginInput.trim(), password);
    }

    /**
     * Tìm khách hàng theo email
     */
    public User getUserByEmail(String email) {
        if (email == null || email.isBlank()) {
            return null;
        }
        return userRepository.findByEmail(email.trim());
    }
}
