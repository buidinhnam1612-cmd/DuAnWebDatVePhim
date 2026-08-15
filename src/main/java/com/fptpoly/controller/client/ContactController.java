package com.fptpoly.controller.client;

import com.fptpoly.model.Feedback;
import com.fptpoly.model.User;
import com.fptpoly.repository.FeedbackRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "ContactController", urlPatterns = "/contact")
public class ContactController extends HttpServlet {

    private FeedbackRepository feedbackRepository = new FeedbackRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        request.getRequestDispatcher("/views/client/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 1. Lấy dữ liệu từ Form
        String hoTen = request.getParameter("hoTen");
        String senderEmail = request.getParameter("email");
        String noiDung = request.getParameter("noiDung");

        // 2. Tạo mã Feedback ngẫu nhiên
        String maFeedback = "FB" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        // 3. Lấy thông tin User đăng nhập (nếu có)
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account"); // Hoặc "user" tùy theo key bạn lưu lúc Login

        // Giả sử trong class User của bạn phương thức lấy ID là getMaKhachHang() hoặc getUserId()/getMaUser()
        String maKhachHang = null;
        if (user != null) {
            maKhachHang = user.getMaKhachHang(); // Nếu báo đỏ dòng này, bạn đổi thành user.getUserId() hoặc getter ID tương ứng
        }

        // 4. Khởi tạo đối tượng Feedback
        Feedback feedback = new Feedback();
        feedback.setMaFeedback(maFeedback);
        feedback.setHoTen(hoTen);
        feedback.setEmail(senderEmail);
        feedback.setNoiDung(noiDung);
        feedback.setMaKhachHang(maKhachHang);

        // 5. Lưu vào Database
        boolean isSaved = feedbackRepository.insert(feedback);

        if (isSaved) {
            request.setAttribute("messageSuccess", "Gửi phản hồi thành công! Cảm ơn bạn đã đóng góp.");
        } else {
            request.setAttribute("messageError", "Gửi phản hồi thất bại. Vui lòng thử lại sau!");
        }

        request.getRequestDispatcher("/views/client/contact.jsp").forward(request, response);
    }
}