package com.uteshop.service;

import java.time.LocalDateTime;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class OTPService {
    private static OTPService instance;
    private final ConcurrentHashMap<String, OTPData> otpStorage = new ConcurrentHashMap<>();
    private final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(2);
    
    // OTP có hiệu lực trong 5 phút
    private static final int OTP_EXPIRY_MINUTES = 5;
    
    private OTPService() {
        // Tự động xóa OTP hết hạn mỗi phút
        scheduler.scheduleAtFixedRate(this::cleanExpiredOTPs, 1, 1, TimeUnit.MINUTES);
    }
    
    public static synchronized OTPService getInstance() {
        if (instance == null) {
            instance = new OTPService();
        }
        return instance;
    }
    
    /**
     * Tạo OTP mới cho email/phone
     * @param identifier Email hoặc số điện thoại
     * @param type "EMAIL" hoặc "SMS" hoặc "FORGOT_PASSWORD"
     * @return OTP code (6 chữ số)
     */
    public String generateOTP(String identifier, String type) {
        // Tạo OTP 6 chữ số
        Random random = new Random();
        String otpCode = String.format("%06d", random.nextInt(1000000));
        
        // Lưu trữ OTP với thời gian hết hạn
        OTPData otpData = new OTPData(otpCode, type, LocalDateTime.now().plusMinutes(OTP_EXPIRY_MINUTES));
        otpStorage.put(identifier.toLowerCase().trim(), otpData);
        
        System.out.println("Generated OTP: " + otpCode + " for " + identifier + " (Type: " + type + ")");
        return otpCode;
    }
    
    /**
     * Xác thực OTP
     * @param identifier Email hoặc số điện thoại
     * @param otpCode Mã OTP người dùng nhập
     * @return true nếu OTP hợp lệ
     */
    public boolean verifyOTP(String identifier, String otpCode) {
        String key = identifier.toLowerCase().trim();
        OTPData otpData = otpStorage.get(key);
        
        if (otpData == null) {
            System.out.println("OTP not found for: " + identifier);
            return false;
        }
        
        if (otpData.isExpired()) {
            System.out.println("OTP expired for: " + identifier);
            otpStorage.remove(key);
            return false;
        }
        
        boolean isValid = otpData.getCode().equals(otpCode.trim());
        if (isValid) {
            // Xóa OTP sau khi xác thực thành công
            otpStorage.remove(key);
            System.out.println("OTP verified successfully for: " + identifier);
        } else {
            System.out.println("Invalid OTP for: " + identifier);
        }
        
        return isValid;
    }
    
    /**
     * Kiểm tra xem có thể gửi lại OTP không (tránh spam)
     * @param identifier Email hoặc số điện thoại
     * @return true nếu có thể gửi lại
     */
    public boolean canResendOTP(String identifier) {
        String key = identifier.toLowerCase().trim();
        OTPData otpData = otpStorage.get(key);
        
        if (otpData == null) {
            return true; // Chưa có OTP nào được tạo
        }
        
        // Chỉ cho phép gửi lại sau 1 phút
        LocalDateTime oneMinuteAgo = LocalDateTime.now().minusMinutes(1);
        return otpData.getCreatedAt().isBefore(oneMinuteAgo);
    }
    
    /**
     * Xóa OTP hết hạn định kỳ
     */
    private void cleanExpiredOTPs() {
        LocalDateTime now = LocalDateTime.now();
        otpStorage.entrySet().removeIf(entry -> entry.getValue().isExpired());
        System.out.println("Cleaned expired OTPs at: " + now);
    }
    
    /**
     * Xóa OTP theo identifier
     * @param identifier Email hoặc số điện thoại
     */
    public void removeOTP(String identifier) {
        String key = identifier.toLowerCase().trim();
        otpStorage.remove(key);
        System.out.println("Removed OTP for: " + identifier);
    }
    
    /**
     * Lấy thông tin OTP (dùng để debug)
     * @param identifier Email hoặc số điện thoại
     * @return OTP data hoặc null nếu không tồn tại
     */
    public OTPData getOTPData(String identifier) {
        String key = identifier.toLowerCase().trim();
        return otpStorage.get(key);
    }
    
    /**
     * Đóng service và dọn dẹp resources
     */
    public void shutdown() {
        scheduler.shutdown();
        otpStorage.clear();
        System.out.println("OTPService shutdown completed");
    }
    
    /**
     * Class lưu trữ thông tin OTP
     */
    public static class OTPData {
        private final String code;
        private final String type;
        private final LocalDateTime expiryTime;
        private final LocalDateTime createdAt;
        
        public OTPData(String code, String type, LocalDateTime expiryTime) {
            this.code = code;
            this.type = type;
            this.expiryTime = expiryTime;
            this.createdAt = LocalDateTime.now();
        }
        
        public String getCode() {
            return code;
        }
        
        public String getType() {
            return type;
        }
        
        public LocalDateTime getExpiryTime() {
            return expiryTime;
        }
        
        public LocalDateTime getCreatedAt() {
            return createdAt;
        }
        
        public boolean isExpired() {
            return LocalDateTime.now().isAfter(expiryTime);
        }
        
        public long getRemainingMinutes() {
            if (isExpired()) {
                return 0;
            }
            return java.time.Duration.between(LocalDateTime.now(), expiryTime).toMinutes();
        }
        
        @Override
        public String toString() {
            return String.format("OTPData{code='***', type='%s', expiryTime=%s, expired=%s}", 
                    type, expiryTime, isExpired());
        }
    }
}