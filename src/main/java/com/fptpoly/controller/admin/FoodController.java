package com.fptpoly.controller.admin;

import com.fptpoly.model.Food;
import com.fptpoly.service.FoodService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/food")
public class FoodController extends HttpServlet {

    private FoodService foodService;

    @Override
    public void init() {
        foodService = new FoodService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        List<Food> foodList;

        if ("search".equals(action)) {
            String keyword = request.getParameter("keyword");
            foodList = foodService.searchFood(keyword);
        } else {
            foodList = foodService.getAllFood();
        }

        request.setAttribute("foodList", foodList);
        request.getRequestDispatcher("/views/admin/food.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            String maDoAn = request.getParameter("maDoAn");
            String tenDoAn = request.getParameter("tenDoAn");
            double gia = Double.parseDouble(request.getParameter("gia"));
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));
            String loai = request.getParameter("loai");

            Food food = new Food(maDoAn, tenDoAn, gia, soLuong, "Còn hàng", "", loai);
            boolean result = foodService.createFood(food);

            if (result) {
                request.getSession().setAttribute("success", "Thêm đồ ăn/đồ uống thành công!");
            } else {
                request.getSession().setAttribute("error", "Thêm đồ ăn/đồ uống thất bại!");
            }
        } else if ("updateStatus".equals(action)) {
            String maDoAn = request.getParameter("maDoAn");
            String trangThai = request.getParameter("trangThai");
            foodService.updateStatus(maDoAn, trangThai);
            request.getSession().setAttribute("success", "Cập nhật trạng thái thành công!");
        } else if ("updateQuantity".equals(action)) {
            String maDoAn = request.getParameter("maDoAn");
            int soLuong = Integer.parseInt(request.getParameter("soLuong"));
            foodService.updateQuantity(maDoAn, soLuong);
            request.getSession().setAttribute("success", "Cập nhật số lượng thành công!");
        } else if ("updatePrice".equals(action)) {
            String maDoAn = request.getParameter("maDoAn");
            double gia = Double.parseDouble(request.getParameter("gia"));
            foodService.updatePrice(maDoAn, gia);
            request.getSession().setAttribute("success", "Cập nhật giá bán thành công!");
        }

        response.sendRedirect(request.getContextPath() + "/admin/food");
    }
}
