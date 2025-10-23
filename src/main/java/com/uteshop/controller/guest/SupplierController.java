package com.uteshop.controller.guest;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.SanPham;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/guest/suppliers", "/guest/supplier/detail"})
public class SupplierController extends HttpServlet {
    private final CuaHangDAO cuaHangDAO = new CuaHangDAO();
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String path = request.getServletPath();
        String view = "/WEB-INF/views/guest/suppliers.jsp";
        
        try {
            switch (path) {
                case "/guest/suppliers":
                    // Hiển thị tất cả nhà cung cấp (đã sắp xếp theo doanh số)
                    handleAllSuppliers(request);
                    view = "/WEB-INF/views/guest/suppliers.jsp";
                    break;
                    
                case "/guest/supplier/detail":
                    // Hiển thị chi tiết nhà cung cấp và sản phẩm
                    handleSupplierDetail(request);
                    view = "/WEB-INF/views/guest/supplier-detail.jsp";
                    break;
                    
                default:
                    handleAllSuppliers(request);
                    break;
            }
        } catch (Exception e) {
            System.err.println("Error in SupplierController: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Không thể tải thông tin nhà cung cấp");
        }
        
        request.getRequestDispatcher(view).forward(request, response);
    }
    
    private void handleAllSuppliers(HttpServletRequest request) {
        try {
            // Lấy tất cả cửa hàng, đã được sắp xếp theo tổng số lượng bán
            List<CuaHang> suppliers = cuaHangDAO.findAll();
            
            request.setAttribute("suppliers", suppliers);
            request.setAttribute("pageTitle", "Danh sách nhà cung cấp");
            
            System.out.println("SupplierController: Loaded " + suppliers.size() + " suppliers");
            
        } catch (Exception e) {
            System.err.println("Error in handleAllSuppliers: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("suppliers", new ArrayList<>());
            request.setAttribute("errorMessage", "Không thể tải danh sách nhà cung cấp");
        }
    }
    
    private void handleSupplierDetail(HttpServletRequest request) {
        try {
            String supplierIdStr = request.getParameter("id");
            if (supplierIdStr == null || supplierIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Mã nhà cung cấp không hợp lệ");
                return;
            }
            
            int supplierId = Integer.parseInt(supplierIdStr);
            
            // Lấy thông tin cửa hàng
            CuaHang supplier = cuaHangDAO.findById(supplierId);
            if (supplier == null) {
                request.setAttribute("errorMessage", "Không tìm thấy nhà cung cấp");
                return;
            }
            
            // Lấy sản phẩm của cửa hàng
            List<SanPham> products = sanPhamDAO.findByStoreId(supplierId);
            
            request.setAttribute("supplier", supplier);
            request.setAttribute("products", products);
            request.setAttribute("totalProducts", products.size());
            request.setAttribute("pageTitle", "Chi tiết nhà cung cấp - " + supplier.getTenCH());
            
            System.out.println("SupplierController: Loaded supplier " + supplier.getTenCH() + " with " + products.size() + " products");
            
        } catch (NumberFormatException e) {
            System.err.println("Invalid supplier ID: " + e.getMessage());
            request.setAttribute("errorMessage", "Mã nhà cung cấp không hợp lệ");
        } catch (Exception e) {
            System.err.println("Error in handleSupplierDetail: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Không thể tải thông tin nhà cung cấp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}