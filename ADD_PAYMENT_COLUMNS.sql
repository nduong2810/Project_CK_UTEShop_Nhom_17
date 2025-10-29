-- ========================================
-- THÊM CÁC CỘT THANH TOÁN VÀO BẢNG CUAHANG
-- ========================================

USE UTESHOP;
GO

PRINT '🚀 BẮT ĐẦU THÊM CÁC CỘT THANH TOÁN...';
PRINT '';

-- Kiểm tra và thêm các cột thanh toán Bank
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'BankEnable')
BEGIN
    ALTER TABLE CuaHang ADD BankEnable BIT DEFAULT 0;
    PRINT '✅ Đã thêm cột: BankEnable';
END
ELSE
    PRINT '⚠️ Cột BankEnable đã tồn tại';

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'BankName')
BEGIN
    ALTER TABLE CuaHang ADD BankName NVARCHAR(255) NULL;
    PRINT '✅ Đã thêm cột: BankName';
END
ELSE
    PRINT '⚠️ Cột BankName đã tồn tại';

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'BankAccountNumber')
BEGIN
    ALTER TABLE CuaHang ADD BankAccountNumber NVARCHAR(50) NULL;
    PRINT '✅ Đã thêm cột: BankAccountNumber';
END
ELSE
    PRINT '⚠️ Cột BankAccountNumber đã tồn tại';

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'BankAccountName')
BEGIN
    ALTER TABLE CuaHang ADD BankAccountName NVARCHAR(255) NULL;
    PRINT '✅ Đã thêm cột: BankAccountName';
END
ELSE
    PRINT '⚠️ Cột BankAccountName đã tồn tại';

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'BankQR')
BEGIN
    ALTER TABLE CuaHang ADD BankQR NVARCHAR(500) NULL;
    PRINT '✅ Đã thêm cột: BankQR';
END
ELSE
    PRINT '⚠️ Cột BankQR đã tồn tại';

-- Kiểm tra và thêm các cột thanh toán MoMo
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'MomoEnable')
BEGIN
    ALTER TABLE CuaHang ADD MomoEnable BIT DEFAULT 0;
    PRINT '✅ Đã thêm cột: MomoEnable';
END
ELSE
    PRINT '⚠️ Cột MomoEnable đã tồn tại';

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'MomoPhone')
BEGIN
    ALTER TABLE CuaHang ADD MomoPhone NVARCHAR(15) NULL;
    PRINT '✅ Đã thêm cột: MomoPhone';
END
ELSE
    PRINT '⚠️ Cột MomoPhone đã tồn tại';

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'MomoName')
BEGIN
    ALTER TABLE CuaHang ADD MomoName NVARCHAR(255) NULL;
    PRINT '✅ Đã thêm cột: MomoName';
END
ELSE
    PRINT '⚠️ Cột MomoName đã tồn tại';

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CuaHang') AND name = 'MomoQR')
BEGIN
    ALTER TABLE CuaHang ADD MomoQR NVARCHAR(500) NULL;
    PRINT '✅ Đã thêm cột: MomoQR';
END
ELSE
    PRINT '⚠️ Cột MomoQR đã tồn tại';

GO

PRINT '';
PRINT '========================================';
PRINT '✅ HOÀN TẤT THÊM CÁC CỘT!';
PRINT '========================================';
PRINT '';

-- Cập nhật dữ liệu mẫu cho TẤT CẢ cửa hàng
PRINT '📝 Đang cập nhật dữ liệu mẫu...';

UPDATE CuaHang 
SET 
    BankEnable = 1,
    BankName = N'Vietcombank',
    BankAccountNumber = N'1234567890',
    BankAccountName = N'CUA HANG ' + TenCH,
    BankQR = N'qr_sample.png',
    MomoEnable = 1,
    MomoPhone = N'0901234567',
    MomoName = N'CUA HANG ' + TenCH,
    MomoQR = N'qr_sample.png';

PRINT '✅ Đã cập nhật dữ liệu cho ' + CAST(@@ROWCOUNT AS NVARCHAR) + ' cửa hàng!';
PRINT '';

-- Kiểm tra kết quả
PRINT '📊 KẾT QUẢ CẬP NHẬT:';
SELECT 
    MaCH AS 'ID',
    TenCH AS N'Tên cửa hàng',
    BankEnable AS 'Bank',
    BankName AS N'Ngân hàng',
    BankAccountNumber AS 'STK',
    BankQR AS 'QR Bank',
    MomoEnable AS 'MoMo',
    MomoPhone AS 'SĐT',
    MomoQR AS 'QR MoMo'
FROM CuaHang
ORDER BY MaCH;

PRINT '';
PRINT '========================================';
PRINT '🎉 HOÀN TẤT!';
PRINT '========================================';
PRINT '';
PRINT '📝 BƯỚC TIẾP THEO:';
PRINT '1. Tạo file QR mẫu: mở TAO_QR_CODE.html';
PRINT '2. Tải file qr_sample.png';
PRINT '3. Đặt vào: src/main/webapp/assets/img/qr/';
PRINT '4. Khởi động lại Tomcat server';
PRINT '5. Test thanh toán → QR sẽ hiển thị!';
PRINT '========================================';
GO
