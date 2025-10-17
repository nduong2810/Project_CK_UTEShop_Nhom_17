package com.uteshop.controller.guest;

import com.uteshop.dao.DanhMucDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.SanPham;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet({"/guest/home", "/guest/home/loadmore"})
public class HomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhMucDAO danhMucDAO = new DanhMucDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("============================================");
        System.out.println("HomeController.doGet() CALLED!");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Context Path: " + request.getContextPath());
        System.out.println("============================================");
        
        // Ensure request/response use UTF-8 to avoid mojibake
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        System.out.println("Processing path: " + path);
        
        // Xử lý load more products
        if (path.equals("/guest/home/loadmore")) {
            System.out.println("Handling loadmore request");
            handleLoadMore(request, response);
            return;
        }
        
        // Xử lý trang home bình thường
        System.out.println("Handling home page request");
        handleHomePage(request, response);
    }
    
    private void handleHomePage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println(">>> handleHomePage() started");
        
        try {
            // Kiểm tra xem có yêu cầu hiển thị tất cả sản phẩm không
            String showAllParam = request.getParameter("showAll");
            boolean showAll = "true".equals(showAllParam);
            
            System.out.println("ShowAll parameter: " + showAll);
            
            List<SanPham> products;
            
            if (showAll) {
                // Hiển thị TẤT CẢ sản phẩm khi click "Xem thêm"
                products = sanPhamDAO.getAllProductsSorted();
                System.out.println("HomeController: Showing ALL products - " + products.size() + " products");
            } else {
                // Lần đầu vào trang: chỉ hiển thị top 10 bán chạy nhất
                products = sanPhamDAO.getTop10SanPhamBanChay();
                System.out.println("HomeController: Showing TOP 10 best sellers - " + products.size() + " products");
            }
            
            // Lấy danh sách danh mục để hiển thị bộ lọc
            List<DanhMuc> categories = danhMucDAO.getAllCategories();
            System.out.println("Loaded categories: " + categories.size());
            
            // Đếm tổng số sản phẩm
            long totalProducts = sanPhamDAO.countProducts();
            
            System.out.println("Total products in DB: " + totalProducts);
            
            // Set attributes
            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("showAll", showAll);
            
            System.out.println("All attributes set, forwarding to JSP...");
            
            // Forward to JSP
            request.getRequestDispatcher("/WEB-INF/views/guest/home.jsp").forward(request, response);
            
            System.out.println(">>> handleHomePage() completed successfully");
            
        } catch (Exception e) {
            System.err.println("!!! ERROR in HomeController.handleHomePage()");
            System.err.println("Error message: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải danh sách sản phẩm. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/WEB-INF/views/guest/home.jsp").forward(request, response);
        }
    }
    
    private void handleLoadMore(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        try {
            // Lấy tham số page và size từ request
            String pageParam = request.getParameter("page");
            String sizeParam = request.getParameter("size");
            
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
            int pageSize = (sizeParam != null) ? Integer.parseInt(sizeParam) : 4;
            
            System.out.println("HomeController LoadMore: page=" + page + ", pageSize=" + pageSize);
            
            // Tính offset: Trang chủ đã hiển thị 10 sản phẩm, load more bắt đầu từ sản phẩm thứ 11
            // Page 1 -> offset = 10 (bỏ qua 10 sản phẩm đầu tiên)
            // Page 2 -> offset = 10 + 4 = 14
            // Page 3 -> offset = 10 + 8 = 18
            int offset = 10 + (page - 1) * pageSize;
            
            System.out.println("HomeController LoadMore: Calculated offset=" + offset + " for " + pageSize + " products");
            
            // Lấy sản phẩm với pagination
            List<SanPham> products = sanPhamDAO.findAllWithPagination(offset, pageSize);
            
            // Đếm tổng số sản phẩm
            long totalProducts = sanPhamDAO.countProducts();
            
            System.out.println("HomeController LoadMore: Found " + products.size() + " products, total=" + totalProducts);
            
            // Tính tổng số sản phẩm đã hiển thị
            long totalDisplayed = 10 + page * pageSize;
            // Điều chỉnh nếu số sản phẩm thực tế ít hơn
            if (totalDisplayed > totalProducts) {
                totalDisplayed = totalProducts;
            }
            boolean hasMore = totalDisplayed < totalProducts;
            
            // Tạo JSON response thủ công
            StringBuilder jsonResponse = new StringBuilder();
            jsonResponse.append("{");
            jsonResponse.append("\"success\": true,");
            jsonResponse.append("\"products\": [");
            
            // Thêm danh sách sản phẩm vào JSON
            for (int i = 0; i < products.size(); i++) {
                SanPham product = products.get(i);
                if (i > 0) jsonResponse.append(",");
                jsonResponse.append("{");
                jsonResponse.append("\"maSP\": ").append(product.getMaSP()).append(",");
                jsonResponse.append("\"tenSP\": \"").append(escapeJson(product.getTenSP())).append("\",");
                jsonResponse.append("\"donGia\": ").append(product.getDonGia()).append(",");
                jsonResponse.append("\"hinhAnh\": \"").append(escapeJson(product.getHinhAnh())).append("\",");
                jsonResponse.append("\"moTa\": \"").append(escapeJson(product.getMoTa())).append("\",");
                jsonResponse.append("\"soLuongBan\": ").append(product.getSoLuongBan());
                jsonResponse.append("}");
            }
            
            jsonResponse.append("],");
            jsonResponse.append("\"totalProducts\": ").append(totalProducts).append(",");
            jsonResponse.append("\"hasMore\": ").append(hasMore).append(",");
            jsonResponse.append("\"currentPage\": ").append(page).append(",");
            jsonResponse.append("\"loadedCount\": ").append(products.size()).append(",");
            jsonResponse.append("\"totalLoaded\": ").append(totalDisplayed).append(",");
            jsonResponse.append("\"message\": \"");
            
            if (products.size() > 0) {
                jsonResponse.append("Đã tải thêm ").append(products.size())
                           .append(" sản phẩm! (Hiển thị ").append(totalDisplayed)
                           .append("/").append(totalProducts).append(" sản phẩm)");
            } else {
                jsonResponse.append("Đã hiển thị tất cả ").append(totalProducts).append(" sản phẩm!");
            }
            
            jsonResponse.append("\"");
            jsonResponse.append("}");
            
            // Log chi tiết để debug
            System.out.println("HomeController LoadMore: Total displayed=" + totalDisplayed + ", hasMore=" + hasMore);
            System.out.println("HomeController LoadMore: Offset formula: 10 + (" + page + " - 1) * " + pageSize + " = " + offset);
            
            // Gửi response
            response.getWriter().write(jsonResponse.toString());
            response.getWriter().flush();
            
        } catch (NumberFormatException e) {
            System.err.println("Invalid page or size parameter: " + e.getMessage());
            sendErrorResponse(response, "Tham số trang không hợp lệ");
        } catch (Exception e) {
            System.err.println("Error in HomeController LoadMore: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "Không thể tải thêm sản phẩm. Vui lòng thử lại.");
        }
    }
    
    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.getWriter().write("{\"success\": false, \"message\": \"" + escapeJson(message) + "\"}");
        response.getWriter().flush();
    }
    
    private String escapeJson(String text) {
        if (text == null) return "";
        return text.replace("\"", "\\\"")
                  .replace("\\", "\\\\")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}