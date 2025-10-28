<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        }
        
        /* Enhanced styling for Vietnamese text display */
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-weight: 600;
            color: #2d3748;
            text-rendering: optimizeLegibility;
        }
        
        .form-label {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-weight: 600;
            color: #2d3748;
            text-rendering: optimizeLegibility;
        }
        
        .form-control {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            text-align: center;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .form-control {
            border-radius: 10px;
            border: 2px solid #e9ecef;
            padding: 12px 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-save {
            background: linear-gradient(45deg, #11998e, #38ef7d);
            border: none;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.4);
            color: white;
        }
        
        .btn-cancel {
            background: #6c757d;
            color: white;
            padding: 12px 30px;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .btn-cancel:hover {
            background: #5a6268;
            color: white;
            transform: translateY(-2px);
        }
        
        .info-card {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 15px;
            border-radius: 0 10px 10px 0;
            margin-bottom: 20px;
        }
        
        .discount-preview {
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 20px;
        }
        
        .preview-code {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        
        .conditional-field {
            display: none;
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
                        <a href="${pageContext.request.contextPath}/vendor/discounts" class="list-group-item list-group-item-action border-0 active">
                            <i class="fas fa-tags me-2"></i> Mã giảm giá
                        </a>
                        <a href="${pageContext.request.contextPath}/vendor/orders" class="list-group-item list-group-item-action border-0">
                            <i class="fas fa-shopping-cart me-2"></i> Đơn hàng
                            </a>
                    </div>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10">
                <div class="form-header">
                    <h2 class="mb-0">
                        <i class="fas fa-tag me-2"></i>
                        <c:choose>
                            <c:when test="${discount != null}">Chỉnh sửa Mã giảm giá</c:when>
                            <c:otherwise>Tạo Mã giảm giá mới</c:otherwise>
                        </c:choose>
                    </h2>
                    <p class="mb-0 mt-2">Tạo chương trình khuyến mãi để thu hút khách hàng</p>
                </div>
                
                <!-- Messages -->
                <c:if test="${param.error != null}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <c:choose>
                            <c:when test="${param.error == 'MISSING_REQUIRED_FIELDS'}">
                                Vui lòng điền đầy đủ thông tin bắt buộc.
                            </c:when>
                            <c:when test="${param.error == 'INVALID_CODE_LENGTH'}">
                                Mã giảm giá không hợp lệ (1-20 ký tự).
                            </c:when>
                            <c:when test="${param.error == 'CODE_ALREADY_EXISTS'}">
                                Mã giảm giá đã tồn tại.
                            </c:when>
                            <c:when test="${param.error == 'CREATE_FAILED'}">
                                Có lỗi xảy ra khi tạo mã giảm giá.
                            </c:when>
                            <c:when test="${param.error == 'INVALID_DATA'}">
                                Dữ liệu không hợp lệ.
                            </c:when>
                            <c:otherwise>
                                ${param.error}
                            </c:otherwise>
                        </c:choose>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <div class="row">
                    <div class="col-lg-8">
                        <div class="form-container">
                            <form method="post" action="${pageContext.request.contextPath}/vendor/discounts/${discount != null ? 'edit' : 'create'}" id="discountForm">
                                <c:if test="${discount != null}">
                                    <input type="hidden" name="action" value="updateDiscount">
                                    <input type="hidden" name="id" value="${discount.maGG}">
                                </c:if>
                                <c:if test="${discount == null}">
                                    <input type="hidden" name="action" value="createDiscount">
                                </c:if>
                                
                                <!-- Mã số (Chỉ cho phép nhập khi tạo mới) -->
                                <div class="form-group">
                                    <label for="maSo" class="form-label">
                                        Mã giảm giá <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="maSo" name="maSo" 
                                           value="${discount.maSo}" 
                                           ${discount != null ? 'readonly' : ''} 
                                           placeholder="VD: SUMMER2024, SALE50..."
                                           style="${discount != null ? 'background: #f8f9fa;' : ''}"
                                           required>
                                    <small class="text-muted">Mã này khách hàng sẽ nhập để được giảm giá</small>
                                </div>
                                
                                <!-- Tên chương trình -->
                                <div class="form-group">
                                    <label for="tenChuongTrinh" class="form-label">
                                        Tên chương trình <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="tenChuongTrinh" name="tenChuongTrinh" 
                                           value="${discount.tenChuongTrinh}" 
                                           placeholder="VD: Khuyến mãi mùa hè 2024"
                                           required>
                                </div>
                                
                                <!-- Mô tả -->
                                <div class="form-group">
                                    <label for="moTa" class="form-label">Mô tả</label>
                                    <textarea class="form-control" id="moTa" name="moTa" rows="3" 
                                              placeholder="Mô tả chi tiết về chương trình khuyến mãi...">${discount.moTa}</textarea>
                                </div>
                                
                                <!-- Loại giảm giá và giá trị -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="loaiGiam" class="form-label">
                                                Loại giảm giá <span class="text-danger">*</span>
                                            </label>
                                            <select class="form-control" id="loaiGiam" name="loaiGiam" required>
                                                <option value="PERCENT" ${discount.loaiGiam == 'PERCENT' ? 'selected' : ''}>
                                                    Giảm theo phần trăm (%)
                                                </option>
                                                <option value="FIXED_AMOUNT" ${discount.loaiGiam == 'FIXED_AMOUNT' ? 'selected' : ''}>
                                                    Giảm số tiền cố định (₫)
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="giaTriGiam" class="form-label">
                                                Giá trị giảm <span class="text-danger">*</span>
                                            </label>
                                            <input type="number" class="form-control" id="giaTriGiam" name="giaTriGiam" 
                                                   value="${discount.giaTriGiam}" 
                                                   step="0.01" min="0.01"
                                                   placeholder="VD: 10 hoặc 50000"
                                                   required>
                                            <small class="text-muted" id="discountHint">Nhập % cho loại phần trăm, số tiền cho loại cố định</small>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Điều kiện áp dụng -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="giaTriDonHangToiThieu" class="form-label">
                                                Giá trị đơn hàng tối thiểu
                                            </label>
                                            <input type="number" class="form-control" id="giaTriDonHangToiThieu" name="giaTriDonHangToiThieu" 
                                                   value="${discount.giaTriDonHangToiThieu}" 
                                                   step="1000" min="0"
                                                   placeholder="VD: 100000">
                                            <small class="text-muted">Để trống nếu không có điều kiện</small>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group" id="maxDiscountGroup">
                                            <label for="giaTriGiamToiDa" class="form-label">
                                                Giá trị giảm tối đa
                                            </label>
                                            <input type="number" class="form-control" id="giaTriGiamToiDa" name="giaTriGiamToiDa" 
                                                   value="${discount.giaTriGiamToiDa}" 
                                                   step="1000" min="0"
                                                   placeholder="VD: 200000">
                                            <small class="text-muted">Chỉ áp dụng cho loại giảm %</small>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Thời gian áp dụng -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="ngayBatDau" class="form-label">
                                                Ngày bắt đầu <span class="text-danger">*</span>
                                            </label>
                                            <c:choose>
                                                <c:when test="${discount != null && discount.ngayBatDau != null}">
                                                    <c:set var="startDateTime" value="${discount.ngayBatDau}" />
                                                    <c:set var="startDateTimeStr" value="${startDateTime.year}-${startDateTime.monthValue < 10 ? '0' : ''}${startDateTime.monthValue}-${startDateTime.dayOfMonth < 10 ? '0' : ''}${startDateTime.dayOfMonth}T${startDateTime.hour < 10 ? '0' : ''}${startDateTime.hour}:${startDateTime.minute < 10 ? '0' : ''}${startDateTime.minute}" />
                                                    <input type="datetime-local" class="form-control" id="ngayBatDau" name="ngayBatDau" 
                                                           value="${startDateTimeStr}" required>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="datetime-local" class="form-control" id="ngayBatDau" name="ngayBatDau" required>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="ngayKetThuc" class="form-label">
                                                Ngày kết thúc <span class="text-danger">*</span>
                                            </label>
                                            <c:choose>
                                                <c:when test="${discount != null && discount.ngayKetThuc != null}">
                                                    <c:set var="endDateTime" value="${discount.ngayKetThuc}" />
                                                    <c:set var="endDateTimeStr" value="${endDateTime.year}-${endDateTime.monthValue < 10 ? '0' : ''}${endDateTime.monthValue}-${endDateTime.dayOfMonth < 10 ? '0' : ''}${endDateTime.dayOfMonth}T${endDateTime.hour < 10 ? '0' : ''}${endDateTime.hour}:${endDateTime.minute < 10 ? '0' : ''}${endDateTime.minute}" />
                                                    <input type="datetime-local" class="form-control" id="ngayKetThuc" name="ngayKetThuc" 
                                                           value="${endDateTimeStr}" required>
                                                </c:when>
                                                <c:otherwise>
                                                    <input type="datetime-local" class="form-control" id="ngayKetThuc" name="ngayKetThuc" required>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Giới hạn sử dụng -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="soLuongToiDa" class="form-label">
                                                Số lượng tối đa
                                            </label>
                                            <input type="number" class="form-control" id="soLuongToiDa" name="soLuongToiDa" 
                                                   value="${discount.soLuongToiDa}" 
                                                   min="1"
                                                   placeholder="VD: 100">
                                            <small class="text-muted">Để trống nếu không giới hạn</small>
                                        </div>
                                    </div>
                                    <c:if test="${discount != null}">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="trangThai" class="form-label">Trạng thái</label>
                                                <select class="form-control" id="trangThai" name="trangThai">
                                                    <option value="true" ${discount.trangThai ? 'selected' : ''}>Hoạt động</option>
                                                    <option value="false" ${!discount.trangThai ? 'selected' : ''}>Tạm dừng</option>
                                                </select>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                
                                <!-- Buttons -->
                                <div class="text-end mt-4">
                                    <a href="${pageContext.request.contextPath}/vendor/discounts" class="btn btn-cancel me-3">
                                        <i class="fas fa-times me-2"></i>Hủy
                                    </a>
                                    <button type="submit" class="btn btn-save">
                                        <i class="fas fa-save me-2"></i>
                                        <c:choose>
                                            <c:when test="${discount != null}">Cập nhật</c:when>
                                            <c:otherwise>Tạo mã giảm giá</c:otherwise>
                                        </c:choose>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                    
                    <!-- Preview -->
                    <div class="col-lg-4">
                        <div class="info-card">
                            <h6><i class="fas fa-info-circle me-2"></i>Hướng dẫn</h6>
                            <ul class="mb-0 ps-3">
                                <li>Mã giảm giá phải là duy nhất</li>
                                <li>Loại % áp dụng cho tỷ lệ phần trăm (0-100)</li>
                                <li>Loại cố định áp dụng số tiền cụ thể</li>
                                <li>Có thể thiết lập điều kiện đơn hàng tối thiểu</li>
                                <li>Có thể giới hạn số lượng sử dụng</li>
                            </ul>
                        </div>
                        
                        <div class="discount-preview" id="discountPreview">
                            <div class="preview-code" id="previewCode">PREVIEW</div>
                            <div id="previewValue">Nhập thông tin để xem trước</div>
                            <div id="previewCondition" class="mt-2"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Include Footer -->
    <jsp:include page="../common/footer.jsp" />
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Set default datetime if creating new discount
        if (!document.getElementById('ngayBatDau').value) {
            const now = new Date();
            now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
            document.getElementById('ngayBatDau').value = now.toISOString().slice(0,16);
            
            const endDate = new Date(now.getTime() + (30 * 24 * 60 * 60 * 1000)); // +30 days
            document.getElementById('ngayKetThuc').value = endDate.toISOString().slice(0,16);
        }
        
        // Update preview when form changes
        function updatePreview() {
            const code = document.getElementById('maSo').value || 'PREVIEW';
            const type = document.getElementById('loaiGiam').value;
            const value = document.getElementById('giaTriGiam').value;
            const minOrder = document.getElementById('giaTriDonHangToiThieu').value;
            
            document.getElementById('previewCode').textContent = code;
            
            if (value) {
                let valueText = '';
                if (type === 'PERCENT') {
                    valueText = 'Giảm ' + value + '%';
                } else {
                    const numValue = parseFloat(value);
                    valueText = 'Giảm ' + numValue.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '₫';
                }
                document.getElementById('previewValue').textContent = valueText;
            }
            
            if (minOrder) {
                const numOrder = parseFloat(minOrder);
                const formattedOrder = numOrder.toFixed(0).replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                document.getElementById('previewCondition').textContent = 
                    'Đơn hàng tối thiểu: ' + formattedOrder + '₫';
            } else {
                document.getElementById('previewCondition').textContent = '';
            }
        }
        
        // Show/hide max discount field based on discount type
        function toggleMaxDiscountField() {
            const type = document.getElementById('loaiGiam').value;
            const maxDiscountGroup = document.getElementById('maxDiscountGroup');
            const maxDiscountInput = document.getElementById('giaTriGiamToiDa');
            
            if (type === 'PERCENT') {
                maxDiscountGroup.style.display = 'block';
            } else {
                maxDiscountGroup.style.display = 'none';
                maxDiscountInput.value = '';
            }
        }
        
        // Event listeners
        document.getElementById('maSo').addEventListener('input', updatePreview);
        document.getElementById('loaiGiam').addEventListener('change', function() {
            toggleMaxDiscountField();
            updatePreview();
        });
        document.getElementById('giaTriGiam').addEventListener('input', updatePreview);
        document.getElementById('giaTriDonHangToiThieu').addEventListener('input', updatePreview);
        
        // Initialize
        toggleMaxDiscountField();
        updatePreview();
        
        // Form validation
        document.getElementById('discountForm').addEventListener('submit', function(e) {
            const startDate = new Date(document.getElementById('ngayBatDau').value);
            const endDate = new Date(document.getElementById('ngayKetThuc').value);
            
            if (endDate <= startDate) {
                e.preventDefault();
                alert('Ngày kết thúc phải sau ngày bắt đầu!');
                return;
            }
            
            const discountType = document.getElementById('loaiGiam').value;
            const discountValue = parseFloat(document.getElementById('giaTriGiam').value);
            
            if (discountType === 'PERCENT' && (discountValue <= 0 || discountValue > 100)) {
                e.preventDefault();
                alert('Giá trị giảm % phải từ 0.01 đến 100!');
                return;
            }
        });
    </script>