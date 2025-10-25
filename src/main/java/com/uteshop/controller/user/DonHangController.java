package com.uteshop.controller.user;

import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.transaction.Transactional;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/orders")
public class DonHangController extends HttpServlet {
	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Trỏ đúng đến file JSP thật sự của bạn
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/user/orders.jsp");
        dispatcher.forward(request, response);
    }
}
