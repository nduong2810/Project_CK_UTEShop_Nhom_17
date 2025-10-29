-- Script cập nhật thông tin QR Code cho các cửa hàng
-- Chạy script này để thêm dữ liệu QR code mẫu

-- Cập nhật thông tin thanh toán cho cửa hàng TechZone (maCH = 1)
UPDATE cuahang 
SET 
    bank_enable = TRUE,
    bank_name = 'Vietcombank',
    bank_account_number = '0123456789',
    bank_account_name = 'NGUYEN VAN A',
    bank_qr = 'techzone_bank_qr.png',
    momo_enable = TRUE,
    momo_phone = '0901234567',
    momo_name = 'NGUYEN VAN A',
    momo_qr = 'techzone_momo_qr.png'
WHERE ma_ch = 1;

-- Cập nhật thông tin thanh toán cho cửa hàng FashionHub (maCH = 2)
UPDATE cuahang 
SET 
    bank_enable = TRUE,
    bank_name = 'Techcombank',
    bank_account_number = '9876543210',
    bank_account_name = 'TRAN THI B',
    bank_qr = 'fashionhub_bank_qr.png',
    momo_enable = TRUE,
    momo_phone = '0912345678',
    momo_name = 'TRAN THI B',
    momo_qr = 'fashionhub_momo_qr.png'
WHERE ma_ch = 2;

-- Cập nhật thông tin thanh toán cho cửa hàng HomeDecor (maCH = 3)
UPDATE cuahang 
SET 
    bank_enable = TRUE,
    bank_name = 'VPBank',
    bank_account_number = '1122334455',
    bank_account_name = 'LE VAN C',
    bank_qr = 'homedecor_bank_qr.png',
    momo_enable = TRUE,
    momo_phone = '0923456789',
    momo_name = 'LE VAN C',
    momo_qr = 'homedecor_momo_qr.png'
WHERE ma_ch = 3;

-- Xem kết quả
SELECT ma_ch, ten_ch, bank_enable, bank_name, bank_qr, momo_enable, momo_qr 
FROM cuahang 
WHERE ma_ch IN (1, 2, 3);
