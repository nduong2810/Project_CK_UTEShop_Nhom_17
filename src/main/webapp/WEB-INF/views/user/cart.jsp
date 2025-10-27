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
    </style>
</head>
<body>
    <div class="cart-container">
        <div class="cart-header">Giỏ Hàng Của Bạn</div>
        
        <c:if test="${empty cartItems}">
            <p style="text-align: center;">Giỏ hàng trống!</p>
        </c:if>
        
        <c:if test="${not empty cartItems}">
            <table class="cart-table">
                <thead>
                    <tr>
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
                            <td><fmt:formatNumber value="${item.thanhTien}" type="number" groupingUsed="true"/>₫</td>
                            <td>
                                <button class="remove-btn" onclick="removeItem(${item.sanPham.maSP})">Xóa</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="cart-total">
                Tổng cộng: <fmt:formatNumber value="${totalAmount}" type="number" groupingUsed="true"/>₫
            </div>
            <button class="checkout-btn" onclick="window.location.href='${pageContext.request.contextPath}/checkout'">Thanh Toán</button>
        </c:if>
    </div>

    <script>
        const basePath = '${pageContext.request.contextPath}';

        // Change quantity: sends POST to /user/cart?action=update with productId and quantity
        function changeQuantity(productId, delta, btn) {
            // find quantity span nearby
            const row = btn.closest('.cart-item');
            const qtySpan = row.querySelector('.qty-value');
            let current = parseInt(qtySpan.textContent) || 0;
            const newQty = current + delta;
            if (newQty < 1) {
                if (!confirm('Số lượng = 0 sẽ xóa sản phẩm. Bạn có muốn tiếp tục?')) return;
            }

            // create form and submit as POST
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

        // Remove item by productId via GET (CartController handles delete in doGet)
        function removeItem(productId) {
            if (!confirm('Bạn có chắc muốn xóa sản phẩm này?')) return;
            window.location.href = basePath + '/user/cart?action=delete&productId=' + productId;
        }
    </script>
</body>
</html>