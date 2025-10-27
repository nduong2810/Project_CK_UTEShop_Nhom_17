package com.uteshop.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

/**
 * Servlet để serve static resources như images, css, js
 */
@WebServlet(urlPatterns = {"/assets/*"})
public class StaticResourceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String requestURI = request.getRequestURI();
        String contextPath = request.getContextPath();
        
        // Lấy đường dẫn relative từ /assets/
        String resourcePath = requestURI.substring(contextPath.length() + "/assets".length());
        
        // Tạo đường dẫn đầy đủ đến file
        String realPath = getServletContext().getRealPath("/assets" + resourcePath);
        File file = new File(realPath);
        
        // Kiểm tra file có tồn tại không
        if (!file.exists() || !file.isFile()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        // Xác định MIME type
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            mimeType = Files.probeContentType(file.toPath());
        }
        if (mimeType == null) {
            if (resourcePath.endsWith(".css")) {
                mimeType = "text/css";
            } else if (resourcePath.endsWith(".js")) {
                mimeType = "application/javascript";
            } else if (resourcePath.endsWith(".png")) {
                mimeType = "image/png";
            } else if (resourcePath.endsWith(".jpg") || resourcePath.endsWith(".jpeg")) {
                mimeType = "image/jpeg";
            } else if (resourcePath.endsWith(".gif")) {
                mimeType = "image/gif";
            } else {
                mimeType = "application/octet-stream";
            }
        }
        
        // Set headers
        response.setContentType(mimeType);
        response.setContentLengthLong(file.length());
        response.setHeader("Cache-Control", "public, max-age=31536000"); // Cache 1 năm
        
        // Gửi file
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {
            
            byte[] buffer = new byte[8192];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}