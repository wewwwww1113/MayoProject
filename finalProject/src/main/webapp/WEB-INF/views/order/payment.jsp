<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Arrays"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1, h2, h3 {
            color: #333;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin-bottom: 10px;
        }
        
        .return-btn {
            display: block;
            width: 120px;
            margin: 10px auto;
            text-align: center;
            padding: 10px;
            text-decoration: none;
            color: #fff;
            background-color: red;
            border: 1px solid #6c757d;
            border-radius: 3px;
            transition: background-color 0.3s ease;
        }

        .return-btn:hover {
            background-color: #5a6268;
            border-color: #5a6268;
        }

        .return-btn:active {
            background-color: #5a6268;
            border-color: #5a6268;
            transform: translateY(1px);
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container">
        <h1>결제 페이지</h1>
        
        <h2>주문 내역</h2>
        
        <h3>주문자 정보</h3>
        <ul>
            <li>성함 : ${order.buyerName}</li>
            <li>전화번호 : ${order.buyerTel}</li>
            <li>주소 : ${order.buyerAddr}</li>
        </ul>
        
        <br>
        <h3>주문 정보</h3>
        <ul>
            <li>상품 : ${order.pdName}</li>
            <li>결제 방식 : 카드</li>
        </ul>
        
        <h3>위와 같이 주문하셨습니다.</h3>
        <h2>총 가격 : ${order.amount}</h2>
        
        <a href="${pageContext.request.contextPath}" class="return-btn">메인 페이지로 이동</a>
    </div>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>