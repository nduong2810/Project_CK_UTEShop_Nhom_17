<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - UTESHOP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .checkout-container {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 15px;
        }
        
        .section-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #667eea;
        }
        
        .address-item {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .address-item:hover {
            border-color: #667eea;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
        }
        
        .address-item.selected {
            border-color: #667eea;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05), rgba(118, 75, 162, 0.05));
        }
        
        .address-item input[type="radio"] {
            width: 20px;
            height: 20px;
            margin-right: 10px;
        }
        
        .payment-method {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .payment-method:hover {
            border-color: #667eea;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
        }
        
        .payment-method.selected {
            border-color: #667eea;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.08), rgba(118, 75, 162, 0.08));
        }
        
        .payment-method input[type="radio"] {
            width: 22px;
            height: 22px;
            margin-right: 15px;
        }
        
        .payment-icon {
            font-size: 2.5rem;
            margin-right: 20px;
            color: #667eea;
        }
        
        .payment-details {
            display: none;
            margin-top: 20px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .payment-details.active {
            display: block;
            animation: slideDown 0.3s ease;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .qr-code-container {
            text-align: center;
            padding: 20px;
            background: white;
            border-radius: 8px;
            margin-top: 15px;
        }
        
        .qr-code-container img {
            max-width: 300px;
            border: 3px solid #667eea;
            border-radius: 8px;
            padding: 10px;
        }
        
        .product-item {
            display: flex;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .product-item:last-child {
            border-bottom: none;
        }
        
        .product-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 15px;
        }
        
        .product-info {
            flex: 1;
        }
        
        .product-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }
        
        .product-quantity {
            color: #666;
            font-size: 0.9rem;
        }
        
        .product-price {
            font-weight: 600;
            color: #667eea;
            font-size: 1.1rem;
        }
        
        .discount-section {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .discount-input {
            flex: 1;
            padding: 12px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 1rem;
        }
        
        .discount-input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .btn-apply-discount {
            padding: 12px 30px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-apply-discount:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        
        .order-summary {
            position: sticky;
            top: 20px;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .summary-row:last-child {
            border-bottom: none;
            font-size: 1.3rem;
            font-weight: 700;
            color: #667eea;
            padding-top: 20px;
            margin-top: 10px;
            border-top: 2px solid #667eea;
        }
        
        .discount-badge {
            background: linear-gradient(45deg, #ff6b6b, #ee5a6f);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 15px;
        }
        
        .btn-place-order {
            width: 100%;
            padding: 18px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.2rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 20px;
        }
        
        .btn-place-order:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }
        
        .btn-place-order:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }
        
        .store-group {
            margin-bottom: 25px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .store-header {
            padding-bottom: 10px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .store-name {
            font-weight: 600;
            color: #667eea;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.2rem;
        }
        
        /* Discount Panel Styles */
        .discount-panel {
            background: white;
            border: 2px solid #ffc107;
            border-radius: 10px;
            margin: 15px 0;
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.2);
            animation: slideDown 0.3s ease;
        }
        
        .discount-panel-header {
            background: linear-gradient(135deg, #ffc107, #ff9800);
            padding: 15px 20px;
            border-radius: 8px 8px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }
        
        .discount-panel-header h6 {
            margin: 0;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .btn-close-panel {
            background: transparent;
            border: none;
            color: white;
            font-size: 1.2rem;
            cursor: pointer;
            padding: 5px 10px;
            transition: all 0.3s;
        }
        
        .btn-close-panel:hover {
            transform: scale(1.2);
        }
        
        .discount-panel-body {
            padding: 20px;
            max-height: 400px;
            overflow-y: auto;
        }
        
        .discount-item-card {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        
        .discount-item-card:hover {
            border-color: #ffc107;
            box-shadow: 0 4px 12px rgba(255, 193, 7, 0.3);
            transform: translateX(5px);
        }
        
        .discount-item-card input[type="checkbox"] {
            width: 20px;
            height: 20px;
            margin-top: 5px;
            cursor: pointer;
            accent-color: #ffc107;
        }
        
        .discount-item-card input[type="checkbox"]:checked + label {
            color: #ffc107;
        }
        
        .discount-item-card label {
            flex: 1;
            cursor: pointer;
        }
        
        .discount-code {
            font-size: 1.1rem;
            font-weight: 700;
            color: #ff9800;
            margin-bottom: 5px;
        }
        
        .discount-title {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .discount-value {
            margin-bottom: 5px;
        }
        
        .discount-value .badge {
            font-size: 0.9rem;
            padding: 6px 12px;
        }
        
        .discount-condition {
            font-size: 0.85rem;
            color: #666;
            margin-top: 5px;
        }
        
        .applied-discount-badge {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            border: 2px solid #28a745;
            border-radius: 8px;
            padding: 12px 15px;
            margin: 10px 0;
            display: flex;
            align-items: center;
            animation: fadeIn 0.5s ease;
        }
        
        .store-subtotal {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            background: white;
            border-radius: 8px;
            margin-top: 15px;
            font-size: 1.1rem;
            border: 2px solid #667eea;
        }
        
        .store-subtotal-amount {
            color: #667eea;
            font-size: 1.3rem;
        }
        
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .alert-custom {
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;
        }
        
        .badge-default {
            background: #28a745;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 0.75rem;
            color: white;
        }
        
        /* Shipping Provider Styles */
        .shipping-selector {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            border: 2px solid #e9ecef;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .shipping-selector:hover {
            border-color: #667eea;
            background: rgba(102, 126, 234, 0.05);
        }
        
        .shipping-selector.has-selection {
            border-color: #28a745;
            background: rgba(40, 167, 69, 0.05);
        }
        
        .shipping-icon {
            font-size: 2rem;
            color: #667eea;
        }
        
        .shipping-info {
            flex: 1;
        }
        
        .shipping-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 3px;
        }
        
        .shipping-selected-text {
            color: #28a745;
            font-size: 0.9rem;
        }
        
        .shipping-panel {
            background: white;
            border: 2px solid #667eea;
            border-radius: 10px;
            margin: 15px 0;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
            animation: slideDown 0.3s ease;
        }
        
        .shipping-panel-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
            padding: 15px 20px;
            border-radius: 8px 8px 0 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }
        
        .shipping-panel-header h6 {
            margin: 0;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .shipping-panel-body {
            padding: 20px;
            max-height: 450px;
            overflow-y: auto;
        }
        
        .shipping-item-card {
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: flex-start;
            gap: 15px;
        }
        
        .shipping-item-card:hover {
            border-color: #667eea;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
            transform: translateX(5px);
        }
        
        .shipping-item-card.selected {
            border-color: #28a745;
            background: rgba(40, 167, 69, 0.05);
        }
        
        .shipping-item-card input[type="radio"] {
            width: 20px;
            height: 20px;
            margin-top: 5px;
            cursor: pointer;
            accent-color: #667eea;
        }
        
        .shipping-item-content {
            flex: 1;
        }
        
        .shipping-provider-name {
            font-size: 1.1rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }
        
        .shipping-provider-desc {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 8px;
        }
        
        .shipping-fee-badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 1rem;
        }
        
        .shipping-estimate {
            color: #28a745;
            font-size: 0.85rem;
            margin-top: 8px;
            display: flex;
            align-items: center;
            gap: 5px;
        }
    </style>
</head>
<body>
    <div class="checkout-container">
        <h2 class="text-center mb-4">
            <i class="fas fa-shopping-cart me-2"></i>Thanh Toán Đơn Hàng
        </h2>
        
        <!-- Alert Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-custom alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-custom alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/user/checkout/place-order" method="post" id="checkoutForm">
            <div class="row">
                <!-- Left Column -->
                <div class="col-lg-8">
                    <!-- Địa chỉ giao hàng -->
                    <div class="section-card">
                        <div class="section-title">
                            <i class="fas fa-map-marker-alt me-2"></i>Địa chỉ giao hàng
                        </div>
                        
                        <c:choose>
                            <c:when test="${empty addresses}">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Bạn chưa có địa chỉ giao hàng. 
                                    <a href="${pageContext.request.contextPath}/user/addresses" class="alert-link">Thêm địa chỉ mới</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="addr" items="${addresses}">
                                    <div class="address-item ${addr.maDC == defaultAddress.maDC ? 'selected' : ''}" 
                                         onclick="selectAddress(this, ${addr.maDC})">
                                        <div class="d-flex align-items-start">
                                            <input type="radio" name="addressId" value="${addr.maDC}" 
                                                   ${addr.maDC == defaultAddress.maDC ? 'checked' : ''} required>
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <strong>${addr.tenNguoiNhan}</strong>
                                                    <c:if test="${addr.laMacDinh}">
                                                        <span class="badge-default">Mặc định</span>
                                                    </c:if>
                                                </div>
                                                <div class="text-muted mt-1">${addr.soDienThoai}</div>
                                                <div class="mt-2">
                                                    ${addr.diaChiCuThe}, ${addr.phuong}, ${addr.quan}, ${addr.thanhPho}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/user/addresses" class="btn btn-outline-primary">
                                        <i class="fas fa-plus me-2"></i>Thêm địa chỉ mới
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Đơn vị vận chuyển -->
                    <div class="section-card">
                        <div class="section-title mb-3">
                            <i class="fas fa-shipping-fast me-2"></i>Đơn vị vận chuyển
                        </div>
                        
                        <div class="shipping-selector ${not empty defaultShipping ? 'has-selection' : ''}" 
                             id="shippingSelector" 
                             onclick="toggleShippingPanel()">
                            <div class="shipping-icon">
                                <i class="fas fa-truck"></i>
                            </div>
                            <div class="shipping-info">
                                <div class="shipping-name" id="selectedShippingName">
                                    <c:choose>
                                        <c:when test="${not empty defaultShipping}">
                                            ${defaultShipping.tenDonVi}
                                        </c:when>
                                        <c:otherwise>
                                            Chọn đơn vị vận chuyển
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="shipping-selected-text" id="selectedShippingInfo">
                                    <c:if test="${not empty defaultShipping}">
                                        Phí vận chuyển: <fmt:formatNumber value="${defaultShipping.phiVanChuyen}" type="number" groupingUsed="true"/>₫
                                    </c:if>
                                </div>
                            </div>
                            <div>
                                <i class="fas fa-chevron-down" id="shippingChevron"></i>
                            </div>
                        </div>
                        
                        <!-- Panel chọn đơn vị vận chuyển -->
                        <div class="shipping-panel" id="shippingPanel" style="display: none;">
                            <div class="shipping-panel-header">
                                <h6><i class="fas fa-truck me-2"></i>Chọn đơn vị vận chuyển</h6>
                                <button type="button" class="btn-close btn-close-white" onclick="closeShippingPanel()"></button>
                            </div>
                            <div class="shipping-panel-body">
                                <c:choose>
                                    <c:when test="${empty shippingProviders}">
                                        <div class="alert alert-warning">
                                            <i class="fas fa-exclamation-triangle me-2"></i>
                                            Hiện tại chưa có đơn vị vận chuyển nào khả dụng.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="provider" items="${shippingProviders}" varStatus="status">
                                            <div class="shipping-item-card ${provider.maVC == defaultShipping.maVC ? 'selected' : ''}" 
                                                 id="shippingCard${provider.maVC}"
                                                 onclick="selectShipping(${provider.maVC}, '${provider.tenDonVi}', ${provider.phiVanChuyen})">
                                                <input type="radio" 
                                                       name="shippingProviderId" 
                                                       value="${provider.maVC}" 
                                                       ${provider.maVC == defaultShipping.maVC ? 'checked' : ''}
                                                       onchange="selectShipping(${provider.maVC}, '${provider.tenDonVi}', ${provider.phiVanChuyen})">
                                                <div class="shipping-item-content">
                                                    <div class="shipping-provider-name">
                                                        <i class="fas fa-shipping-fast text-primary me-2"></i>
                                                        ${provider.tenDonVi}
                                                    </div>
                                                    <div>
                                                        <span class="shipping-fee-badge">
                                                            <i class="fas fa-money-bill-wave me-1"></i>
                                                            <fmt:formatNumber value="${provider.phiVanChuyen}" type="number" groupingUsed="true"/>₫
                                                        </span>
                                                    </div>
                                                    <div class="shipping-estimate">
                                                        <i class="fas fa-clock"></i>
                                                        <span>Giao hàng trong 2-5 ngày</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        
                        <!-- Hidden input to store selected shipping ID -->
                        <input type="hidden" name="shippingId" id="shippingId" 
                               value="${not empty defaultShipping ? defaultShipping.maVC : ''}" required>
                    </div>
                    
                    <!-- Sản phẩm -->
                    <div class="section-card">
                        <div class="section-title">
                            <i class="fas fa-box me-2"></i>Sản phẩm đã chọn
                        </div>
                        
                        <c:forEach var="storeEntry" items="${itemsByStore}" varStatus="storeStatus">
                            <div class="store-group" data-store-id="${storeEntry.key.maCH}">
                                <div class="store-header d-flex justify-content-between align-items-center mb-3">
                                    <div class="store-name">
                                        <i class="fas fa-store"></i>
                                        <span>${storeEntry.key.tenCH}</span>
                                    </div>
                                    
                                    <!-- Nút xem mã giảm giá -->
                                    <c:if test="${not empty storeDiscounts[storeEntry.key.maCH]}">
                                        <button type="button" class="btn btn-outline-warning btn-sm" 
                                                onclick="toggleDiscountPanel(${storeEntry.key.maCH})"
                                                style="border-radius: 20px; padding: 8px 20px; font-weight: 600;">
                                            <i class="fas fa-gift me-2"></i>Xem mã giảm giá 
                                            (${storeDiscounts[storeEntry.key.maCH].size()})
                                        </button>
                                    </c:if>
                                </div>
                                
                                <!-- Panel mã giảm giá (ẩn mặc định) -->
                                <c:if test="${not empty storeDiscounts[storeEntry.key.maCH]}">
                                    <div class="discount-panel" id="discountPanel-${storeEntry.key.maCH}" style="display: none;">
                                        <div class="discount-panel-header">
                                            <h6><i class="fas fa-tags me-2"></i>Chọn mã giảm giá</h6>
                                            <button type="button" class="btn-close-panel" 
                                                    onclick="toggleDiscountPanel(${storeEntry.key.maCH})">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                        <div class="discount-panel-body">
                                            <c:forEach var="discount" items="${storeDiscounts[storeEntry.key.maCH]}">
                                                <div class="discount-item-card">
                                                    <input type="checkbox" 
                                                           id="discount-${storeEntry.key.maCH}-${discount.maGG}"
                                                           name="storeDiscount-${storeEntry.key.maCH}"
                                                           value="${discount.maGG}"
                                                           data-code="${discount.maSo}"
                                                           data-type="${discount.loaiGiam}"
                                                           data-value="${discount.giaTriGiam}"
                                                           data-min="${discount.giaTriDonHangToiThieu}"
                                                           data-max="${discount.giaTriGiamToiDa}"
                                                           onchange="applyStoreDiscount(${storeEntry.key.maCH}, this)">
                                                    <label for="discount-${storeEntry.key.maCH}-${discount.maGG}">
                                                        <div class="discount-code">${discount.maSo}</div>
                                                        <div class="discount-title">${discount.tenChuongTrinh}</div>
                                                        <div class="discount-value">
                                                            <c:choose>
                                                                <c:when test="${discount.loaiGiam == 'PERCENT' || discount.loaiGiam == 'percent'}">
                                                                    <span class="badge bg-success">
                                                                        Giảm ${discount.giaTriGiam}%
                                                                        <c:if test="${discount.giaTriGiamToiDa != null}">
                                                                            - Tối đa <fmt:formatNumber value="${discount.giaTriGiamToiDa}" type="number" groupingUsed="true"/>₫
                                                                        </c:if>
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-success">
                                                                        Giảm <fmt:formatNumber value="${discount.giaTriGiam}" type="number" groupingUsed="true"/>₫
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <c:if test="${discount.giaTriDonHangToiThieu != null}">
                                                            <div class="discount-condition">
                                                                <i class="fas fa-info-circle me-1"></i>
                                                                Đơn tối thiểu: <fmt:formatNumber value="${discount.giaTriDonHangToiThieu}" type="number" groupingUsed="true"/>₫
                                                            </div>
                                                        </c:if>
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </c:if>
                                
                                <!-- Hiển thị mã đã áp dụng -->
                                <div class="applied-discount-badge" id="appliedBadge-${storeEntry.key.maCH}" style="display: none;">
                                    <i class="fas fa-check-circle text-success me-2"></i>
                                    <span>Đã áp dụng: <strong id="appliedCode-${storeEntry.key.maCH}"></strong></span>
                                    <span class="ms-2 text-success fw-bold" id="appliedAmount-${storeEntry.key.maCH}"></span>
                                </div>
                                
                                <!-- Danh sách sản phẩm -->
                                <c:forEach var="item" items="${storeEntry.value}">
                                    <div class="product-item">
                                        <img src="${pageContext.request.contextPath}/assets/img/products/${item.sanPham.hinhAnh}" 
                                             alt="${item.sanPham.tenSP}" class="product-image"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';">
                                        <div class="product-info">
                                            <div class="product-name">${item.sanPham.tenSP}</div>
                                            <div class="product-quantity">Số lượng: ${item.soLuong}</div>
                                        </div>
                                        <div class="product-price">
                                            <fmt:formatNumber value="${item.thanhTien}" type="number"
                                                    groupingUsed="true" maxFractionDigits="0"/>₫
                                        </div>
                                    </div>
                                </c:forEach>
                                
                                <!-- Tổng tiền cửa hàng -->
                                <div class="store-subtotal">
                                    <span>Tổng cộng:</span>
                                    <strong class="store-subtotal-amount" id="storeSubtotal-${storeEntry.key.maCH}">
                                        <c:set var="storeTotal" value="0"/>
                                        <c:forEach var="item" items="${storeEntry.value}">
                                            <c:set var="storeTotal" value="${storeTotal + item.thanhTien}"/>
                                        </c:forEach>
                                        <fmt:formatNumber value="${storeTotal}" type="number" 
                                                        groupingUsed="true" maxFractionDigits="0"/>₫
                                    </strong>
                                </div>
                                
                                <!-- Hidden input để lưu mã giảm giá đã chọn -->
                                <input type="hidden" name="storeDiscountCode-${storeEntry.key.maCH}" 
                                       id="selectedDiscountCode-${storeEntry.key.maCH}" value="">
                                <input type="hidden" name="storeDiscountAmount-${storeEntry.key.maCH}" 
                                       id="selectedDiscountAmount-${storeEntry.key.maCH}" value="0">
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- Phương thức thanh toán -->
                    <div class="section-card">
                        <div class="section-title">
                            <i class="fas fa-credit-card me-2"></i>Phương thức thanh toán
                        </div>
                        
                        <!-- COD - Tiền mặt -->
                        <div class="payment-method" onclick="selectPayment(this, 'COD')">
                            <div class="d-flex align-items-center">
                                <input type="radio" name="paymentMethod" value="COD" checked required>
                                <i class="fas fa-money-bill-wave payment-icon"></i>
                                <div>
                                    <strong style="font-size: 1.1rem;">Thanh toán khi nhận hàng (COD)</strong>
                                    <div class="text-muted mt-1">Thanh toán bằng tiền mặt khi nhận hàng</div>
                                </div>
                            </div>
                            <div class="payment-details" id="cod-details">
                                <div class="alert alert-info mb-0">
                                    <i class="fas fa-info-circle me-2"></i>
                                    Bạn sẽ thanh toán bằng tiền mặt cho shipper khi nhận hàng.
                                </div>
                            </div>
                        </div>
                        
                        <!-- Chuyển khoản Ngân hàng -->
                        <div class="payment-method" onclick="selectPayment(this, 'BANK_TRANSFER')">
                            <div class="d-flex align-items-center">
                                <input type="radio" name="paymentMethod" value="BANK_TRANSFER" required>
                                <i class="fas fa-university payment-icon"></i>
                                <div>
                                    <strong style="font-size: 1.1rem;">Chuyển khoản Ngân hàng</strong>
                                    <div class="text-muted mt-1">Chuyển khoản qua tài khoản ngân hàng</div>
                                </div>
                            </div>
                            <div class="payment-details" id="bank-details">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    <strong>Lưu ý:</strong> Vui lòng chuyển khoản chính xác số tiền và ghi rõ nội dung chuyển khoản.
                                </div>
                                
                                <!-- Hiển thị thông tin ngân hàng của từng cửa hàng -->
                                <c:forEach var="storeEntry" items="${itemsByStore}">
                                    <c:if test="${storeEntry.key.bankEnable}">
                                        <div class="mb-4">
                                            <h6 class="fw-bold text-primary">
                                                <i class="fas fa-store me-2"></i>${storeEntry.key.tenCH}
                                            </h6>
                                            <table class="table table-borderless mb-3">
                                                <tr>
                                                    <td class="fw-bold" style="width: 150px;">Ngân hàng:</td>
                                                    <td>${storeEntry.key.bankName}</td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-bold">Số tài khoản:</td>
                                                    <td>
                                                        <span class="text-primary fw-bold">${storeEntry.key.bankAccountNumber}</span>
                                                        <button type="button" class="btn btn-sm btn-outline-primary ms-2" 
                                                                onclick="copyToClipboard('${storeEntry.key.bankAccountNumber}')">
                                                            <i class="fas fa-copy"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-bold">Chủ tài khoản:</td>
                                                    <td>${storeEntry.key.bankAccountName}</td>
                                                </tr>
                                            </table>
                                            
                                            <c:if test="${not empty storeEntry.key.bankQR}">
                                                <div class="qr-code-container">
                                                    <p class="fw-bold mb-3">Quét mã QR để thanh toán</p>
                                                    <img src="${pageContext.request.contextPath}/assets/img/qr/${storeEntry.key.bankQR}" 
                                                         alt="Bank QR Code">
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                        
                        <!-- MoMo -->
                        <div class="payment-method" onclick="selectPayment(this, 'MOMO')">
                            <div class="d-flex align-items-center">
                                <input type="radio" name="paymentMethod" value="MOMO" required>
                                <i class="fab fa-cc-amazon-pay payment-icon" style="color: #d82d8b;"></i>
                                <div>
                                    <strong style="font-size: 1.1rem;">Ví MoMo</strong>
                                    <div class="text-muted mt-1">Thanh toán qua ví điện tử MoMo</div>
                                </div>
                            </div>
                            <div class="payment-details" id="momo-details">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    <strong>Lưu ý:</strong> Vui lòng chuyển khoản chính xác số tiền và ghi rõ nội dung.
                                </div>
                                
                                <!-- Hiển thị thông tin MoMo của từng cửa hàng -->
                                <c:forEach var="storeEntry" items="${itemsByStore}">
                                    <c:if test="${storeEntry.key.momoEnable}">
                                        <div class="mb-4">
                                            <h6 class="fw-bold text-primary">
                                                <i class="fas fa-store me-2"></i>${storeEntry.key.tenCH}
                                            </h6>
                                            <table class="table table-borderless mb-3">
                                                <tr>
                                                    <td class="fw-bold" style="width: 150px;">Số điện thoại:</td>
                                                    <td>
                                                        <span class="text-danger fw-bold">${storeEntry.key.momoPhone}</span>
                                                        <button type="button" class="btn btn-sm btn-outline-danger ms-2" 
                                                                onclick="copyToClipboard('${storeEntry.key.momoPhone}')">
                                                            <i class="fas fa-copy"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fw-bold">Chủ tài khoản:</td>
                                                    <td>${storeEntry.key.momoName}</td>
                                                </tr>
                                            </table>
                                            
                                            <c:if test="${not empty storeEntry.key.momoQR}">
                                                <div class="qr-code-container">
                                                    <p class="fw-bold mb-3">Quét mã QR để thanh toán</p>
                                                    <img src="${pageContext.request.contextPath}/assets/img/qr/${storeEntry.key.momoQR}" 
                                                         alt="MoMo QR Code">
                                                </div>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Ghi chú -->
                    <div class="section-card">
                        <div class="section-title">
                            <i class="fas fa-comment me-2"></i>Ghi chú đơn hàng
                        </div>
                        <textarea name="note" class="form-control" rows="3" 
                                  placeholder="Ghi chú về đơn hàng của bạn..."></textarea>
                    </div>
                </div>
                
                <!-- Right Column - Order Summary -->
                <div class="col-lg-4">
                    <div class="order-summary">
                        <div class="section-card">
                            <div class="section-title">
                                <i class="fas fa-file-invoice-dollar me-2"></i>Tổng đơn hàng
                            </div>
                            
                            <div class="alert alert-info mb-3">
                                <i class="fas fa-info-circle me-2"></i>
                                <small>Chọn mã giảm giá từ từng cửa hàng bên trái để được giảm giá!</small>
                            </div>
                            
                            <!-- Chi tiết giá -->
                            <div class="summary-row">
                                <span>Tạm tính:</span>
                                <strong><fmt:formatNumber value="${subtotal}" type="number" 
                                        groupingUsed="true" maxFractionDigits="0"/>₫</strong>
                            </div>
                            
                            <div class="summary-row">
                                <span>Phí vận chuyển:</span>
                                <strong><fmt:formatNumber value="${shippingFee}" type="number" 
                                        groupingUsed="true" maxFractionDigits="0"/>₫</strong>
                            </div>
                            
                            <!-- Dòng giảm giá (sẽ được thêm động bằng JavaScript) -->
                            <c:if test="${discountAmount != null && discountAmount > 0}">
                                <div class="summary-row text-danger" id="discountRow">
                                    <span><i class="fas fa-tag me-2"></i>Giảm giá:</span>
                                    <strong id="discountAmountText">-<fmt:formatNumber value="${discountAmount}" type="number" 
                                            groupingUsed="true" maxFractionDigits="0"/>₫</strong>
                                </div>
                            </c:if>
                            
                            <div class="summary-row">
                                <span>Tổng thanh toán:</span>
                                <strong id="totalAmountText"><fmt:formatNumber value="${totalAmount}" type="number" 
                                        groupingUsed="true" maxFractionDigits="0"/>₫</strong>
                            </div>
                            
                            <button type="submit" class="btn-place-order" 
                                    ${empty addresses ? 'disabled' : ''}>
                                <i class="fas fa-check-circle me-2"></i>Đặt hàng
                            </button>
                            
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/user/cart" class="text-muted">
                                    <i class="fas fa-arrow-left me-2"></i>Quay lại giỏ hàng
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // === KHỞI TẠO ===
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-show payment details cho COD (method mặc định)
            const selectedPayment = document.querySelector('.payment-method input[type="radio"]:checked');
            if (selectedPayment && selectedPayment.value === 'COD') {
                const paymentMethod = selectedPayment.closest('.payment-method');
                paymentMethod.classList.add('selected');
                paymentMethod.querySelector('.payment-details').classList.add('active');
            }
        });
        
        // === HÀM XỬ LÝ THANH TOÁN (ĐÃ SỬA LỖI) ===
        function selectPayment(element, method) {
            console.log('🔵 selectPayment called - method:', method);
            
            // Bước 1: Bỏ chọn tất cả radio buttons trước
            document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
                radio.checked = false;
            });
            
            // Bước 2: Xóa CSS selected khỏi tất cả
            document.querySelectorAll('.payment-method').forEach(item => {
                item.classList.remove('selected');
                item.querySelector('.payment-details').classList.remove('active');
            });
            
            // Bước 3: Thêm selected CSS
            element.classList.add('selected');
            
            // Bước 4: CHECK RADIO BUTTON - ĐÂY LÀ QUAN TRỌNG NHẤT!
            const radioButton = element.querySelector('input[type="radio"][value="' + method + '"]');
            if (radioButton) {
                radioButton.checked = true;
                console.log('✅ Radio button checked:', method, '- Verified:', radioButton.checked);
            } else {
                console.error('❌ Radio button NOT FOUND for method:', method);
            }
            
            // Bước 5: Hiển thị chi tiết nếu là COD
            if (method === 'COD') {
                element.querySelector('.payment-details').classList.add('active');
            }
            
            // Debug: In ra giá trị hiện tại của form
            setTimeout(() => {
                const checkedRadio = document.querySelector('input[name="paymentMethod"]:checked');
                console.log('🔍 After 100ms - Checked payment method:', checkedRadio ? checkedRadio.value : 'NONE');
            }, 100);
        }
        
        // === CÁC HÀM KHÁC ===
        function selectAddress(element, addressId) {
            document.querySelectorAll('.address-item').forEach(item => {
                item.classList.remove('selected');
            });
            element.classList.add('selected');
            element.querySelector('input[type="radio"]').checked = true;
        }
        
        function copyToClipboard(text) {
            navigator.clipboard.writeText(text).then(() => {
                alert('Đã sao chép: ' + text);
            });
        }
        
        function toggleDiscountPanel(storeId) {
            console.log('🎁 toggleDiscountPanel called - storeId:', storeId);
            
            const panel = document.getElementById('discountPanel-' + storeId);
            console.log('📦 Panel element:', panel);
            
            if (!panel) {
                console.error('❌ Panel not found! ID:', 'discountPanel-' + storeId);
                return;
            }
            
            const currentDisplay = panel.style.display;
            console.log('👀 Current display:', currentDisplay);
            
            if (currentDisplay === 'none' || currentDisplay === '') {
                panel.style.display = 'block';
                console.log('✅ Panel opened');
            } else {
                panel.style.display = 'none';
                console.log('✅ Panel closed');
            }
        }
        
        function applyStoreDiscount(storeId, checkbox) {
            const allCheckboxes = document.querySelectorAll('input[name="storeDiscount-' + storeId + '"]');
            allCheckboxes.forEach(cb => {
                if (cb !== checkbox) {
                    cb.checked = false;
                }
            });
            
            if (checkbox.checked) {
                const discountCode = checkbox.getAttribute('data-code');
                const discountType = checkbox.getAttribute('data-type');
                const discountValue = parseFloat(checkbox.getAttribute('data-value'));
                const minOrder = checkbox.getAttribute('data-min');
                const maxDiscount = checkbox.getAttribute('data-max');
                
                const storeGroup = document.querySelector('.store-group[data-store-id="' + storeId + '"]');
                const productItems = storeGroup.querySelectorAll('.product-item');
                let storeTotal = 0;
                
                productItems.forEach(item => {
                    const priceText = item.querySelector('.product-price').textContent;
                    const price = parseFloat(priceText.replace(/[^\d]/g, ''));
                    storeTotal += price;
                });
                
                if (minOrder && minOrder !== 'null') {
                    const minOrderValue = parseFloat(minOrder);
                    if (storeTotal < minOrderValue) {
                        alert('Đơn hàng tối thiểu ' + minOrderValue.toLocaleString('vi-VN') + '₫ để áp dụng mã này!');
                        checkbox.checked = false;
                        return;
                    }
                }
                
                let discountAmount = 0;
                if (discountType === 'PERCENT' || discountType === 'percent') {
                    discountAmount = storeTotal * (discountValue / 100);
                    if (maxDiscount && maxDiscount !== 'null') {
                        const maxDiscountValue = parseFloat(maxDiscount);
                        if (discountAmount > maxDiscountValue) {
                            discountAmount = maxDiscountValue;
                        }
                    }
                } else {
                    discountAmount = discountValue;
                }
                
                if (discountAmount > storeTotal) {
                    discountAmount = storeTotal;
                }
                
                const newStoreTotal = storeTotal - discountAmount;
                const storeSubtotalEl = document.getElementById('storeSubtotal-' + storeId);
                if (storeSubtotalEl) {
                    storeSubtotalEl.textContent = newStoreTotal.toLocaleString('vi-VN') + '₫';
                }
                
                document.getElementById('appliedBadge-' + storeId).style.display = 'flex';
                document.getElementById('appliedCode-' + storeId).textContent = discountCode;
                document.getElementById('appliedAmount-' + storeId).textContent = 
                    '(-' + discountAmount.toLocaleString('vi-VN') + '₫)';
                
                document.getElementById('selectedDiscountCode-' + storeId).value = discountCode;
                document.getElementById('selectedDiscountAmount-' + storeId).value = discountAmount;
                
                toggleDiscountPanel(storeId);
                updateOrderTotal();
                
            } else {
                removeStoreDiscount(storeId);
            }
        }
        
        function removeStoreDiscount(storeId) {
            const storeGroup = document.querySelector('.store-group[data-store-id="' + storeId + '"]');
            const productItems = storeGroup.querySelectorAll('.product-item');
            let storeTotal = 0;
            productItems.forEach(item => {
                const priceText = item.querySelector('.product-price').textContent;
                const price = parseFloat(priceText.replace(/[^\d]/g, ''));
                storeTotal += price;
            });
            
            const storeSubtotalEl = document.getElementById('storeSubtotal-' + storeId);
            if (storeSubtotalEl) {
                storeSubtotalEl.textContent = storeTotal.toLocaleString('vi-VN') + '₫';
            }
            
            document.getElementById('appliedBadge-' + storeId).style.display = 'none';
            document.getElementById('selectedDiscountCode-' + storeId).value = '';
            document.getElementById('selectedDiscountAmount-' + storeId).value = '0';
            
            updateOrderTotal();
        }
        
        // Cập nhật tổng đơn hàng
        function updateOrderTotal() {
            // --- 1. TÍNH TOÁN ---
            
            // Tính tổng Tạm tính (lấy từ "Tổng cộng" bên trái, đã giảm)
            // và tính tổng số tiền Giảm giá
            let subtotal = 0;
            let totalDiscount = 0;
            const allStoreGroups = document.querySelectorAll('.store-group');
            
            allStoreGroups.forEach(group => {
                const subtotalText = group.querySelector('.store-subtotal-amount').textContent;
                const storeAmount = parseFloat(subtotalText.replace(/[^\d]/g, ''));
                subtotal += storeAmount;
                
                // Lấy số tiền giảm của cửa hàng này
                const storeId = group.getAttribute('data-store-id');
                const discountInput = document.getElementById('selectedDiscountAmount-' + storeId);
                if (discountInput && discountInput.value) {
                    const discount = parseFloat(discountInput.value);
                    if (!isNaN(discount) && discount > 0) {
                        totalDiscount += discount;
                    }
                }
            });
    
            // Lấy phí vận chuyển
            let shippingFee = 0;
            const selectedShippingRadio = document.querySelector('input[name="shippingProviderId"]:checked');
            if (selectedShippingRadio) {
                const shippingCard = selectedShippingRadio.closest('.shipping-item-card');
                if (shippingCard) {
                    const feeText = shippingCard.querySelector('.shipping-fee-badge').textContent;
                    shippingFee = parseFloat(feeText.replace(/[^\d]/g, ''));
                }
            }
            
            // Tính tổng thanh toán: Tạm tính (đã giảm) + Phí ship
            const finalTotal = subtotal + shippingFee;
    
            // --- 2. CẬP NHẬT GIAO DIỆN ---
            
            // Cập nhật "Tạm tính" (Dòng 1)
            const summaryRows = document.querySelectorAll('.summary-row');
            if (summaryRows[0] && summaryRows[0].querySelector('strong')) {
                summaryRows[0].querySelector('strong').textContent = subtotal.toLocaleString('vi-VN') + '₫';
            }
            
            // Cập nhật "Phí vận chuyển" (Dòng 2)
            if (summaryRows[1] && summaryRows[1].querySelector('strong')) {
                summaryRows[1].querySelector('strong').textContent = shippingFee.toLocaleString('vi-VN') + '₫';
            }
    
            // Cập nhật "Giảm giá" (Tìm hoặc Tạo)
            let discountRow = document.getElementById('discountRow');
            
            if (totalDiscount > 0) {
                // Nếu chưa có, tạo mới
                if (!discountRow) {
                    discountRow = document.createElement('div');
                    discountRow.id = 'discountRow';
                    discountRow.className = 'summary-row text-danger';
                    
                    // Chèn trước dòng "Tổng thanh toán" (dòng có id 'totalAmountText')
                    const totalAmountRow = document.getElementById('totalAmountText').closest('.summary-row');
                    if (totalAmountRow) {
                        totalAmountRow.parentNode.insertBefore(discountRow, totalAmountRow);
                    }
                }
                
                // Cập nhật nội dung và hiển thị
                discountRow.innerHTML = `
                    <span><i class="fas fa-tag me-2"></i>Giảm giá:</span>
                    <strong>-${totalDiscount.toLocaleString('vi-VN')}₫</strong>
                `;
                discountRow.style.display = 'flex'; // Dùng 'flex' vì .summary-row là flex
    
            } else {
                // Nếu có, ẩn đi
                if (discountRow) {
                    discountRow.style.display = 'none';
                }
            }
    
            // Cập nhật "Tổng thanh toán" (Dùng ID cho chắc chắn)
            const totalAmountElement = document.getElementById('totalAmountText');
            if (totalAmountElement) {
                totalAmountElement.textContent = finalTotal.toLocaleString('vi-VN') + '₫';
            }
            
            console.log('✅ Updated Order Total:', {
                subtotal: subtotal,
                discount: totalDiscount,
                shipping: shippingFee,
                finalTotal: finalTotal
            });
        }
        
        // Form validation before submit
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            console.log('🚀 Form submitting...');
            
            const addressSelected = document.querySelector('input[name="addressId"]:checked');
            const paymentSelected = document.querySelector('input[name="paymentMethod"]:checked');
            const shippingSelected = document.getElementById('shippingId').value;
            
            console.log('📋 Validation check:');
            console.log('  - Address:', addressSelected ? addressSelected.value : 'NOT SELECTED');
            console.log('  - Payment:', paymentSelected ? paymentSelected.value : 'NOT SELECTED ❌');
            console.log('  - Shipping:', shippingSelected || 'NOT SELECTED');
            
            if (!addressSelected) {
                e.preventDefault();
                alert('Vui lòng chọn địa chỉ giao hàng');
                console.error('❌ Form blocked: No address selected');
                return false;
            }
            
            if (!shippingSelected) {
                e.preventDefault();
                alert('Vui lòng chọn đơn vị vận chuyển');
                console.error('❌ Form blocked: No shipping selected');
                return false;
            }
            
            if (!paymentSelected) {
                e.preventDefault();
                alert('❌ LỖI: Vui lòng chọn phương thức thanh toán!\n\nNếu bạn đã click vào Bank/MoMo, vui lòng thử lại hoặc chọn COD.');
                console.error('❌ Form blocked: No payment method selected');
                
                // Debug: Liệt kê tất cả radio buttons
                const allRadios = document.querySelectorAll('input[name="paymentMethod"]');
                console.log('📻 All payment radio buttons:');
                allRadios.forEach(radio => {
                    console.log('  -', radio.value, ':', radio.checked ? 'CHECKED ✅' : 'not checked');
                });
                
                return false;
            }
            
            console.log('✅ Form validation passed! Submitting with payment:', paymentSelected.value);
            
            // Show loading
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
        });
        
        // ========== SHIPPING PROVIDER FUNCTIONS ==========
        
        // Toggle shipping panel
        function toggleShippingPanel() {
            const panel = document.getElementById('shippingPanel');
            const chevron = document.getElementById('shippingChevron');
            
            if (panel.style.display === 'none') {
                panel.style.display = 'block';
                chevron.classList.remove('fa-chevron-down');
                chevron.classList.add('fa-chevron-up');
            } else {
                panel.style.display = 'none';
                chevron.classList.remove('fa-chevron-up');
                chevron.classList.add('fa-chevron-down');
            }
        }
        
        // Close shipping panel
        function closeShippingPanel() {
            const panel = document.getElementById('shippingPanel');
            const chevron = document.getElementById('shippingChevron');
            panel.style.display = 'none';
            chevron.classList.remove('fa-chevron-up');
            chevron.classList.add('fa-chevron-down');
        }
        
        // Select shipping provider
        function selectShipping(shippingId, shippingName, shippingFee) {
            // Cập nhật UI selector
            document.getElementById('selectedShippingName').textContent = shippingName;
            document.getElementById('selectedShippingInfo').textContent = 
                'Phí vận chuyển: ' + shippingFee.toLocaleString('vi-VN') + '₫';
            
            // Đánh dấu has-selection
            const selector = document.getElementById('shippingSelector');
            selector.classList.add('has-selection');
            
            // Lưu giá trị vào hidden input
            document.getElementById('shippingId').value = shippingId;
            
            // Bỏ selected class khỏi tất cả cards
            document.querySelectorAll('.shipping-item-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            // Thêm selected class vào card được chọn
            const selectedCard = document.getElementById('shippingCard' + shippingId);
            if (selectedCard) {
                selectedCard.classList.add('selected');
            }
            
            // Cập nhật tổng tiền đơn hàng với phí ship mới
            updateShippingFee(shippingFee);
            
            // Đóng panel sau khi chọn
            setTimeout(() => {
                closeShippingPanel();
            }, 300);
            
            console.log('✅ Selected shipping:', {
                id: shippingId,
                name: shippingName,
                fee: shippingFee
            });
        }
        
        // Update shipping fee in order summary
        function updateShippingFee(newShippingFee) {
            const summaryRows = document.querySelectorAll('.summary-row');
            let shippingRowIndex = -1;
            
            // Tìm dòng "Phí vận chuyển"
            summaryRows.forEach((row, index) => {
                const labelText = row.querySelector('span:first-child')?.textContent;
                if (labelText && labelText.includes('Phí vận chuyển')) {
                    shippingRowIndex = index;
                }
            });
            
            // Cập nhật phí vận chuyển
            if (shippingRowIndex !== -1) {
                const shippingRow = summaryRows[shippingRowIndex];
                // An toàn hơn khi tìm 'strong' thay vì 'span:last-child'
                const feeElement = shippingRow.querySelector('strong');
                if (feeElement) {
                    feeElement.textContent = newShippingFee.toLocaleString('vi-VN') + '₫';
                }
            }
            
            // Tính lại tổng thanh toán
            updateOrderTotal();
        }
    </script>
</body>
</html>