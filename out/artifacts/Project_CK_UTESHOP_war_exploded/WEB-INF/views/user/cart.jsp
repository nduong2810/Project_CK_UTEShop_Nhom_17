<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giỏ Hàng - UTESHOP</title>
    
    <style>
        /* Hero Banner với gradient đẹp hơn */
        .hero-carousel {
            position: relative;
            width: 100%;
            height: 350px;
            overflow: hidden;
            margin-bottom: 40px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
        }
        
        .hero-carousel::before {
            content: '';
            position: absolute;
            width: 500px;
            height: 500px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            top: -200px;
            left: -100px;
            animation: float 20s ease-in-out infinite;
        }
        
        .hero-carousel::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.1);
            bottom: -150px;
            right: -100px;
            animation: float 25s ease-in-out infinite;
            animation-delay: -5s;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(0deg); }
            25% { transform: translateY(-30px) rotate(90deg); }
            50% { transform: translateY(0) rotate(180deg); }
            75% { transform: translateY(30px) rotate(270deg); }
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
        }
        
        .hero-content h1 {
            font-size: 2.8rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
            animation: fadeInDown 0.8s ease-out;
        }
        
        .hero-content p {
            font-size: 1.2rem;
            opacity: 0.95;
            animation: fadeIn 1s ease-out 0.3s both;
        }
        
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .select-all-section {
            background: white;
            padding: 20px 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .select-all-section input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #2874f0;
        }
        
        .select-all-section label {
            font-weight: 600;
            color: #333;
            font-size: 1rem;
            cursor: pointer;
            user-select: none;
        }
        
        .cart-summary-bar {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }
        .cart-summary-bar .summary-item {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .cart-summary-bar .summary-item i {
            font-size: 1.5rem;
            color: #667eea;
        }
        
        .cart-summary-bar .summary-item .label {
            color: #666;
            font-size: 0.9rem;
            font-weight: 500;
        }
        
        .cart-summary-bar .summary-item .value {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2874f0;
        }
        
        .checkout-actions {
            display: flex;
            gap: 15px;
            align-items: center;
        }
        .btn-checkout {
            background: linear-gradient(45deg, #2874f0, #1a5fce);
            color: white;
            border: none;
            padding: 15px 40px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(40, 116, 240, 0.3);
        }
        .btn-checkout:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(40, 116, 240, 0.4);
        }
        .btn-continue-shopping {
            background: white;
            color: #667eea;
            border: 2px solid #667eea;
            padding: 13px 30px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .btn-continue-shopping:hover {
            background: #667eea;
            color: white;
        }
        .section-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .section-header h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 10px;
        }
        
        .section-header p {
            font-size: 1.1rem;
            color: #666;
        }
        
        .cart-items-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }
        .product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            border: 1px solid #e0e0e0;
            display: flex;
            flex-direction: row;
            align-items: stretch;
        }
        
        .product-card.selected {
            border: 2px solid #2874f0;
            background: #f8f9ff;
        }
        
        .product-card:hover {
            box-shadow: 0 6px 20px rgba(0,0,0,0.12);
            transform: translateY(-2px);
        }
        
        .product-checkbox {
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
            border-right: 1px solid #e0e0e0;
        }
        
        .product-checkbox input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
            accent-color: #2874f0;
        }
        .product-image-container {
            width: 150px;
            min-width: 150px;
            height: 150px;
            position: relative;
            overflow: hidden;
            background: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        .product-image {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.3s ease;
        }
        .product-card:hover .product-image {
            transform: scale(1.1);
        }
        .badge-cart {
            position: absolute;
            top: 10px;
            left: 10px;
            background: linear-gradient(45deg, #2874f0, #1a5fce);
            color: white;
            padding: 5px 10px;
            border-radius: 15px;
            font-size: 0.7rem;
            font-weight: 600;
            z-index: 2;
        }
        .product-card .card-body {
            padding: 15px 20px;
            display: flex;
            flex-direction: row;
            flex-grow: 1;
            align-items: center;
            gap: 20px;
        }
        
        .product-info {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .product-card .card-title {
            font-size: 1.05rem;
            font-weight: 600;
            margin-bottom: 5px;
            color: #333;
            line-height: 1.4;
        }
        .product-card .card-title a {
            color: inherit;
            text-decoration: none;
        }
        .product-card .card-title a:hover {
            color: #2874f0;
        }
        .product-card .price {
            font-size: 0.95rem;
            font-weight: 600;
            color: #666;
        }
        
        .product-card .price::before {
            content: '';
        }
        .quantity-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .quantity-label {
            font-weight: 600;
            color: #333;
            font-size: 0.9rem;
        }
        .quantity-controls {
            display: inline-flex;
            align-items: center;
            border: 2px solid #2874f0;
            border-radius: 25px;
            overflow: hidden;
            background: white;
            box-shadow: 0 2px 8px rgba(40, 116, 240, 0.15);
        }
        
        .quantity-controls button {
            background: white;
            color: #2874f0;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            font-size: 1rem;
            transition: all 0.3s;
            font-weight: 700;
            min-width: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .quantity-controls button:hover {
            background: #2874f0;
            color: white;
        }
        
        .quantity-controls button:active {
            transform: scale(0.95);
        }
        
        .quantity-controls .qty-value {
            padding: 6px 15px;
            font-weight: 700;
            color: #2874f0;
            min-width: 50px;
            text-align: center;
            background: #f0f4ff;
            border-left: 1px solid #e0e8ff;
            border-right: 1px solid #e0e8ff;
            font-size: 1rem;
        }
        .item-total-section {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 3px;
        }
        
        .item-total-label {
            font-weight: 600;
            color: #666;
            font-size: 0.85rem;
        }
        
        .item-total-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: #e74c3c;
        }
        
        .product-actions {
            display: flex;
            flex-direction: column;
            gap: 8px;
            min-width: 120px;
        }
        
        .product-buttons {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }
        .btn-remove, .btn-buy-single {
            padding: 8px 16px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            color: white;
            white-space: nowrap;
        }
        .btn-remove {
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
        }
        .btn-remove:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
        }
        .btn-buy-single {
            background: linear-gradient(45deg, #ff9f00, #ff5f00);
            box-shadow: 0 4px 15px rgba(255, 159, 0, 0.3);
        }
        .btn-buy-single:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(255, 159, 0, 0.4);
        }
        .empty-cart {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        }
        .empty-cart i {
            font-size: 6rem;
            color: #e9ecef;
            margin-bottom: 20px;
        }
        .empty-cart h2 {
            color: #7f8c8d;
            font-size: 1.8rem;
            margin-bottom: 15px;
        }
        .empty-cart .shop-now-btn {
            display: inline-block;
            background: linear-gradient(135deg, #2874f0 0%, #1a5fce 100%);
            color: white;
            padding: 15px 40px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 700;
            transition: all 0.3s;
        }
        .empty-cart .shop-now-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(40, 116, 240, 0.4);
        }
        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-success {
            background: #d4edda;
            color: #155724;
        }
        .alert-error {
            background: #f8d7da;
            color: #721c24;
        }
        @media (max-width: 992px) {
            .product-card {
                flex-direction: column;
            }
            
            .product-checkbox {
                flex-direction: row;
                justify-content: flex-start;
                padding: 15px 20px;
                border-right: none;
                border-bottom: 1px solid #e0e0e0;
            }
            
            .product-image-container {
                width: 100%;
                height: 250px;
            }
            
            .product-card .card-body {
                flex-direction: column;
                align-items: stretch;
                gap: 15px;
            }
            
            .product-actions {
                min-width: auto;
            }
            
            .product-buttons {
                flex-direction: row;
            }
            
            .item-total-section {
                align-items: center;
                flex-direction: row;
                justify-content: space-between;
            }
        }
        
        @media (max-width: 768px) {
            .hero-content h1 { 
                font-size: 1.8rem; 
            }
            .hero-content p {
                font-size: 1rem;
            }
            .cart-summary-bar { 
                flex-direction: column; 
                align-items: flex-start;
            }
            .checkout-actions {
                width: 100%;
                flex-direction: column;
            }
            .btn-checkout, .btn-continue-shopping {
                width: 100%;
                justify-content: center;
            }
            .section-header h2 {
                font-size: 1.8rem;
            }
            .product-card .card-title {
                font-size: 1rem;
            }
            .product-image-container {
                height: 200px;
            }
        }
    </style>
</head>
<body>

<main>
    <section class="hero-carousel">
        <div class="hero-content">
            <h1><i class="fas fa-shopping-cart"></i> Giỏ Hàng Của Bạn</h1>
            <p>Quản lý sản phẩm và tiến hành thanh toán</p>
        </div>
    </section>

    <div class="container-xl">
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-circle"></i>
                ${error}
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="empty-cart">
                    <i class="fas fa-shopping-cart"></i>
                    <h2>Giỏ hàng trống</h2>
                    <p>Bạn chưa có sản phẩm nào trong giỏ hàng. Hãy tiếp tục mua sắm!</p>
                    <a href="${pageContext.request.contextPath}/guest/home" class="shop-now-btn">
                        <i class="fas fa-shopping-bag me-2"></i>Mua Sắm Ngay
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-summary-bar">
                    <div class="summary-item">
                        <i class="fas fa-box"></i>
                        <div>
                            <div class="label">Sản phẩm đã chọn</div>
                            <div class="value" id="summary-selected-count">${cartCount}</div>
                        </div>
                    </div>
                    <div class="summary-item">
                        <i class="fas fa-money-bill-wave"></i>
                        <div>
                            <div class="label">Tổng tiền</div>
                            <div class="value" id="summary-total-amount">
                                <fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true"/>₫
                            </div>
                        </div>
                    </div>
                    <div class="checkout-actions">
                        <a href="${pageContext.request.contextPath}/guest/home" class="btn-continue-shopping">
                            <i class="fas fa-arrow-left"></i> Tiếp tục mua sắm
                        </a>
                        <button class="btn-checkout" onclick="proceedToCheckout()">
                            <i class="fas fa-credit-card"></i> Thanh Toán
                        </button>
                    </div>
                </div>

                <section class="mb-5">


                    <div class="select-all-section">
                        <input type="checkbox" id="select-all-checkbox" checked onchange="toggleSelectAll()">
                        <label for="select-all-checkbox">Chọn tất cả (<span id="selected-count">${cartCount}</span> sản phẩm)</label>
                    </div>

                    <div class="cart-items-list">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="product-card" data-product-id="${item.sanPham.maSP}">
                                <div class="product-checkbox">
                                    <input type="checkbox" 
                                           class="item-checkbox" 
                                           data-price="${item.donGia}"
                                           data-quantity="${item.soLuong}"
                                           data-total="${item.thanhTien}"
                                           checked
                                           onchange="updateSelectedItems()">
                                </div>
                                
                                <div class="product-image-container">
                                    <a href="${pageContext.request.contextPath}/guest/product?id=${item.sanPham.maSP}">
                                        <img src="${pageContext.request.contextPath}/assets/img/${item.sanPham.hinhAnh}" 
                                             alt="${item.sanPham.tenSP}"
                                             class="product-image"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/img/Logo_HCMUTE.png';">
                                    </a>
                                    <div class="badge-cart">Trong giỏ</div>
                                </div>
                                
                                <div class="card-body">
                                    <div class="product-info">
                                        <h6 class="card-title">
                                            <a href="${pageContext.request.contextPath}/guest/product?id=${item.sanPham.maSP}">
                                                ${item.sanPham.tenSP}
                                            </a>
                                        </h6>
                                        
                                        <div class="price">
                                            Đơn giá: <fmt:formatNumber value="${item.donGia}" type="number" groupingUsed="true"/>₫
                                        </div>

                                        <div class="quantity-section">
                                            <span class="quantity-label">Số lượng:</span>
                                            <div class="quantity-controls">
                                                <button type="button" onclick="changeQuantity(${item.sanPham.maSP}, -1, this)">
                                                    <i class="fas fa-minus"></i>
                                                </button>
                                                <span class="qty-value">${item.soLuong}</span>
                                                <button type="button" onclick="changeQuantity(${item.sanPham.maSP}, 1, this)">
                                                    <i class="fas fa-plus"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="item-total-section">
                                        <span class="item-total-label">Thành tiền:</span>
                                        <span class="item-total-price">
                                            <fmt:formatNumber value="${item.thanhTien}" type="number" groupingUsed="true"/>₫
                                        </span>
                                    </div>
                                    
                                    <div class="product-actions">
                                        <div class="product-buttons">
                                            <button class="btn-remove" onclick="removeFromCart(${item.sanPham.maSP})">
                                                <i class="fas fa-trash-alt me-2"></i>Xóa
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<script>
const basePath = '${pageContext.request.contextPath}';

// Format number to VND
function formatVND(number) {
    return new Intl.NumberFormat('vi-VN', { style: 'decimal', minimumFractionDigits: 0 }).format(number) + '₫';
}

// Toggle select all checkbox
function toggleSelectAll() {
    const selectAllCheckbox = document.getElementById('select-all-checkbox');
    const itemCheckboxes = document.querySelectorAll('.item-checkbox');
    
    itemCheckboxes.forEach(checkbox => {
        checkbox.checked = selectAllCheckbox.checked;
        updateCardStyle(checkbox);
    });
    
    updateSelectedItems();
}

// Update selected items count and total amount
function updateSelectedItems() {
    const itemCheckboxes = document.querySelectorAll('.item-checkbox:checked');
    const totalCheckboxes = document.querySelectorAll('.item-checkbox');
    
    let selectedCount = 0;
    let totalAmount = 0;
    
    itemCheckboxes.forEach(checkbox => {
        selectedCount++;
        totalAmount += parseFloat(checkbox.getAttribute('data-total'));
        updateCardStyle(checkbox);
    });
    
    // Update UI
    document.getElementById('selected-count').textContent = selectedCount;
    document.getElementById('summary-selected-count').textContent = selectedCount;
    document.getElementById('summary-total-amount').textContent = formatVND(totalAmount);
    
    // Update select all checkbox state
    const selectAllCheckbox = document.getElementById('select-all-checkbox');
    selectAllCheckbox.checked = (selectedCount === totalCheckboxes.length);
    
    // Update card styles for unchecked items
    document.querySelectorAll('.item-checkbox').forEach(cb => {
        if (!cb.checked) {
            updateCardStyle(cb);
        }
    });
}

// Update card style based on checkbox state
function updateCardStyle(checkbox) {
    const card = checkbox.closest('.product-card');
    if (checkbox.checked) {
        card.classList.add('selected');
    } else {
        card.classList.remove('selected');
    }
}

function changeQuantity(productId, delta, btn) {
    const row = btn.closest('.product-card');
    const qtySpan = row.querySelector('.qty-value');
    let current = parseInt(qtySpan.textContent) || 0;
    const newQty = current + delta;
    
    if (newQty < 1) {
        if (!confirm('Số lượng = 0 sẽ xóa sản phẩm khỏi giỏ hàng. Bạn có muốn tiếp tục?')) return;
    }

    btn.disabled = true;
    btn.style.opacity = '0.6';

    const form = document.createElement('form');
    form.method = 'POST';
    form.action = basePath + '/user/cart?action=update';
    form.innerHTML = '<input type="hidden" name="productId" value="' + productId + '">' +
                   '<input type="hidden" name="quantity" value="' + newQty + '">';
    document.body.appendChild(form);
    form.submit();
}

function removeFromCart(productId) {
    if (!confirm('Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?')) return;
    
    const row = document.querySelector('.product-card[data-product-id="' + productId + '"]');
    if (row) {
        row.style.opacity = '0.5';
        row.style.transition = 'opacity 0.3s';
    }
    
    window.location.href = basePath + '/user/cart?action=delete&productId=' + productId;
}

function buyNowSingle(productId) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = basePath + '/user/checkout';
    form.innerHTML = '<input type="hidden" name="selectedItems" value="' + productId + '">';
    document.body.appendChild(form);
    form.submit();
}

function proceedToCheckout() {
    const selectedCheckboxes = document.querySelectorAll('.item-checkbox:checked');
    
    if (selectedCheckboxes.length === 0) {
        alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
        return;
    }

    const form = document.createElement('form');
    form.method = 'POST';
    form.action = basePath + '/user/checkout';

    selectedCheckboxes.forEach(checkbox => {
        const card = checkbox.closest('.product-card');
        const productId = card.getAttribute('data-product-id');
        const input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'selectedItems';
        input.value = productId;
        form.appendChild(input);
    });

    document.body.appendChild(form);
    form.submit();
}

document.addEventListener('DOMContentLoaded', function() {
    // Auto-hide alerts
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s';
            alert.style.opacity = '0';
            setTimeout(() => alert.remove(), 500);
        }, 5000);
    });
    
    // Initialize checkbox states and calculate totals
    updateSelectedItems();
    
    // Add change event listener to all checkboxes
    document.querySelectorAll('.item-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', updateSelectedItems);
    });
});

console.log('🛒 UTESHOP Cart page loaded!');
</script>
</body>
</html>
