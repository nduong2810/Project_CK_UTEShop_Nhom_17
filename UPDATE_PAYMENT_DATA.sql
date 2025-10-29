-- ========================================
-- CẬP NHẬT DỮ LIỆU THANH TOÁN VÀ QR CODE
-- Chạy script này để thêm thông tin thanh toán mẫu
-- ========================================

USE UTEShop;
GO

-- Kiểm tra các cửa hàng hiện có
PRINT '📋 Danh sách cửa hàng:';
SELECT MaCH, TenCH FROM CuaHang;
PRINT '';
GO

-- Cập nhật thông tin thanh toán cho TẤT CẢ các cửa hàng
UPDATE CuaHang 
SET 
    BankEnable = 1,
    BankName = N'Vietcombank',
    BankAccountNumber = N'1234567890',
    BankAccountName = N'NGUYEN VAN A',
    BankQR = N'qr_sample.png',
    MomoEnable = 1,
    MomoPhone = N'0901234567',
    MomoName = N'NGUYEN VAN A',
    MomoQR = N'qr_sample.png';

PRINT '✅ Đã cập nhật thông tin thanh toán cho TẤT CẢ cửa hàng!';
PRINT '';
GO

-- Kiểm tra kết quả
PRINT '📊 KẾT QUẢ:';
SELECT 
    MaCH AS 'ID',
    TenCH AS N'Tên cửa hàng',
    BankEnable AS 'Bank',
    BankName AS N'Ngân hàng',
    BankAccountNumber AS 'STK',
    BankQR AS 'QR File',
    MomoEnable AS 'MoMo',
    MomoPhone AS 'SĐT MoMo'
FROM CuaHang;
GO

PRINT '';
PRINT '========================================';
PRINT '🎉 HOÀN TẤT!';
PRINT '========================================';
PRINT '';
PRINT '📝 BƯỚC TIẾP THEO:';
PRINT '1. Tải ảnh QR mẫu (tôi sẽ tạo cho bạn)';
PRINT '2. Đặt vào: src/main/webapp/assets/img/qr/';
PRINT '3. Tên file: qr_sample.png';
PRINT '4. Khởi động lại server';
PRINT '5. Test trang thanh toán!';
PRINT '';
PRINT '✨ Hoặc tạo QR thật tại:';
PRINT '   - Bank: https://qr.sepay.vn/';
PRINT '   - MoMo: Vào app MoMo > Mã QR > Lưu ảnh';
PRINT '========================================';
GO
