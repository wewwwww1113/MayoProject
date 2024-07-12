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
        .button {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #0056b3;
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
        
        <a href="/main-page" class="button">메인 페이지로 이동</a>
    </div>
    <%@include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>