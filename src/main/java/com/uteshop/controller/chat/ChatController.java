package com.uteshop.controller.chat;

import com.google.gson.Gson;
import com.uteshop.dao.CuaHangDAO;
import com.uteshop.dao.HoiThoaiDAO;
import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.dao.TinNhanDAO;
import com.uteshop.dto.HoiThoaiDTO;
import com.uteshop.dto.TinNhanDTO;
import com.uteshop.entity.CuaHang;
import com.uteshop.entity.HoiThoai;
import com.uteshop.entity.NguoiDung;
import com.uteshop.entity.TinNhan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Controller cho trang chat
 */
@WebServlet("/chat")
public class ChatController extends HttpServlet {
    private HoiThoaiDAO hoiThoaiDAO = new HoiThoaiDAO();
    private TinNhanDAO tinNhanDAO = new TinNhanDAO();
    private NguoiDungDAO nguoiDungDAO = new NguoiDungDAO();
    private CuaHangDAO cuaHangDAO = new CuaHangDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        NguoiDung currentUser = (NguoiDung) session.getAttribute("user");
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("getConversations".equals(action)) {
            getConversations(request, response, currentUser);
        } else if ("getMessages".equals(action)) {
            getMessages(request, response, currentUser);
        } else if ("startChat".equals(action)) {
            startChat(request, response, currentUser);
        } else {
            // Hiển thị trang chat
            List<HoiThoai> conversations = hoiThoaiDAO.getConversationsByUserId(currentUser.getMaND());
            request.setAttribute("conversations", conversations);
            request.setAttribute("currentUser", currentUser);
            request.getRequestDispatcher("/WEB-INF/views/chat/chat-panel.jsp").forward(request, response);
        }
    }
    
    /**
     * Lấy danh sách hội thoại
     */
    private void getConversations(HttpServletRequest request, HttpServletResponse response, NguoiDung currentUser) 
            throws IOException {
        List<HoiThoai> conversations = hoiThoaiDAO.getConversationsByUserId(currentUser.getMaND());
        
        // Chuyển đổi Entity sang DTO để tránh lỗi Hibernate proxy
        List<HoiThoaiDTO> conversationDTOs = conversations.stream()
            .map(this::convertToDTO)
            .collect(Collectors.toList());
        
        // Chuyển đổi sang format JSON phù hợp
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(conversationDTOs));
    }
    
    /**
     * Lấy tin nhắn của hội thoại
     */
    private void getMessages(HttpServletRequest request, HttpServletResponse response, NguoiDung currentUser) 
            throws IOException {
        try {
            Integer conversationId = Integer.parseInt(request.getParameter("conversationId"));
            
            // Kiểm tra quyền truy cập
            HoiThoai hoiThoai = hoiThoaiDAO.getConversationById(conversationId);
            if (hoiThoai == null) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            // Kiểm tra user có phải là thành viên của hội thoại không
            boolean isParticipant = hoiThoai.getMaKhachHang().equals(currentUser.getMaND());
            if (!isParticipant) {
                // Kiểm tra xem có phải là chủ cửa hàng không
                CuaHang cuaHang = cuaHangDAO.findByUserId(currentUser.getMaND());
                if (cuaHang == null || !cuaHang.getMaCH().equals(hoiThoai.getMaCuaHang())) {
                    response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    return;
                }
            }
            
            // Lấy tin nhắn
            List<TinNhan> messages = tinNhanDAO.getAllMessagesByConversationId(conversationId);
            
            // Đánh dấu đã đọc
            tinNhanDAO.markAllAsRead(conversationId, currentUser.getMaND());
            hoiThoaiDAO.resetUnreadCount(conversationId);
            
            // Chuyển đổi Entity sang DTO để tránh lỗi Hibernate proxy
            List<TinNhanDTO> messageDTOs = messages.stream()
                .map(this::convertToMessageDTO)
                .collect(Collectors.toList());
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(gson.toJson(messageDTOs));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    /**
     * Bắt đầu chat với cửa hàng
     */
    private void startChat(HttpServletRequest request, HttpServletResponse response, NguoiDung currentUser) 
            throws IOException {
        try {
            Integer storeId = Integer.parseInt(request.getParameter("storeId"));
            
            // Tìm hoặc tạo hội thoại
            HoiThoai hoiThoai = hoiThoaiDAO.findOrCreateConversation(currentUser.getMaND(), storeId);
            
            if (hoiThoai != null) {
                Map<String, Object> result = new HashMap<>();
                result.put("success", true);
                result.put("conversationId", hoiThoai.getMaHoiThoai());
                
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(gson.toJson(result));
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    /**
     * Chuyển đổi HoiThoai Entity sang DTO
     * Tránh lỗi Hibernate proxy khi serialize
     */
    private HoiThoaiDTO convertToDTO(HoiThoai hoiThoai) {
        HoiThoaiDTO dto = new HoiThoaiDTO();
        dto.setMaHoiThoai(hoiThoai.getMaHoiThoai());
        dto.setMaKhachHang(hoiThoai.getMaKhachHang());
        dto.setMaCuaHang(hoiThoai.getMaCuaHang());
        dto.setTinNhanCuoi(hoiThoai.getTinNhanCuoi());
        dto.setNgayTaoHoiThoai(hoiThoai.getNgayTaoHoiThoai());
        dto.setNgayCapNhat(hoiThoai.getNgayCapNhat());
        dto.setSoTinNhanChuaDoc(hoiThoai.getSoTinNhanChuaDoc());
        dto.setNguoiGuiCuoi(hoiThoai.getNguoiGuiCuoi());
        dto.setTrangThai(hoiThoai.getTrangThai());
        
        // Lấy tên từ entity đã eager load
        if (hoiThoai.getKhachHang() != null) {
            dto.setTenKhachHang(hoiThoai.getKhachHang().getHoTen());
        }
        if (hoiThoai.getCuaHang() != null) {
            dto.setTenCuaHang(hoiThoai.getCuaHang().getTenCH());
        }
        
        return dto;
    }
    
    /**
     * Chuyển đổi TinNhan Entity sang DTO
     * Tránh lỗi Hibernate proxy khi serialize
     */
    private TinNhanDTO convertToMessageDTO(TinNhan tinNhan) {
        TinNhanDTO dto = new TinNhanDTO();
        dto.setMaTinNhan(tinNhan.getMaTinNhan());
        dto.setMaHoiThoai(tinNhan.getMaHoiThoai());
        dto.setMaNguoiGui(tinNhan.getMaNguoiGui());
        dto.setNoiDung(tinNhan.getNoiDung());
        dto.setNgayGui(tinNhan.getNgayGui());
        dto.setDaDoc(tinNhan.getDaDoc());
        dto.setNgayDoc(tinNhan.getNgayDoc());
        dto.setLoaiTinNhan(tinNhan.getLoaiTinNhan());
        dto.setDuongDanFile(tinNhan.getDuongDanFile());
        
        // Lấy tên người gửi nếu đã load
        if (tinNhan.getNguoiGui() != null) {
            dto.setTenNguoiGui(tinNhan.getNguoiGui().getHoTen());
        }
        
        return dto;
    }
}
