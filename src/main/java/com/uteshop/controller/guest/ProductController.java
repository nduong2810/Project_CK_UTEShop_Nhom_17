package com.uteshop.controller.guest;

import com.uteshop.dao.DanhGiaSanPhamDAO;
import com.uteshop.dao.DonHangDAO;
import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.DanhGiaSanPham;
import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@WebServlet("/guest/product")
public class ProductController extends HttpServlet {
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhGiaSanPhamDAO danhGiaSanPhamDAO = new DanhGiaSanPhamDAO();
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private final DonHangDAO donHangDAO = new DonHangDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = "/WEB-INF/views/guest/product-detail.jsp";
        
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing.");
                return;
            }

            Integer productId = Integer.parseInt(idParam);
            SanPham product = sanPhamDAO.findById(productId);

            if (product != null) {
                request.setAttribute("product", product);
                
                List<DanhGiaSanPham> reviews = danhGiaSanPhamDAO.getReviewsByProduct(productId, 0, 10);
                request.setAttribute("reviews", reviews);

                if (product.getCuaHang() != null) {
                    Integer storeId = product.getCuaHang().getMaCH();
                    List<SanPham> productsOfStore = sanPhamDAO.findByStore(storeId, 6);
                    productsOfStore.removeIf(p -> p.getMaSP().equals(productId));
                    request.setAttribute("productsOfStore", productsOfStore);
                }

                NguoiDung loggedInUser = (NguoiDung) request.getSession().getAttribute("user");
                if (loggedInUser != null) {
                    DonHang userOrderForProduct = donHangDAO.findCompletedOrderByUserAndProduct(loggedInUser.getMaND(), productId);
                    if (userOrderForProduct != null) {
                        request.setAttribute("userOrderForProduct", userOrderForProduct);
                    }
                }

            } else {
                request.setAttribute("errorMessage", "Sản phẩm không tồn tại.");
                pathInfo = "/WEB-INF/views/guest/home.jsp";
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID format.");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi không xác định khi tải sản phẩm.");
            pathInfo = "/WEB-INF/views/guest/home.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(pathInfo);
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("addReview".equals(action)) {
            handleAddReview(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action for POST request.");
        }
    }

    private void handleAddReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdParam = request.getParameter("productId");
        String ratingParam = request.getParameter("rating");
        String comment = request.getParameter("comment");
        String orderIdParam = request.getParameter("orderId");
        
        NguoiDung user = (NguoiDung) request.getSession().getAttribute("user");

        if (productIdParam == null || productIdParam.isEmpty() ||
            ratingParam == null || ratingParam.isEmpty() ||
            comment == null || comment.isEmpty() ||
            user == null ||
            orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing review parameters, order ID, or user not logged in.");
            return;
        }

        try {
            Integer productId = Integer.parseInt(productIdParam);
            Integer rating = Integer.parseInt(ratingParam);
            Integer orderId = Integer.parseInt(orderIdParam);

            SanPham product = sanPhamDAO.findById(productId);
            DonHang order = donHangDAO.findById(orderId);

            if (product != null && user != null && order != null) {
                DanhGiaSanPham review = new DanhGiaSanPham();
                review.setDiemDanhGia(rating);
                review.setNoiDung(comment);
                review.setNgayDanhGia(new Date());
                review.setTrangThai(true);
                review.setSanPham(product);
                review.setNguoiDung(user);
                review.setDonHang(order);

                boolean success = danhGiaSanPhamDAO.addReview(review);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/guest/product?id=" + productId);
                } else {
                    request.setAttribute("errorMessage", "Failed to add review.");
                    doGet(request, response);
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product, User, or Order not found.");
            }

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format for product ID, rating, or order ID.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred while adding the review.");
            response.sendRedirect(request.getContextPath() + "/guest/product?id=" + request.getParameter("productId") + "&error=true");
        }
    }
}
