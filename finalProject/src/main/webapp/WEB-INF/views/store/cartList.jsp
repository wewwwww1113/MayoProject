<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, com.kh.springProject.store.model.vo.Cart" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        .product-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        .product-card {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            width: 30%;
            margin: 1%;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            overflow: hidden;
            text-align: center;
            min-height: 350px;
            box-sizing: border-box;
        }

        .product-card img {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }

        .product-info {
            padding: 15px;
            flex-grow: 1;
        }

        .product-info h3 {
            margin: 10px 0;
            font-size: 18px;
            color: #333;
        }

        .product-info p {
            margin: 5px 0;
            color: #777;
        }

        .product-info .price {
            color: #e74c3c;
            font-size: 16px;
            font-weight: bold;
        }

        .actions {
            display: flex;
            justify-content: center;
            margin-top: 10px;
        }

        .actions a {
            margin: 0 5px;
            padding: 8px 12px;
            text-decoration: none;
            color: #fff;
            background-color: #007bff;
            border: 1px solid #007bff;
            border-radius: 3px;
            transition: background-color 0.3s ease;
        }

        .actions a:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .actions a:active {
            background-color: #0056b3;
            border-color: #0056b3;
            transform: translateY(1px);
        }

        .checkout-btn {
            display: block;
            width: 120px;
            margin: 20px auto;
            text-align: center;
            padding: 10px;
            text-decoration: none;
            color: #fff;
            background-color: #28a745;
            border: 1px solid #28a745;
            border-radius: 3px;
            transition: background-color 0.3s ease;
        }

        .checkout-btn:hover {
            background-color: #218838;
            border-color: #218838;
        }

        .checkout-btn:active {
            background-color: #218838;
            border-color: #218838;
            transform: translateY(1px);
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>

<div class="container">
    <h2>장바구니</h2>
    <form action="updateCartAndorderView.ct" method="post">
    <div class="product-grid">
        <c:forEach items="${cart}" var="cart">
            <div class="product-card">
                <img src="${cart.store.pdImage}" alt="Product Image">
                <div class="product-info">
                    <h3>${cart.store.pdName}</h3>
                    <p>${cart.store.pdDescription}</p>
                    <p class="price">${cart.store.price}원</p>
                    
                        <label for="quantity">수량:</label>
                        <input type="number" id="quantity_${cart.cartId}" name="quantity_${cart.cartId}" value="${cart.quantity}" min="1" required>

                    
                    <div class="actions">
                        <a href="javascript:void(0);" onclick="deleteCart(${cart.cartId});">삭제</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <button type="submit" class="checkout-btn">결제페이지로 가기</button>
    </form>
</div>

<script>
function deleteCart(cartId) {
    if (confirm("정말 삭제하시겠습니까?")) {
        // AJAX를 이용한 비동기 요청
        var aaa = new XMLHttpRequest();
        aaa.open('DELETE', 'delete.ct?cartId=' + cartId, true);
        aaa.onload = function () {
            if (aaa.status === 200) {
                // 요청 성공 시 페이지 새로고침
                location.reload();
                alert('삭제 성공하였습니다.');
            } else {
                alert('삭제 실패하였습니다.');
            }
        };
        aaa.send();
    }
}
</script>

</body>
</html>