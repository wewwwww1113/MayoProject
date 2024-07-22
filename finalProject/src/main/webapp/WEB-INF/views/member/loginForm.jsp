<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400&display=swap');
        
        body {
            font-family: 'Playfair Display', serif;
              
            margin: 0;
            padding-top: 80px; /* 헤더 높이만큼 패딩 추가 */
        }
        .container {
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            text-align: center;
            margin: 100px auto 0;
        }
        .container h2 {
            margin-bottom: 20px;
            font-size: 40px;
            color: #080808;
            font-family: 'Playfair Display', serif; /* 제목에 'Playfair Display' 글꼴 적용 */
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
            background-color: #808080; /* 센터와 동일한 회색 */
            color: white;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .login-button:hover {
            background-color: #333;
        }
        .social-login-buttons {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .social-login-buttons button {
            width: 223px; /* 네이버 버튼의 폭에 맞춤 */
            height: 48px; /* 네이버 버튼 높이에 맞춤 */
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white; /* 글씨 색상을 흰색으로 설정 */
        }
        .social-login-buttons .google-login {
            background-color: #db4437; /* 배경색을 붉은색으로 설정 */
        }
        .social-login-buttons .kakao-login {
            background-color: #ffeb3b;
            color: black;
        }
        .social-login-buttons .naver-login {
            background-color: #03c75a;
            color: white;
            height: 48px; /* 높이 조정 */
            width: 223px; /* 폭 조정 */
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
        
        
    ul, li, h1 {
     	
        margin: 0;
        padding: 0;
        list-style: none;
    }
    
     a {
        color: #FFFFFF; /* 기본 글자 색상 흰색 */
        text-decoration: none; /* 모든 a 태그에 밑줄 없애기 */
        transition: color 0.3s ease, background-color 0.3s ease; /* 부드러운 전환 효과 */
    }

    /* 글자 호버 */
    a:hover {
        color: black; 
        text-decoration: none; /* hover 상태에서도 밑줄 없애기 */
    }
    
    
      body, ul, li, h1 {
        margin: 0;
        padding: 0;
        list-style: none;
    }
    
     a {
        color: #FFFFFF; /* 기본 글자 색상 흰색 */
        text-decoration: none; /* 모든 a 태그에 밑줄 없애기 */
        transition: color 0.3s ease, background-color 0.3s ease; /* 부드러운 전환 효과 */
    }

    /* 글자 호버 */
    a:hover {
        color: black; 
        text-decoration: none; /* hover 상태에서도 밑줄 없애기 */
    }
    
     body {
        background: rgb(255, 255, 255);
        font-family: Arial, sans-serif;
    }
        
    </style>
</head>
<body>
    <div class="container">
        <c:choose>
            <c:when test="${not empty sessionScope.loginUser}">
                <p>${sessionScope.loginUser.memberNick} 환영합니다.</p>
                <button onclick="location.href='logout.me'">로그아웃</button>
            </c:when>
            <c:otherwise>
                <h2>Login</h2>
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
                    <button class="google-login" onclick="location.href='https://accounts.google.com/o/oauth2/v2/auth?client_id=63483462058-fju3itdbk36q6m7c4pkvv3qrqoujfngc.apps.googleusercontent.com&redirect_uri=http://localhost:8080/api/v1/oauth2/google/callback&response_type=code&scope=email%20profile%20openid&access_type=offline'">
                        Google로 로그인
                    </button>
                    <div id="naver_id_login" style="text-align:center">
                        <a href="${url}">
                            <img width="223" height="48" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" alt="네이버 로그인"/>
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
