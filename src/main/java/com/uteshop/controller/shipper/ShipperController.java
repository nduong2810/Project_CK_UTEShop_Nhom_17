package com.uteshop.controller.shipper;

import com.uteshop.dao.DonHangDAO;
import com.uteshop.dao.PhanCongGiaoHangDAO;
import com.uteshop.entity.DonHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.PhanCongGiaoHang;
import com.uteshop.util.JPAUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(urlPatterns = {"/shipper/dashboard", "/shipper/orders", "/shipper/history", "/shipper/pickup"})
public class ShipperController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Khai báo các DAO ở cấp độ lớp
    private PhanCongGiaoHangDAO orderRepo = new PhanCongGiaoHangDAO();
    private DonHangDAO donHangDAO = new DonHangDAO();

    @Override
    public void init() throws ServletException {
        super.init();
        try {
            JPAUtil.getEntityManager().close(); // Chỉ để kiểm tra khởi tạo
            log("JPA EntityManagerFactory is ready.");
        } catch (Exception e) {
            log("❌ Lỗi khởi tạo JPA trong ShipperController:", e);
            throw new ServletException("Cơ sở dữ liệu không thể kết nối hoặc JPA không khởi tạo.", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        NguoiDung user = (NguoiDung) session.getAttribute("user");

        if (user.getVaiTro() != NguoiDung.VaiTro.SHIPPER && user.getVaiTro() != NguoiDung.VaiTro.ADMIN) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập trang này.");
            return;
        }

        Integer shipperMaND = user.getMaND();
        String path = request.getServletPath();

        switch (path) {
            case "/shipper/orders":
                showOrders(request, response, shipperMaND);
                break;
            case "/shipper/history":
                showHistory(request, response, shipperMaND);
                break;
            case "/shipper/pickup":
                showPickupList(request, response, shipperMaND);
                break;
            case "/shipper/dashboard":
            default:
                showDashboard(request, response, shipperMaND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("updateStatus".equals(action)) {
            handleUpdateStatus(request, response);
        } else if ("confirmPickup".equals(action)) {
            handleConfirmPickup(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Yêu cầu POST không hợp lệ.");
        }
    }

    // --- CÁC PHƯƠNG THỨC XỬ LÝ GET ---

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, Integer shipperMaND) throws ServletException, IOException {
        try {
            Long totalAssigned = orderRepo.countOrdersByShipperAndStatus(shipperMaND, "Tất cả");
            Long completed = orderRepo.countOrdersByShipperAndStatus(shipperMaND, "HOAN_THANH");
            Long inProgress = orderRepo.countOrdersByShipperAndStatus(shipperMaND, "DANG_GIAO");

            request.setAttribute("totalAssigned", totalAssigned);
            request.setAttribute("completed", completed);
            request.setAttribute("inProgress", inProgress);
            request.setAttribute("viewTitle", "Shipper Dashboard & Thống kê");

            request.getRequestDispatcher("/WEB-INF/views/shipper/order-statistics.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi tải Dashboard Shipper:", e);
            response.sendRedirect(request.getContextPath() + "/guest/home?error=Lỗi tải dữ liệu Dashboard.");
        }
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response, Integer shipperMaND) throws ServletException, IOException {
        try {
            List<PhanCongGiaoHang> pendingOrders = orderRepo.findPendingOrdersByShipperId(shipperMaND);
            request.setAttribute("pendingOrders", pendingOrders);
            request.setAttribute("viewTitle", "Danh Sách Đơn Hàng Cần Giao");
            request.getRequestDispatcher("/WEB-INF/views/shipper/assigned-orders.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi tải danh sách đơn hàng:", e);
            response.sendRedirect(request.getContextPath() + "/shipper/dashboard?error=Lỗi tải danh sách đơn hàng.");
        }
    }

    private void showHistory(HttpServletRequest request, HttpServletResponse response, Integer shipperMaND) throws ServletException, IOException {
        try {
            List<PhanCongGiaoHang> historyOrders = orderRepo.findHistoryOrdersByShipperId(shipperMaND);
            request.setAttribute("historyOrders", historyOrders);
            request.setAttribute("viewTitle", "Lịch Sử Giao Hàng");
            request.getRequestDispatcher("/WEB-INF/views/shipper/history.jsp").forward(request, response);
        } catch (Exception e) {
            log("Lỗi tải lịch sử giao hàng:", e);
            response.sendRedirect(request.getContextPath() + "/shipper/dashboard?error=Lỗi tải lịch sử giao hàng.");
        }
    }

    private void showPickupList(HttpServletRequest request, HttpServletResponse response, Integer shipperMaND) throws ServletException, IOException {
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

    // --- CÁC PHƯƠNG THỨC XỬ LÝ POST ---

    private void handleUpdateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer maPC = null;
        try {
            maPC = Integer.parseInt(request.getParameter("maPC"));
            String newStatus = request.getParameter("newStatus");
            LocalDateTime ngayHoanThanh = null;
            if ("HOAN_THANH".equals(newStatus) || "TRA_HANG".equals(newStatus)) {
                ngayHoanThanh = LocalDateTime.now();
            }
            orderRepo.updateDeliveryStatus(maPC, newStatus, ngayHoanThanh);
            response.sendRedirect(request.getContextPath() + "/shipper/orders?message=Cập nhật trạng thái thành công!");
        } catch (Exception e) {
            log("Lỗi khi cập nhật trạng thái cho MaPC=" + maPC, e);
            response.sendRedirect(request.getContextPath() + "/shipper/orders?error=Cập nhật thất bại.");
        }
    }

    private void handleConfirmPickup(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer maDH = null;
        try {
            NguoiDung shipper = (NguoiDung) request.getSession().getAttribute("user");
            Integer shipperMaND = shipper.getMaND();
            maDH = Integer.parseInt(request.getParameter("maDH"));

            log("INFO: Shipper MaND=" + shipperMaND + " đang xác nhận lấy đơn hàng MaDH=" + maDH);
            boolean success = orderRepo.assignOrderToShipper(maDH, shipperMaND);

            if (success) {
                // =======================================================
                // SỬA LỖI: MÃ HÓA (URL ENCODE) THÔNG BÁO TIẾNG VIỆT
                // =======================================================
                String message = URLEncoder.encode("Đã xác nhận lấy đơn hàng #" + maDH + " thành công!", StandardCharsets.UTF_8);
                String redirectURL = request.getContextPath() + "/shipper/pickup?message=" + message;
                response.sendRedirect(redirectURL);
                
            } else {
                // Cũng nên mã hóa thông báo lỗi
                String error = URLEncoder.encode("Xác nhận thất bại! Đơn hàng có thể đã được người khác nhận.", StandardCharsets.UTF_8);
                String redirectURL = request.getContextPath() + "/shipper/pickup?error=" + error;
                response.sendRedirect(redirectURL);
            }
        } catch (Exception e) {
            log("FATAL: Lỗi khi xác nhận lấy đơn MaDH=" + maDH, e);
            String error = URLEncoder.encode("Hệ thống đã gặp lỗi nghiêm trọng.", StandardCharsets.UTF_8);
            response.sendRedirect(request.getContextPath() + "/shipper/pickup?error=" + error);
        }
    }
}