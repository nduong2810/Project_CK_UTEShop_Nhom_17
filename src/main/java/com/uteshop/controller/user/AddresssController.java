package com.uteshop.controller.user;

import com.uteshop.entity.NguoiDung;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/address-form")
public class AddresssController extends HttpServlet {

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Trỏ đúng đến file JSP thật sự của bạn
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/address-form.jsp");
        dispatcher.forward(request, response);
    }
}