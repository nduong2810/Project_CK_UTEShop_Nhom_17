package com.uteshop.controller.user;

import com.uteshop.dao.DanhGiaSanPhamDAO;
import com.uteshop.dao.DonHangDAO;
import com.uteshop.entity.DanhGiaSanPham;
import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

@WebServlet(urlPatterns = {"/user/review", "/user/submit-review", "/user/check-review", "/user/delete-review", "/user/update-review"})
@MultipartConfig
public class ReviewController extends HttpServlet {
    private final DanhGiaSanPhamDAO danhGiaSanPhamDAO = new DanhGiaSanPhamDAO();
    private final DonHangDAO donHangDAO = new DonHangDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String path = request.getServletPath();
        
        if ("/user/check-review".equals(path)) {
            checkReview(request, response, user);
        } else if ("/user/review".equals(path)) {
            // Redirect to order detail page where user can review products
            String orderId = request.getParameter("orderId");
            if (orderId != null && !orderId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/user/order-detail?id=" + orderId + "&fromReview=true");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/orders");
            }
        } else if ("/user/delete-review".equals(path)) {
            deleteReview(request, response, user);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        String path = request.getServletPath();
        
        if ("/user/update-review".equals(path)) {
            updateReview(request, response, user);
        } else {
            submitReview(request, response, user);
        }
    }

    private void checkReview(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        try {
            Integer productId = Integer.parseInt(request.getParameter("productId"));
            Integer orderId = Integer.parseInt(request.getParameter("orderId"));

            boolean hasReviewed = danhGiaSanPhamDAO.hasUserReviewedProduct(user.getMaND(), productId, orderId);

            response.setContentType("application/json");
            response.getWriter().write("{\"hasReviewed\": " + hasReviewed + "}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    private void submitReview(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        try {
            Integer productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String reviewText = request.getParameter("reviewText");
            String orderIdParam = request.getParameter("orderId");

            if (orderIdParam == null || orderIdParam.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/user/orders?error=missing_order");
                return;
            }
            Integer orderId = Integer.parseInt(orderIdParam);

            // Quick check: Has user already reviewed this product in this order?
            if (danhGiaSanPhamDAO.hasUserReviewedProduct(user.getMaND(), productId, orderId)) {
                response.sendRedirect(request.getContextPath() + "/user/order-detail?id=" + orderId + "&error=already_reviewed");
                return;
            }

            // Create review object
            DanhGiaSanPham review = new DanhGiaSanPham();
            review.setDiemDanhGia(rating);
            review.setNoiDung(reviewText);
            review.setNgayDanhGia(new Date());
            review.setTrangThai(true);

            // Set relationships using IDs only (no need to load full entities)
            SanPham sanPham = new SanPham();
            sanPham.setMaSP(productId);
            review.setSanPham(sanPham);

            review.setNguoiDung(user);
            
            DonHang donHang = new DonHang();
            donHang.setMaDH(orderId);
            review.setDonHang(donHang);

            // Handle file upload (if any)
            Part imagePart = request.getPart("reviewImages");
            if (imagePart != null && imagePart.getSize() > 0) {
                // Get the real path to webapp directory
                String uploadPath = getServletContext().getRealPath("/assets/uploads/reviews");
                Path uploadDir = Paths.get(uploadPath);
                if (!Files.exists(uploadDir)) {
                    Files.createDirectories(uploadDir);
                }
                String imageFileName = System.currentTimeMillis() + "_" + Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String fullPath = uploadPath + File.separator + imageFileName;
                imagePart.write(fullPath);
                review.setHinhAnh(imageFileName);
                System.out.println("✅ Image saved to: " + fullPath);
            }

            // Save review (validation happens in DAO layer)
            boolean success = danhGiaSanPhamDAO.addReview(review);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/user/order-detail?id=" + orderId + "&success=reviewed");
            } else {
                response.sendRedirect(request.getContextPath() + "/user/order-detail?id=" + orderId + "&error=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/user/orders?error=invalid_data");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/user/orders?error=server_error");
        }
    }

    private void deleteReview(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        try {
            Integer reviewId = Integer.parseInt(request.getParameter("reviewId"));
            Integer productId = Integer.parseInt(request.getParameter("productId"));

            boolean success = danhGiaSanPhamDAO.deleteReviewById(reviewId, user.getMaND());

            if (success) {
                response.sendRedirect(request.getContextPath() + "/guest/product?id=" + productId + "&success=deleted");
            } else {
                response.sendRedirect(request.getContextPath() + "/guest/product?id=" + productId + "&error=delete_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/guest/home?error=server_error");
        }
    }

    private void updateReview(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        try {
            Integer reviewId = Integer.parseInt(request.getParameter("reviewId"));
            Integer productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String reviewText = request.getParameter("reviewText");

            String newImageFileName = null;

            // Handle file upload (if any)
            Part imagePart = request.getPart("reviewImages");
            if (imagePart != null && imagePart.getSize() > 0) {
                String uploadPath = getServletContext().getRealPath("/assets/uploads/reviews");
                Path uploadDir = Paths.get(uploadPath);
                if (!Files.exists(uploadDir)) {
                    Files.createDirectories(uploadDir);
                }
                newImageFileName = System.currentTimeMillis() + "_" + Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String fullPath = uploadPath + File.separator + newImageFileName;
                imagePart.write(fullPath);
                System.out.println("✅ Image updated and saved to: " + fullPath);
            }

            boolean success = danhGiaSanPhamDAO.updateUserReview(reviewId, user.getMaND(), rating, reviewText, newImageFileName);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/guest/product?id=" + productId + "&success=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/guest/product?id=" + productId + "&error=update_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/guest/home?error=server_error");
        }
    }
}
