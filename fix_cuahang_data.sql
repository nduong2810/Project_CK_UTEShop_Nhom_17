-- ================================================
-- FIX: Đảm bảo mỗi VENDOR chỉ có 1 CỬA HÀNG
-- Database: UTESHOP
-- Date: 2025-10-28
-- ================================================

USE UTESHOP;
GO

PRINT N'🔍 Bắt đầu kiểm tra và sửa dữ liệu cửa hàng...';
GO

-- Kiểm tra các vendor có nhiều hơn 1 cửa hàng
PRINT N'📊 Danh sách các vendor có nhiều cửa hàng:';
SELECT 
    nd.MaND,
    nd.TenDangNhap,
    nd.HoTen,
    COUNT(ch.MaCH) as SoLuongCuaHang
FROM NguoiDung nd
LEFT JOIN CuaHang ch ON nd.MaND = ch.MaND
WHERE nd.VaiTro = 'VENDOR'
GROUP BY nd.MaND, nd.TenDangNhap, nd.HoTen
HAVING COUNT(ch.MaCH) > 1;
GO

-- Xóa các cửa hàng trùng lặp, chỉ giữ lại cửa hàng đầu tiên (theo NgayTao)
PRINT N'🗑️ Xóa các cửa hàng trùng lặp...';

-- Tạo bảng tạm chứa các cửa hàng cần giữ lại (cửa hàng đầu tiên của mỗi vendor)
WITH FirstShops AS (
    SELECT 
        MaND,
        MIN(MaCH) as FirstShopId
    FROM CuaHang
    GROUP BY MaND
)
-- Xóa các cửa hàng không phải là cửa hàng đầu tiên
DELETE FROM CuaHang
WHERE MaCH NOT IN (SELECT FirstShopId FROM FirstShops);

PRINT N'✅ Đã xóa các cửa hàng trùng lặp!';
GO

-- Kiểm tra lại sau khi xóa
PRINT N'📊 Kiểm tra lại sau khi sửa:';
SELECT 
    nd.MaND,
    nd.TenDangNhap,
    nd.HoTen,
    nd.VaiTro,
    ch.MaCH,
    ch.TenCH,
    ch.TrangThai
FROM NguoiDung nd
LEFT JOIN CuaHang ch ON nd.MaND = ch.MaND
WHERE nd.VaiTro = 'VENDOR'
ORDER BY nd.MaND;
GO

-- Đảm bảo các vendor trong NguoiDung có vai trò đúng
PRINT N'🔧 Cập nhật vai trò VENDOR cho người dùng có cửa hàng...';
UPDATE NguoiDung
SET VaiTro = 'VENDOR'
WHERE MaND IN (SELECT DISTINCT MaND FROM CuaHang)
  AND VaiTro != 'VENDOR';

PRINT N'✅ Hoàn tất cập nhật vai trò!';
GO

-- Thống kê cuối cùng
PRINT N'📈 Thống kê cuối cùng:';
SELECT 
    N'Tổng số VENDOR' as ThongKe,
    COUNT(*) as SoLuong
FROM NguoiDung 
WHERE VaiTro = 'VENDOR'
UNION ALL
SELECT 
    N'Tổng số cửa hàng' as ThongKe,
    COUNT(*) as SoLuong
FROM CuaHang
UNION ALL
SELECT 
    N'Vendor có cửa hàng' as ThongKe,
    COUNT(DISTINCT ch.MaND) as SoLuong
FROM CuaHang ch
INNER JOIN NguoiDung nd ON ch.MaND = nd.MaND
WHERE nd.VaiTro = 'VENDOR';
GO

PRINT N'✅ ✅ ✅ HOÀN TẤT SỬA DỮ LIỆU! ✅ ✅ ✅';
GO
