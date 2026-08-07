package com.fptpoly.controller.employee;

import com.fptpoly.model.Showtime;
import com.fptpoly.service.ShowtimeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "EmployeeShowtimeController",
        urlPatterns = "/employee/showtime")
public class EmployeeShowtimeController extends HttpServlet {

    private ShowtimeService showtimeService = new ShowtimeService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String tenPhim = request.getParameter("tenPhim");

        if (tenPhim != null && !tenPhim.trim().isEmpty()) {

            List<Showtime> listShowtime =
                    showtimeService.searchShowtime(tenPhim);

            request.setAttribute("listShowtime", listShowtime);
        }

        request.getRequestDispatcher("/views/employee/showtime.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);

    }
}
