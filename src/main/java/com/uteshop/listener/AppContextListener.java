package com.uteshop.listener;

import com.uteshop.dao.DanhMucDAO;
import com.uteshop.entity.DanhMuc;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.List;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        DanhMucDAO danhMucDAO = new DanhMucDAO();
        
        // Lấy danh sách danh mục và đặt vào application scope
        List<DanhMuc> categories = danhMucDAO.findAll();
        context.setAttribute("categories", categories);
        
        System.out.println("Category list loaded into application context.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Không cần xử lý khi ứng dụng dừng
    }
}
