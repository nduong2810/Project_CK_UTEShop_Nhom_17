package com.uteshop.controller.user;

import com.uteshop.dao.DiaChiGiaoHangDAO;
import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.DiaChiGiaoHang;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/address")
public class AddressController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private DiaChiGiaoHangDAO diaChiDAO = new DiaChiGiaoHangDAO();
    private NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        NguoiDung user = (NguoiDung) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if (action == null || action.equals("list")) {
                // Hiển thị danh sách địa chỉ
                listAddresses(request, response, user);
            } else if (action.equals("add")) {
                // Hiển thị form thêm địa chỉ
                showAddForm(request, response);
            } else if (action.equals("edit")) {
                // Hiển thị form sửa địa chỉ
                showEditForm(request, response, user);
            } else if (action.equals("delete")) {
                // Xóa địa chỉ
                deleteAddress(request, response, user);
            } else if (action.equals("setDefault")) {
                // Đặt làm địa chỉ mặc định
                setDefaultAddress(request, response, user);
            } else {
                listAddresses(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            listAddresses(request, response, user);
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
        
        String action = request.getParameter("action");
        
        try {
            if (action.equals("save")) {
                // Lưu địa chỉ (thêm mới hoặc cập nhật)
                saveAddress(request, response, user);
            } else {
                listAddresses(request, response, user);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            listAddresses(request, response, user);
        }
    }
    
    private void listAddresses(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        List<DiaChiGiaoHang> addresses = diaChiDAO.getAddressesByUser(user.getMaND());
        long addressCount = diaChiDAO.countAddressesByUser(user.getMaND());
        
        request.setAttribute("addresses", addresses);
        request.setAttribute("addressCount", addressCount);
        
        request.getRequestDispatcher("/WEB-INF/views/user/address-list.jsp").forward(request, response);
    }
    
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setAttribute("isEdit", false);
        request.getRequestDispatcher("/WEB-INF/views/user/address-form.jsp").forward(request, response);
    }
    
    private void showEditForm(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int addressId = Integer.parseInt(request.getParameter("id"));
            System.out.println("DEBUG: Đang cố gắng chỉnh sửa địa chỉ với ID: " + addressId); // Debug 1

            DiaChiGiaoHang address = diaChiDAO.findById(addressId);
            
            if (address == null) {
                System.out.println("DEBUG: Không tìm thấy địa chỉ với ID: " + addressId + " trong ứng dụng."); // Debug 2
                request.setAttribute("error", "Không tìm thấy địa chỉ hoặc bạn không có quyền truy cập");
                listAddresses(request, response, user);
                return;
            }

            // Nếu địa chỉ được tìm thấy, kiểm tra quyền sở hữu
            // Đảm bảo rằng address.getNguoiDung() không null trước khi gọi getMaND()
            if (address.getNguoiDung() == null) {
                System.out.println("DEBUG: Đối tượng NguoiDung liên kết với địa chỉ ID " + addressId + " là null."); // Debug 3a
                request.setAttribute("error", "Lỗi dữ liệu: Không tìm thấy thông tin người dùng cho địa chỉ này.");
                listAddresses(request, response, user);
                return;
            }

            int addressOwnerId = address.getNguoiDung().getMaND();
            int loggedInUserId = user.getMaND();
            System.out.println("DEBUG: ID chủ sở hữu địa chỉ (từ DB): " + addressOwnerId); // Debug 3b
            System.out.println("DEBUG: ID người dùng đang đăng nhập (từ Session): " + loggedInUserId); // Debug 4

            if (addressOwnerId != loggedInUserId) {
                System.out.println("DEBUG: Người dùng không có quyền truy cập địa chỉ này. (ID chủ sở hữu: " + addressOwnerId + ", ID đăng nhập: " + loggedInUserId + ")"); // Debug 5
                request.setAttribute("error", "Không tìm thấy địa chỉ hoặc bạn không có quyền truy cập");
                listAddresses(request, response, user);
                return;
            }
            
            request.setAttribute("address", address);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/WEB-INF/views/user/address-form.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            System.err.println("ERROR: ID địa chỉ không hợp lệ: " + request.getParameter("id")); // Debug 6
            request.setAttribute("error", "ID địa chỉ không hợp lệ");
            listAddresses(request, response, user);
        } catch (Exception e) {
            System.err.println("ERROR: Lỗi không xác định trong showEditForm: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi: " + e.getMessage());
            listAddresses(request, response, user);
        }
    }
    
    private void saveAddress(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            String tenNguoiNhan = request.getParameter("tenNguoiNhan");
            String soDienThoai = request.getParameter("soDienThoai");
            String diaChiCuThe = request.getParameter("diaChiCuThe");
            String phuong = request.getParameter("phuong");
            String quan = request.getParameter("quan");
            String thanhPho = request.getParameter("thanhPho");
            boolean laMacDinh = "on".equals(request.getParameter("laMacDinh"));
            
            // Validate dữ liệu
            if (tenNguoiNhan == null || tenNguoiNhan.trim().isEmpty() ||
                soDienThoai == null || soDienThoai.trim().isEmpty() ||
                diaChiCuThe == null || diaChiCuThe.trim().isEmpty() ||
                phuong == null || phuong.trim().isEmpty() ||
                quan == null || quan.trim().isEmpty() ||
                thanhPho == null || thanhPho.trim().isEmpty()) {
                
                request.setAttribute("error", "Vui lòng điền đầy đủ thông tin");
                request.setAttribute("tenNguoiNhan", tenNguoiNhan);
                request.setAttribute("soDienThoai", soDienThoai);
                request.setAttribute("diaChiCuThe", diaChiCuThe);
                request.setAttribute("phuong", phuong);
                request.setAttribute("quan", quan);
                request.setAttribute("thanhPho", thanhPho);
                request.setAttribute("laMacDinh", laMacDinh);
                
                String idStr = request.getParameter("id");
                if (idStr != null && !idStr.isEmpty()) {
                    request.setAttribute("isEdit", true);
                    try {
                        int addressId = Integer.parseInt(idStr);
                        DiaChiGiaoHang existingAddress = diaChiDAO.findById(addressId);
                        if (existingAddress != null && existingAddress.getNguoiDung().getMaND() == user.getMaND()) {
                            request.setAttribute("address", existingAddress);
                        }
                    } catch (NumberFormatException e) {
                        System.err.println("ERROR: ID địa chỉ không hợp lệ khi xử lý lỗi validation: " + idStr);
                    }
                } else {
                    request.setAttribute("isEdit", false);
                }
                
                request.getRequestDispatcher("/WEB-INF/views/user/address-form.jsp").forward(request, response);
                return;
            }
            
            // Tạo hoặc cập nhật địa chỉ
            DiaChiGiaoHang address;
            String idStr = request.getParameter("id");
            
            if (idStr != null && !idStr.isEmpty()) {
                // Cập nhật địa chỉ hiện tại
                int addressId = Integer.parseInt(idStr);
                address = diaChiDAO.findById(addressId);
                
                if (address == null || address.getNguoiDung().getMaND() != user.getMaND()) {
                    request.setAttribute("error", "Không tìm thấy địa chỉ hoặc bạn không có quyền truy cập");
                    listAddresses(request, response, user);
                    return;
                }
            } else {
                // Tạo địa chỉ mới
                address = new DiaChiGiaoHang();
                address.setNguoiDung(user);
            }
            
            // Set dữ liệu
            address.setTenNguoiNhan(tenNguoiNhan.trim());
            address.setSoDienThoai(soDienThoai.trim());
            address.setDiaChiCuThe(diaChiCuThe.trim());
            address.setPhuong(phuong.trim());
            address.setQuan(quan.trim());
            address.setThanhPho(thanhPho.trim());
            address.setLaMacDinh(laMacDinh);
            
            // Lưu vào database
            boolean success = diaChiDAO.save(address);
            
            if (success) {
                request.setAttribute("success", "Lưu địa chỉ thành công");
            } else {
                request.setAttribute("error", "Không thể lưu địa chỉ");
            }
            
            // Redirect để tránh resubmit form
            response.sendRedirect(request.getContextPath() + "/user/address");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            showAddForm(request, response);
        }
    }
    
    private void deleteAddress(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int addressId = Integer.parseInt(request.getParameter("id"));
            
            boolean success = diaChiDAO.delete(addressId, user.getMaND());
            
            if (success) {
                request.setAttribute("success", "Đã xóa địa chỉ");
            } else {
                request.setAttribute("error", "Không thể xóa địa chỉ");
            }
            
            // Redirect để tránh resubmit form
            response.sendRedirect(request.getContextPath() + "/user/address");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID địa chỉ không hợp lệ");
            listAddresses(request, response, user);
        }
    }
    
    private void setDefaultAddress(HttpServletRequest request, HttpServletResponse response, NguoiDung user) 
            throws ServletException, IOException {
        
        try {
            int addressId = Integer.parseInt(request.getParameter("id"));
            
            boolean success = diaChiDAO.setAsDefault(addressId, user.getMaND());
            
            if (success) {
                request.setAttribute("success", "Đã đặt làm địa chỉ mặc định");
            } else {
                request.setAttribute("error", "Không thể đặt làm địa chỉ mặc định");
            }
            
            // Redirect để tránh resubmit form
            response.sendRedirect(request.getContextPath() + "/user/address");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID địa chỉ không hợp lệ");
            listAddresses(request, response, user);
        }
    }
}