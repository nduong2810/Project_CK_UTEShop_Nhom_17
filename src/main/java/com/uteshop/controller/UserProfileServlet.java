package com.uteshop.controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/user/profile")
public class UserProfileServlet extends HttpServlet {
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Trỏ đúng đến file JSP thật sự của bạn
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp");
        dispatcher.forward(request, response);
    }

}
