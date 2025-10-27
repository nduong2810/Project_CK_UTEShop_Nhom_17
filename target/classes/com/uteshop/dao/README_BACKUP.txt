BACKUP CÁC THAY ĐỔI QUAN TRỌNG - 27/10/2025
====================================================

Các file đã được backup trước khi pull code mới:

1. BACKEND FILES:
   - VendorController.java: Đã thêm quản lý đơn hàng (orders, order-detail, update-status)
   - DonHangDAO.java: Đã thêm các phương thức quản lý đơn hàng theo cửa hàng
   - DiscountUtils.java: Utility class mới cho kiểm tra điều kiện xóa mã giảm giá

2. FRONTEND FILES (jsp_files/):
   - orders.jsp: Trang quản lý danh sách đơn hàng với lọc theo trạng thái
   - order-detail.jsp: Trang chi tiết đơn hàng và cập nhật trạng thái
   - discounts.jsp: Đã cập nhật với tính năng xóa mã giảm giá có điều kiện

3. TÍNH NĂNG ĐÃ THÊM:
   ✅ Hệ thống quản lý đơn hàng theo 6 trạng thái
   ✅ Xóa mã giảm giá chỉ khi hết hạn hoặc hết lượt sử dụng
   ✅ Giao diện đẹp với Bootstrap và responsive
   ✅ Phân trang và thống kê
   ✅ Workflow cập nhật trạng thái đơn hàng

4. CÁCH KHÔI PHỤC SAU KHI PULL:
   - Copy các file từ backup_changes/ về vị trí gốc
   - Merge các thay đổi nếu có conflict
   - Test lại các chức năng

LƯU Ý: Backup này được tạo tự động trước khi pull code mới để đảm bảo không mất công việc.