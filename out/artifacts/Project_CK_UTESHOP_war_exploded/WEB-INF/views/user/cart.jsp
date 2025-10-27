<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ Hàng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .cart-container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 20px;
        }
        .cart-header {
            background: #2ecc71;
            color: white;
            padding: 15px;
            border-radius: 8px 8px 0 0;
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .cart-table th, .cart-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .cart-table th {
            background: #f8f9fa;
            font-weight: bold;
        }
        .cart-table th:nth-child(1) { width: 5%; } /* Checkbox */
        .cart-table th:nth-child(2) { width: 10%; } /* Hình ảnh */
        .cart-table th:nth-child(3) { width: 30%; } /* Tên sản phẩm */
        .cart-table th:nth-child(4) { width: 15%; } /* Giá */
        .cart-table th:nth-child(5) { width: 20%; } /* Số lượng */
        .cart-table th:nth-child(6) { width: 15%; } /* Tổng */
        .cart-table th:nth-child(7) { width: 10%; } /* Hành động */
        .cart-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 5px;
        }
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .quantity-controls button {
            background: #3498db;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            transition: background 0.3s;
        }
        .quantity-controls button:hover {
            background: #2980b9;
        }
        .remove-btn {
            background: #e74c3c;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background 0.3s;
        }
        .remove-btn:hover {
            background: #c0392b;
        }
        .cart-total {
            text-align: right;
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
        }
        .checkout-btn {
            background: #2ecc71;
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            float: right;
            margin-top: 10px;
            transition: background 0.3s;
        }
        .checkout-btn:hover {
            background: #27ae60;
        }
        .select-all {
            margin-bottom: 10px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="cart-container">
        <div class="cart-header">Giỏ Hàng Của Bạn</div>
        
        <c:if test="${empty cartItems}">
            <p style="text-align: center;">Giỏ hàng trống!</p>
        </c:if>
        
        <c:if test="${not empty cartItems}">
            <div class="select-all">
                <input type="checkbox" id="select-all" checked onchange="toggleSelectAll()"> Chọn tất cả
            </div>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="header-checkbox" checked onchange="updateTotal()"></th>
                        <th>Sản Phẩm</th>
                        <th>Tên</th>
                        <th>Giá</th>
                        <th>Số Lượng</th>
                        <th>Tổng</th>
                        <th>Hành Động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${cartItems}">
                        <tr class="cart-item">
                            <td><input type="checkbox" class="item-checkbox" data-total="${item.thanhTien}" checked onchange="updateTotal()"></td>
                            <td>
                                <img src="${pageContext.request.contextPath}/assets/img/${item.sanPham.hinhAnh}" alt="${item.sanPham.tenSP}">
                            </td>
                            <td>${item.sanPham.tenSP}</td>
                            <td><fmt:formatNumber value="${item.donGia}" type="number" groupingUsed="true"/>₫</td>
                            <td>
                                <div class="quantity-controls">
                                    <button type="button" onclick="changeQuantity(${item.sanPham.maSP}, -1, this)">-</button>
                                    <span class="qty-value">${item.soLuong}</span>
                                    <button type="button" onclick="changeQuantity(${item.sanPham.maSP}, 1, this)">+</button>
                                </div>
                            </td>
                            <td class="item-total"><fmt:formatNumber value="${item.thanhTien}" type="number" groupingUsed="true"/>₫</td>
                            <td>
                                <button class="remove-btn" onclick="removeItem(${item.sanPham.maSP})">Xóa</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="cart-total">
                Tổng cộng: <span id="total-amount"><fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true"/>₫</span>
            </div>
            <button class="checkout-btn" onclick="proceedToCheckout()">Thanh Toán</button>
        </c:if>
    </div>

    <script>
        const basePath = '${pageContext.request.contextPath}';

        // Format number to VND
        function formatVND(number) {
            return new Intl.NumberFormat('vi-VN', { style: 'decimal', minimumFractionDigits: 0 }).format(number) + '₫';
        }

        // Update total amount based on selected items
        function updateTotal() {
            const checkboxes = document.querySelectorAll('.item-checkbox:checked');
            let total = 0;
            checkboxes.forEach(checkbox => {
                total += parseFloat(checkbox.getAttribute('data-total'));
            });
            document.getElementById('total-amount').textContent = formatVND(total);

            // Update "select all" checkbox state
            const allCheckboxes = document.querySelectorAll('.item-checkbox');
            const selectAll = document.getElementById('select-all');
            selectAll.checked = allCheckboxes.length === checkboxes.length;
        }

        // Toggle all checkboxes
        function toggleSelectAll() {
            const selectAll = document.getElementById('select-all');
            const checkboxes = document.querySelectorAll('.item-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
            updateTotal();
        }

        // Change quantity: sends POST to /user/cart?action=update with productId and quantity
        function changeQuantity(productId, delta, btn) {
            const row = btn.closest('.cart-item');
            const qtySpan = row.querySelector('.qty-value');
            let current = parseInt(qtySpan.textContent) || 0;
            const newQty = current + delta;
            if (newQty < 1) {
                if (!confirm('Số lượng = 0 sẽ xóa sản phẩm. Bạn có muốn tiếp tục?')) return;
            }

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = basePath + '/user/cart?action=update';

            const inputProduct = document.createElement('input');
            inputProduct.type = 'hidden';
            inputProduct.name = 'productId';
            inputProduct.value = productId;
            form.appendChild(inputProduct);

            const inputQuantity = document.createElement('input');
            inputQuantity.type = 'hidden';
            inputQuantity.name = 'quantity';
            inputQuantity.value = newQty;
            form.appendChild(inputQuantity);

            document.body.appendChild(form);
            form.submit();
        }

        // Remove item by productId via GET
        function removeItem(productId) {
            if (!confirm('Bạn có chắc muốn xóa sản phẩm này?')) return;
            window.location.href = basePath + '/user/cart?action=delete&productId=' + productId;
        }

        // Proceed to checkout with selected items
        function proceedToCheckout() {
            const selectedItems = [];
            const checkboxes = document.querySelectorAll('.item-checkbox:checked');
            checkboxes.forEach(checkbox => {
                const row = checkbox.closest('.cart-item');
                const productId = row.querySelector('button[onclick*="changeQuantity"]').getAttribute('onclick').match(/\d+/)[0];
                selectedItems.push(productId);
            });

            if (selectedItems.length === 0) {
                alert('Vui lòng chọn ít nhất một sản phẩm để thanh toán!');
                return;
            }

            const form = document.createElement('form');
            form.method = 'POST';
            form.action = basePath + '/checkout';

            selectedItems.forEach(productId => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'selectedItems';
                input.value = productId;
                form.appendChild(input);
            });

            document.body.appendChild(form);
            form.submit();
        }
    </script>
</body>
</html>