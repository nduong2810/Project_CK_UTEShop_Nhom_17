package com.uteshop.controller.user;

import com.uteshop.dao.*;
import com.uteshop.entity.*;
import com.uteshop.utils.DiscountUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet(urlPatterns = {"/user/checkout", "/user/checkout/apply-discount", "/user/checkout/place-order"})
public class CheckoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private GioHangDAO gioHangDAO = new GioHangDAO();
    private DiaChiGiaoHangDAO diaChiDAO = new DiaChiGiaoHangDAO();
    private MaGiamGiaDAO maGiamGiaDAO = new MaGiamGiaDAO();
    private DonHangDAO donHangDAO = new DonHangDAO();
    private CuaHangDAO cuaHangDAO = new CuaHangDAO();
    private SanPhamDAO sanPhamDAO = new SanPhamDAO();

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
        
        System.out.println("[DEBUG] CheckoutController.doGet - path: " + path + ", userId: " + user.getMaND());
        
        if (path.equals("/user/checkout")) {
            showCheckoutPage(request, response, user);
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
        
        System.out.println("[DEBUG] CheckoutController.doPost - path: " + path + ", userId: " + user.getMaND());
        
        try {
            // Handle POST to /user/checkout (from cart page)
            if (path.equals("/user/checkout")) {
                showCheckoutPage(request, response, user);
            } else if (path.equals("/user/checkout/apply-discount")) {
                applyDiscount(request, response, user);
            } else if (path.equals("/user/checkout/place-order")) {
                placeOrder(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            showCheckoutPage(request, response, user);
        }
    }
    
    private void showCheckoutPage(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        System.out.println("[DEBUG] showCheckoutPage - Start for userId: " + user.getMaND());
        
        // Lấy giỏ hàng
        List<ChiTietGioHang> cartItems = gioHangDAO.getCartItems(user.getMaND());
        
        System.out.println("[DEBUG] showCheckoutPage - Cart items count: " + (cartItems != null ? cartItems.size() : 0));
        
        if (cartItems == null || cartItems.isEmpty()) {
            System.out.println("[DEBUG] showCheckoutPage - Cart is empty, redirecting to cart");
            response.sendRedirect(request.getContextPath() + "/user/cart");
            return;
        }
        
        // Nhóm sản phẩm theo cửa hàng
        Map<CuaHang, List<ChiTietGioHang>> itemsByStore = groupItemsByStore(cartItems);
        
        // Lấy danh sách mã giảm giá đang hoạt động của từng cửa hàng
        Map<Integer, List<MaGiamGia>> storeDiscounts = new HashMap<>();
        for (CuaHang store : itemsByStore.keySet()) {
            List<MaGiamGia> discounts = maGiamGiaDAO.getActiveDiscountsByStore(store.getMaCH());
            if (discounts != null && !discounts.isEmpty()) {
                storeDiscounts.put(store.getMaCH(), discounts);
            }
        }
        
        // Lấy địa chỉ giao hàng
        List<DiaChiGiaoHang> addresses = diaChiDAO.getAddressesByUser(user.getMaND());
        DiaChiGiaoHang defaultAddress = diaChiDAO.getDefaultAddress(user.getMaND());
        
        // Tính tổng tiền
        BigDecimal subtotal = cartItems.stream()
            .map(ChiTietGioHang::getThanhTien)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal shippingFee = BigDecimal.valueOf(30000); // Phí ship cố định 30k
        BigDecimal totalAmount = subtotal.add(shippingFee);
        
        // Lấy thông tin discount từ session (nếu có)
        HttpSession session = request.getSession();
        MaGiamGia appliedDiscount = (MaGiamGia) session.getAttribute("appliedDiscount");
        BigDecimal discountAmount = (BigDecimal) session.getAttribute("discountAmount");
        
        if (appliedDiscount != null && discountAmount != null) {
            totalAmount = totalAmount.subtract(discountAmount);
        }
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("itemsByStore", itemsByStore);
        request.setAttribute("storeDiscounts", storeDiscounts);
        request.setAttribute("addresses", addresses);
        request.setAttribute("defaultAddress", defaultAddress);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shippingFee", shippingFee);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("appliedDiscount", appliedDiscount);
        request.setAttribute("discountAmount", discountAmount);
        
        System.out.println("[DEBUG] showCheckoutPage - Forwarding to checkout.jsp");
        System.out.println("[DEBUG] showCheckoutPage - Addresses count: " + (addresses != null ? addresses.size() : 0));
        System.out.println("[DEBUG] showCheckoutPage - Subtotal: " + subtotal);
        System.out.println("[DEBUG] showCheckoutPage - Total: " + totalAmount);
        
        request.getRequestDispatcher("/WEB-INF/views/user/checkout.jsp").forward(request, response);
    }
    
    private void applyDiscount(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        String discountCode = request.getParameter("discountCode");
        
        if (discountCode == null || discountCode.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập mã giảm giá");
            showCheckoutPage(request, response, user);
            return;
        }
        
        // Tìm mã giảm giá
        MaGiamGia discount = maGiamGiaDAO.findByCode(discountCode.trim());
        
        if (discount == null) {
            request.setAttribute("error", "Mã giảm giá không tồn tại");
            showCheckoutPage(request, response, user);
            return;
        }
        
        // Kiểm tra mã có còn hiệu lực không
        if (!DiscountUtils.isActive(discount)) {
            request.setAttribute("error", "Mã giảm giá đã hết hiệu lực hoặc đã hết lượt sử dụng");
            showCheckoutPage(request, response, user);
            return;
        }
        
        // Lấy giỏ hàng và tính tổng
        List<ChiTietGioHang> cartItems = gioHangDAO.getCartItems(user.getMaND());
        BigDecimal subtotal = cartItems.stream()
            .map(ChiTietGioHang::getThanhTien)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        BigDecimal shippingFee = BigDecimal.valueOf(30000);
        BigDecimal totalBeforeDiscount = subtotal.add(shippingFee);
        
        // Kiểm tra giá trị đơn hàng tối thiểu
        if (discount.getGiaTriDonHangToiThieu() != null && 
            subtotal.compareTo(discount.getGiaTriDonHangToiThieu()) < 0) {
            request.setAttribute("error", 
                String.format("Đơn hàng tối thiểu %,d₫ để áp dụng mã này", 
                    discount.getGiaTriDonHangToiThieu().longValue()));
            showCheckoutPage(request, response, user);
            return;
        }
        
        // Tính số tiền giảm
        BigDecimal discountAmount = calculateDiscountAmount(discount, subtotal);
        
        // Lưu vào session
        HttpSession session = request.getSession();
        session.setAttribute("appliedDiscount", discount);
        session.setAttribute("discountAmount", discountAmount);
        
        request.setAttribute("success", 
            String.format("Đã áp dụng mã giảm giá. Bạn được giảm %,d₫", discountAmount.longValue()));
        
        showCheckoutPage(request, response, user);
    }
    
    private void placeOrder(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        
        // Lấy thông tin từ form
        String addressIdStr = request.getParameter("addressId");
        String paymentMethod = request.getParameter("paymentMethod");
        String note = request.getParameter("note");
        
        // Validate
        if (addressIdStr == null || addressIdStr.isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn địa chỉ giao hàng");
            showCheckoutPage(request, response, user);
            return;
        }
        
        if (paymentMethod == null || paymentMethod.isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn phương thức thanh toán");
            showCheckoutPage(request, response, user);
            return;
        }
        
        int addressId = Integer.parseInt(addressIdStr);
        DiaChiGiaoHang address = diaChiDAO.findById(addressId);
        
        if (address == null || address.getNguoiDung().getMaND() != user.getMaND()) {
            request.setAttribute("error", "Địa chỉ không hợp lệ");
            showCheckoutPage(request, response, user);
            return;
        }
        
        // Lấy giỏ hàng
        List<ChiTietGioHang> cartItems = gioHangDAO.getCartItems(user.getMaND());
        
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/cart");
            return;
        }
        
        // Nhóm theo cửa hàng và tạo đơn hàng cho mỗi cửa hàng
        Map<CuaHang, List<ChiTietGioHang>> itemsByStore = groupItemsByStore(cartItems);
        
        HttpSession session = request.getSession();
        MaGiamGia appliedDiscount = (MaGiamGia) session.getAttribute("appliedDiscount");
        BigDecimal totalDiscountAmount = (BigDecimal) session.getAttribute("discountAmount");
        
        List<Integer> orderIds = new ArrayList<>();
        
        for (Map.Entry<CuaHang, List<ChiTietGioHang>> entry : itemsByStore.entrySet()) {
            CuaHang store = entry.getKey();
            List<ChiTietGioHang> storeItems = entry.getValue();
            
            // Tính tổng cho từng cửa hàng
            BigDecimal storeSubtotal = storeItems.stream()
                .map(ChiTietGioHang::getThanhTien)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            BigDecimal storeShipping = BigDecimal.valueOf(30000);
            
            // Phân bổ discount theo tỷ lệ nếu có
            BigDecimal storeDiscount = BigDecimal.ZERO;
            if (appliedDiscount != null && totalDiscountAmount != null) {
                BigDecimal totalCartValue = cartItems.stream()
                    .map(ChiTietGioHang::getThanhTien)
                    .reduce(BigDecimal.ZERO, BigDecimal::add);
                
                // Tính tỷ lệ của cửa hàng này trong tổng giỏ hàng
                BigDecimal ratio = storeSubtotal.divide(totalCartValue, 4, BigDecimal.ROUND_HALF_UP);
                storeDiscount = totalDiscountAmount.multiply(ratio).setScale(0, BigDecimal.ROUND_HALF_UP);
            }
            
            BigDecimal storeTotal = storeSubtotal.add(storeShipping).subtract(storeDiscount);
            
            // Tạo đơn hàng
            DonHang order = new DonHang();
            order.setNguoiDung(user);
            order.setNgayDat(new Date());
            order.setTongTien(storeSubtotal);
            order.setTienGiam(storeDiscount);
            order.setPhiVanChuyen(storeShipping);
            order.setTongThanhToan(storeTotal);
            order.setTrangThai(DonHang.TrangThaiDonHang.CHO_XAC_NHAN);
            
            // Set phương thức thanh toán
            switch (paymentMethod) {
                case "COD":
                    order.setPhuongThucThanhToan(DonHang.PhuongThucThanhToan.COD);
                    break;
                case "BANK_TRANSFER":
                    order.setPhuongThucThanhToan(DonHang.PhuongThucThanhToan.BANK_TRANSFER);
                    break;
                case "MOMO":
                    order.setPhuongThucThanhToan(DonHang.PhuongThucThanhToan.MOMO);
                    break;
                default:
                    order.setPhuongThucThanhToan(DonHang.PhuongThucThanhToan.COD);
            }
            
            // Địa chỉ giao hàng
            String fullAddress = String.format("%s, %s, %s, %s", 
                address.getDiaChiCuThe(), address.getPhuong(), address.getQuan(), address.getThanhPho());
            order.setDiaChiGiaoHang(fullAddress);
            order.setTenNguoiNhan(address.getTenNguoiNhan());
            order.setSoDienThoaiNhanHang(address.getSoDienThoai());
            order.setGhiChu(note);
            
            // Tạo chi tiết đơn hàng
            List<ChiTietDonHang> orderDetails = new ArrayList<>();
            for (ChiTietGioHang cartItem : storeItems) {
                ChiTietDonHang detail = new ChiTietDonHang();
                detail.setDonHang(order);
                detail.setSanPham(cartItem.getSanPham());
                detail.setSoLuong(cartItem.getSoLuong());
                detail.setDonGia(cartItem.getSanPham().getDonGia());
                orderDetails.add(detail);
            }
            order.setChiTietDonHangs(orderDetails);
            
            // Lưu đơn hàng vào DB
            boolean success = donHangDAO.insert(order);
            
            if (success) {
                orderIds.add(order.getMaDH());
                
                // Xóa các sản phẩm của cửa hàng này khỏi giỏ hàng
                for (ChiTietGioHang item : storeItems) {
                    gioHangDAO.removeFromCart(user.getMaND(), item.getSanPham().getMaSP());
                }
            }
        }
        
        // Cập nhật số lượng sử dụng mã giảm giá
        if (appliedDiscount != null) {
            maGiamGiaDAO.incrementUsageCount(appliedDiscount.getMaGG());
        }
        
        // Xóa discount khỏi session
        session.removeAttribute("appliedDiscount");
        session.removeAttribute("discountAmount");
        
        // Redirect đến trang xác nhận
        if (!orderIds.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/orders?success=1");
        } else {
            request.setAttribute("error", "Không thể tạo đơn hàng. Vui lòng thử lại!");
            showCheckoutPage(request, response, user);
        }
    }
    
    private Map<CuaHang, List<ChiTietGioHang>> groupItemsByStore(List<ChiTietGioHang> cartItems) {
        Map<CuaHang, List<ChiTietGioHang>> result = new LinkedHashMap<>();
        
        for (ChiTietGioHang item : cartItems) {
            CuaHang store = item.getSanPham().getCuaHang();
            
            if (!result.containsKey(store)) {
                result.put(store, new ArrayList<>());
            }
            
            result.get(store).add(item);
        }
        
        return result;
    }
    
    private BigDecimal calculateDiscountAmount(MaGiamGia discount, BigDecimal orderValue) {
        BigDecimal discountAmount = BigDecimal.ZERO;
        
        if (discount.getLoaiGiam() == MaGiamGia.LoaiGiam.PERCENT || 
            discount.getLoaiGiam() == MaGiamGia.LoaiGiam.percent) {
            // Giảm theo %
            discountAmount = orderValue.multiply(discount.getGiaTriGiam())
                .divide(BigDecimal.valueOf(100), 0, BigDecimal.ROUND_HALF_UP);
            
            // Kiểm tra giá trị giảm tối đa
            if (discount.getGiaTriGiamToiDa() != null && 
                discountAmount.compareTo(discount.getGiaTriGiamToiDa()) > 0) {
                discountAmount = discount.getGiaTriGiamToiDa();
            }
        } else {
            // Giảm cố định
            discountAmount = discount.getGiaTriGiam();
        }
        
        // Không được giảm quá tổng giá trị đơn hàng
        if (discountAmount.compareTo(orderValue) > 0) {
            discountAmount = orderValue;
        }
        
        return discountAmount;
    }
}
