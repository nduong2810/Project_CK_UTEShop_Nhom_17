-- ============================================================
-- FIX: Sửa lỗi ConstraintViolationException khi thanh toán
-- Lỗi: CHECK constraint không chứa 'BANK_TRANSFER'
-- ============================================================

USE uteshop;
GO

-- BƯỚC 1: Tìm tên constraint cũ
-- Chạy query này để xem tên constraint hiện tại:
SELECT 
    OBJECT_NAME(parent_object_id) AS TableName,
    name AS ConstraintName,
    definition AS ConstraintDefinition
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('DonHang')
  AND OBJECT_NAME(object_id) LIKE '%phuongT%';

-- KẾT QUẢ: ConstraintName = CK__DonHang__phuongT__282DF8C2 (hoặc tương tự)
-- Definition: ([phuongThucThanhToan]='MOMO' OR [phuongThucThanhToan]='VNPAY' OR [phuongThucThanhToan]='COD')

-- ============================================================
-- BƯỚC 2: Xóa constraint cũ
-- ============================================================
-- ⚠️ CHÚ Ý: Thay tên constraint bên dưới nếu tên của bạn khác
ALTER TABLE [dbo].[DonHang]
DROP CONSTRAINT CK__DonHang__phuongT__282DF8C2;
GO

-- ============================================================
-- BƯỚC 3: Tạo constraint mới với đầy đủ các giá trị
-- ============================================================
ALTER TABLE [dbo].[DonHang]
ADD CONSTRAINT CK_DonHang_PhuongThucThanhToan
CHECK ([phuongThucThanhToan] IN ('COD', 'BANK_TRANSFER', 'MOMO', 'VNPAY'));
GO

-- ============================================================
-- BƯỚC 4: Kiểm tra kết quả
-- ============================================================
-- Xem lại constraint mới:
SELECT 
    OBJECT_NAME(parent_object_id) AS TableName,
    name AS ConstraintName,
    definition AS ConstraintDefinition
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('DonHang')
  AND name = 'CK_DonHang_PhuongThucThanhToan';

-- ============================================================
-- HOÀN THÀNH!
-- ============================================================
-- Bây giờ database đã chấp nhận:
-- ✅ 'COD' - Thanh toán khi nhận hàng
-- ✅ 'BANK_TRANSFER' - Chuyển khoản ngân hàng
-- ✅ 'MOMO' - Ví MoMo
-- ✅ 'VNPAY' - Ví VNPay (dự phòng cho tương lai)
-- ============================================================
