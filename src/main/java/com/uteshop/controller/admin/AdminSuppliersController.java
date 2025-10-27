package com.uteshop.controller.admin;

import com.uteshop.dao.CuaHangDAO;
import com.uteshop.entity.CuaHang;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/suppliers")
public class AdminSuppliersController extends HttpServlet {
    private final CuaHangDAO shopDao = new CuaHangDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pageSize = parseIntOrDefault(req.getParameter("pageSize"), 10);
        int page     = parseIntOrDefault(req.getParameter("page"), 1);
        String q     = trimToNull(req.getParameter("q"));

        int total = shopDao.countAll(q);
        int totalPages = Math.max(1, (int)Math.ceil(total * 1.0 / pageSize));
        page = Math.min(Math.max(page, 1), totalPages);

        List<CuaHang> list = shopDao.findPaged(page, pageSize, q);

        req.setAttribute("shops", list);
        req.setAttribute("total", total);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("param_q", q);

        req.getRequestDispatcher("/WEB-INF/views/admin/suppliers.jsp").forward(req, resp);
    }

    private int parseIntOrDefault(String s, int def){ try{ return (s==null||s.isBlank())?def:Integer.parseInt(s.trim()); }catch(Exception e){return def;}}
    private String trimToNull(String s){ if (s==null) return null; String t=s.trim(); return t.isEmpty()?null:t; }
}
