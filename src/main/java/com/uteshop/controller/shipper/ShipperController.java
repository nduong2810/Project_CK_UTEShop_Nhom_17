package com.uteshop.controller.shipper;

import com.uteshop.dao.DonHangDAO;
import com.uteshop.dao.PhanCongGiaoHangDAO;
import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.PhanCongGiaoHang;
import com.uteshop.util.JPAUtil; // Đã thêm import JPAUtil để minh họa việc quản lý EM
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Servlet Controller chính xử lý tất cả các yêu cầu liên quan đến Shipper (Nhân viên giao hàng).
 * Bao gồm: Dashboard (Thống kê), Quản lý đơn hàng cần giao, và Lịch sử giao hàng.
 * URL Patterns: /shipper/dashboard, /shipper/orders, /shipper/history
 */
@WebServlet(urlPatterns = {"/shipper/dashboard", "/shipper/orders", "/shipper/history", "/shipper/pickup"})
public class ShipperController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private DonHangDAO donHangDAO = new DonHangDAO();
    // Khởi tạo DAO (Giả định đã sửa đổi để sử dụng JPAUtil)
    private PhanCongGiaoHangDAO orderRepo = new PhanCongGiaoHangDAO();
    
    // Khởi tạo EntityManagerFactory khi ứng dụng khởi động (Chỉ dùng khi chưa có ContextListener)
    @Override
    public void init() throws ServletException {
        super.init();
        try {
            // Đảm bảo EntityManagerFactory được khởi tạo khi Servlet bắt đầu
            JPAUtil.getEntityManager(); 
            log("JPA EntityManagerFactory is ready.");
        } catch (Exception e) {
            log("❌ Lỗi khởi tạo JPA trong ShipperController:", e);
            // Nếu dòng này xuất hiện trong log, lỗi nằm ở cấu hình persistence.xml hoặc kết nối DB
            throw new UnavailableException("Cơ sở dữ liệu không thể kết nối hoặc JPA không khởi tạo.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // --- 1. KIỂM TRA QUYỀN VÀ ĐĂNG NHẬP ---
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        // Kiểm tra Vai trò (chỉ SHIPPER và ADMIN được phép truy cập)
        if (user.getVaiTro() != NguoiDung.VaiTro.SHIPPER && user.getVaiTro() != NguoiDung.VaiTro.ADMIN) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này.");
            return;
        }
        
        // Lấy MaND của shipper để truy vấn dữ liệu
        Integer shipperMaND = user.getMaND();
        
        String path = request.getServletPath();
        
        // --- 2. XỬ LÝ ĐIỀU HƯỚNG THEO PATH ---
        switch (path) {
            case "/shipper/orders":
                showOrders(request, response, shipperMaND); // Danh sách đơn hàng cần giao
                break;
                
            case "/shipper/history":
                showHistory(request, response, shipperMaND); // Lịch sử đã giao/hủy
                break;
            
            // =======================================================
            // THÊM CASE MỚI NÀY ĐỂ XỬ LÝ TRANG NHẬN ĐƠN TẠI KHO
            // =======================================================
            case "/shipper/pickup":
                showPickupList(request, response, shipperMaND);
                break;
                
            case "/shipper/dashboard":
            default:
                showDashboard(request, response, shipperMaND); // Thống kê + Dashboard mặc định
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            handleUpdateStatus(request, response);
        } 
        // THÊM ELSE IF MỚI
        else if ("confirmPickup".equals(action)) {
            handleConfirmPickup(request, response);
        } 
        else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Yêu cầu POST không hợp lệ.");
        }
    }
    
    // --- PHƯƠNG THỨC XỬ LÝ CHỨC NĂNG ---

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, Integer shipperMaND)
            throws ServletException, IOException {
        try {
            // Tích hợp logic Thống kê vào Dashboard
            Long totalAssigned = orderRepo.countOrdersByShipperAndStatus(shipperMaND, "Tất cả");
            Long completed = orderRepo.countOrdersByShipperAndStatus(shipperMaND, "HOAN_THANH");
            Long inProgress = orderRepo.countOrdersByShipperAndStatus(shipperMaND, "DANG_GIAO");
            
            request.setAttribute("totalAssigned", totalAssigned);
            request.setAttribute("completed", completed);
            request.setAttribute("inProgress", inProgress);
            request.setAttribute("viewTitle", "Shipper Dashboard & Thống kê");
            
            // Forward tới JSP của Dashboard/Thống kê
            request.getRequestDispatcher("/WEB-INF/views/shipper/order-statistics.jsp").forward(request, response);
            
        } catch (Exception e) {
            log("Lỗi tải Dashboard Shipper:", e);
            request.setAttribute("error", "Lỗi tải dữ liệu Dashboard.");
            // Chuyển hướng tới trang lỗi chung (hoặc trang chủ)
            response.sendRedirect(request.getContextPath() + "/guest/home?error=Lỗi tải dữ liệu Dashboard."); 
        }
    }
    
    private void showOrders(HttpServletRequest request, HttpServletResponse response, Integer shipperMaND)
            throws ServletException, IOException {
        try {
            // THAY ĐỔI: Gọi trực tiếp phương thức đã được tối ưu hóa trong DAO.
            // Phương thức này sử dụng "JOIN FETCH" để tải cả thông tin Đơn Hàng,
            // tránh được lỗi LazyInitializationException.
            List<PhanCongGiaoHang> pendingOrders = orderRepo.findPendingOrdersByShipperId(shipperMaND);

            // BỎ ĐI: Không cần lấy tất cả rồi lọc trong bộ nhớ nữa.
            // List<PhanCongGiaoHang> assignedOrders = orderRepo.findAssignedOrdersByShipperId(shipperMaND);
            // List<PhanCongGiaoHang> pendingOrders = assignedOrders.stream()
            //       .filter(pc -> !("HOAN_THANH".equals(pc.getTrangThai()) || "TRA_HANG".equals(pc.getTrangThai())))
            //       .collect(Collectors.toList());

            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("viewTitle", "Danh Sách Đơn Hàng Cần Giao");

            request.getRequestDispatcher("/WEB-INF/views/shipper/assigned-orders.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi tải danh sách đơn hàng:", e);
            // DÒNG NÀY VÀ CÁC DÒNG DƯỚI ĐÂY CẦN GÕ LẠI
            response.sendRedirect(request.getContextPath() + "/shipper/dashboard?error=Lỗi tải danh sách đơn hàng.");
        }
    }
 // Trong lớp ShipperController.java

    private void showHistory(HttpServletRequest request, HttpServletResponse response, Integer shipperMaND)
            throws ServletException, IOException {
        try {
            // KHÔNG CẦN DÒNG NÀY NỮA: Integer shipperMaND = user.getMaND();
            
            // Gọi phương thức DAO để lấy các đơn đã hoàn thành hoặc trả lại
            List<PhanCongGiaoHang> historyOrders = orderRepo.findHistoryOrdersByShipperId(shipperMaND);
            
            request.setAttribute("historyOrders", historyOrders);
            request.setAttribute("viewTitle", "Lịch Sử Giao Hàng");
            
            // Forward tới file JSP mới tạo
            request.getRequestDispatcher("/WEB-INF/views/shipper/history.jsp").forward(request, response);
            
        } catch (Exception e) {
            log("Lỗi tải lịch sử giao hàng:", e);
            response.sendRedirect(request.getContextPath() + "/shipper/dashboard?error=Lỗi tải lịch sử giao hàng.");
        }
    }

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Integer maPC = null;
        String newStatus = null;
        
        try {
            maPC = Integer.parseInt(request.getParameter("maPC"));
            newStatus = request.getParameter("newStatus");
            
            LocalDateTime ngayHoanThanh = null;
            if ("HOAN_THANH".equals(newStatus) || "TRA_HANG".equals(newStatus)) {
                // Gán ngày hoàn thành/trả hàng nếu trạng thái là cuối cùng
                ngayHoanThanh = LocalDateTime.now();
            }
            
            orderRepo.updateDeliveryStatus(maPC, newStatus, ngayHoanThanh);
            
            // Redirect về trang Orders sau khi cập nhật thành công
            response.sendRedirect(request.getContextPath() + "/shipper/orders?message=Cập nhật trạng thái đơn hàng thành công!");
            
        } catch (NumberFormatException e) {
            // Lỗi khi chuyển MaPC sang số
            log("Lỗi định dạng MaPC khi cập nhật trạng thái Shipper", e);
            response.sendRedirect(request.getContextPath() + "/shipper/orders?error=Dữ liệu đầu vào không hợp lệ (Mã Phân công).");
        } catch (RuntimeException e) {
            // Lỗi từ DAO (ví dụ: lỗi Transaction/DB)
            log("Lỗi CSDL khi cập nhật trạng thái đơn hàng MaPC=" + maPC, e);
            response.sendRedirect(request.getContextPath() + "/shipper/orders?error=Cập nhật thất bại. Vui lòng thử lại. Lỗi: " + e.getMessage());
        } catch (Exception e) {
            log("Lỗi không xác định khi cập nhật trạng thái Shipper", e);
            response.sendRedirect(request.getContextPath() + "/shipper/orders?error=Cập nhật thất bại. Lỗi không xác định.");
        }
    }
    private void showPickupList(HttpServletRequest request, HttpServletResponse response, Integer shipperMaND)
            throws ServletException, IOException {
        try {
            List<DonHang> readyOrders = donHangDAO.findOrdersReadyForPickup();
            request.setAttribute("readyOrders", readyOrders);
            request.setAttribute("viewTitle", "Xác Nhận Lấy Đơn Hàng Tại Kho");
            request.getRequestDispatcher("/WEB-INF/views/shipper/pickup-orders.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi tải danh sách đơn hàng chờ lấy:", e);
            response.sendRedirect(request.getContextPath() + "/shipper/dashboard?error=Không thể tải danh sách đơn hàng.");
        }
    }

    private void handleConfirmPickup(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            // Lỗi có thể xảy ra ở đây:
            Integer maDH = Integer.parseInt(request.getParameter("maDH")); // 1. Tham số "maDH" có null hoặc không phải số?
            
            NguoiDung shipper = (NguoiDung) request.getSession().getAttribute("user"); // 2. Session có user không?
            Integer shipperMaND = shipper.getMaND();

            // Hoặc lỗi xảy ra trong phương thức DAO này:
            boolean success = orderRepo.assignOrderToShipper(maDH, shipperMaND); // 3. Logic trong DAO có lỗi không?

            if (success) {
                response.sendRedirect(request.getContextPath() + "/shipper/pickup?message=Đã xác nhận lấy đơn hàng " + maDH + " thành công!");
            } else {
                response.sendRedirect(request.getContextPath() + "/shipper/pickup?error=Xác nhận thất bại! Đơn hàng có thể đã được người khác nhận.");
            }
        } catch (Exception e) {
            // Nếu có Exception, nó sẽ rơi vào đây
            log("Lỗi khi xác nhận lấy đơn hàng:", e); // 4. Dòng log này có xuất hiện trong console không?
            response.sendRedirect(request.getContextPath() + "/shipper/pickup?error=Đã có lỗi xảy ra.");
        }
    }
}