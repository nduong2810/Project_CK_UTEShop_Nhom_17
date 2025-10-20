package com.uteshop.controller.admin;

import com.uteshop.dao.SanPhamDAO;
import com.uteshop.dao.DanhMucDAO;
import com.uteshop.dao.CuaHangDAO;
import com.uteshop.entity.SanPham;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.CuaHang;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/products", "/admin/products/add", "/admin/products/edit", "/admin/products/delete"})
@MultipartConfig
public class AdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final DanhMucDAO danhMucDAO = new DanhMucDAO();
    private final CuaHangDAO cuaHangDAO = new CuaHangDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/admin/products":
                listProducts(request, response);
                break;
            case "/admin/products/add":
                showAddForm(request, response);
                break;
            case "/admin/products/edit":
                showEditForm(request, response);
                break;
            case "/admin/products/delete":
                deleteProduct(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        
        switch (path) {
            case "/admin/products/add":
                addProduct(request, response);
                break;
            case "/admin/products/edit":
                editProduct(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }
    
    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get pagination parameters
            String pageParam = request.getParameter("page");
            String sizeParam = request.getParameter("size");
            
            int page = 0;
            int size = 10;
            
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam) - 1; // Convert to 0-based
                    if (page < 0) page = 0;
                } catch (NumberFormatException e) {
                    page = 0;
                }
            }
            
            if (sizeParam != null && !sizeParam.isEmpty()) {
                try {
                    size = Integer.parseInt(sizeParam);
                    if (size < 1) size = 10;
                    if (size > 50) size = 50;
                } catch (NumberFormatException e) {
                    size = 10;
                }
            }
            
            List<SanPham> products = sanPhamDAO.findAll(page, size);
            long totalProducts = sanPhamDAO.countProducts();
            
            request.setAttribute("products", products);
            request.setAttribute("currentPage", page + 1);
            request.setAttribute("pageSize", size);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalPages", (int) Math.ceil((double) totalProducts / size));
            
            request.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải danh sách sản phẩm: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/views/admin/product-list.jsp").forward(request, response);
        }
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Load categories and stores for dropdown
            List<DanhMuc> categories = danhMucDAO.findAll();
            List<CuaHang> stores = cuaHangDAO.findAll();
            
            request.setAttribute("categories", categories);
            request.setAttribute("stores", stores);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/product-add.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải form thêm sản phẩm: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }
    
    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get form parameters
            String tenSP = request.getParameter("tenSP");
            String moTa = request.getParameter("moTa");
            String donGiaStr = request.getParameter("donGia");
            String soLuongTonStr = request.getParameter("soLuongTon");
            String hinhAnh = request.getParameter("hinhAnh");
            String maDMStr = request.getParameter("maDM");
            String maCHStr = request.getParameter("maCH");
            
            // Validate required fields
            if (tenSP == null || tenSP.trim().isEmpty()) {
                request.setAttribute("error", "Tên sản phẩm không được để trống");
                showAddForm(request, response);
                return;
            }
            
            if (donGiaStr == null || donGiaStr.trim().isEmpty()) {
                request.setAttribute("error", "Đơn giá không được để trống");
                showAddForm(request, response);
                return;
            }
            
            // Parse numeric values
            BigDecimal donGia = new BigDecimal(donGiaStr);
            int soLuongTon = soLuongTonStr != null && !soLuongTonStr.isEmpty() ? 
                           Integer.parseInt(soLuongTonStr) : 0;
            int maDM = maDMStr != null && !maDMStr.isEmpty() ? 
                      Integer.parseInt(maDMStr) : 1; // Default category
            int maCH = maCHStr != null && !maCHStr.isEmpty() ? 
                      Integer.parseInt(maCHStr) : 1; // Default store
            
            // Create new product
            SanPham sanPham = new SanPham();
            sanPham.setTenSP(tenSP.trim());
            sanPham.setMoTa(moTa != null ? moTa.trim() : "");
            sanPham.setDonGia(donGia);
            sanPham.setSoLuongTon(soLuongTon);
            sanPham.setSoLuongBan(0);
            sanPham.setHinhAnh(hinhAnh != null && !hinhAnh.trim().isEmpty() ? 
                              hinhAnh.trim() : "default-product.jpg");
            sanPham.setNgayTao(new java.util.Date()); // Convert LocalDateTime to Date
            sanPham.setTrangThai(true); // Convert boolean to Integer
            
            // Set relationships
            DanhMuc danhMuc = danhMucDAO.findById(maDM);
            CuaHang cuaHang = cuaHangDAO.findById(maCH);
            
            if (danhMuc != null) {
                sanPham.setDanhMuc(danhMuc);
            }
            if (cuaHang != null) {
                sanPham.setCuaHang(cuaHang);
            }
            
            // Save product
            if (sanPhamDAO.save(sanPham)) {
                request.setAttribute("success", "Thêm sản phẩm thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/products?success=1");
            } else {
                request.setAttribute("error", "Không thể thêm sản phẩm. Vui lòng thử lại.");
                showAddForm(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Định dạng số không hợp lệ. Vui lòng kiểm tra lại.");
            showAddForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            showAddForm(request, response);
        }
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            int productId = Integer.parseInt(idStr);
            SanPham product = sanPhamDAO.findById(productId);
            
            if (product == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            // Load categories and stores for dropdown
            List<DanhMuc> categories = danhMucDAO.findAll();
            List<CuaHang> stores = cuaHangDAO.findAll();
            
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.setAttribute("stores", stores);
            
            request.getRequestDispatcher("/WEB-INF/views/admin/product-edit.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/products");
        }
    }
    
    private void editProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            int productId = Integer.parseInt(idStr);
            SanPham sanPham = sanPhamDAO.findById(productId);
            
            if (sanPham == null) {
                request.setAttribute("error", "Không tìm thấy sản phẩm");
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            // Update product fields
            String tenSP = request.getParameter("tenSP");
            String moTa = request.getParameter("moTa");
            String donGiaStr = request.getParameter("donGia");
            String soLuongTonStr = request.getParameter("soLuongTon");
            String hinhAnh = request.getParameter("hinhAnh");
            String maDMStr = request.getParameter("maDM");
            String maCHStr = request.getParameter("maCH");
            
            if (tenSP != null && !tenSP.trim().isEmpty()) {
                sanPham.setTenSP(tenSP.trim());
            }
            if (moTa != null) {
                sanPham.setMoTa(moTa.trim());
            }
            if (donGiaStr != null && !donGiaStr.trim().isEmpty()) {
                sanPham.setDonGia(new BigDecimal(donGiaStr));
            }
            if (soLuongTonStr != null && !soLuongTonStr.trim().isEmpty()) {
                sanPham.setSoLuongTon(Integer.parseInt(soLuongTonStr));
            }
            if (hinhAnh != null && !hinhAnh.trim().isEmpty()) {
                sanPham.setHinhAnh(hinhAnh.trim());
            }
            
            // Update relationships
            if (maDMStr != null && !maDMStr.trim().isEmpty()) {
                DanhMuc danhMuc = danhMucDAO.findById(Integer.parseInt(maDMStr));
                if (danhMuc != null) {
                    sanPham.setDanhMuc(danhMuc);
                }
            }
            if (maCHStr != null && !maCHStr.trim().isEmpty()) {
                CuaHang cuaHang = cuaHangDAO.findById(Integer.parseInt(maCHStr));
                if (cuaHang != null) {
                    sanPham.setCuaHang(cuaHang);
                }
            }
            
            // Update product
            if (sanPhamDAO.update(sanPham)) {
                response.sendRedirect(request.getContextPath() + "/admin/products?updated=1");
            } else {
                request.setAttribute("error", "Không thể cập nhật sản phẩm");
                showEditForm(request, response);
            }
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Định dạng số không hợp lệ");
            showEditForm(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            showEditForm(request, response);
        }
    }
    
    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }
            
            int productId = Integer.parseInt(idStr);
            
            if (sanPhamDAO.delete(productId)) {
                response.sendRedirect(request.getContextPath() + "/admin/products?deleted=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/products?error=delete");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/products?error=invalid_id");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/products?error=system");
        }
    }
}
