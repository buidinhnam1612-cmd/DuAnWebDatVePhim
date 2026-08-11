package com.fptpoly.service;

import com.fptpoly.model.Food;
import com.fptpoly.repository.CustomerFoodRepository;

import java.sql.Connection;
import java.util.List;

public class CustomerFoodService {

    private final CustomerFoodRepository customerFoodRepository = new CustomerFoodRepository();

    public List<Food> getActiveFoods() {
        return customerFoodRepository.getAllActive();
    }

    public boolean insertOrderDetail(Connection con, String maDatVe, String maDoAnUong, int soLuong, double giaBan) throws Exception {
        return customerFoodRepository.insertOrderDetail(con, maDatVe, maDoAnUong, soLuong, giaBan);
    }
}
