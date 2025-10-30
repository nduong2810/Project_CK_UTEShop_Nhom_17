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
 * Servlet này xử lý việc hủy đơn hàng qua AJAX
 * và trả về kết quả dưới dạng JSON.
 */
@WebServlet("/user/orders/cancel")
public class OrderCancelController extends HttpServlet {

    private DonHangDAO donHangDAO = new DonHangDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // --- CÀI ĐẶT PHẢN HỒI LÀ JSON ---
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

            // 2. Lấy Order ID từ parameter
            String idParam = req.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new IllegalArgumentException("Thiếu ID đơn hàng.");
            }
            Integer orderId = Integer.parseInt(idParam);

            // 3. Lấy thông tin đơn hàng
            DonHang order = donHangDAO.findById(orderId);

            // 4. Kiểm tra quyền sở hữu và trạng thái
            if (order == null) {
                throw new Exception("Không tìm thấy đơn hàng.");
            }
            if (!order.getNguoiDung().getMaND().equals(user.getMaND())) {
                throw new SecurityException("Bạn không có quyền hủy đơn hàng này.");
            }
            if (order.getTrangThai() != DonHang.TrangThaiDonHang.CHO_XAC_NHAN) {
                throw new Exception("Không thể hủy đơn hàng ở trạng thái này.");
            }

            // 5. Thực hiện hủy đơn hàng (Cập nhật trạng thái)
            // (Bạn cần có một phương thức trong DAO để cập nhật trạng thái)
            boolean cancelled = donHangDAO.updateStatus(orderId, DonHang.TrangThaiDonHang.DA_HUY);

            if (cancelled) {
                isSuccess = true;
                message = "Hủy đơn hàng thành công!";
            } else {
                throw new Exception("Hủy đơn hàng thất bại từ phía DAO.");
            }

        } catch (NumberFormatException e) {
            message = "ID đơn hàng không hợp lệ.";
            isSuccess = false;
        } catch (SecurityException e) {
            message = e.getMessage(); // "Bạn chưa đăng nhập" hoặc "Không có quyền"
            isSuccess = false;
        } catch (Exception e) {
            message = "Lỗi: " + e.getMessage();
            isSuccess = false;
            e.printStackTrace();
        }

        // --- 6. TRẢ KẾT QUẢ JSON VỀ CHO JAVASCRIPT ---
        String jsonResponse = String.format(
            "{\"success\": %b, \"message\": \"%s\"}",
            isSuccess,
            message
        );
        
        resp.getWriter().write(jsonResponse);
    }
}