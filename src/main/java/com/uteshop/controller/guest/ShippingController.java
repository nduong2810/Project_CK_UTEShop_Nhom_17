package com.uteshop.controller.guest;

import com.uteshop.dao.DonViVanChuyenDAO;
import com.uteshop.entity.DonViVanChuyen;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet(urlPatterns = {"/guest/shipping/partners", "/guest/shipping/policy", "/guest/shipping/track"})
public class ShippingController extends HttpServlet {
    private final DonViVanChuyenDAO donViVanChuyenDAO = new DonViVanChuyenDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        String view = "/WEB-INF/views/guest/home.jsp";
        
        try {
            switch (path) {
                case "/guest/shipping/partners":
                    // Hiển thị đối tác vận chuyển
                    handleShippingPartners(request);
                    view = "/WEB-INF/views/guest/shipping-partners.jsp";
                    break;
                    
                case "/guest/shipping/policy":
                    // Hiển thị chính sách vận chuyển
                    view = "/WEB-INF/views/guest/shipping-policy.jsp";
                    break;
                    
                case "/guest/shipping/track":
                    // Tra cứu đơn hàng
                    view = "/WEB-INF/views/guest/shipping-track.jsp";
                    break;
                    
                default:
                    handleShippingPartners(request);
                    view = "/WEB-INF/views/guest/shipping-partners.jsp";
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải thông tin vận chuyển. Vui lòng thử lại sau.");
            request.setAttribute("shippingPartners", Collections.emptyList());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
        dispatcher.forward(request, response);
    }
    
    private void handleShippingPartners(HttpServletRequest request) {
        try {
            // Lấy tất cả đối tác vận chuyển
            List<DonViVanChuyen> shippingPartners = donViVanChuyenDAO.findAll();
            
            // Lấy top 5 đối tác có phí rẻ nhất
            List<DonViVanChuyen> cheapestPartners = donViVanChuyenDAO.findCheapestShipping(5);
            
            // Đếm tổng số đối tác
            long totalPartners = donViVanChuyenDAO.countShippingPartners();
            
            request.setAttribute("shippingPartners", shippingPartners);
            request.setAttribute("cheapestPartners", cheapestPartners);
            request.setAttribute("totalPartners", totalPartners);
            request.setAttribute("pageTitle", "Đối tác vận chuyển");
            
            System.out.println("ShippingController: Loaded " + shippingPartners.size() + " shipping partners");
            
        } catch (Exception e) {
            System.err.println("Error in handleShippingPartners: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("shippingPartners", Collections.emptyList());
            request.setAttribute("errorMessage", "Không thể tải thông tin đối tác vận chuyển");
        }
    }
}