package com.uteshop.controller.user;

import com.uteshop.dao.GioHangDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.ChiTietGioHang;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

@WebServlet(urlPatterns = {"/user/cart/*"})
public class CartServlet extends HttpServlet {

    private final GioHangDAO gioHangDAO = new GioHangDAO();
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/guest/login");
            return;
        }

        String path = req.getPathInfo();
        // normalize
        if (path == null || "/".equals(path) || "/view".equals(path)) {
            List<ChiTietGioHang> items = Collections.emptyList();
            try {
                items = gioHangDAO.getCartItems(userId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            req.setAttribute("cartItems", items);

            // compute total
            BigDecimal tongTien = BigDecimal.ZERO;
            for (ChiTietGioHang ct : items) {
                if (ct.getDonGia() != null) {
                    tongTien = tongTien.add(ct.getDonGia().multiply(BigDecimal.valueOf(ct.getSoLuong())));
                }
            }
            req.setAttribute("tongTien", tongTien);

            RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/views/user/cart.jsp");
            rd.forward(req, resp);
            return;
        }

        if ("/remove".equals(path)) {
            String pid = req.getParameter("productId");
            if (pid != null) {
                try {
                    int productId = Integer.parseInt(pid);
                    gioHangDAO.removeFromCart(userId, productId);
                } catch (NumberFormatException e) {
                    // ignore invalid id
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
            resp.sendRedirect(req.getContextPath() + "/user/cart");
            return;
        }

        // unknown GET path -> redirect to cart view
        resp.sendRedirect(req.getContextPath() + "/user/cart");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
        if (userId == null) {
            resp.sendRedirect(req.getContextPath() + "/guest/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "add": {
                String pid = req.getParameter("productId");
                String qtyS = req.getParameter("quantity");
                try {
                    int productId = Integer.parseInt(pid);
                    int qty = (qtyS == null || qtyS.isEmpty()) ? 1 : Integer.parseInt(qtyS);
                    if (qty <= 0) qty = 1;
                    gioHangDAO.addToCart(userId, productId, qty);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                // redirect back to product or cart
                resp.sendRedirect(req.getContextPath() + "/user/cart");
                return;
            }
            case "update": {
                String pid = req.getParameter("productId");
                String qtyS = req.getParameter("quantity");
                try {
                    int productId = Integer.parseInt(pid);
                    int qty = Integer.parseInt(qtyS);
                    gioHangDAO.updateQuantity(userId, productId, qty);
                } catch (NumberFormatException e) {
                    // ignore malformed input
                } catch (Exception e) {
                    e.printStackTrace();
                }
                resp.sendRedirect(req.getContextPath() + "/user/cart");
                return;
            }
            case "clear": {
                try {
                    gioHangDAO.clearCart(userId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                resp.sendRedirect(req.getContextPath() + "/user/cart");
                return;
            }
            default: {
                // fallback
                resp.sendRedirect(req.getContextPath() + "/user/cart");
                return;
            }
        }
    }
}