package com.fptpoly.controller.admin;

import com.fptpoly.model.Theater;
import com.fptpoly.service.TheaterService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TheaterController", urlPatterns = {"/theater"})
public class TheaterController extends HttpServlet {

    TheaterService ttservice = new TheaterService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        // 1. XỬ LÝ CHỨC NĂNG ĐỔ DỮ LIỆU LÊN FORM ĐỂ SỬA
        if (action != null && action.equals("edit")) {
            String id = req.getParameter("id");
            if (id != null) {
                Theater theaterNeedEdit = ttservice.getByID(id.trim());
                req.setAttribute("theaterEdit", theaterNeedEdit);
            }
        }

        // 2. LUÔN LOAD DANH SÁCH LÊN BẢNG HÌNH
        List<Theater> listtheater = ttservice.getall();
        req.setAttribute("listSP", listtheater);
        req.getRequestDispatcher("/views/admin/theater.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        try {
            // Lấy dữ liệu từ Form gửi lên
            String maRap = req.getParameter("maRap");
            String tenRap = req.getParameter("tenRap");
            String diaChi = req.getParameter("diaChi");
            String hotLine = req.getParameter("hotLine");
            String hinhAnh = req.getParameter("hinhAnh");

            Theater theaterData = new Theater(maRap, tenRap, diaChi, hotLine, hinhAnh);

            // XỬ LÝ CẬP NHẬT DỮ LIỆU (Chỉ gọi hàm sua)
            boolean isSuccess = ttservice.sua(theaterData);

            if (isSuccess) {
                resp.sendRedirect(req.getContextPath() + "/theater");
            } else {
                req.setAttribute("errorMessage", "Cập nhật dữ liệu thất bại! Vui lòng kiểm tra lại.");
                doGet(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống.");
        }

    }
}
