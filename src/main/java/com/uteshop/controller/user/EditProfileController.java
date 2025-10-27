package com.uteshop.controller.user;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.NguoiDung;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/user/edit-profile")
@MultipartConfig
public class EditProfileController extends HttpServlet {

    private static final String AVATAR_DIR = "/assets/avatar/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/user/edit-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        NguoiDung user = (NguoiDung) session.getAttribute("user");
        NguoiDungDAO dao = new NguoiDungDAO();

        user.setHoTen(request.getParameter("hoTen"));
        user.setEmail(request.getParameter("email"));
        user.setSoDienThoai(request.getParameter("soDienThoai"));
        user.setGioiTinh(request.getParameter("gioiTinh"));
        user.setDiaChi(request.getParameter("diaChi"));

        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            String submittedFileName = filePart.getSubmittedFileName();
            String safeFileName = submittedFileName.replace(" ", "_");
            String fileName = System.currentTimeMillis() + "_" + safeFileName;

            // 1. Lưu vào thư mục triển khai của Tomcat (để hiển thị ngay lập tức)
            String deployPath = getServletContext().getRealPath(AVATAR_DIR);
            File deployDir = new File(deployPath);
            if (!deployDir.exists()) deployDir.mkdirs();
            File deployFile = new File(deployDir, fileName);
            try (InputStream in = filePart.getInputStream()) {
                Files.copy(in, deployFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            System.out.println("✅ Saved to deploy: " + deployFile.getAbsolutePath());

            // 2. Sao chép sang thư mục project gốc (để không bị mất khi deploy)
            try {
                File projectRoot = findProjectRoot(getServletContext().getRealPath("/"));
                if (projectRoot != null) {
                    File projectSourceDir = new File(projectRoot, "src/main/webapp" + AVATAR_DIR);
                    if (!projectSourceDir.exists()) {
                        projectSourceDir.mkdirs();
                    }
                    File projectSourceFile = new File(projectSourceDir, fileName);
                    try (InputStream in = filePart.getInputStream()) {
                        Files.copy(in, projectSourceFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                    System.out.println("✅ Copied to project source: " + projectSourceFile.getAbsolutePath());
                } else {
                    System.err.println("⚠️ Không tìm thấy thư mục gốc của project. Bỏ qua việc sao chép vào source.");
                }
            } catch (Exception e) {
                System.err.println("⚠️ Lỗi khi sao chép file vào thư mục source: " + e.getMessage());
            }

            user.setAvatar(fileName);
        }

        dao.update(user);

        session.setAttribute("user", user);
        request.setAttribute("user", user);
        request.setAttribute("message", "Cập nhật hồ sơ thành công!");
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
    }

    /**
     * Tìm thư mục gốc của dự án bằng cách đi ngược từ thư mục triển khai.
     * Thư mục gốc được xác định là thư mục chứa 'src' hoặc 'pom.xml'.
     */
    private File findProjectRoot(String deployedAppPath) {
        if (deployedAppPath == null) {
            return null;
        }
        File current = new File(deployedAppPath);
        // Lặp lại tối đa 6 cấp để tìm thư mục gốc của dự án
        for (int i = 0; i < 6; i++) {
            if (current == null) {
                break;
            }
            File srcFolder = new File(current, "src");
            File pomFile = new File(current, "pom.xml");
            if ((srcFolder.exists() && srcFolder.isDirectory()) || pomFile.exists()) {
                return current;
            }
            current = current.getParentFile();
        }
        return null; // Không tìm thấy
    }
}