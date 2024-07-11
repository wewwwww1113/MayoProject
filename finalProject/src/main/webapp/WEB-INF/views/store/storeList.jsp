<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.kh.springProject.member.model.vo.Member"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    Member loginUser = (Member) session.getAttribute("loginUser");
    String alertMsg = (String) session.getAttribute("alertMsg");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Store List</title>
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
            height: 400px; /* 고정된 높이 설정 */
            object-fit: cover; /* 이미지가 잘리거나 축소되도록 설정 */
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

        .new-store-btn,
        .cart-btn {
            display: block;
            width: 120px;
            margin: 20px auto;
            text-align: center;
            padding: 10px;
            text-decoration: none;
            color: #fff;
            border: 1px solid;
            border-radius: 3px;
            transition: background-color 0.3s ease;
        }

        .new-store-btn {
            background-color: #28a745;
            border-color: #28a745;
        }

        .new-store-btn:hover {
            background-color: #218838;
            border-color: #218838;
        }

        .new-store-btn:active {
            background-color: #218838;
            border-color: #218838;
            transform: translateY(1px);
        }

        .cart-btn {
            background-color: #ffc107;
            border-color: #ffc107;
        }

        .cart-btn:hover {
            background-color: #e0a800;
            border-color: #e0a800;
        }

        .cart-btn:active {
            background-color: #d39e00;
            border-color: #d39e00;
            transform: translateY(1px);
        }
    </style>
</head>
<body>
<script>
    var msg = "<%= alertMsg %>";

    if (msg !== "null") {
        alert(msg);
        <% session.removeAttribute("alertMsg"); %>
    }

    function deleteStore(storeNo) {
        if (confirm("정말 삭제하시겠습니까?")) {
            window.location.href = "delete.st?storeNo=" + storeNo;
        }
    }

    function updateStore(storeNo) {
        if (confirm("수정하시겠습니까?")) {
            window.location.href = "update.st?storeNo=" + storeNo;
        }
    }

    function addToCart(storeNo) {
        if (confirm("장바구니에 추가하시겠습니까?")) {
            window.location.href = "addToCart.ct?storeNo=" + storeNo;
        }
    }
</script>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<div class="container">
    <h2>똥싸개 상점</h2>
    <div class="product-grid">
        <c:forEach items="${list}" var="store">
            <div class="product-card">
                <img src="${store.pdImage}" alt="Product Image">
                <div class="product-info">
                    <h3>${store.pdName}</h3>
                    <p>${store.pdDescription}</p>
                    <p class="price">${store.price}원</p>
                    <div class="actions">
                        <a href="javascript:void(0);" onclick="addToCart(${store.storeNo});">장바구니에 추가</a>
                        <c:if test="${not empty loginUser and loginUser.memberId eq 'admin'}">
                            <a href="javascript:void(0);" onclick="updateStore(${store.storeNo});">수정</a>
                            <a href="javascript:void(0);" onclick="deleteStore(${store.storeNo});">삭제</a>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <c:choose>
        <c:when test="${not empty loginUser}">
            <c:if test="${loginUser.memberId eq 'admin'}">
                <a href="insert.st" class="new-store-btn">상품 추가</a>
                <a href="list.ct" class="cart-btn">장바구니로 가기</a>
            </c:if>
            <c:if test="${loginUser.memberId ne 'admin'}">
                <a href="javascript:void(0);" onclick="showLoginAlert();" class="cart-btn">장바구니로 가기</a>
            </c:if>
        </c:when>
        <c:otherwise>
            <a href="javascript:void(0);" onclick="showLoginAlert();" class="cart-btn">장바구니로 가기</a>
        </c:otherwise>
    </c:choose>
</div>
<script>
    function showLoginAlert() {
        alert("로그인 후 이용해 주세요.");
    }
</script>
</body>
</html>
