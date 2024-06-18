<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
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
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
            margin: 100px auto 0;
            
            
        }
        .container h2 {
            margin-bottom: 20px;
            font-size: 24px;
            color: #333;
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
        .form-group input[type="checkbox"] {
            width: auto;
        }
        .form-group .checkbox-label {
            display: inline-block;
            font-size: 14px;
            color: #555;
            margin-left: 5px;
        }
        .login-button {
            display: block;
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            background-color: blue;
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .social-login-buttons {
            margin-top: 20px;
        }
        .social-login-buttons button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }
        .social-login-buttons .kakao-login {
            background-color: #ffeb3b;
            color: black;
        }
        .social-login-buttons .naver-login {
            background-color: #03c75a;
            color: white;
        }
        .additional-links {
            margin-top: 10px;
            font-size: 14px;
        }
        .additional-links a {
            color: #00bcd4;
            text-decoration: none;
        }
        .additional-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <c:choose>
            <c:when test="${not empty loginUser}">
                <p>이미 로그인된 상태입니다.</p>
                <button onclick="location.href='logout.me'">로그아웃</button>
            </c:when>
            <c:otherwise>
                <h2>참지마요 로그인</h2>
                <form action="${pageContext.request.contextPath}/login.me" method="post">
                    <div class="form-group">
                        <label for="username"><i class="fas fa-user"></i> 아이디</label>
                        <input type="text" id="username" name="memberId" placeholder="아이디" required>
                    </div>
                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> 비밀번호</label>
                        <input type="password" id="password" name="memberPwd" placeholder="비밀번호" required>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" id="remember-me" name="remember-me">
                        <label for="remember-me" class="checkbox-label">아이디 저장</label>
                    </div>
                    <button type="submit" class="login-button">로그인</button>
                </form>
                <div class="additional-links">
                    <a href="${pageContext.request.contextPath}/findIdPwd.me">아이디 찾기</a> / <a href="findIdPwd.jsp">비밀번호 찾기</a> / <a href="${pageContext.request.contextPath}/enrollCheckForm">회원가입</a>
                </div>
                <div class="social-login-buttons">
                    <button class="kakao-login">카카오 계정으로 로그인</button>
                    <button class="naver-login">네이버 계정으로 로그인</button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
