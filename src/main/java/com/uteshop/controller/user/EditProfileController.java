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
    private static final String PROJECT_FOLDER_NAME = "Project_CK_UTEShop_Nhom_17";
    private static File cachedProjectDir = null;

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

        // === Lấy thông tin từ form ===
        user.setHoTen(request.getParameter("hoTen"));
        user.setEmail(request.getParameter("email"));
        user.setSoDienThoai(request.getParameter("soDienThoai"));
        user.setGioiTinh(request.getParameter("gioiTinh"));
        user.setDiaChi(request.getParameter("diaChi"));

        // === Upload ảnh nếu có ===
        Part filePart = request.getPart("avatar");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            // 1️⃣ Lưu vào thư mục Tomcat
            String deployPath = getServletContext().getRealPath(AVATAR_DIR);
            File deployDir = new File(deployPath);
            if (!deployDir.exists()) deployDir.mkdirs();

            File deployFile = new File(deployDir, fileName);
            try (InputStream in = filePart.getInputStream()) {
                Files.copy(in, deployFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            System.out.println("✅ Saved to deploy: " + deployFile.getAbsolutePath());

            // 2️⃣ Copy sang thư mục project gốc (nếu có)
            if (cachedProjectDir == null || !cachedProjectDir.exists()) {
                cachedProjectDir = findProjectFolder(PROJECT_FOLDER_NAME);
            }

            if (cachedProjectDir != null) {
                File targetDir = new File(cachedProjectDir, "src/main/webapp/assets/avatar");
                if (targetDir.exists() && targetDir.isDirectory()) {
                    File targetFile = new File(targetDir, fileName);
                    try (InputStream in = filePart.getInputStream()) {
                        Files.copy(in, targetFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }
                    System.out.println("✅ Copied to project source: " + targetFile.getAbsolutePath());
                } else {
                    System.err.println("⚠️ Không tìm thấy thư mục avatar trong project, bỏ qua copy.");
                }
            } else {
                System.err.println("⚠️ Không tìm thấy thư mục project thật, bỏ qua copy.");
            }

            // Cập nhật tên file vào DB
            user.setAvatar(fileName);
        }

        // === Gọi DAO để cập nhật thông tin người dùng ===
        dao.update(user);

        // === Làm mới session và phản hồi ===
        session.setAttribute("user", user);
        request.setAttribute("user", user);
        request.setAttribute("message", "Cập nhật hồ sơ thành công!");
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
    }

    /** Quét ổ đĩa để tìm thư mục project thật (không tạo mới) */
    private File findProjectFolder(String folderName) {
        File[] roots = File.listRoots();
        for (File root : roots) {
            File found = searchFolder(root, folderName, 5);
            if (found != null) return found;
        }
        return null;
    }

    private File searchFolder(File dir, String target, int depth) {
        if (depth == 0 || dir == null || !dir.isDirectory()) return null;
        File[] subDirs = dir.listFiles(File::isDirectory);
        if (subDirs == null) return null;

        for (File sub : subDirs) {
            if (sub.getName().equalsIgnoreCase(target)) return sub;
            File found = searchFolder(sub, target, depth - 1);
            if (found != null) return found;
        }
        return null;
    }
}
