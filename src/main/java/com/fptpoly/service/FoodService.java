package com.fptpoly.service;

import com.fptpoly.model.Food;
import com.fptpoly.repository.FoodRepository;

import java.util.List;

public class FoodService {

    private final FoodRepository foodRepository;

    public FoodService() {
        this.foodRepository = new FoodRepository();
    }

    public List<Food> getAllFood() {
        return foodRepository.getAll();
    }

    public List<Food> searchFood(String keyword) {
        if (keyword == null) keyword = "";
        return foodRepository.search(keyword.trim());
    }

    public boolean updateStatus(String maDoAn, String trangThai) {
        return foodRepository.updateStatus(maDoAn, trangThai);
    }

    public boolean updateQuantity(String maDoAn, int soLuong) {
        return foodRepository.updateQuantity(maDoAn, soLuong);
    }

    public boolean updatePrice(String maDoAn, double gia) {
        return foodRepository.updatePrice(maDoAn, gia);
    }

    public boolean createFood(Food food) {
        return foodRepository.insert(food);
    }
}
