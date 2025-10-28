package com.uteshop.controller.user;

import com.uteshop.dao.SanPhamYeuThichDAO;
import com.uteshop.entity.SanPhamYeuThich;
import com.uteshop.entity.NguoiDung;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet({"/user/wishlist-test"})
public class WishlistTestController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SanPhamYeuThichDAO sanPhamYeuThichDAO;

    public void init() {
        sanPhamYeuThichDAO = new SanPhamYeuThichDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        NguoiDung user = (NguoiDung) (session != null ? session.getAttribute("user") : null);
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><meta charset='UTF-8'><title>Wishlist Test</title>");
        out.println("<style>body{font-family:monospace;padding:20px;background:#f5f5f5;}");
        out.println(".success{color:green;} .error{color:red;} .info{color:blue;}</style>");
        out.println("</head><body>");
        
        out.println("<h1>🔍 WISHLIST DEBUG TEST</h1>");
        out.println("<hr>");
        
        // 1. Check session
        out.println("<h2>1. Session Check:</h2>");
        if (session == null) {
            out.println("<p class='error'>❌ No session found!</p>");
            out.println("</body></html>");
            return;
        } else {
            out.println("<p class='success'>✅ Session exists</p>");
        }
        
        // 2. Check user
        out.println("<h2>2. User Check:</h2>");
        if (user == null) {
            out.println("<p class='error'>❌ No user in session!</p>");
            out.println("<p>Please <a href='" + request.getContextPath() + "/auth/login'>login</a></p>");
            out.println("</body></html>");
            return;
        } else {
            out.println("<p class='success'>✅ User found in session</p>");
            out.println("<ul>");
            out.println("<li><strong>User ID:</strong> " + user.getMaND() + "</li>");
            out.println("<li><strong>Username:</strong> " + user.getTenDangNhap() + "</li>");
            out.println("<li><strong>Role:</strong> " + user.getVaiTro() + "</li>");
            out.println("</ul>");
        }
        
        // 3. Check DAO
        out.println("<h2>3. DAO Check:</h2>");
        if (sanPhamYeuThichDAO == null) {
            out.println("<p class='error'>❌ DAO is null!</p>");
            out.println("</body></html>");
            return;
        } else {
            out.println("<p class='success'>✅ DAO initialized</p>");
        }
        
        // 4. Count favorites
        out.println("<h2>4. Count Favorites:</h2>");
        try {
            long count = sanPhamYeuThichDAO.countFavoritesByUser(user.getMaND());
            out.println("<p class='info'>📊 Total favorites in DB: <strong>" + count + "</strong></p>");
            
            if (count == 0) {
                out.println("<p class='error'>❌ No favorites found in database for this user!</p>");
                out.println("<p>SQL Query you can run to check:</p>");
                out.println("<pre>SELECT * FROM SanPhamYeuThich WHERE MaND = " + user.getMaND() + ";</pre>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>❌ Error counting favorites: " + e.getMessage() + "</p>");
            out.println("<pre>" + getStackTrace(e) + "</pre>");
        }
        
        // 5. Try to load favorites
        out.println("<h2>5. Load Favorites:</h2>");
        try {
            List<SanPhamYeuThich> favorites = sanPhamYeuThichDAO.getFavoritesByUser(user.getMaND(), 0, 10);
            
            if (favorites == null) {
                out.println("<p class='error'>❌ Favorites list is NULL!</p>");
            } else if (favorites.isEmpty()) {
                out.println("<p class='error'>❌ Favorites list is EMPTY!</p>");
            } else {
                out.println("<p class='success'>✅ Loaded " + favorites.size() + " favorites</p>");
                out.println("<table border='1' cellpadding='5' style='border-collapse:collapse;'>");
                out.println("<tr><th>ID</th><th>Product ID</th><th>Product Name</th><th>Price</th><th>Date</th></tr>");
                
                for (SanPhamYeuThich fav : favorites) {
                    out.println("<tr>");
                    out.println("<td>" + fav.getMaYT() + "</td>");
                    
                    try {
                        if (fav.getSanPham() != null) {
                            out.println("<td>" + fav.getSanPham().getMaSP() + "</td>");
                            out.println("<td>" + fav.getSanPham().getTenSP() + "</td>");
                            out.println("<td>" + fav.getSanPham().getDonGia() + "</td>");
                        } else {
                            out.println("<td colspan='3' class='error'>Product is NULL</td>");
                        }
                    } catch (Exception e) {
                        out.println("<td colspan='3' class='error'>Error loading product: " + e.getMessage() + "</td>");
                    }
                    
                    out.println("<td>" + fav.getNgayYeuThich() + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
        } catch (Exception e) {
            out.println("<p class='error'>❌ Error loading favorites: " + e.getMessage() + "</p>");
            out.println("<pre>" + getStackTrace(e) + "</pre>");
        }
        
        // 6. Test links
        out.println("<h2>6. Test Links:</h2>");
        out.println("<ul>");
        out.println("<li><a href='" + request.getContextPath() + "/user/wishlist'>Go to actual wishlist page</a></li>");
        out.println("<li><a href='" + request.getContextPath() + "/user/favorites'>Go to favorites page</a></li>");
        out.println("<li><a href='" + request.getContextPath() + "/guest/home'>Go to home</a></li>");
        out.println("</ul>");
        
        out.println("<hr>");
        out.println("<p><small>Test completed at: " + new java.util.Date() + "</small></p>");
        out.println("</body></html>");
    }
    
    private String getStackTrace(Exception e) {
        java.io.StringWriter sw = new java.io.StringWriter();
        java.io.PrintWriter pw = new java.io.PrintWriter(sw);
        e.printStackTrace(pw);
        return sw.toString();
    }
}
