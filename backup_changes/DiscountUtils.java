package com.uteshop.utils;

import com.uteshop.entity.MaGiamGia;
import java.time.LocalDateTime;

/**
 * Utility class cho các thao tác liên quan đến mã giảm giá
 */
public class DiscountUtils {
    
    /**
     * Kiểm tra xem mã giảm giá có thể xóa được không
     * Điều kiện: Đã hết hạn HOẶC hết lượt sử dụng
     */
    public static boolean canDelete(MaGiamGia discount) {
        if (discount == null) {
            return false;
        }
        
        LocalDateTime now = LocalDateTime.now();
        
        // Kiểm tra hết hạn (ngày kết thúc hoặc hạn sử dụng)
        boolean isExpired = false;
        if ((discount.getNgayKetThuc() != null && now.isAfter(discount.getNgayKetThuc())) ||
            (discount.getHanSuDung() != null && now.isAfter(discount.getHanSuDung()))) {
            isExpired = true;
        }
        
        // Kiểm tra hết lượt sử dụng
        boolean isOutOfUses = false;
        if (discount.getSoLuongToiDa() != null && 
            discount.getSoLuongDaSuDung() >= discount.getSoLuongToiDa()) {
            isOutOfUses = true;
        }
        
        // Có thể xóa khi hết hạn HOẶC hết lượt
        return isExpired || isOutOfUses;
    }
    
    /**
     * Lấy lý do tại sao không thể xóa mã giảm giá
     */
    public static String getDeleteRestrictionReason(MaGiamGia discount) {
        if (discount == null) {
            return "Mã giảm giá không tồn tại";
        }
        
        if (canDelete(discount)) {
            return null; // Có thể xóa
        }
        
        LocalDateTime now = LocalDateTime.now();
        
        // Kiểm tra các điều kiện chưa đạt
        boolean isActive = true;
        if (discount.getNgayKetThuc() != null && now.isAfter(discount.getNgayKetThuc())) {
            isActive = false;
        }
        if (discount.getHanSuDung() != null && now.isAfter(discount.getHanSuDung())) {
            isActive = false;
        }
        
        boolean hasRemainingUses = true;
        if (discount.getSoLuongToiDa() != null && 
            discount.getSoLuongDaSuDung() >= discount.getSoLuongToiDa()) {
            hasRemainingUses = false;
        }
        
        if (isActive && hasRemainingUses) {
            return "Mã giảm giá vẫn còn hiệu lực và còn lượt sử dụng";
        } else if (isActive) {
            return "Mã giảm giá vẫn còn hiệu lực";
        } else if (hasRemainingUses) {
            return "Mã giảm giá vẫn còn lượt sử dụng";
        }
        
        return "Chưa đủ điều kiện để xóa";
    }
    
    /**
     * Kiểm tra mã giảm giá có đang hoạt động không
     */
    public static boolean isActive(MaGiamGia discount) {
        if (discount == null || !discount.isTrangThai()) {
            return false;
        }
        
        LocalDateTime now = LocalDateTime.now();
        
        // Kiểm tra thời gian
        if (discount.getNgayBatDau() != null && now.isBefore(discount.getNgayBatDau())) {
            return false; // Chưa đến thời gian bắt đầu
        }
        
        if (discount.getNgayKetThuc() != null && now.isAfter(discount.getNgayKetThuc())) {
            return false; // Đã hết thời gian
        }
        
        if (discount.getHanSuDung() != null && now.isAfter(discount.getHanSuDung())) {
            return false; // Đã hết hạn sử dụng
        }
        
        // Kiểm tra số lượng
        if (discount.getSoLuongToiDa() != null && 
            discount.getSoLuongDaSuDung() >= discount.getSoLuongToiDa()) {
            return false; // Đã hết lượt sử dụng
        }
        
        return true;
    }
}