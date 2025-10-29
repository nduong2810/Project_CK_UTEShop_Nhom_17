<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

<style>
    /* Base font styling for Vietnamese */
    * {
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    body {
        font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
        background-color: #f8f9fa;
    }
    
    .settings-card {
        background: white;
        border-radius: 15px;
        padding: 30px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        margin-bottom: 20px;
    }
    
    .info-row {
        display: flex;
        padding: 20px 0;
        border-bottom: 1px solid #e9ecef;
        align-items: center;
    }
    
    .info-row:last-child {
        border-bottom: none;
    }
    
    .info-label {
        width: 200px;
        font-weight: 600;
        color: #495057;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    
    .info-value {
        flex: 1;
        color: #212529;
    }
    
    .info-value.text-muted {
        font-style: italic;
    }
    
    .btn-edit-mode {
        background: linear-gradient(45deg, #667eea, #764ba2);
        border: none;
        color: white;
        padding: 10px 30px;
        border-radius: 20px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .btn-edit-mode:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        color: white;
    }
    
    .btn-cancel {
        background: #6c757d;
        border: none;
        color: white;
        padding: 10px 30px;
        border-radius: 20px;
        font-weight: 600;
    }
    
    .btn-cancel:hover {
        background: #5a6268;
        color: white;
    }
    
    #editMode {
        display: none;
    }
    
    .form-label-custom {
        font-weight: 600;
        color: #495057;
        margin-bottom: 8px;
    }
</style>

<div class="container-fluid py-4">
    <div class="row">
        <!-- Sidebar Navigation -->
        <div class="col-md-3 col-lg-2">
            <div class="bg-white rounded-3 shadow-sm p-3 mb-4">
                <h6 class="text-muted mb-3">MENU</h6>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/vendor/dashboard" class="list-group-item list-group-item-action border-0">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/products" class="list-group-item list-group-item-action border-0">
                        <i class="fas fa-box me-2"></i> Sản phẩm
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/discounts" class="list-group-item list-group-item-action border-0">
                        <i class="fas fa-tags me-2"></i> Mã giảm giá
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/orders" class="list-group-item list-group-item-action border-0">
                        <i class="fas fa-shopping-cart me-2"></i> Đơn hàng
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/statistics" class="list-group-item list-group-item-action border-0">
                        <i class="fas fa-chart-pie me-2"></i> Thống kê
                    </a>
                    <a href="${pageContext.request.contextPath}/vendor/settings" class="list-group-item list-group-item-action border-0 active">
                        <i class="fas fa-cog me-2"></i> Cài đặt
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="col-md-9 col-lg-10">
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h2 class="h3 mb-0"><i class="fas fa-cog me-2"></i>Cài đặt Cửa hàng</h2>
                    <p class="text-muted mb-0">Quản lý thông tin và cấu hình cửa hàng của bạn</p>
                </div>
            </div>
            
            <!-- Alert Container for AJAX -->
            <div id="alertContainer"></div>
            
            <!-- Store Information Card - View Mode -->
            <div id="viewMode" class="settings-card">
                
                <div class="info-section">
                    <div class="info-row">
                        <div class="info-label">
                            <i class="fas fa-store"></i>
                            Tên cửa hàng
                        </div>
                        <div class="info-value" id="view_tenCH">
                            <strong>${store.tenCH}</strong>
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">
                            <i class="fas fa-map-marker-alt"></i>
                            Địa chỉ
                        </div>
                        <div class="info-value" id="view_diaChi">
                            <c:choose>
                                <c:when test="${not empty store.diaChi}">
                                    ${store.diaChi}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa cập nhật</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">
                            <i class="fas fa-phone"></i>
                            Số điện thoại
                        </div>
                        <div class="info-value" id="view_soDienThoai">
                            <c:choose>
                                <c:when test="${not empty store.soDienThoai}">
                                    ${store.soDienThoai}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa cập nhật</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">
                            <i class="fas fa-envelope"></i>
                            Email
                        </div>
                        <div class="info-value">
                            <c:choose>
                                <c:when test="${not empty store.email}">
                                    ${store.email}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa cập nhật</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">
                            <i class="fas fa-align-left"></i>
                            Mô tả
                        </div>
                        <div class="info-value" id="view_moTa">
                            <c:choose>
                                <c:when test="${not empty store.moTa}">
                                    ${store.moTa}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa có mô tả</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="info-row">
                        <div class="info-label">
                            <i class="fas fa-calendar"></i>
                            Ngày tạo
                        </div>
                        <div class="info-value">
                            <fmt:formatDate value="${store.ngayTao}" pattern="dd/MM/yyyy HH:mm"/>
                        </div>
                    </div>
                </div>
                
                <!-- Payment Information Section -->
                <div class="mt-3 text-end">
                    <button type="button" class="btn btn-edit-mode" onclick="toggleEditMode()">
                        <i class="fas fa-edit me-2"></i>Chỉnh sửa thông tin
                    </button>
                </div>
            </div>
            
            <!-- Payment Methods Card -->
            <div class="settings-card mt-3">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="mb-0">
                        <i class="fas fa-credit-card me-2"></i>Phương thức thanh toán
                    </h5>
                    <a href="${pageContext.request.contextPath}/vendor/settings/payment" class="btn btn-primary">
                        <i class="fas fa-cog me-2"></i>Quản lý thanh toán
                    </a>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">
                                <i class="fab fa-cc-visa"></i>
                                MoMo
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${store.momoEnable}">
                                        <span class="badge bg-success">Đã kích hoạt</span>
                                        <c:if test="${not empty store.momoPhone}">
                                            <br><small class="text-muted">SĐT: ${store.momoPhone}</small>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Chưa kích hoạt</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="info-row">
                            <div class="info-label">
                                <i class="fas fa-university"></i>
                                Ngân hàng
                            </div>
                            <div class="info-value">
                                <c:choose>
                                    <c:when test="${store.bankEnable}">
                                        <span class="badge bg-success">Đã kích hoạt</span>
                                        <c:if test="${not empty store.bankName}">
                                            <br><small class="text-muted">${store.bankName} - ${store.bankAccountNumber}</small>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">Chưa kích hoạt</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Store Information Card - Edit Mode -->
            <div id="editMode" class="settings-card">
                <h5 class="mb-4"><i class="fas fa-edit me-2"></i>Chỉnh sửa thông tin</h5>
                
                <form id="settingsForm">
                    <input type="hidden" name="action" value="updateStoreSettings">
                    
                    <div class="mb-3">
                        <label class="form-label-custom">
                            <i class="fas fa-store me-1"></i>
                            Tên cửa hàng <span class="text-danger">*</span>
                        </label>
                        <input type="text" class="form-control" name="tenCH" id="edit_tenCH" 
                               value="${store.tenCH}" required maxlength="255">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label-custom">
                            <i class="fas fa-map-marker-alt me-1"></i>
                            Địa chỉ
                        </label>
                        <input type="text" class="form-control" name="diaChi" id="edit_diaChi" 
                               value="${store.diaChi}" maxlength="500">
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label-custom">
                                <i class="fas fa-phone me-1"></i>
                                Số điện thoại
                            </label>
                            <input type="tel" class="form-control" name="soDienThoai" id="edit_soDienThoai" 
                                   value="${store.soDienThoai}" maxlength="15" pattern="[0-9]{10,11}">
                            <small class="text-muted">Ví dụ: 0901234567</small>
                        </div>
                        
                        <div class="col-md-6 mb-3">
                            <label class="form-label-custom">
                                <i class="fas fa-envelope me-1"></i>
                                Email
                            </label>
                            <input type="email" class="form-control" value="${store.email}" readonly disabled>
                            <small class="text-muted">Email không thể thay đổi</small>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label-custom">
                            <i class="fas fa-align-left me-1"></i>
                            Mô tả cửa hàng
                        </label>
                        <textarea class="form-control" name="moTa" id="edit_moTa" 
                                  rows="4" maxlength="1000">${store.moTa}</textarea>
                        <small class="text-muted">Tối đa 1000 ký tự</small>
                    </div>
                    
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-edit-mode" onclick="saveSettings()">
                            <i class="fas fa-save me-2"></i>Lưu thay đổi
                        </button>
                        <button type="button" class="btn btn-cancel ms-2" onclick="toggleEditMode()">
                            <i class="fas fa-times me-2"></i>Hủy
                        </button>
                    </div>
                </form>
            </div>
            
 
        </div>
    </div>
</div>

<script>
    function toggleEditMode() {
        const viewMode = document.getElementById('viewMode');
        const editMode = document.getElementById('editMode');
        
        if (viewMode.style.display === 'none') {
            viewMode.style.display = 'block';
            editMode.style.display = 'none';
        } else {
            viewMode.style.display = 'none';
            editMode.style.display = 'block';
        }
    }
    
    function saveSettings() {
        const form = document.getElementById('settingsForm');
        const formData = new FormData(form);
        
        // Disable button và show loading
        const saveBtn = event.target;
        const originalHTML = saveBtn.innerHTML;
        saveBtn.disabled = true;
        saveBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang lưu...';
        
        // Submit form using fetch API
        fetch('${pageContext.request.contextPath}/vendor/settings/update', {
            method: 'POST',
            body: formData
        })
        .then(response => response.text())
        .then(data => {
            // Update view mode với dữ liệu mới từ form
            const tenCH = formData.get('tenCH');
            const diaChi = formData.get('diaChi');
            const soDienThoai = formData.get('soDienThoai');
            const moTa = formData.get('moTa');
            
            // Update values in view mode
            document.getElementById('view_tenCH').innerHTML = '<strong>' + tenCH + '</strong>';
            document.getElementById('view_diaChi').innerHTML = diaChi || '<span class="text-muted">Chưa cập nhật</span>';
            document.getElementById('view_soDienThoai').innerHTML = soDienThoai || '<span class="text-muted">Chưa cập nhật</span>';
            document.getElementById('view_moTa').innerHTML = moTa || '<span class="text-muted">Chưa có mô tả</span>';
            
            // Show success alert
            showAlert('success', 'Cập nhật thông tin cửa hàng thành công!');
            
            // Switch to view mode
            setTimeout(() => {
                toggleEditMode();
            }, 500);
            
            // Re-enable button
            saveBtn.disabled = false;
            saveBtn.innerHTML = originalHTML;
        })
        .catch(error => {
            console.error('Error:', error);
            showAlert('danger', 'Có lỗi xảy ra khi lưu thông tin. Vui lòng thử lại!');
            saveBtn.disabled = false;
            saveBtn.innerHTML = originalHTML;
        });
    }
    
    function showAlert(type, message) {
        const alertContainer = document.getElementById('alertContainer');
        const alertHTML = '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
            '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + ' me-2"></i>' +
            '<strong>' + (type === 'success' ? 'Thành công!' : 'Lỗi!') + '</strong> ' + message +
            '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
            '</div>';
        alertContainer.innerHTML = alertHTML;
        
        // Auto dismiss after 5 seconds
        setTimeout(() => {
            const alert = alertContainer.querySelector('.alert');
            if (alert) {
                alert.remove();
            }
        }, 5000);
    }
</script>
