<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân - UTESHOP</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f5f7;
            margin: 0;
            padding: 50px 0;
            color: #333;
        }

        .profile-card {
            background: #fff;
            max-width: 700px;
            margin: 0 auto;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
            padding: 40px 50px;
            transition: all 0.3s ease;
        }

        .profile-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid #6c63ff;
            object-fit: cover;
            margin-bottom: 15px;
            box-shadow: 0 4px 15px rgba(108, 99, 255, 0.3);
        }

        .profile-name {
            font-size: 1.9rem;
            font-weight: 700;
            color: #222;
            margin-bottom: 6px;
        }

        .profile-role {
            font-size: 1rem;
            color: #6c63ff;
            font-weight: 500;
        }

        .info-section {
            border-top: 1px solid #eee;
            padding-top: 25px;
        }

        .info-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 15px;
            color: #444;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f2f2f2;
            font-size: 0.95rem;
        }

        .info-label {
            color: #666;
            font-weight: 500;
        }

        .info-value {
            color: #333;
            font-weight: 500;
            text-align: right;
        }

        .status-active {
            color: #2ecc71;
            font-weight: 600;
        }

        .status-inactive {
            color: #e74c3c;
            font-weight: 600;
        }

        .btn-edit {
            margin-top: 30px;
            background: linear-gradient(90deg, #6c63ff, #896bff);
            color: white;
            border: none;
            padding: 12px 28px;
            font-size: 1rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-edit:hover {
            background: linear-gradient(90deg, #5a53e8, #7d5eff);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(108, 99, 255, 0.3);
        }

        @media (max-width: 600px) {
            .profile-card {
                padding: 25px 20px;
            }

            .info-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .info-value {
                text-align: left;
            }
        }
    </style>
</head>
<body>

<div class="profile-card">
    <div class="profile-header">
        <img src="https://via.placeholder.com/120" alt="Avatar" class="profile-avatar">
        <div class="profile-name">Nguyễn Văn A</div>
        <div class="profile-role">Vai trò: Người dùng</div>
    </div>

    <div class="info-section">
        <div class="info-title">Thông tin cá nhân</div>

        <div class="info-item">
            <span class="info-label">Tên đăng nhập:</span>
            <span class="info-value">nguyenvana</span>
        </div>
        <div class="info-item">
            <span class="info-label">Email:</span>
            <span class="info-value">nguyenvana@example.com</span>
        </div>
        <div class="info-item">
            <span class="info-label">Địa chỉ:</span>
            <span class="info-value">123 Đường ABC, TP.HCM</span>
        </div>
        <div class="info-item">
            <span class="info-label">Số điện thoại:</span>
            <span class="info-value">0901234567</span>
        </div>
        <div class="info-item">
            <span class="info-label">Ngày tạo:</span>
            <span class="info-value">2025-10-01</span>
        </div>
        <div class="info-item">
            <span class="info-label">Ngày cập nhật:</span>
            <span class="info-value">2025-10-23</span>
        </div>
        <div class="info-item">
            <span class="info-label">Trạng thái:</span>
            <span class="info-value status-active">Đang hoạt động</span>
        </div>
        <div class="info-item">
            <span class="info-label">Ghi chú:</span>
            <span class="info-value">Khách hàng VIP</span>
        </div>
    </div>

    <div style="text-align:center;">
        <button class="btn-edit">
            <i class="fas fa-pen"></i> Chỉnh sửa hồ sơ
        </button>
    </div>
</div>

</body>
</html>
