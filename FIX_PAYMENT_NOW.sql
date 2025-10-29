-- ========================================
-- CHẠY NGAY ĐỂ SỬA LỖI THANH TOÁN
-- ========================================

USE uteshop;
GO

-- Bước 1: Tìm và xóa tất cả constraint cũ liên quan đến phuongThucThanhToan
DECLARE @ConstraintName NVARCHAR(200);
DECLARE @SQL NVARCHAR(MAX);

-- Tìm constraint name
SELECT @ConstraintName = name 
FROM sys.check_constraints 
WHERE parent_object_id = OBJECT_ID('DonHang') 
  AND definition LIKE '%phuongThucThanhToan%'
  AND definition NOT LIKE '%BANK_TRANSFER%';

-- Xóa constraint nếu tồn tại
IF @ConstraintName IS NOT NULL
BEGIN
    SET @SQL = 'ALTER TABLE [dbo].[DonHang] DROP CONSTRAINT [' + @ConstraintName + ']';
    PRINT 'Đang xóa constraint cũ: ' + @ConstraintName;
    EXEC sp_executesql @SQL;
    PRINT '✅ Đã xóa constraint cũ!';
END
ELSE
BEGIN
    PRINT '⚠️ Không tìm thấy constraint cũ (có thể đã được xóa rồi)';
END
GO

-- Bước 2: Tạo constraint mới (đúng) - Kiểm tra xem đã tồn tại chưa
IF NOT EXISTS (
    SELECT 1 
    FROM sys.check_constraints 
    WHERE name = 'CK_DonHang_PaymentMethod'
)
BEGIN
    ALTER TABLE [dbo].[DonHang]
    ADD CONSTRAINT CK_DonHang_PaymentMethod
    CHECK ([phuongThucThanhToan] IN ('COD', 'BANK_TRANSFER', 'MOMO', 'VNPAY'));
    PRINT '✅ Đã tạo constraint mới với BANK_TRANSFER!';
END
ELSE
BEGIN
    PRINT '⚠️ Constraint mới đã tồn tại rồi!';
END
GO

-- Bước 3: Kiểm tra kết quả
SELECT 
    name AS ConstraintName,
    definition AS ConstraintDefinition
FROM sys.check_constraints 
WHERE parent_object_id = OBJECT_ID('DonHang') 
  AND definition LIKE '%phuongThucThanhToan%';

PRINT '';
PRINT '========================================';
PRINT '🎉 SUCCESS! Constraint đã được sửa!';
PRINT '========================================';
PRINT 'Bây giờ các phương thức sau được chấp nhận:';
PRINT '✅ COD';
PRINT '✅ BANK_TRANSFER';
PRINT '✅ MOMO';
PRINT '✅ VNPAY';
PRINT '';
PRINT '➡️ Bây giờ hãy thử đặt hàng lại!';
PRINT '========================================';
GO
