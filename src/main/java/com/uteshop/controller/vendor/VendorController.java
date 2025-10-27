package com.uteshop.controller.vendor;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.dao.MaGiamGiaDAO;
import com.uteshop.dao.DonHangDAO;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;
import com.uteshop.entity.MaGiamGia;
import com.uteshop.entity.DonHang;
import com.uteshop.utils.DiscountUtils;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@WebServlet(urlPatterns = {"/vendor/dashboard", "/vendor/products", "/vendor/discounts", "/vendor/discounts/create", "/vendor/discounts/edit", "/vendor/discounts/delete", "/vendor/orders", "/vendor/orders/detail", "/vendor/orders/update-status", "/vendor/revenue-report", "/vendor/statistics", "/vendor/settings", "/vendor/settings/update"})
public class VendorController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Khai báo DAO
    private final CuaHangDAO cuaHangDAO = new CuaHangDAO();
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final MaGiamGiaDAO maGiamGiaDAO = new MaGiamGiaDAO();
    private final DonHangDAO donHangDAO = new DonHangDAO();

    // Phương thức hỗ trợ kiểm tra quyền
    private NguoiDung checkAuth(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        NguoiDung user = (NguoiDung) Optional.ofNullable(session)
                .map(s -> s.getAttribute("user"))
                .orElse(null);

        if (user == null || user.getVaiTro() == null || user.getMaND() == null) {
            return null;
        }
        
        // Kiểm tra VaiTro chính xác là VENDOR
        String vaiTro = user.getVaiTro().toString().toUpperCase();
        if (!vaiTro.equals("VENDOR")) {
            return null;
        }
        
        return user;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        NguoiDung user = checkAuth(request);
        
        // Bước 1: Kiểm tra người dùng đã đăng nhập và có quyền Vendor
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login?error=Vui long dang nhap voi vai tro Vendor.");
            return;
        }
        
        // Lấy action: Sử dụng ServletPath để lấy đường dẫn đầy đủ
        String action = request.getServletPath();
        String path = action.replace("/vendor", ""); // Loại bỏ prefix /vendor để lấy phần còn lại
        
        // Bước 2: Kiểm tra xem người dùng đã có cửa hàng chưa
        CuaHang store = cuaHangDAO.findByUserId(user.getMaND()); 
        if (store == null) {
            System.err.println("Không tìm thấy CuaHang cho userId: " + user.getMaND());
            response.sendRedirect(request.getContextPath() + "/vendor/register-store?error=Vui long dang ky cua hang truoc.");
            return;
        }
        
        // Nếu đã có cửa hàng, đặt attribute và xử lý action
        request.setAttribute("store", store);
        
        switch (path) {
            case "/dashboard":
                showDashboard(request, response, user);
                break;
            case "/products":
                showProducts(request, response, user, store);
                break;
            case "/discounts":
                showDiscounts(request, response, user, store);
                break;
            case "/discounts/create":
                showCreateDiscount(request, response, user, store);
                break;
            case "/discounts/edit":
                showEditDiscount(request, response, user, store);
                break;
            case "/orders":
                showOrders(request, response, user, store);
                break;
            case "/orders/detail":
                showOrderDetail(request, response, user, store);
                break;
            case "/revenue-report":
                showRevenueReport(request, response, user, store);
                break;
            case "/statistics":
                showStatistics(request, response, user, store);
                break;
            case "/settings":
                showSettings(request, response, user, store);
                break;
            default:
                showDashboard(request, response, user);
                break;
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        try {
            // CuaHang store đã được đặt trong request ở doGet()
            CuaHang store = (CuaHang) request.getAttribute("store");
            
            // Lấy ngày tháng năm hiện tại
            java.time.LocalDate now = java.time.LocalDate.now();
            int currentDay = now.getDayOfMonth();
            int currentMonth = now.getMonthValue();
            int currentYear = now.getYear();
            
            // Thêm thống kê mã giảm giá cho dashboard
            if (store != null) {
                try {
                    // Thống kê mã giảm giá
                    int totalDiscounts = maGiamGiaDAO.countByCuaHangId(store.getMaCH());
                    int activeDiscounts = maGiamGiaDAO.getActiveDiscountsByStore(store.getMaCH()).size();
                    
                    request.setAttribute("totalDiscounts", totalDiscounts);
                    request.setAttribute("activeDiscounts", activeDiscounts);
                    
                    // Thống kê sản phẩm
                    int totalProducts = sanPhamDAO.countByCuaHangId(store.getMaCH());
                    request.setAttribute("totalProducts", totalProducts);
                    
                    // Thống kê đơn hàng
                    long newOrdersCount = donHangDAO.countNewOrders(store.getMaCH());
                    long totalOrders = donHangDAO.countByStoreAndStatus(store.getMaCH(), null);
                    request.setAttribute("newOrdersCount", newOrdersCount);
                    request.setAttribute("totalOrders", totalOrders);
                    
                    // Thống kê doanh thu theo ngày, tháng, năm
                    BigDecimal dailyRevenue = donHangDAO.getDailyRevenue(store.getMaCH(), currentDay, currentMonth, currentYear);
                    BigDecimal monthlyRevenue = donHangDAO.getMonthlyRevenue(store.getMaCH(), currentMonth, currentYear);
                    BigDecimal yearlyRevenue = donHangDAO.getYearlyRevenue(store.getMaCH(), currentYear);
                    
                    request.setAttribute("dailyRevenue", dailyRevenue);
                    request.setAttribute("monthlyRevenue", monthlyRevenue);
                    request.setAttribute("yearlyRevenue", yearlyRevenue);
                    
                    // Dữ liệu cho biểu đồ doanh thu 7 ngày
                    List<Object[]> last7Days = donHangDAO.getLast7DaysRevenue(store.getMaCH());
                    request.setAttribute("last7DaysRevenue", last7Days);
                    
                    // Dữ liệu cho biểu đồ doanh thu 12 tháng
                    List<Object[]> last12Months = donHangDAO.getLast12MonthsRevenue(store.getMaCH());
                    request.setAttribute("last12MonthsRevenue", last12Months);
                    
                    // Ngày hiện tại
                    request.setAttribute("now", new java.util.Date());
                    
                } catch (Exception e) {
                    // Nếu có lỗi, chỉ log và tiếp tục
                    System.err.println("Lỗi khi lấy thống kê: " + e.getMessage());
                    e.printStackTrace();
                    request.setAttribute("totalDiscounts", 0);
                    request.setAttribute("activeDiscounts", 0);
                    request.setAttribute("totalProducts", 0);
                    request.setAttribute("newOrdersCount", 0);
                    request.setAttribute("totalOrders", 0);
                    request.setAttribute("dailyRevenue", BigDecimal.ZERO);
                    request.setAttribute("monthlyRevenue", BigDecimal.ZERO);
                    request.setAttribute("yearlyRevenue", BigDecimal.ZERO);
                }
            }
            
            request.setAttribute("pageTitle", "Vendor Dashboard");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/dashboard.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Lỗi trong showDashboard: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dashboard: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/dashboard.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    /**
     * Phương thức tải danh sách sản phẩm và forward đến products.jsp
     */
    private void showProducts(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        
        // 1. Lấy các tham số tìm kiếm và phân trang
        String searchKeyword = request.getParameter("search");
        String sortBy = request.getParameter("sort");
        String statusFilter = request.getParameter("status");
        
        // Phân trang
        int page = 1;
        int pageSize = 10;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
            String sizeParam = request.getParameter("size");
            if (sizeParam != null && !sizeParam.isEmpty()) {
                pageSize = Integer.parseInt(sizeParam);
                if (pageSize < 5) pageSize = 5;
                if (pageSize > 50) pageSize = 50;
            }
        } catch (NumberFormatException e) {
            // Sử dụng giá trị mặc định nếu parse lỗi
        }
        
        // 2. Lấy danh sách Sản phẩm với bộ lọc
        List<SanPham> products;
        int totalProducts = 0;
        try {
            products = sanPhamDAO.findByCuaHangIdWithFilter(
                store.getMaCH(), 
                searchKeyword, 
                sortBy, 
                statusFilter,
                (page - 1) * pageSize,
                pageSize
            );
            
            totalProducts = sanPhamDAO.countByCuaHangIdWithFilter(
                store.getMaCH(),
                searchKeyword,
                statusFilter
            );
            
            if (products == null) {
                products = List.of(); // Gán danh sách rỗng nếu null
            }
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải danh sách sản phẩm: " + e.getMessage());
            products = List.of(); // Gán danh sách rỗng khi có lỗi
            e.printStackTrace();
        }
        
        // 3. Tính toán thông tin phân trang
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        
        // 4. Đặt dữ liệu vào Request
        request.setAttribute("products", products);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("statusFilter", statusFilter);
        
        // 5. Thông tin thống kê nhanh
        try {
            int activeProducts = sanPhamDAO.countByCuaHangIdWithFilter(store.getMaCH(), null, "true");
            int inactiveProducts = sanPhamDAO.countByCuaHangIdWithFilter(store.getMaCH(), null, "false");
            request.setAttribute("activeProductsCount", activeProducts);
            request.setAttribute("inactiveProductsCount", inactiveProducts);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // 6. Chuyển tiếp đến JSP
        request.setAttribute("pageTitle", "Quản lý Sản phẩm");
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/products.jsp");
        dispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        NguoiDung user = checkAuth(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login?error=Vui long dang nhap voi vai tro Vendor.");
            return;
        }

        String action = request.getParameter("action");
        CuaHang store = cuaHangDAO.findByUserId(user.getMaND());
        if (store == null) {
            response.sendRedirect(request.getContextPath() + "/vendor/register-store?error=Vui long dang ky cua hang truoc.");
            return;
        }

        if ("delete".equals(action)) {
            String maSPParam = request.getParameter("id");
            if (maSPParam != null && !maSPParam.isEmpty()) {
                try {
                    Integer maSP = Integer.parseInt(maSPParam);
                    SanPham product = sanPhamDAO.findById(maSP);
                    if (product != null && product.getCuaHang().getMaCH().equals(store.getMaCH())) {
                        sanPhamDAO.delete(product);
                        response.sendRedirect(request.getContextPath() + "/vendor/products?msg=Xoa san pham thanh cong.");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/vendor/products?error=San pham khong ton tai hoac khong co quyen.");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect(request.getContextPath() + "/vendor/products?error=ID san pham khong hop le.");
                }
            }
        } else if ("toggleStatus".equals(action)) {
            toggleProductStatus(request, response, user, store);
        } else if ("createDiscount".equals(action)) {
            createDiscount(request, response, user, store);
        } else if ("updateDiscount".equals(action)) {
            updateDiscount(request, response, user, store);
        } else if ("deleteDiscount".equals(action)) {
            deleteDiscount(request, response, user, store);
        } else if ("updateOrderStatus".equals(action)) {
            updateOrderStatus(request, response, user, store);
        } else if ("updateStoreSettings".equals(action)) {
            updateStoreSettings(request, response, user, store);
        } else {
            doGet(request, response); // Xử lý các POST khác bằng doGet
        }
    }
    
    // Phương thức toggle trạng thái sản phẩm (Ẩn/Hiện)
    private void toggleProductStatus(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        String maSPParam = request.getParameter("id");
        String statusParam = request.getParameter("status");
        
        if (maSPParam == null || maSPParam.isEmpty() || statusParam == null) {
            response.sendRedirect(request.getContextPath() + "/vendor/products?error=Thong tin khong hop le.");
            return;
        }
        
        try {
            Integer maSP = Integer.parseInt(maSPParam);
            boolean newStatus = Boolean.parseBoolean(statusParam);
            
            SanPham product = sanPhamDAO.findById(maSP);
            if (product != null && product.getCuaHang().getMaCH().equals(store.getMaCH())) {
                product.setTrangThai(newStatus);
                sanPhamDAO.update(product);
                
                String message = newStatus ? "Hien san pham thanh cong." : "An san pham thanh cong.";
                response.sendRedirect(request.getContextPath() + "/vendor/products?msg=" + message);
            } else {
                response.sendRedirect(request.getContextPath() + "/vendor/products?error=San pham khong ton tai hoac khong co quyen.");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/vendor/products?error=ID san pham khong hop le.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vendor/products?error=Co loi xay ra khi cap nhat trang thai.");
        }
    }
    
    // Phương thức hiển thị danh sách mã giảm giá
    private void showDiscounts(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        
        // Phân trang
        int page = 1;
        int pageSize = 10;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            // Sử dụng giá trị mặc định
        }
        
        try {
            // Lấy danh sách mã giảm giá với phân trang
            List<MaGiamGia> discounts = maGiamGiaDAO.findByCuaHangIdWithPaging(
                store.getMaCH(), 
                (page - 1) * pageSize, 
                pageSize
            );
            
            int totalDiscounts = maGiamGiaDAO.countByCuaHangId(store.getMaCH());
            int totalPages = (int) Math.ceil((double) totalDiscounts / pageSize);
            
            // Thống kê nhanh
            List<MaGiamGia> activeDiscounts = maGiamGiaDAO.getActiveDiscountsByStore(store.getMaCH());
            
            request.setAttribute("discounts", discounts);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalDiscounts", totalDiscounts);
            request.setAttribute("activeDiscountsCount", activeDiscounts.size());
            
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải danh sách mã giảm giá: " + e.getMessage());
            e.printStackTrace();
        }
        
        request.setAttribute("pageTitle", "Quản lý Mã giảm giá");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/discounts.jsp");
        dispatcher.forward(request, response);
    }
    
    // Phương thức hiển thị form tạo mã giảm giá
    private void showCreateDiscount(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        request.setAttribute("pageTitle", "Tạo Mã giảm giá");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/discount-form.jsp");
        dispatcher.forward(request, response);
    }
    
    // Phương thức hiển thị form chỉnh sửa mã giảm giá
    private void showEditDiscount(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=ID mã giảm giá không hợp lệ.");
            return;
        }
        
        try {
            int discountId = Integer.parseInt(idParam);
            MaGiamGia discount = maGiamGiaDAO.findById(discountId);
            
            if (discount == null || !discount.getCuaHang().getMaCH().equals(store.getMaCH())) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=Mã giảm giá không tồn tại hoặc không có quyền.");
                return;
            }
            
            request.setAttribute("discount", discount);
            request.setAttribute("pageTitle", "Chỉnh sửa Mã giảm giá");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/discount-form.jsp");
            dispatcher.forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=ID mã giảm giá không hợp lệ.");
        }
    }
    
    // Phương thức tạo mã giảm giá mới
    private void createDiscount(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String maSo = request.getParameter("maSo");
            String tenChuongTrinh = request.getParameter("tenChuongTrinh");
            String moTa = request.getParameter("moTa");
            String loaiGiamStr = request.getParameter("loaiGiam");
            String giaTriGiamStr = request.getParameter("giaTriGiam");
            String giaTriDonHangToiThieuStr = request.getParameter("giaTriDonHangToiThieu");
            String giaTriGiamToiDaStr = request.getParameter("giaTriGiamToiDa");
            String ngayBatDauStr = request.getParameter("ngayBatDau");
            String ngayKetThucStr = request.getParameter("ngayKetThuc");
            String soLuongToiDaStr = request.getParameter("soLuongToiDa");
            
            // Validation cơ bản và làm sạch dữ liệu
            if (maSo == null || maSo.trim().isEmpty() ||
                tenChuongTrinh == null || tenChuongTrinh.trim().isEmpty() ||
                giaTriGiamStr == null || giaTriGiamStr.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts/create?error=MISSING_REQUIRED_FIELDS");
                return;
            }
            
            // Chuẩn hóa mã số - loại bỏ khoảng trắng và chuyển thành chữ hoa
            String cleanMaSo = maSo.trim().toUpperCase().replaceAll("\\s+", "");
            if (cleanMaSo.isEmpty() || cleanMaSo.length() > 20) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts/create?error=INVALID_CODE_LENGTH");
                return;
            }
            
            // Kiểm tra mã số có tồn tại không
            MaGiamGia existingDiscount = maGiamGiaDAO.findByMaSo(cleanMaSo);
            if (existingDiscount != null) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts/create?error=CODE_ALREADY_EXISTS");
                return;
            }
            
            // Tạo mã giảm giá mới với validation chặt chẽ
            MaGiamGia discount = new MaGiamGia();
            
            // Đảm bảo các trường bắt buộc có giá trị
            discount.setMaSo(cleanMaSo); // Đảm bảo không null và không rỗng
            discount.setTenChuongTrinh(tenChuongTrinh.trim());
            discount.setMoTa(moTa != null ? moTa.trim() : "");
            discount.setLoaiGiam(MaGiamGia.LoaiGiam.valueOf(loaiGiamStr));
            discount.setGiaTriGiam(new BigDecimal(giaTriGiamStr));
            discount.setCuaHang(store);
            discount.setNgayTao(LocalDateTime.now());
            discount.setTrangThai(true); // Đảm bảo có giá trị boolean
            discount.setSoLuongDaSuDung(0); // Đảm bảo có giá trị mặc định
            
            // Thiết lập HanSuDung để tránh lỗi constraint violation
            LocalDateTime defaultHanSuDung = LocalDateTime.now().plusDays(30);
            discount.setHanSuDung(defaultHanSuDung); // Đảm bảo cột HanSuDung không NULL
            
            // Các giá trị optional
            if (giaTriDonHangToiThieuStr != null && !giaTriDonHangToiThieuStr.trim().isEmpty()) {
                discount.setGiaTriDonHangToiThieu(new BigDecimal(giaTriDonHangToiThieuStr));
            }
            
            if (giaTriGiamToiDaStr != null && !giaTriGiamToiDaStr.trim().isEmpty()) {
                discount.setGiaTriGiamToiDa(new BigDecimal(giaTriGiamToiDaStr));
            }
            
            if (soLuongToiDaStr != null && !soLuongToiDaStr.trim().isEmpty()) {
                discount.setSoLuongToiDa(Integer.parseInt(soLuongToiDaStr));
            }
            
            // Xử lý ngày tháng
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            if (ngayBatDauStr != null && !ngayBatDauStr.trim().isEmpty()) {
                discount.setNgayBatDau(LocalDateTime.parse(ngayBatDauStr, formatter));
            }
            if (ngayKetThucStr != null && !ngayKetThucStr.trim().isEmpty()) {
                discount.setNgayKetThuc(LocalDateTime.parse(ngayKetThucStr, formatter));
            }
            
            // Lưu vào database
            boolean success = maGiamGiaDAO.save(discount);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?msg=CREATE_SUCCESS");
            } else {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts/create?error=CREATE_FAILED");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vendor/discounts/create?error=INVALID_DATA");
        }
    }
    
    // Phương thức cập nhật mã giảm giá
    private void updateDiscount(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=ID mã giảm giá không hợp lệ.");
                return;
            }
            
            int discountId = Integer.parseInt(idParam);
            MaGiamGia discount = maGiamGiaDAO.findById(discountId);
            
            if (discount == null || !discount.getCuaHang().getMaCH().equals(store.getMaCH())) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=Mã giảm giá không tồn tại hoặc không có quyền.");
                return;
            }
            
            // Cập nhật thông tin
            String tenChuongTrinh = request.getParameter("tenChuongTrinh");
            String moTa = request.getParameter("moTa");
            String loaiGiamStr = request.getParameter("loaiGiam");
            String giaTriGiamStr = request.getParameter("giaTriGiam");
            String giaTriDonHangToiThieuStr = request.getParameter("giaTriDonHangToiThieu");
            String giaTriGiamToiDaStr = request.getParameter("giaTriGiamToiDa");
            String ngayBatDauStr = request.getParameter("ngayBatDau");
            String ngayKetThucStr = request.getParameter("ngayKetThuc");
            String soLuongToiDaStr = request.getParameter("soLuongToiDa");
            String trangThaiStr = request.getParameter("trangThai");
            
            discount.setTenChuongTrinh(tenChuongTrinh.trim());
            discount.setMoTa(moTa != null ? moTa.trim() : "");
            discount.setLoaiGiam(MaGiamGia.LoaiGiam.valueOf(loaiGiamStr));
            discount.setGiaTriGiam(new BigDecimal(giaTriGiamStr));
            discount.setTrangThai("true".equals(trangThaiStr));
            
            // Các giá trị optional
            if (giaTriDonHangToiThieuStr != null && !giaTriDonHangToiThieuStr.trim().isEmpty()) {
                discount.setGiaTriDonHangToiThieu(new BigDecimal(giaTriDonHangToiThieuStr));
            } else {
                discount.setGiaTriDonHangToiThieu(null);
            }
            
            if (giaTriGiamToiDaStr != null && !giaTriGiamToiDaStr.trim().isEmpty()) {
                discount.setGiaTriGiamToiDa(new BigDecimal(giaTriGiamToiDaStr));
            } else {
                discount.setGiaTriGiamToiDa(null);
            }
            
            if (soLuongToiDaStr != null && !soLuongToiDaStr.trim().isEmpty()) {
                discount.setSoLuongToiDa(Integer.parseInt(soLuongToiDaStr));
            } else {
                discount.setSoLuongToiDa(null);
            }
            
            // Xử lý ngày tháng
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            if (ngayBatDauStr != null && !ngayBatDauStr.trim().isEmpty()) {
                discount.setNgayBatDau(LocalDateTime.parse(ngayBatDauStr, formatter));
            }
            if (ngayKetThucStr != null && !ngayKetThucStr.trim().isEmpty()) {
                discount.setNgayKetThuc(LocalDateTime.parse(ngayKetThucStr, formatter));
            }
            
            // Cập nhật vào database
            boolean success = maGiamGiaDAO.update(discount);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?msg=UPDATE_SUCCESS");
            } else {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts/edit?id=" + discountId + "&error=UPDATE_FAILED");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=INVALID_DATA");
        }
    }
    
    // Phương thức xóa mã giảm giá
    private void deleteDiscount(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=INVALID_ID");
            return;
        }
        
        try {
            int discountId = Integer.parseInt(idParam);
            MaGiamGia discount = maGiamGiaDAO.findById(discountId);
            
            if (discount == null || !discount.getCuaHang().getMaCH().equals(store.getMaCH())) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=NOT_FOUND");
                return;
            }
            
            // Sử dụng DiscountUtils để kiểm tra điều kiện xóa
            if (!DiscountUtils.canDelete(discount)) {
                String reason = DiscountUtils.getDeleteRestrictionReason(discount);
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=DELETE_RESTRICTED&reason=" + 
                    java.net.URLEncoder.encode(reason, "UTF-8"));
                return;
            }
            
            // Thực hiện xóa nếu đủ điều kiện
            boolean success = maGiamGiaDAO.delete(discountId);
            if (success) {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?msg=DELETE_SUCCESS");
            } else {
                response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=DELETE_FAILED");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=INVALID_ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vendor/discounts?error=DELETE_FAILED");
        }
    }
    
    // ===== PHẦN QUẢN LÝ ĐĐN HÀNG =====
    
    /**
     * Hiển thị danh sách đơn hàng của cửa hàng
     */
    private void showOrders(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        
        // 1. Lấy các tham số lọc và phân trang
        String statusParam = request.getParameter("status");
        DonHang.TrangThaiDonHang statusFilter = null;
        
        if (statusParam != null && !statusParam.isEmpty()) {
            try {
                statusFilter = DonHang.TrangThaiDonHang.valueOf(statusParam);
            } catch (IllegalArgumentException e) {
                // Ignore invalid status
            }
        }
        
        // Phân trang
        int page = 1;
        int pageSize = 20;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            // Sử dụng giá trị mặc định
        }
        
        try {
            // 2. Lấy danh sách đơn hàng
            List<DonHang> orders = donHangDAO.findByStoreWithPagination(store.getMaCH(), statusFilter, page, pageSize);
            long totalOrders = donHangDAO.countByStoreAndStatus(store.getMaCH(), statusFilter);
            
            // 3. Tính toán phân trang
            int totalPages = (int) Math.ceil((double) totalOrders / pageSize);
            
            // 4. Lấy thống kê đơn hàng theo trạng thái
            java.util.Map<DonHang.TrangThaiDonHang, Long> orderStats = donHangDAO.getOrderStatsByStore(store.getMaCH());
            
            // 5. Đặt attributes
            request.setAttribute("orders", orders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("statusFilter", statusFilter);
            request.setAttribute("orderStats", orderStats);
            request.setAttribute("pageTitle", "Quản lý Đơn hàng");
            
            // 6. Forward đến JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/orders.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vendor/dashboard?error=Co loi xay ra khi tai danh sach don hang.");
        }
    }
    
    /**
     * Hiển thị chi tiết đơn hàng
     */
    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/vendor/orders?error=ID don hang khong hop le.");
            return;
        }
        
        try {
            Integer orderId = Integer.parseInt(idParam);
            
            // Lấy chi tiết đơn hàng (chỉ của cửa hàng này)
            DonHang order = donHangDAO.findByIdAndStore(orderId, store.getMaCH());
            
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/vendor/orders?error=Don hang khong ton tai hoac khong co quyen.");
                return;
            }
            
            // Đặt attributes
            request.setAttribute("order", order);
            request.setAttribute("pageTitle", "Chi tiết Đơn hàng #" + orderId);
            
            // Forward đến JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/order-detail.jsp");
            dispatcher.forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/vendor/orders?error=ID don hang khong hop le.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vendor/orders?error=Co loi xay ra khi tai chi tiet don hang.");
        }
    }
    
    /**
     * Hiển thị báo cáo doanh thu theo ngày, tháng, năm
     */
    private void showRevenueReport(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        try {
            String type = request.getParameter("type");
            BigDecimal revenue = null;
            
            if (type != null && !type.isEmpty()) {
                switch (type) {
                    case "daily":
                        String dateStr = request.getParameter("date");
                        if (dateStr != null && !dateStr.isEmpty()) {
                            // Parse date string: yyyy-MM-dd
                            String[] dateParts = dateStr.split("-");
                            int year = Integer.parseInt(dateParts[0]);
                            int month = Integer.parseInt(dateParts[1]);
                            int day = Integer.parseInt(dateParts[2]);
                            revenue = donHangDAO.getDailyRevenue(store.getMaCH(), day, month, year);
                        }
                        break;
                        
                    case "monthly":
                        String monthStr = request.getParameter("month");
                        String yearStr = request.getParameter("year");
                        if (monthStr != null && yearStr != null) {
                            int month = Integer.parseInt(monthStr);
                            int year = Integer.parseInt(yearStr);
                            revenue = donHangDAO.getMonthlyRevenue(store.getMaCH(), month, year);
                        }
                        break;
                        
                    case "yearly":
                        String yearOnlyStr = request.getParameter("year");
                        if (yearOnlyStr != null) {
                            int year = Integer.parseInt(yearOnlyStr);
                            revenue = donHangDAO.getYearlyRevenue(store.getMaCH(), year);
                        }
                        break;
                }
            }
            
            // Set attributes
            if (revenue != null) {
                request.setAttribute("revenue", revenue);
            }
            request.setAttribute("now", new java.util.Date());
            request.setAttribute("pageTitle", "Báo cáo Doanh thu");
            
            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/revenue-report.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải báo cáo doanh thu: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/revenue-report.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    /**
     * Hiển thị trang thống kê và báo cáo chi tiết
     */
    private void showStatistics(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        try {
            // Lấy ngày tháng năm hiện tại
            java.time.LocalDate now = java.time.LocalDate.now();
            int currentDay = now.getDayOfMonth();
            int currentMonth = now.getMonthValue();
            int currentYear = now.getYear();
            
            // Thống kê doanh thu
            BigDecimal dailyRevenue = donHangDAO.getDailyRevenue(store.getMaCH(), currentDay, currentMonth, currentYear);
            BigDecimal monthlyRevenue = donHangDAO.getMonthlyRevenue(store.getMaCH(), currentMonth, currentYear);
            BigDecimal yearlyRevenue = donHangDAO.getYearlyRevenue(store.getMaCH(), currentYear);
            
            // Doanh thu 7 ngày gần nhất
            List<Object[]> last7DaysRevenue = donHangDAO.getLast7DaysRevenue(store.getMaCH());
            
            // Doanh thu 12 tháng gần nhất
            List<Object[]> last12MonthsRevenue = donHangDAO.getLast12MonthsRevenue(store.getMaCH());
            
            // Thống kê đơn hàng
            long newOrdersCount = donHangDAO.countNewOrders(store.getMaCH());
            long totalOrders = donHangDAO.countByStoreAndStatus(store.getMaCH(), null);
            java.util.Map<DonHang.TrangThaiDonHang, Long> orderStats = donHangDAO.getOrderStatsByStore(store.getMaCH());
            
            // Thống kê sản phẩm
            int totalProducts = sanPhamDAO.countByCuaHangId(store.getMaCH());
            int activeProducts = sanPhamDAO.countByCuaHangIdWithFilter(store.getMaCH(), null, "true");
            int inactiveProducts = sanPhamDAO.countByCuaHangIdWithFilter(store.getMaCH(), null, "false");
            
            // Top 10 sản phẩm bán chạy nhất
            List<Object[]> topSellingProducts = sanPhamDAO.findTopSellingWithQuantityByStore(store.getMaCH(), 10);
            
            // Thống kê mã giảm giá
            int totalDiscounts = maGiamGiaDAO.countByCuaHangId(store.getMaCH());
            int activeDiscounts = maGiamGiaDAO.getActiveDiscountsByStore(store.getMaCH()).size();
            
            // Set attributes
            request.setAttribute("dailyRevenue", dailyRevenue);
            request.setAttribute("monthlyRevenue", monthlyRevenue);
            request.setAttribute("yearlyRevenue", yearlyRevenue);
            request.setAttribute("last7DaysRevenue", last7DaysRevenue);
            request.setAttribute("last12MonthsRevenue", last12MonthsRevenue);
            
            request.setAttribute("newOrdersCount", newOrdersCount);
            request.setAttribute("totalOrders", totalOrders);
            request.setAttribute("orderStats", orderStats);
            
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("activeProducts", activeProducts);
            request.setAttribute("inactiveProducts", inactiveProducts);
            request.setAttribute("topSellingProducts", topSellingProducts);
            
            request.setAttribute("totalDiscounts", totalDiscounts);
            request.setAttribute("activeDiscounts", activeDiscounts);
            
            request.setAttribute("currentDay", currentDay);
            request.setAttribute("currentMonth", currentMonth);
            request.setAttribute("currentYear", currentYear);
            request.setAttribute("now", new java.util.Date());
            
            request.setAttribute("pageTitle", "Thống kê & Báo cáo");
            
            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/statistics.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải thống kê: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/statistics.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    /**
     * Hiển thị trang cài đặt cửa hàng
     */
    private void showSettings(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        try {
            // Set attributes
            request.setAttribute("pageTitle", "Cài đặt Cửa hàng");
            
            // Forward to JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/settings.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải cài đặt: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/settings.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    /**
     * Cập nhật thông tin cửa hàng
     */
    private void updateStoreSettings(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String tenCH = request.getParameter("tenCH");
            String diaChi = request.getParameter("diaChi");
            String soDienThoai = request.getParameter("soDienThoai");
            String email = request.getParameter("email");
            String moTa = request.getParameter("moTa");
            
            // Validation
            if (tenCH == null || tenCH.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/vendor/settings?error=Tên cửa hàng không được để trống");
                return;
            }
            
            // Cập nhật thông tin
            store.setTenCH(tenCH.trim());
            
            if (diaChi != null && !diaChi.trim().isEmpty()) {
                store.setDiaChi(diaChi.trim());
            }
            
            if (soDienThoai != null && !soDienThoai.trim().isEmpty()) {
                store.setSoDienThoai(soDienThoai.trim());
            }
            
            if (email != null && !email.trim().isEmpty()) {
                store.setEmail(email.trim());
            }
            
            if (moTa != null) {
                store.setMoTa(moTa.trim());
            }
            
            // Cập nhật vào database
            boolean success = cuaHangDAO.update(store);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/vendor/settings?success=Cập nhật thông tin cửa hàng thành công");
            } else {
                response.sendRedirect(request.getContextPath() + "/vendor/settings?error=Có lỗi xảy ra khi cập nhật");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vendor/settings?error=Dữ liệu không hợp lệ: " + e.getMessage());
        }
    }
    
    /**
     * Cập nhật trạng thái đơn hàng
     */
    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        
        String orderIdParam = request.getParameter("orderId");
        String newStatusParam = request.getParameter("newStatus");
        
        if (orderIdParam == null || orderIdParam.trim().isEmpty() || 
            newStatusParam == null || newStatusParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/vendor/orders?error=Thong tin cap nhat khong hop le.");
            return;
        }
        
        try {
            Integer orderId = Integer.parseInt(orderIdParam);
            DonHang.TrangThaiDonHang newStatus = DonHang.TrangThaiDonHang.valueOf(newStatusParam);
            
            // Kiểm tra quyền và cập nhật trạng thái
            boolean success = donHangDAO.updateOrderStatusByStore(orderId, store.getMaCH(), newStatus);
            
            if (success) {
                String successMsg = "Cap nhat trang thai don hang thanh cong: " + getStatusDisplayName(newStatus);
                response.sendRedirect(request.getContextPath() + "/vendor/orders/detail?id=" + orderId + "&msg=" + 
                    java.net.URLEncoder.encode(successMsg, "UTF-8"));
            } else {
                response.sendRedirect(request.getContextPath() + "/vendor/orders?error=Khong the cap nhat trang thai don hang.");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/vendor/orders?error=ID don hang khong hop le.");
        } catch (IllegalArgumentException e) {
            response.sendRedirect(request.getContextPath() + "/vendor/orders?error=Trang thai khong hop le.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/vendor/orders?error=Co loi xay ra khi cap nhat trang thai.");
        }
    }
    
    /**
     * Lấy tên hiển thị của trạng thái đơn hàng
     */
    private String getStatusDisplayName(DonHang.TrangThaiDonHang status) {
        switch (status) {
            case DON_HANG_MOI: return "Đơn hàng mới";
            case DA_XAC_NHAN: return "Đã xác nhận";
            case DANG_GIAO: return "Đang giao";
            case DA_GIAO: return "Đã giao";
            case DA_HUY: return "Đã hủy";
            case TRA_HANG: return "Trả hàng";
            case HOAN_TIEN: return "Hoàn tiền";
            case DANG_XU_LY: return "Đang xử lý";
            case CHO_XAC_NHAN: return "Chờ xác nhận";
            default: return status.toString();
        }
    }
}
