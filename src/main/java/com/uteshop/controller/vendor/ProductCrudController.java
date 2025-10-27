package com.uteshop.controller.vendor;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.dao.DanhMucDAO;
import com.uteshop.dao.SanPhamDAO;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.DanhMuc;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.SanPham;

import jakarta.servlet.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.StandardCopyOption;
import java.util.Date;
import java.util.List;
import java.util.Optional;

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
    private final DanhMucDAO dmDAO = new DanhMucDAO();

    private static final String UPLOAD_DIR = "assets" + File.separator + "img";

    private NguoiDung checkAuth(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        NguoiDung user = (NguoiDung) Optional.ofNullable(session)
                .map(s -> (NguoiDung) s.getAttribute("user"))
                .orElse(null);
        
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
        System.out.println("Store retrieved: MaCH = " + (store != null ? store.getMaCH() : "NULL") + ", MaND = " + user.getMaND());
        if (store == null) {
            response.sendRedirect(request.getContextPath() + "/vendor/register-store");
            return;
        }
        
        request.getSession().setAttribute("store", store);
        request.setAttribute("store", store);
        
        try {
            List<DanhMuc> categories = dmDAO.findAll();
            request.setAttribute("categories", categories);
        } catch (Exception e) {
            request.setAttribute("error", "Không thể tải danh sách danh mục: " + e.getMessage());
            e.printStackTrace();
        }

        String maSPParam = request.getParameter("id");
        if (maSPParam != null && !maSPParam.isEmpty() && request.getAttribute("product") == null) {
            try {
                Integer maSP = Integer.parseInt(maSPParam);
                SanPham product = sanPhamDAO.findById(maSP);
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
            request.setAttribute("product", new SanPham());
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
            response.sendRedirect(request.getContextPath() + "/vendor/register-store?msg=Vui lòng đăng ký cửa hàng trước khi thêm sản phẩm.");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String maSPParam = request.getParameter("maSP");
        SanPham product = new SanPham(); 
        
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
            product.setNgayTao(new Date());
        }
        
        String tenSP = request.getParameter("tenSP");
        String moTa = request.getParameter("moTa");
        String giaStr = request.getParameter("gia");
        String soLuongStr = request.getParameter("soLuong");
        String maDMStr = request.getParameter("maDM");

        try {
            if (tenSP == null || tenSP.trim().isEmpty() || giaStr == null || soLuongStr == null || maDMStr == null || maDMStr.isEmpty()) {
                throw new IllegalArgumentException("Vui lòng điền đầy đủ Tên, Giá, Số lượng và chọn Danh mục.");
            }

            product.setTenSP(tenSP);
            product.setMoTa(moTa);
            product.setDonGia(new BigDecimal(giaStr));
            product.setSoLuongTon(Integer.valueOf(soLuongStr));
            product.setMaDM(Integer.parseInt(maDMStr)); // Gán maDM trực tiếp

            product.setNgayCapNhat(new Date());

            // Xử lý upload ảnh
            Part filePart = request.getPart("anhMinhHoa");
            String fileName = (filePart != null) ? filePart.getSubmittedFileName() : null;
            
            // Chỉ xử lý upload ảnh khi có file mới được chọn
            if (fileName != null && !fileName.isEmpty()) {
                // Lấy đường dẫn thực tế của webapp deployed
                String webappPath = request.getServletContext().getRealPath("/");
                System.out.println("Original webapp path: " + webappPath);
                
                // Xác định đường dẫn source webapp bằng nhiều cách
                String sourceWebappPath = null;
                
                // Cách 1: Thử thay thế target path
                if (webappPath.contains("target")) {
                    String projectRoot = webappPath.substring(0, webappPath.indexOf("target"));
                    sourceWebappPath = projectRoot + "src" + File.separator + "main" + File.separator + "webapp" + File.separator;
                    System.out.println("Method 1 - Source webapp path: " + sourceWebappPath);
                }
                
                // Cách 2: Thử đường dẫn cố định dựa trên cấu trúc project
                if (sourceWebappPath == null || !new File(sourceWebappPath).exists()) {
                    // Sử dụng đường dẫn cố định dựa trên thông tin từ workspace
                    sourceWebappPath = "D:" + File.separator + "HK I Year 3(first)" + File.separator + "LTWeb" + File.separator + "Project_CK_UTEShop_Nhom_17" + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator;
                    System.out.println("Method 2 - Fixed source webapp path: " + sourceWebappPath);
                }
                
                // Cách 3: Fallback sử dụng working directory
                if (sourceWebappPath == null || !new File(sourceWebappPath).exists()) {
                    String userDir = System.getProperty("user.dir");
                    if (userDir.contains("Project_CK_UTEShop_Nhom_17")) {
                        sourceWebappPath = userDir + File.separator + "src" + File.separator + "main" + File.separator + "webapp" + File.separator;
                    } else {
                        sourceWebappPath = webappPath; // Fallback to deployed path
                    }
                    System.out.println("Method 3 - Working dir source webapp path: " + sourceWebappPath);
                }
                
                String sourceUploadPath = sourceWebappPath + "assets" + File.separator + "img";
                String deployedUploadPath = webappPath + "assets" + File.separator + "img";
                
                System.out.println("Final source upload path: " + sourceUploadPath);
                System.out.println("Final deployed upload path: " + deployedUploadPath);
                
                // Tạo cả 2 thư mục nếu chưa tồn tại
                File sourceUploadDir = new File(sourceUploadPath);
                File deployedUploadDir = new File(deployedUploadPath);
                
                if (!sourceUploadDir.exists()) {
                    boolean created = sourceUploadDir.mkdirs();
                    System.out.println("Created source directory: " + created + " at " + sourceUploadPath);
                }
                if (!deployedUploadDir.exists()) {
                    boolean created = deployedUploadDir.mkdirs();
                    System.out.println("Created deployed directory: " + created + " at " + deployedUploadPath);
                }

                String savedFileName = System.currentTimeMillis() + "_" + fileName;
                
                try {
                    // Xóa ảnh cũ nếu đang update và có ảnh cũ
                    if (isUpdate && product.getHinhAnh() != null && !product.getHinhAnh().isEmpty()) {
                        String oldSourceFilePath = sourceUploadPath + File.separator + product.getHinhAnh();
                        String oldDeployedFilePath = deployedUploadPath + File.separator + product.getHinhAnh();
                        
                        File oldSourceFile = new File(oldSourceFilePath);
                        File oldDeployedFile = new File(oldDeployedFilePath);
                        
                        if (oldSourceFile.exists()) {
                            boolean deleted = oldSourceFile.delete();
                            System.out.println("Deleted old source image: " + deleted + " at " + oldSourceFilePath);
                        }
                        if (oldDeployedFile.exists()) {
                            boolean deleted = oldDeployedFile.delete();
                            System.out.println("Deleted old deployed image: " + deleted + " at " + oldDeployedFilePath);
                        }
                    }
                    
                    // Lưu ảnh mới vào deployed (bắt buộc để hiển thị)
                    String deployedFilePath = deployedUploadPath + File.separator + savedFileName;
                    filePart.write(deployedFilePath);
                    File deployedFile = new File(deployedFilePath);
                    System.out.println("Saved new image to deployed: " + deployedFile.exists() + " at " + deployedFilePath);
                    
                    // Lưu vào source (nếu thư mục tồn tại)
                    if (sourceUploadDir.exists() && sourceUploadDir.canWrite()) {
                        String sourceFilePath = sourceUploadPath + File.separator + savedFileName;
                        // Copy file từ deployed sang source
                        java.nio.file.Files.copy(
                            deployedFile.toPath(), 
                            new File(sourceFilePath).toPath(), 
                            java.nio.file.StandardCopyOption.REPLACE_EXISTING
                        );
                        File sourceFile = new File(sourceFilePath);
                        System.out.println("Copied new image to source: " + sourceFile.exists() + " at " + sourceFilePath);
                    } else {
                        System.out.println("Cannot write to source directory: " + sourceUploadPath);
                    }
                    
                } catch (IOException e) {
                    System.err.println("Error saving files: " + e.getMessage());
                    e.printStackTrace();
                    throw e;
                }
                
                // Cập nhật tên file ảnh mới vào database
                product.setHinhAnh(savedFileName);
                System.out.println("Updated product image to: " + savedFileName);
                
            } else if (!isUpdate && (product.getHinhAnh() == null || product.getHinhAnh().isEmpty())) {
                // Chỉ bắt buộc upload ảnh khi thêm mới sản phẩm
                throw new IllegalArgumentException("Vui lòng chọn ảnh minh họa cho sản phẩm mới.");
            } else if (isUpdate) {
                // Nếu đang update và không có file mới, giữ nguyên ảnh cũ
                System.out.println("No new image uploaded, keeping existing image: " + product.getHinhAnh());
            }

            System.out.println("Product MaCH before insert: " + (product.getCuaHang() != null ? product.getCuaHang().getMaCH() : "NULL"));
            System.out.println("Product MaDM before insert: " + product.getMaDM()); // Thêm log để kiểm tra
            boolean success = isUpdate ? sanPhamDAO.update(product) : sanPhamDAO.insert(product);
            
            if (success) {
                String msg = isUpdate ? "Cập nhật sản phẩm thành công!" : "Thêm sản phẩm thành công!";
                response.sendRedirect(request.getContextPath() + "/vendor/products?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
            } else {
                request.setAttribute("error", "Lỗi hệ thống khi lưu sản phẩm (DAO trả về false). Vui lòng kiểm tra log DAO.");
                repopulateForm(request, product, tenSP, moTa, giaStr, soLuongStr, maDMStr);
                doGet(request, response);
            }
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi định dạng số: ID Danh mục, Giá hoặc Số lượng phải là số hợp lệ.");
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

    private void repopulateForm(HttpServletRequest request, SanPham product, String tenSP, String moTa, String giaStr, 
                                String soLuongStr, String maDMStr) {
        product.setTenSP(tenSP);
        product.setMoTa(moTa);
        
        try {
            if (maDMStr != null && !maDMStr.isEmpty()) {
                product.setMaDM(Integer.parseInt(maDMStr)); // Cập nhật maDM
            } else {
                product.setMaDM(null);
            }
        } catch (Exception ignored) {}

        try {
            if (giaStr != null && !giaStr.isEmpty()) {
                product.setDonGia(new BigDecimal(giaStr));
            } else {
                product.setDonGia(null);
            }
        } catch (Exception ignored) {}

        try {
            if (soLuongStr != null && !soLuongStr.isEmpty()) {
                product.setSoLuongTon(Integer.valueOf(soLuongStr));
            } else {
                product.setSoLuongTon(0);
            }
        } catch (Exception ignored) {}

        request.setAttribute("product", product);
        request.setAttribute("pageTitle", product.getMaSP() != null ? "Chỉnh sửa Sản phẩm" : "Thêm Sản phẩm mới");
    }
}