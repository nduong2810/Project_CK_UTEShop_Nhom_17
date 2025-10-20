package com.uteshop.util;

import com.uteshop.dao.NguoiDungDAO;
import com.uteshop.entity.NguoiDung;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Arrays;
import java.util.Date;

/**
 * Template class for adding Vietnamese data to prevent encoding issues
 * Use this class as a reference when adding new Vietnamese data
 */
public class VietnameseDataTemplate {
    
    /**
     * Sample Vietnamese names for testing
     */
    public static final List<String> SAMPLE_VIETNAMESE_NAMES = Arrays.asList(
        "Nguyễn Văn An",
        "Trần Thị Bình", 
        "Lê Hoàng Cường",
        "Phạm Minh Đức",
        "Võ Thị Hương",
        "Đặng Văn Khánh",
        "Bùi Thị Lan",
        "Hoàng Minh Nam",
        "Dương Thị Oanh",
        "Ngô Văn Phong",
        "Trương Thị Mai",
        "Phan Văn Hòa",
        "Lý Thị Kim",
        "Đinh Văn Long",
        "Vũ Thị Ngọc"
    );
    
    /**
     * Sample Vietnamese addresses
     */
    public static final List<String> SAMPLE_VIETNAMESE_ADDRESSES = Arrays.asList(
        "123 Đường Lê Lợi, Quận 1, TP.HCM",
        "456 Nguyễn Huệ, Quận 1, TP.HCM", 
        "789 Trần Hưng Đạo, Quận 5, TP.HCM",
        "12 Võ Văn Ngân, Thủ Đức, TP.HCM",
        "34 Lý Thường Kiệt, Quận 10, TP.HCM",
        "56 Cách Mạng Tháng 8, Quận 3, TP.HCM",
        "78 Hai Bà Trưng, Quận 3, TP.HCM",
        "90 Nguyễn Thị Minh Khai, Quận 1, TP.HCM",
        "11 Điện Biên Phủ, Quận Bình Thạnh, TP.HCM",
        "22 Phan Văn Trị, Quận Gò Vấp, TP.HCM",
        "33 Hoàng Văn Thụ, Quận Phú Nhuận, TP.HCM",
        "44 Nguyễn Văn Cừ, Quận 5, TP.HCM",
        "55 Lê Văn Sỹ, Quận 3, TP.HCM",
        "66 Trường Chinh, Quận Tân Bình, TP.HCM",
        "77 Xô Viết Nghệ Tĩnh, Quận Bình Thạnh, TP.HCM"
    );
    
    /**
     * Sample Vietnamese product names
     */
    public static final List<String> SAMPLE_PRODUCT_NAMES = Arrays.asList(
        "Áo thun nam cao cấp",
        "Túi xách nữ thời trang",
        "Giày thể thao chạy bộ",
        "Đồng hồ thông minh",
        "Điện thoại di động",
        "Máy tính xách tay",
        "Tai nghe không dây",
        "Bàn phím cơ gaming",
        "Chuột máy tính văn phòng",
        "Loa bluetooth mini",
        "Ốp lưng điện thoại",
        "Sạc dự phòng di động",
        "Kính cường lực bảo vệ",
        "Cáp sạc chính hãng",
        "Đế tản nhiệt laptop"
    );
    
    /**
     * Sample Vietnamese product descriptions
     */
    public static final List<String> SAMPLE_PRODUCT_DESCRIPTIONS = Arrays.asList(
        "Sản phẩm chất lượng cao, được nhập khẩu từ Nhật Bản",
        "Thiết kế hiện đại, phù hợp với xu hướng thời trang",
        "Chất liệu bền bỉ, sử dụng được trong thời gian dài",
        "Công nghệ tiên tiến, mang lại trải nghiệm tuyệt vời",
        "Giá cả phải chăng, phù hợp với mọi đối tượng",
        "Bảo hành chính hãng 12 tháng tại Việt Nam",
        "Giao hàng nhanh chóng trong vòng 24 giờ",
        "Hỗ trợ khách hàng 24/7 qua hotline",
        "Đổi trả miễn phí trong vòng 7 ngày",
        "Sản phẩm được yêu thích nhất năm 2024",
        "Thiết kế ergonomic, thoải mái khi sử dụng",
        "Tiết kiệm năng lượng, thân thiện môi trường",
        "Dễ dàng vệ sinh và bảo dưỡng",
        "Phù hợp cho cả nam và nữ mọi lứa tuổi",
        "Được chứng nhận an toàn quốc tế"
    );
    
    /**
     * Create a sample user with Vietnamese data
     * Use this method as template when adding new users
     */
    public static NguoiDung createSampleVietnameseUser(String username, String email) {
        NguoiDung user = new NguoiDung();
        
        // Use VietnameseEncodingUtil to ensure proper encoding
        user.setTenDangNhap(username);
        user.setEmail(email);
        user.setMatKhau("password123"); // In real app, use PasswordUtil.hashPassword()
        
        // Randomly select Vietnamese name and address
        String vietnameseName = SAMPLE_VIETNAMESE_NAMES.get(
            (int)(Math.random() * SAMPLE_VIETNAMESE_NAMES.size())
        );
        String vietnameseAddress = SAMPLE_VIETNAMESE_ADDRESSES.get(
            (int)(Math.random() * SAMPLE_VIETNAMESE_ADDRESSES.size())
        );
        
        user.setHoTen(VietnameseEncodingUtil.prepareVietnameseText(vietnameseName));
        user.setDiaChi(VietnameseEncodingUtil.prepareVietnameseText(vietnameseAddress));
        user.setSoDienThoai("09" + String.format("%08d", (int)(Math.random() * 100000000)));
        user.setVaiTro(NguoiDung.VaiTro.USER);
        user.setTrangThai(true); // Changed from 1 to true
        user.setNgayTao(new java.util.Date());
        
        return user;
    }
    
    /**
     * Create multiple sample Vietnamese users at once
     */
    public static void insertMultipleVietnameseUsers(int count) {
        System.out.println("🇻🇳 Thêm " + count + " người dùng tiếng Việt mẫu...");
        
        NguoiDungDAO dao = new NguoiDungDAO();
        int successCount = 0;
        
        for (int i = 1; i <= count; i++) {
            String username = "vnuser_" + System.currentTimeMillis() + "_" + i;
            String email = "user" + i + "_" + System.currentTimeMillis() + "@uteshop.com";
            
            NguoiDung user = createSampleVietnameseUser(username, email);
            
            boolean success = dao.save(user);
            if (success) {
                successCount++;
                System.out.println("✅ [" + i + "/" + count + "] Tạo thành công: " + user.getHoTen());
            } else {
                System.out.println("❌ [" + i + "/" + count + "] Thất bại: " + user.getHoTen());
            }
        }
        
        System.out.println("🎉 Hoàn thành! Đã tạo thành công " + successCount + "/" + count + " người dùng!");
    }
    
    /**
     * Example method showing how to safely insert Vietnamese data
     */
    public static void insertSampleVietnameseUsers() {
        insertMultipleVietnameseUsers(5);
    }
    
    /**
     * Method to create a Vietnamese user with specific details
     */
    public static NguoiDung createVietnameseUser(String username, String email, String fullName, 
                                                String address, String phone, NguoiDung.VaiTro role) {
        NguoiDung user = new NguoiDung();
        
        user.setTenDangNhap(username);
        user.setEmail(email);
        user.setMatKhau("password123"); // Remember to hash in real app
        user.setHoTen(VietnameseEncodingUtil.prepareVietnameseText(fullName));
        user.setDiaChi(VietnameseEncodingUtil.prepareVietnameseText(address));
        user.setSoDienThoai(phone);
        user.setVaiTro(role);
        user.setTrangThai(true); // Changed from 1 to true
        user.setNgayTao(new java.util.Date());
        
        return user;
    }
    
    /**
     * Validation method to check if Vietnamese text is properly encoded
     */
    public static boolean validateVietnameseText(String text) {
        if (text == null || text.trim().isEmpty()) {
            return true; // Empty text is valid
        }
        
        // Check for common Vietnamese characters
        String[] vietnameseChars = {"ă", "â", "đ", "ê", "ô", "ơ", "ư", "á", "à", "ả", "ã", "ạ"};
        
        boolean hasVietnamese = false;
        for (String vnChar : vietnameseChars) {
            if (text.toLowerCase().contains(vnChar)) {
                hasVietnamese = true;
                break;
            }
        }
        
        // If has Vietnamese characters, check they're not corrupted (no ? marks)
        if (hasVietnamese) {
            return !text.contains("?") && !text.contains("Ã") && !text.contains("â€");
        }
        
        return true; // Non-Vietnamese text is valid
    }
    
    /**
     * Demonstrate creating Vietnamese users with different roles
     */
    public static void demonstrateVietnameseUsers() {
        System.out.println("🎯 Demo tạo người dùng tiếng Việt với các vai trò khác nhau:");
        
        NguoiDungDAO dao = new NguoiDungDAO();
        
        // Create admin user
        NguoiDung admin = createVietnameseUser(
            "admin_vn", 
            "admin.vn@uteshop.com",
            "Nguyễn Thành Nam - Quản trị viên",
            "268 Lý Thường Kiệt, Quận 10, TP.HCM",
            "0901234567",
            NguoiDung.VaiTro.ADMIN
        );
        
        // Create vendor user  
        NguoiDung vendor = createVietnameseUser(
            "vendor_vn",
            "vendor.vn@uteshop.com", 
            "Trần Thị Hoa - Chủ cửa hàng",
            "123 Nguyễn Huệ, Quận 1, TP.HCM",
            "0902345678",
            NguoiDung.VaiTro.VENDOR
        );
        
        // Create shipper user
        NguoiDung shipper = createVietnameseUser(
            "shipper_vn",
            "shipper.vn@uteshop.com",
            "Lê Văn Đức - Nhân viên giao hàng", 
            "456 Võ Văn Tần, Quận 3, TP.HCM",
            "0903456789",
            NguoiDung.VaiTro.SHIPPER
        );
        
        // Save users and show results
        NguoiDung[] users = {admin, vendor, shipper};
        String[] roles = {"Quản trị viên", "Vendor", "Shipper"};
        
        for (int i = 0; i < users.length; i++) {
            boolean success = dao.save(users[i]);
            if (success) {
                System.out.println("✅ " + roles[i] + ": " + users[i].getHoTen() + " | " + users[i].getDiaChi());
            } else {
                System.out.println("❌ Thất bại tạo " + roles[i] + ": " + users[i].getHoTen());
            }
        }
    }
    
    /**
     * Main method for testing Vietnamese data insertion
     */
    public static void main(String[] args) {
        System.out.println("🧪 Testing Vietnamese Data Template...");
        
        // Test sample data creation
        NguoiDung sampleUser = createSampleVietnameseUser("test_template", "template@test.com");
        System.out.println("Sample user created:");
        System.out.println("Name: " + sampleUser.getHoTen());
        System.out.println("Address: " + sampleUser.getDiaChi());
        System.out.println("Phone: " + sampleUser.getSoDienThoai());
        
        // Validate the text
        boolean nameValid = validateVietnameseText(sampleUser.getHoTen());
        boolean addressValid = validateVietnameseText(sampleUser.getDiaChi());
        
        System.out.println("Name validation: " + (nameValid ? "✅ VALID" : "❌ INVALID"));
        System.out.println("Address validation: " + (addressValid ? "✅ VALID" : "❌ INVALID"));
        
        // Uncomment to run demonstrations
        // insertMultipleVietnameseUsers(5);
        // demonstrateVietnameseUsers();
        
        System.out.println("\n📋 Hướng dẫn sử dụng:");
        System.out.println("1. Gọi insertMultipleVietnameseUsers(5) để thêm 5 user mẫu");
        System.out.println("2. Gọi demonstrateVietnameseUsers() để tạo user với vai trò khác nhau");
        System.out.println("3. Sử dụng createVietnameseUser() để tạo user với thông tin cụ thể");
        System.out.println("4. Luôn sử dụng validateVietnameseText() để kiểm tra encoding");
    }
}