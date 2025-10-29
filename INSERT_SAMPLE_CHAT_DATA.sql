-- =============================================
-- SCRIPT TẠO DỮ LIỆU MẪU CHO CHAT - UTESHOP
-- Chạy file này SAU KHI đã tạo bảng HoiThoai và TinNhan
-- =============================================

USE UTESHOP;
GO

PRINT 'Bắt đầu tạo dữ liệu mẫu cho chat...';
GO

-- Lấy thông tin user và shop để tạo dữ liệu mẫu
DECLARE @KhachHangID INT;
DECLARE @CuaHangID INT;

-- Lấy ID của khách hàng đầu tiên (vai trò CUSTOMER)
SELECT TOP 1 @KhachHangID = MaND FROM NguoiDung WHERE VaiTro = 'CUSTOMER' ORDER BY MaND;

-- Lấy ID của cửa hàng đầu tiên
SELECT TOP 1 @CuaHangID = MaCH FROM CuaHang WHERE TrangThai = 1 ORDER BY MaCH;

-- Kiểm tra nếu có dữ liệu
IF @KhachHangID IS NULL OR @CuaHangID IS NULL
BEGIN
    PRINT 'CẢNH BÁO: Không tìm thấy khách hàng hoặc cửa hàng trong database!';
    PRINT 'Vui lòng đảm bảo có ít nhất 1 user với vai trò CUSTOMER và 1 cửa hàng hoạt động.';
END
ELSE
BEGIN
    PRINT 'Khách hàng ID: ' + CAST(@KhachHangID AS VARCHAR);
    PRINT 'Cửa hàng ID: ' + CAST(@CuaHangID AS VARCHAR);
    
    -- Xóa dữ liệu cũ nếu có (để test lại)
    DELETE FROM TinNhan WHERE MaHoiThoai IN (SELECT MaHoiThoai FROM HoiThoai WHERE MaKhachHang = @KhachHangID AND MaCuaHang = @CuaHangID);
    DELETE FROM HoiThoai WHERE MaKhachHang = @KhachHangID AND MaCuaHang = @CuaHangID;
    
    -- Tạo hội thoại mẫu
    DECLARE @HoiThoaiID INT;
    
    INSERT INTO HoiThoai (MaKhachHang, MaCuaHang, TinNhanCuoi, NgayTaoHoiThoai, NgayCapNhat, SoTinNhanChuaDoc, NguoiGuiCuoi, TrangThai)
    VALUES (@KhachHangID, @CuaHangID, N'Cảm ơn bạn! Tôi sẽ đặt hàng ngay.', DATEADD(HOUR, -2, GETDATE()), GETDATE(), 0, @KhachHangID, 1);
    
    SET @HoiThoaiID = SCOPE_IDENTITY();
    PRINT 'Đã tạo hội thoại ID: ' + CAST(@HoiThoaiID AS VARCHAR);
    
    -- Lấy MaND của chủ cửa hàng
    DECLARE @VendorID INT;
    SELECT @VendorID = MaND FROM CuaHang WHERE MaCH = @CuaHangID;
    
    -- Tạo các tin nhắn mẫu (cuộc trò chuyện giữa khách hàng và shop)
    
    -- Tin nhắn 1: Khách hàng chào hỏi (2 giờ trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @KhachHangID, N'Xin chào shop! Tôi muốn hỏi về sản phẩm của shop.', DATEADD(HOUR, -2, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 2: Shop trả lời (1 giờ 55 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @VendorID, N'Xin chào! Cảm ơn bạn đã quan tâm đến shop. Bạn muốn hỏi về sản phẩm nào ạ?', DATEADD(MINUTE, -115, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 3: Khách hàng hỏi chi tiết (1 giờ 50 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @KhachHangID, N'Tôi thấy có sản phẩm rất ưng ý, nhưng không biết còn hàng không? Và có ship nhanh được không?', DATEADD(MINUTE, -110, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 4: Shop trả lời (1 giờ 45 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @VendorID, N'Dạ sản phẩm shop vẫn còn hàng ạ! Hiện tại shop đang có chương trình ship nhanh trong 24h cho khu vực nội thành. Bạn ở khu vực nào ạ?', DATEADD(MINUTE, -105, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 5: Khách hàng (1 giờ 40 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @KhachHangID, N'Tôi ở Quận 1, TP.HCM. Vậy là tốt quá! Shop có giảm giá thêm cho khách hàng mới không?', DATEADD(MINUTE, -100, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 6: Shop (1 giờ 35 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @VendorID, N'Dạ bên shop đang có mã giảm giá 15% cho đơn hàng đầu tiên ạ! Mã: WELCOME15. Bạn nhập mã này khi thanh toán nhé!', DATEADD(MINUTE, -95, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 7: Khách hàng (1 giờ 30 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @KhachHangID, N'Tuyệt vời! Còn về chất lượng sản phẩm thì sao shop? Có bảo hành không ạ?', DATEADD(MINUTE, -90, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 8: Shop (1 giờ 25 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @VendorID, N'Dạ shop cam kết 100% hàng chính hãng ạ! Tất cả sản phẩm đều có tem bảo hành 12 tháng của hãng. Nếu có bất kỳ vấn đề gì, bạn có thể đổi trả trong vòng 7 ngày nha!', DATEADD(MINUTE, -85, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 9: Khách hàng (1 giờ 20 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @KhachHangID, N'Ồ thế thì yên tâm rồi! Vậy tôi order luôn nhé. Shop có hỗ trợ thanh toán COD không?', DATEADD(MINUTE, -80, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 10: Shop (1 giờ 15 phút trước)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @VendorID, N'Dạ có ạ! Shop hỗ trợ cả COD và chuyển khoản. Nếu chuyển khoản trước, shop sẽ ưu tiên xử lý đơn nhanh hơn và tặng thêm quà nhỏ nhé! 🎁', DATEADD(MINUTE, -75, GETDATE()), 1, 'TEXT');
    
    -- Tin nhắn 11: Khách hàng (5 phút trước - tin nhắn mới nhất)
    INSERT INTO TinNhan (MaHoiThoai, MaNguoiGui, NoiDung, NgayGui, DaDoc, LoaiTinNhan)
    VALUES (@HoiThoaiID, @KhachHangID, N'Cảm ơn shop! Tôi sẽ đặt hàng ngay.', DATEADD(MINUTE, -5, GETDATE()), 1, 'TEXT');
    
    PRINT 'Đã tạo 11 tin nhắn mẫu thành công!';
    
    -- Cập nhật lại tin nhắn cuối cùng và thời gian
    UPDATE HoiThoai 
    SET TinNhanCuoi = N'Cảm ơn shop! Tôi sẽ đặt hàng ngay.',
        NgayCapNhat = DATEADD(MINUTE, -5, GETDATE()),
        NguoiGuiCuoi = @KhachHangID,
        SoTinNhanChuaDoc = 0
    WHERE MaHoiThoai = @HoiThoaiID;
    
    -- Hiển thị kết quả
    SELECT 'THỐNG KÊ DỮ LIỆU MẪU' AS ThongKe;
    SELECT 'Số hội thoại' AS LoaiDuLieu, COUNT(*) AS SoLuong FROM HoiThoai WHERE MaKhachHang = @KhachHangID
    UNION ALL
    SELECT 'Số tin nhắn' AS LoaiDuLieu, COUNT(*) AS SoLuong FROM TinNhan WHERE MaHoiThoai = @HoiThoaiID;
    
    -- Hiển thị chi tiết hội thoại
    SELECT 
        h.MaHoiThoai,
        kh.HoTen AS KhachHang,
        ch.TenCH AS CuaHang,
        h.TinNhanCuoi,
        h.NgayCapNhat,
        h.SoTinNhanChuaDoc
    FROM HoiThoai h
    JOIN NguoiDung kh ON h.MaKhachHang = kh.MaND
    JOIN CuaHang ch ON h.MaCuaHang = ch.MaCH
    WHERE h.MaKhachHang = @KhachHangID AND h.MaCuaHang = @CuaHangID;
END

GO

PRINT '========================================';
PRINT 'HOÀN THÀNH! Đã tạo dữ liệu mẫu thành công!';
PRINT '========================================';
PRINT '';
PRINT 'BÂY GIỜ BẠN CÓ THỂ:';
PRINT '1. Deploy lại project';
PRINT '2. Login vào tài khoản khách hàng';
PRINT '3. Click vào menu User → Tin nhắn';
PRINT '4. Bạn sẽ thấy cuộc hội thoại mẫu!';
PRINT '========================================';
GO
