package com.uteshop.controller.guest;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.model.SanPham;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/guest/home")
public class HomeController extends HttpServlet {
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<SanPham> top10 = sanPhamDAO.getTop10SanPhamBanChay();
        request.setAttribute("top10", top10);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/guest/home.jsp");
        dispatcher.forward(request, response);
    }
}
