package com.uteshop.controller.vendor;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(urlPatterns = {"/vendor/dashboard", "/vendor/products"})
public class VendorController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Khai báo DAO
    private final CuaHangDAO cuaHangDAO = new CuaHangDAO();
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

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
        
        // Lấy action: Sử dụng ServletPath và lấy phần cuối cùng (vd: /dashboard)
        String action = request.getServletPath();
        String path = action.substring(action.lastIndexOf('/')); // Lấy /dashboard hoặc /products
        
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
            default:
                showDashboard(request, response, user);
                break;
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response, NguoiDung user)
            throws ServletException, IOException {
        // CuaHang store đã được đặt trong request ở doGet()
        request.setAttribute("pageTitle", "Vendor Dashboard");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/dashboard.jsp");
        dispatcher.forward(request, response);
    }
    
    /**
     * Phương thức tải danh sách sản phẩm và forward đến products.jsp
     */
    private void showProducts(HttpServletRequest request, HttpServletResponse response, NguoiDung user, CuaHang store)
            throws ServletException, IOException {
        // 1. Lấy danh sách Sản phẩm
        List<SanPham> products;
        try {
            products = sanPhamDAO.findByCuaHangId(store.getMaCH());
            if (products == null) {
                products = List.of(); // Gán danh sách rỗng nếu null
            }
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải danh sách sản phẩm: " + e.getMessage());
            products = List.of(); // Gán danh sách rỗng khi có lỗi
            e.printStackTrace();
        }
        
        // 2. Đặt dữ liệu vào Request
        request.setAttribute("products", products); 
        
        // 3. Chuyển tiếp đến JSP
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
        } else {
            doGet(request, response); // Xử lý các POST khác bằng doGet
        }
    }
}