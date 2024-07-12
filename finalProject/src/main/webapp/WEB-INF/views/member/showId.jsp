<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기 결과</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400&display=swap');

        body {
            font-family: 'Playfair Display', serif;
            background-color: #ffffff;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            display: flex;
            flex: 1;
            justify-content: center;
            align-items: center;
            margin-top: -200px; /* 박스를 더 위로 올립니다 */
        }
        .content {
            background-color: #f5f5f5;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
        }
        .content h2 {
            margin-bottom: 20px;
            font-size: 40px;
            color: #080808;
            font-family: 'Playfair Display', serif;
            font-weight: 400;
        }
        .content p {
            font-size: 18px;
            color: #555;
        }
        .button-container {
            margin-top: 20px;
        }
        .button-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            background-color: black;
            color: white;
        }
        footer {
            background-color: #003366;
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            position: relative;
            bottom: 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="content">
            <h2>아이디 찾기 결과</h2>
            <c:if test="${not empty foundId}">
                <p>고객님의 아이디는 <strong>${foundId}</strong> 입니다.</p>
            </c:if>
            <c:if test="${empty foundId}">
                <p>아이디를 찾을 수 없습니다.</p>
            </c:if>
            <div class="button-container">
                <button onclick="location.href='loginForm.me'">로그인 하기</button>
            </div>
        </div>
    </div>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
