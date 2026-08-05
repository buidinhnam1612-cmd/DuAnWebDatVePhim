package com.fptpoly.controller.employee;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/employee/dashboard")
public class EmployeeDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {


        request.getRequestDispatcher(
                "/views/employee/dashboard.jsp"
        ).forward(request, response);

    }
}