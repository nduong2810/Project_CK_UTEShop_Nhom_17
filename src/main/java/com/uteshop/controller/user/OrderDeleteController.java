package com.uteshop.controller.user;

import com.uteshop.dao.DonHangDAO;
import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet này xử lý việc XÓA đơn hàng qua AJAX
 * và trả về kết quả dưới dạng JSON.
 */
@WebServlet("/user/orders/delete")
public class OrderDeleteController extends HttpServlet {

    private DonHangDAO donHangDAO = new DonHangDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        boolean isSuccess = false;
        String message = "";
        
        try {
            HttpSession session = req.getSession();
            NguoiDung user = (NguoiDung) session.getAttribute("user");

            // 1. Kiểm tra đăng nhập
            if (user == null) {
                throw new SecurityException("Bạn chưa đăng nhập.");
            }

            // 2. Lấy Order ID
            String idParam = req.getParameter("id");
            if (idParam == null) {
                throw new IllegalArgumentException("Thiếu ID đơn hàng.");
            }
            Integer orderId = Integer.parseInt(idParam);

            // 3. Lấy thông tin đơn hàng
            DonHang order = donHangDAO.findById(orderId);

            // 4. Kiểm tra quyền sở hữu
            if (order == null) {
                throw new Exception("Không tìm thấy đơn hàng.");
            }
            if (!order.getNguoiDung().getMaND().equals(user.getMaND())) {
                throw new SecurityException("Bạn không có quyền xóa đơn hàng này.");
            }
            

            boolean deleted = donHangDAO.delete(orderId); 

            if (deleted) {
                isSuccess = true;
                message = "Xóa đơn hàng thành công!";
            } else {
                throw new Exception("Xóa đơn hàng thất bại từ DAO.");
            }

        } catch (NumberFormatException e) {
            message = "ID đơn hàng không hợp lệ.";
            isSuccess = false;
        } catch (SecurityException e) {
            message = e.getMessage();
            isSuccess = false;
        } catch (Exception e) {
            message = "Lỗi: " + e.getMessage();
            isSuccess = false;
            e.printStackTrace();
        }

        // 6. Trả JSON về
        String jsonResponse = String.format(
            "{\"success\": %b, \"message\": \"%s\"}",
            isSuccess,
            message
        );
        
        resp.getWriter().write(jsonResponse);
    }
}