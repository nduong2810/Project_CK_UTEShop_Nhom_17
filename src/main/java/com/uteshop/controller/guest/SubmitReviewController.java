package com.uteshop.controller.guest;

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

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

@WebServlet("/guest/submit-review")
@MultipartConfig
public class SubmitReviewController extends HttpServlet {
    private final DanhGiaSanPhamDAO danhGiaSanPhamDAO = new DanhGiaSanPhamDAO();
    private final DonHangDAO donHangDAO = new DonHangDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Integer productId = Integer.parseInt(request.getParameter("productId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String reviewText = request.getParameter("reviewText");
            String orderIdParam = request.getParameter("orderId");

            System.out.println("SubmitReviewController: Received productId=" + productId + ", rating=" + rating + ", orderIdParam=" + orderIdParam);

            if (orderIdParam == null || orderIdParam.isEmpty()) {
                System.err.println("SubmitReviewController: Order ID is missing.");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID is missing for review submission.");
                return;
            }
            Integer orderId = Integer.parseInt(orderIdParam);

            DanhGiaSanPham review = new DanhGiaSanPham();
            review.setDiemDanhGia(rating);
            review.setNoiDung(reviewText);
            review.setNgayDanhGia(new Date());
            review.setTrangThai(true);

            SanPham sanPham = new SanPham();
            sanPham.setMaSP(productId);
            review.setSanPham(sanPham);

            review.setNguoiDung(user);
            
            DonHang donHang = donHangDAO.findById(orderId);
            System.out.println("SubmitReviewController: Found DonHang for orderId " + orderId + ": " + (donHang != null ? donHang.getMaDH() : "null"));

            if (donHang == null) {
                System.err.println("SubmitReviewController: Order not found for ID: " + orderId);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found for the provided ID.");
                return;
            }
            review.setDonHang(donHang);

            // Handle file uploads
            String uploadPath = getServletContext().getRealPath("") + "/assets/uploads/reviews";
            Path uploadDir = Paths.get(uploadPath);
            if (!Files.exists(uploadDir)) {
                Files.createDirectories(uploadDir);
            }

            Part imagePart = request.getPart("reviewImages");
            if (imagePart != null && imagePart.getSize() > 0) {
                String imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                imagePart.write(uploadPath + "/" + imageFileName);
                review.setHinhAnh(imageFileName);
            }

            Part videoPart = request.getPart("reviewVideo");
            if (videoPart != null && videoPart.getSize() > 0) {
                String videoFileName = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();
                videoPart.write(uploadPath + "/" + videoFileName);
                review.setVideo(videoFileName);
            }

            danhGiaSanPhamDAO.addReview(review);
            System.out.println("SubmitReviewController: Review added successfully for productId=" + productId);

            response.sendRedirect(request.getContextPath() + "/guest/product?id=" + productId);

        } catch (NumberFormatException e) {
            System.err.println("SubmitReviewController: Invalid number format: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format for product ID, rating, or order ID.");
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("SubmitReviewController: An unexpected error occurred: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/guest/product?id=" + request.getParameter("productId") + "&error=true");
        }
    }
}
