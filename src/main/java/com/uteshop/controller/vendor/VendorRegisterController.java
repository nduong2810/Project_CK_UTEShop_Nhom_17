package com.uteshop.controller.vendor;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.persistence.NonUniqueResultException; // Thêm import này

import java.io.IOException;
import java.util.Date; 

@WebServlet(urlPatterns = {"/vendor/register-store"})
public class VendorRegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private final CuaHangDAO cuaHangDAO = new CuaHangDAO();
    private final NguoiDungDAO nguoiDungDAO = new NguoiDungDAO(); // Khai báo nếu cần

    // Phương thức hỗ trợ kiểm tra quyền
    private NguoiDung getAuthenticatedUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (NguoiDung) session.getAttribute("user");
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Kiểm tra quyền
        NguoiDung user = getAuthenticatedUser(request);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        // 2. Kiểm tra xem Vendor đã có cửa hàng chưa (Đã thêm try-catch để bắt NonUniqueResultException)
        try {
            CuaHang existingStore = cuaHangDAO.findByUserId(user.getMaND());
            if (existingStore != null) {
                // Nếu đã có, chuyển hướng về Dashboard
                response.sendRedirect(request.getContextPath() + "/vendor/dashboard?error=Bạn đã có cửa hàng rồi.");
                return;
            }
        } catch (NonUniqueResultException e) {
            // Trường hợp lỗi NonUniqueResultException (nhiều hơn 1 cửa hàng cho 1 user)
            System.err.println("Lỗi DB: Người dùng " + user.getMaND() + " có nhiều hơn một cửa hàng.");
            response.sendRedirect(request.getContextPath() + "/vendor/dashboard?error=Lỗi dữ liệu: Bạn có nhiều hơn một cửa hàng. Vui lòng liên hệ hỗ trợ.");
            return;
        } catch (Exception e) {
            // Lỗi DB chung
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/auth/login?error=Lỗi hệ thống khi kiểm tra cửa hàng.");
            return;
        }
        
        // 3. Hiển thị form đăng ký
        request.setAttribute("pageTitle", "Đăng ký Cửa hàng");
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/vendor/register_store.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // ** RẤT QUAN TRỌNG: Thiết lập Encoding để xử lý tiếng Việt **
        request.setCharacterEncoding("UTF-8"); 
        
        // 1. Kiểm tra quyền
        NguoiDung user = getAuthenticatedUser(request);
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        // 2. Kiểm tra lại Vendor đã có cửa hàng chưa (tránh trùng lặp)
        if (cuaHangDAO.findByUserId(user.getMaND()) != null) {
            response.sendRedirect(request.getContextPath() + "/vendor/dashboard?error=Bạn đã có cửa hàng.");
            return;
        }
        
        // 3. Lấy dữ liệu từ Form
        String tenCH = request.getParameter("tenCH");
        String moTa = request.getParameter("moTa");
        String diaChi = request.getParameter("diaChi");
        String soDienThoai = request.getParameter("soDienThoai");
        
        // 4. Kiểm tra dữ liệu bắt buộc từ Form
        if (tenCH == null || tenCH.trim().isEmpty() || soDienThoai == null || soDienThoai.trim().isEmpty()) {
             request.setAttribute("error", "Vui lòng điền đầy đủ Tên Cửa hàng và Số điện thoại.");
             // Điền lại dữ liệu cũ vào form
             repopulateForm(request, tenCH, moTa, diaChi, soDienThoai); 
             doGet(request, response);
             return;
        }
        
        // 5. Tạo Entity CuaHang mới và thiết lập các trường bắt buộc theo DB Schema
        CuaHang newStore = new CuaHang();
        
        // Thiết lập các trường lấy từ form
        newStore.setTenCH(tenCH);
        newStore.setMoTa(moTa);
        newStore.setDiaChi(diaChi);
        newStore.setSoDienThoai(soDienThoai);
        
        // Thiết lập các trường bắt buộc theo DB Schema
        newStore.setMaND(user.getMaND()); // MaND (Khóa ngoại)
        newStore.setEmail(user.getEmail()); // Email
        newStore.setNgayTao(new Date()); // NgayTao
        newStore.setNgayCapNhat(new Date()); // NgayCapNhat (Giả định)
        newStore.setTrangThai(true); // TrangThai (Mặc định là hoạt động)
        
        // 6. Lưu vào DAO
        try {
            if (cuaHangDAO.insert(newStore)) {
                // *** THAY ĐỔI: Lưu thông báo thành công vào Session ***
                request.getSession().setAttribute("successMessage", "Đăng ký cửa hàng thành công!");

                // Đăng ký thành công, chuyển hướng về Dashboard
                response.sendRedirect(request.getContextPath() + "/vendor/dashboard");
                
                user.setVaiTro(NguoiDung.VaiTro.VENDOR); 
                nguoiDungDAO.update(user);
                request.getSession().setAttribute("user", user);
                
            } else {
                // Lỗi DB hoặc lỗi khác từ DAO (DAO trả về false)
                request.setAttribute("error", "Lỗi: Không thể đăng ký cửa hàng. Vui lòng kiểm tra lại dữ liệu hoặc liên hệ hỗ trợ.");
                repopulateForm(request, tenCH, moTa, diaChi, soDienThoai); 
                doGet(request, response); // Quay lại form
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Bắt lỗi hệ thống/DB không mong muốn khác
            request.setAttribute("error", "Lỗi hệ thống không xác định trong quá trình đăng ký: " + e.getMessage());
            repopulateForm(request, tenCH, moTa, diaChi, soDienThoai); 
            doGet(request, response);
        }
    }
    
    /**
     * Phương thức hỗ trợ điền lại dữ liệu form sau khi gặp lỗi
     */
    private void repopulateForm(HttpServletRequest request, String tenCH, String moTa, String diaChi, String soDienThoai) {
        request.setAttribute("tenCH_val", tenCH);
        request.setAttribute("moTa_val", moTa);
        request.setAttribute("diaChi_val", diaChi);
        request.setAttribute("soDienThoai_val", soDienThoai);
    }
}
