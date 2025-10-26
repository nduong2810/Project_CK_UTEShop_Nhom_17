package com.uteshop.controller.vendor;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.DanhMuc; // Cần import DanhMuc
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List; // Cần import List
import java.util.Optional;

// Khai báo để cho phép Servlet xử lý dữ liệu multipart (upload file)
@WebServlet(urlPatterns = {"/vendor/product-crud"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProductCrudController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final SanPhamDAO sanPhamDAO = new SanPhamDAO();
    private final CuaHangDAO cuaHangDAO = new CuaHangDAO();

    // Định nghĩa đường dẫn lưu trữ file 
    private static final String UPLOAD_DIR = "uploads" + File.separator + "products";

    /**
     * Kiểm tra người dùng đã đăng nhập và có vai trò VENDOR hay không.
     */
    private NguoiDung checkAuth(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        NguoiDung user = (NguoiDung) Optional.ofNullable(session)
                .map(s -> (NguoiDung) s.getAttribute("user"))
                .orElse(null);
        
        // Sử dụng toString() và toUpperCase() để so sánh an toàn
        if (user == null || user.getVaiTro() == null || !user.getVaiTro().toString().toUpperCase().contains("VENDOR")) {
            return null;
        }
        return user;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        NguoiDung user = checkAuth(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        CuaHang store = cuaHangDAO.findByUserId(user.getMaND());
        if (store == null) {
            response.sendRedirect(request.getContextPath() + "/vendor/register-store");
            return;
        }
        
        request.setAttribute("store", store);
        
        // 1. THÊM LOGIC LẤY DANH MỤC VÀ ĐẨY VÀO REQUEST
        try {
            List<DanhMuc> categories = sanPhamDAO.listCategories();
            request.setAttribute("categories", categories);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải danh sách danh mục: " + e.getMessage());
            e.printStackTrace();
        }

        // Xử lý chế độ SỬA (Edit)
        String maSPParam = request.getParameter("id");
        if (maSPParam != null && !maSPParam.isEmpty() && request.getAttribute("product") == null) {
            try {
                Integer maSP = Integer.parseInt(maSPParam);
                SanPham product = sanPhamDAO.findById(maSP);

                // Kiểm tra quyền: Sản phẩm phải thuộc cửa hàng hiện tại
                if (product != null && product.getCuaHang().getMaCH().equals(store.getMaCH())) {
                    request.setAttribute("product", product);
                    request.setAttribute("pageTitle", "Chỉnh sửa Sản phẩm");
                } else {
                    response.sendRedirect(request.getContextPath() + "/vendor/products?error=Sản phẩm không tồn tại hoặc không thuộc quyền quản lý của bạn.");
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/vendor/products?error=ID sản phẩm không hợp lệ.");
                return;
            }
        } else if (request.getAttribute("product") == null) {
            request.setAttribute("pageTitle", "Thêm Sản phẩm mới");
        }
        
        request.getRequestDispatcher("/WEB-INF/views/vendor/product_crud_form.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        NguoiDung user = checkAuth(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        CuaHang store = cuaHangDAO.findByUserId(user.getMaND());
        if (store == null) {
             response.sendRedirect(request.getContextPath() + "/vendor/register-store");
            return;
        }
        
        // Bắt buộc phải có để xử lý tiếng Việt từ form
        request.setCharacterEncoding("UTF-8"); 

        String maSPParam = request.getParameter("maSP");
        SanPham product = new SanPham(); 
        
        // Cố gắng load sản phẩm hiện tại nếu là update
        boolean isUpdate = maSPParam != null && !maSPParam.isEmpty();
        if (isUpdate) {
            try {
                Integer maSP = Integer.parseInt(maSPParam);
                SanPham existingProduct = sanPhamDAO.findById(maSP);
                if (existingProduct != null && existingProduct.getCuaHang().getMaCH().equals(store.getMaCH())) {
                    product = existingProduct;
                } else {
                    response.sendRedirect(request.getContextPath() + "/vendor/products?error=Sản phẩm không tồn tại hoặc không có quyền.");
                    return;
                }
            } catch (NumberFormatException e) {
                 response.sendRedirect(request.getContextPath() + "/vendor/products?error=ID sản phẩm không hợp lệ.");
                 return;
            }
        } else {
            product.setCuaHang(store); 
            product.setTrangThai(true); 
        }
        
        // Khởi tạo các biến để sử dụng trong repopulateForm nếu lỗi xảy ra
        String tenSP = request.getParameter("tenSP");
        String moTa = request.getParameter("moTa");
        String giaStr = request.getParameter("gia"); 
        String soLuongStr = request.getParameter("soLuong");
        String maDMStr = request.getParameter("maDM"); // <-- ĐỌC THÊM THAM SỐ DANH MỤC

        // Bắt đầu khối TRY chính để xử lý dữ liệu và upload file
        try {
            
            // 2. Lấy dữ liệu Text & Bắt lỗi NumberFormat
            if (tenSP == null || tenSP.trim().isEmpty() || giaStr == null || soLuongStr == null || maDMStr == null || maDMStr.isEmpty()) {
                 throw new IllegalArgumentException("Vui lòng điền đầy đủ Tên, Giá, Số lượng và chọn Danh mục.");
            }

            product.setTenSP(tenSP);
            product.setMoTa(moTa);
            product.setDonGia(new BigDecimal(giaStr)); 
            product.setSoLuongTon(Integer.valueOf(soLuongStr)); 

            // 3. THÊM LOGIC GÁN DANH MỤC
            Integer maDM = Integer.parseInt(maDMStr);
            // Tạo Entity DanhMuc tạm thời chỉ với maDM để DAO có thể tìm và gán Entity Managed
            DanhMuc dm = new DanhMuc();
            dm.setMaDM(maDM);
            product.setDanhMuc(dm); 


            // 4. Xử lý Upload File (Ảnh)
            Part filePart = request.getPart("anhMinhHoa");
            String fileName = filePart.getSubmittedFileName();
            
            // Sửa lỗi setHinhAnh: Đảm bảo chỉ cập nhật khi có file mới
            if (fileName != null && !fileName.isEmpty()) {
                String applicationPath = request.getServletContext().getRealPath("");
                String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
                
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                String savedFileName = System.currentTimeMillis() + "_" + fileName;
                filePart.write(uploadPath + File.separator + savedFileName);
                
                // Fix: Sử dụng setHinhAnh
                product.setHinhAnh(UPLOAD_DIR + File.separator + savedFileName);
                
            } else if (!isUpdate && (product.getHinhAnh() == null || product.getHinhAnh().isEmpty())) {
                // Nếu là thêm mới VÀ không có file HinhAnh cũ, bắt buộc chọn file mới.
                throw new IllegalArgumentException("Vui lòng chọn ảnh minh họa cho sản phẩm mới.");
            }
            
            // 5. Lưu vào DB
            boolean success;
            if (isUpdate) {
                success = sanPhamDAO.update(product);
            } else {
                success = sanPhamDAO.insert(product);
            }
            
            if (success) {
                String msg = isUpdate ? "Cập nhật sản phẩm thành công!" : "Thêm sản phẩm thành công!";
                response.sendRedirect(request.getContextPath() + "/vendor/products?msg=" + msg);
            } else {
                request.setAttribute("error", "Lỗi hệ thống khi lưu sản phẩm (DAO trả về false). Vui lòng kiểm tra log DAO.");
                // Repopulate form với dữ liệu đã nhập (bao gồm Danh mục)
                repopulateForm(request, product, tenSP, moTa, giaStr, soLuongStr, maDMStr);
                doGet(request, response);
            }
            
        // Bắt các lỗi chuyển đổi dữ liệu và I/O
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi định dạng số: ID Danh mục, Giá hoặc Số lượng phải là số hợp lệ.");
            // Repopulate với dữ liệu text đã lấy được
            repopulateForm(request, product, tenSP, moTa, giaStr, soLuongStr, maDMStr); 
            doGet(request, response); 
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi dữ liệu: " + e.getMessage());
            repopulateForm(request, product, tenSP, moTa, giaStr, soLuongStr, maDMStr); 
            doGet(request, response); 
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi không xác định trong quá trình xử lý form/upload file: " + e.getMessage());
            repopulateForm(request, product, tenSP, moTa, giaStr, soLuongStr, maDMStr); 
            doGet(request, response);
        }
    }

    /**
     * Phương thức hỗ trợ điền lại dữ liệu form sau khi gặp lỗi.
     * Cập nhật product entity với dữ liệu từ request để JSP hiển thị lại.
     */
    private void repopulateForm(HttpServletRequest request, SanPham product, 
                                String tenSP, String moTa, String giaStr, 
                                String soLuongStr, String maDMStr) {
        
        // Gán lại dữ liệu TEXT đã nhập
        product.setTenSP(tenSP);
        product.setMoTa(moTa);
        
        // Gán lại Danh mục đã chọn
        try {
            if (maDMStr != null && !maDMStr.isEmpty()) {
                Integer maDM = Integer.parseInt(maDMStr);
                DanhMuc dm = new DanhMuc();
                dm.setMaDM(maDM);
                product.setDanhMuc(dm);
            }
        } catch (Exception ignored) { /* Bỏ qua lỗi */ }
        
        // Gán lại dữ liệu SỐ, dùng try-catch để tránh lỗi NumberFormatException nếu người dùng nhập chữ
        try {
             if (giaStr != null && !giaStr.isEmpty()) product.setDonGia(new BigDecimal(giaStr));
        } catch (Exception ignored) { /* Bỏ qua lỗi, giữ nguyên giá trị cũ hoặc null */ }
        
        try {
             if (soLuongStr != null && !soLuongStr.isEmpty()) product.setSoLuongTon(Integer.valueOf(soLuongStr));
        } catch (Exception ignored) { /* Bỏ qua lỗi, giữ nguyên giá trị cũ hoặc null */ }
        
        request.setAttribute("product", product);
        request.setAttribute("pageTitle", product.getMaSP() != null ? "Chỉnh sửa Sản phẩm" : "Thêm Sản phẩm mới");
    }
    
    // Quá tải phương thức repopulateForm để sử dụng mặc định (Không khuyến khích sử dụng)
    private void repopulateForm(HttpServletRequest request, SanPham product) {
        repopulateForm(request, product, request.getParameter("tenSP"), request.getParameter("moTa"), 
                       request.getParameter("gia"), request.getParameter("soLuong"), 
                       request.getParameter("maDM"));
    }
}
