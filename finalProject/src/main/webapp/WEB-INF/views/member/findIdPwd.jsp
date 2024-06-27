<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e0f7fa;
            margin: 0;
            padding-top: 60px; /* 헤더 높이만큼 패딩 추가 */
        }
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            background-color: #003366;
            color: white;
            padding: 10px 0;
            text-align: center;
            z-index: 1000;
        }
        .header a {
            color: white;
            margin: 0 20px;
            text-decoration: none;
        }
        .container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin: 100px auto 0;
        }
        .container h2 {
            text-align: center;
            color: #333;
        }
        .container form {
            display: flex;
            flex-direction: column;
        }
        .container form label {
            margin: 10px 0 5px;
            font-size: 14px;
            color: #555;
        }
        .container form input {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .container form .button-container {
            display: flex;
            justify-content: space-between;
        }
        .container form .button-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }
        .container form .button-container .submit-button {
            background-color: blue;
            color: white;
        }
        .container form .button-container .cancel-button {
            background-color: #ffc107;
            color: white;
        }
        .email-input {
            display: flex;
            align-items: center;
        }
        .email-input input {
            margin: 0 5px;
            flex: 1;
        }
        .email-input select {
            margin-left: 5px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>아이디 찾기</h2>
        <form action="${pageContext.request.contextPath}/findId.me" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="memberNick" placeholder="이름을 입력하세요" required>
            </div>
            <label for="email">이메일 주소</label>
            <div class="email-input">
                <input type="text" id="email" name="email" placeholder="이메일 주소" required>
                <span>@</span>
                <select id="email-domain" name="email-domain" required>
                    <option value="naver.com">naver.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="daum.net">daum.net</option>
                    <option value="outlook.com">outlook.com</option>
                    <option value="nate.com">nate.com</option>
                </select>
            </div>
            <div class="button-container">
                <button type="submit" class="submit-button">아이디 찾기</button>
                <button type="button" class="cancel-button" onclick="location.href='cancel.page'">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
