package com.uteshop.controller.guest;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.SanPham;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/guest/product")
public class ProductController extends HttpServlet {
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    
    // Mapping từ product ID đến trang chi tiết cụ thể
    private static final Map<Integer, String> PRODUCT_DETAIL_PAGES = new HashMap<>();
    
    static {
        // Các sản phẩm có sẵn
        PRODUCT_DETAIL_PAGES.put(1, "iphone15-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(2, "samsung-s24-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(3, "oppo-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(4, "xiaomi-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(5, "macbook-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(6, "dell-xps13-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(7, "gaming-pc-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(8, "ipad-pro-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(9, "apple-watch-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(10, "airpods-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(11, "sony-headphones-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(12, "sac-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(13, "aothun-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(14, "jeans-nam-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(15, "polo-nam-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(16, "sneaker-nam-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(17, "dam-congso-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(18, "blazer-nu-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(19, "tui-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(20, "noi-com-dien-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(21, "xe-dap-giant-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(22, "xe-day-be-detail.jsp");
        
        // Các sản phẩm mới tạo
        PRODUCT_DETAIL_PAGES.put(23, "ban-lam-viec-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(24, "ghe-gaming-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(25, "may-pha-cafe-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(26, "tu-lanh-samsung-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(27, "may-giat-lg-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(28, "dieu-hoa-panasonic-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(29, "tv-sony-oled-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(30, "lo-vi-song-sharp-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(31, "may-hut-bui-dyson-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(32, "bep-tu-nhat-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(33, "may-loc-nuoc-ro-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(34, "robot-hut-bui-xiaomi-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(35, "may-say-toc-dyson-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(36, "may-ep-trai-cay-detail.jsp");
        PRODUCT_DETAIL_PAGES.put(37, "may-xay-sinh-to-detail.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = "/WEB-INF/views/guest/product-detail.jsp"; // Fallback mặc định
        
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
                
                // Kiểm tra xem có trang chi tiết cụ thể cho sản phẩm này không
                String specificPage = PRODUCT_DETAIL_PAGES.get(productId);
                if (specificPage != null) {
                    pathInfo = "/WEB-INF/views/guest/" + specificPage;
                    System.out.println("Routing product ID " + productId + " to: " + specificPage);
                } else {
                    // Sử dụng trang chung nếu không có trang cụ thể
                    System.out.println("No specific page found for product ID " + productId + ", using default page.");
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
}