<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400&display=swap');
        
        body {
            font-family: 'Playfair Display', serif;
            background-color: #ffffff;
            margin: 0;
            padding-top: 80px; /* 헤더 높이만큼 패딩 추가 */
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            display: flex;
            flex: 1;
            justify-content: center;
            align-items: flex-start;
            padding-top: 60px; /* 컨테이너의 패딩 값을 줄여 상단 여백 조정 */
        }
        .content {
            background-color: #f5f5f5;
            padding: 50px; /* 박스 크기를 키우기 위해 패딩 증가 */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 500px; /* 박스 크기 증가 */
            text-align: center;
        }
        .content h2 {
            margin-bottom: 20px;
            font-size: 40px;
            color: #080808;
            font-family: 'Playfair Display', serif;
            font-weight: 400;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .form-group label {
            display: block;
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
        }
        .form-group input {
            width: calc(100% - 40px);
            padding: 10px 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .button-container {
            display: flex;
            justify-content: space-between;
        }
        .button-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }
        .submit-button {
            background-color: black;
            color: white;
        }
        .cancel-button {
            background-color: #ffc107;
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
            <h2>비밀번호 찾기</h2>
            <form action="${pageContext.request.contextPath}/findPassword.me" method="post">
                <div class="form-group">
                    <label for="id">아이디</label>
                    <input type="text" id="id" name="memberId" placeholder="아이디를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="email">이메일 주소</label>
                    <input type="email" id="email" name="email" placeholder="이메일 주소를 입력하세요" required>
                </div>
                <div class="button-container">
                    <button type="submit" class="submit-button">비밀번호 찾기</button>
                    <button type="button" class="cancel-button" onclick="location.href='cancel.page'">취소</button>
                </div>
            </form>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>
