<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Thông tin Thanh toán - UTESHOP Vendor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        .payment-section {
            background: #fff;
            border-radius: 8px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .payment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .payment-header h4 {
            margin: 0;
            color: #333;
        }
        
        .payment-logo {
            width: 60px;
            height: 60px;
            object-fit: contain;
        }
        
        .qr-preview {
            max-width: 250px;
            max-height: 250px;
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 10px;
            margin-top: 10px;
        }
        
        .qr-preview img {
            width: 100%;
            height: auto;
            border-radius: 4px;
        }
        
        .switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
        }
        
        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }
        
        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 34px;
        }
        
        .slider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }
        
        input:checked + .slider {
            background-color: #28a745;
        }
        
        input:checked + .slider:before {
            transform: translateX(26px);
        }
        
        .alert-custom {
            border-radius: 8px;
            border-left: 4px solid;
        }
        
        .alert-custom.alert-success {
            border-left-color: #28a745;
        }
        
        .alert-custom.alert-danger {
            border-left-color: #dc3545;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-2 bg-dark text-white vh-100 p-0">
            <div class="p-3">
                <h5 class="text-center mb-4">
                    <i class="fas fa-store me-2"></i>Vendor Panel
                </h5>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/vendor/dashboard" class="list-group-item list-group-item-action bg-dark text-white border-0">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/products" class="list-group-item list-group-item-action bg-dark text-white border-0">
                        <i class="fas fa-box me-2"></i> Sản phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/orders" class="list-group-item list-group-item-action bg-dark text-white border-0">
                        <i class="fas fa-shopping-cart me-2"></i> Đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/discounts" class="list-group-item list-group-item-action bg-dark text-white border-0">
                        <i class="fas fa-tags me-2"></i> Mã giảm giá
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/settings" class="list-group-item list-group-item-action bg-dark text-white border-0">
                        <i class="fas fa-cog me-2"></i> Cài đặt
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/settings/payment" class="list-group-item list-group-item-action bg-dark text-white border-0 active">
                        <i class="fas fa-credit-card me-2"></i> Thanh toán
                    </a>
                </div>
            </div>
        </div>

        <!-- Main Content -->
        <div class="col-md-10 p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2><i class="fas fa-credit-card me-2"></i>Quản lý Thông tin Thanh toán</h2>
                    <p class="text-muted">Cấu hình phương thức thanh toán cho cửa hàng của bạn</p>
                </div>
                <a href="${pageContext.request.contextPath}/vendor/settings" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Quay lại
                </a>
            </div>

            <!-- Alert Container for AJAX messages -->
            <div id="alertContainer">
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success alert-custom alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${param.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty param.error}">
                    <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>${param.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
            </div>

            <form id="paymentForm" enctype="multipart/form-data">
                <input type="hidden" name="action" value="updatePaymentInfo">

                <!-- MoMo Payment Section -->
                <div class="payment-section">
                    <div class="payment-header">
                        <div class="d-flex align-items-center">
                            <img src="https://developers.momo.vn/v3/assets/images/square-logo.svg" alt="MoMo" class="payment-logo me-3">
                            <div>
                                <h4>Thanh toán MoMo</h4>
                                <p class="text-muted mb-0">Nhận thanh toán qua ví điện tử MoMo</p>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox" name="momoEnable" id="momoEnable" 
                                   ${store.momoEnable ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <div id="momoContent" style="display: ${store.momoEnable ? 'block' : 'none'}">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Số điện thoại MoMo <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="momoPhone" 
                                           value="${store.momoPhone}" placeholder="Nhập số điện thoại MoMo">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Tên chủ tài khoản <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="momoName" 
                                           value="${store.momoName}" placeholder="Nhập tên chủ tài khoản">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Ảnh QR Code MoMo</label>
                                    <input type="file" class="form-control" name="momoQR" 
                                           accept="image/*" onchange="previewImage(event, 'momoQRPreview')">
                                    <small class="text-muted">Định dạng: JPG, PNG. Kích thước tối đa: 10MB</small>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">Xem trước QR Code</label>
                                <div class="qr-preview" id="momoQRPreview">
                                    <c:choose>
                                        <c:when test="${not empty store.momoQR}">
                                            <img src="${pageContext.request.contextPath}/assets/img/${store.momoQR}" 
                                                 alt="MoMo QR Code">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center text-muted p-4">
                                                <i class="fas fa-qrcode fa-3x mb-2"></i>
                                                <p>Chưa có ảnh QR Code</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Bank Payment Section -->
                <div class="payment-section">
                    <div class="payment-header">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-university fa-3x text-primary me-3"></i>
                            <div>
                                <h4>Chuyển khoản Ngân hàng</h4>
                                <p class="text-muted mb-0">Nhận thanh toán qua chuyển khoản ngân hàng</p>
                            </div>
                        </div>
                        <label class="switch">
                            <input type="checkbox" name="bankEnable" id="bankEnable" 
                                   ${store.bankEnable ? 'checked' : ''}>
                            <span class="slider"></span>
                        </label>
                    </div>

                    <div id="bankContent" style="display: ${store.bankEnable ? 'block' : 'none'}">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label class="form-label">Tên ngân hàng <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="bankName" 
                                           value="${store.bankName}" placeholder="VD: Vietcombank, VPBank, BIDV...">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Số tài khoản <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="bankAccountNumber" 
                                           value="${store.bankAccountNumber}" placeholder="Nhập số tài khoản">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Tên chủ tài khoản <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="bankAccountName" 
                                           value="${store.bankAccountName}" placeholder="Nhập tên chủ tài khoản">
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label">Ảnh QR Code Ngân hàng</label>
                                    <input type="file" class="form-control" name="bankQR" 
                                           accept="image/*" onchange="previewImage(event, 'bankQRPreview')">
                                    <small class="text-muted">Định dạng: JPG, PNG. Kích thước tối đa: 10MB</small>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">Xem trước QR Code</label>
                                <div class="qr-preview" id="bankQRPreview">
                                    <c:choose>
                                        <c:when test="${not empty store.bankQR}">
                                            <img src="${pageContext.request.contextPath}/assets/img/${store.bankQR}" 
                                                 alt="Bank QR Code">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="text-center text-muted p-4">
                                                <i class="fas fa-qrcode fa-3x mb-2"></i>
                                                <p>Chưa có ảnh QR Code</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="text-end">
                    <button type="button" id="saveBtn" class="btn btn-primary btn-lg" onclick="savePaymentInfo()">
                        <i class="fas fa-save me-2"></i>Lưu thông tin thanh toán
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Toggle MoMo section
    document.getElementById('momoEnable').addEventListener('change', function() {
        document.getElementById('momoContent').style.display = this.checked ? 'block' : 'none';
    });
    
    // Toggle Bank section
    document.getElementById('bankEnable').addEventListener('change', function() {
        document.getElementById('bankContent').style.display = this.checked ? 'block' : 'none';
    });
    
    // Preview image before upload
    function previewImage(event, previewId) {
        const file = event.target.files[0];
        const preview = document.getElementById(previewId);
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = '<img src="' + e.target.result + '" alt="QR Code Preview">';
            }
            reader.readAsDataURL(file);
        }
    }
    
    // Save payment info using AJAX
    function savePaymentInfo() {
        const form = document.getElementById('paymentForm');
        const formData = new FormData(form);
        const saveBtn = document.getElementById('saveBtn');
        
        // Validation
        const momoEnable = document.getElementById('momoEnable').checked;
        const bankEnable = document.getElementById('bankEnable').checked;
        
        if (momoEnable) {
            const momoPhone = formData.get('momoPhone');
            const momoName = formData.get('momoName');
            
            if (!momoPhone || !momoPhone.trim() || !momoName || !momoName.trim()) {
                showAlert('danger', 'Vui lòng nhập đầy đủ thông tin MoMo (số điện thoại và tên chủ tài khoản)');
                return;
            }
        }
        
        if (bankEnable) {
            const bankName = formData.get('bankName');
            const bankAccountNumber = formData.get('bankAccountNumber');
            const bankAccountName = formData.get('bankAccountName');
            
            if (!bankName || !bankName.trim() || !bankAccountNumber || !bankAccountNumber.trim() || 
                !bankAccountName || !bankAccountName.trim()) {
                showAlert('danger', 'Vui lòng nhập đầy đủ thông tin Ngân hàng (tên ngân hàng, số tài khoản và tên chủ tài khoản)');
                return;
            }
        }
        
        // Disable button and show loading
        const originalHTML = saveBtn.innerHTML;
        saveBtn.disabled = true;
        saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang lưu...';
        
        // Submit using fetch API
        fetch('<c:url value="/vendor/settings/payment"/>', {
            method: 'POST',
            body: formData
        })
        .then(response => {
            if (response.ok) {
                return response.text();
            }
            throw new Error('Có lỗi xảy ra khi lưu thông tin');
        })
        .then(data => {
            // Show success message
            showAlert('success', 'Cập nhật thông tin thanh toán thành công!');
            
            // Scroll to top to see the alert
            window.scrollTo({ top: 0, behavior: 'smooth' });
            
            // Re-enable button
            saveBtn.disabled = false;
            saveBtn.innerHTML = originalHTML;
        })
        .catch(error => {
            console.error('Error:', error);
            showAlert('danger', 'Có lỗi xảy ra khi lưu thông tin. Vui lòng thử lại!');
            
            // Scroll to top to see the alert
            window.scrollTo({ top: 0, behavior: 'smooth' });
            
            // Re-enable button
            saveBtn.disabled = false;
            saveBtn.innerHTML = originalHTML;
        });
    }
    
    // Show alert message
    function showAlert(type, message) {
        const alertContainer = document.getElementById('alertContainer');
        const iconClass = type === 'success' ? 'check-circle' : 'exclamation-circle';
        const alertTitle = type === 'success' ? 'Thành công!' : 'Lỗi!';
        
        const alertHTML = '<div class="alert alert-' + type + ' alert-custom alert-dismissible fade show" role="alert">' +
            '<i class="fas fa-' + iconClass + ' me-2"></i>' +
            '<strong>' + alertTitle + '</strong> ' + message +
            '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
            '</div>';
        
        alertContainer.innerHTML = alertHTML;
        
        // Auto dismiss after 5 seconds
        setTimeout(function() {
            const alert = alertContainer.querySelector('.alert');
            if (alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            }
        }, 5000);
    }
</script>

</body>
</html>
