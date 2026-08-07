package com.fptpoly.controller.client;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;


@WebServlet("/movies")
public class MovieController extends HttpServlet {


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {


        request.getRequestDispatcher(
                "/views/client/movie.jsp"
        ).forward(request, response);


    }


}