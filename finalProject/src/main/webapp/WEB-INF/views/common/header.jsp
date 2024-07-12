<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <title>Document</title>
  <style>
    /* 노말라이즈 */
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
    }

    body {
        background: rgb(255, 255, 255);
        font-family: Arial, sans-serif;
    }

    header {
        background: gray;
        transition: 0.3s ease-in;
        height: 80px; /* 헤더바 높이를 50px로 설정 */
        display: flex;
        align-items: center;
        justify-content: center;
    }

    nav {
        max-width: 960px;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    nav > ul {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 100%;
    }

    nav > ul > li {
        margin-right: 60px; /* 글자 사이의 간격을 넓히기 위해 margin-right를 50px로 변경 */
        position: relative;
        display: flex;
        align-items: center; /* 세로 중앙 정렬 */
        height: 50px; /* li 높이 설정 */
    }

    nav > ul > li a {
        font-size: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 120px; /* 너비를 120px 이상으로 설정 */
    height: 100%;
    text-align: center;
    white-space: nowrap; /* 줄 바꿈 방지 */
    
}

    nav > ul > li ul {
        width: 100%;
        opacity: 0;
        position: absolute;
        top: 50px; /* 서브 메뉴가 올바른 위치에 나타나도록 top 값을 50px로 변경 */
        left: 0;
        background: white;
        transition: opacity 0.3s 0.2s;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    nav > ul > li ul li {
        white-space: nowrap;
        padding: 10px;
    }

    nav > ul > li:hover ul {
        opacity: 1;
    }

    .login-menu {
        margin-left: auto;
    }

.toggle-text {
    display: inline-block;
    width: 150px; /* 너비를 충분히 늘립니다. */
    text-align: center;
    overflow: hidden;
    white-space: nowrap; /* 한 줄로 유지 */
    transition: opacity 0.5s ease-in-out; /* 부드러운 전환 효과 */
    font-size: 20px; /* 글자 크기 설정 */
}
        
        .logo {
    margin-right: 250px; /* 로고와 메뉴 사이의 간격 조정 */
}

.logo img {
    height: 100px; /* 로고 이미지의 높이 설정 */
    /* 다른 스타일링을 추가로 필요한 경우 여기에 추가 */
}
        
  </style>
</head>
<body>
  <header>
  
  <div class="logo">
        <img src="../review/img/mayo.jpg">
    </div>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/map">MAP</a></li>
            <li><a href="list.st">STORE</a></li>
            <li><a href="test.re">REVIEW</a></li>
            <li><a href="rank.ra">RANK</a></li>
            <li><a href="list.fr">BOARD</a></li>
            <li><a href="list.cs">SERVICE</a></li>
            <c:choose>
                <c:when test="${not empty loginUser}">
                    <li>
                        <a href="${pageContext.request.contextPath}/mypage.me">
                            <span id="welcomeText" class="toggle-text"><c:out value="${loginUser.memberNick}"/>님 환영!</span>
                        </a>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/logout.me">LOGOUT</a></li>
                </c:when>
                <c:otherwise>
                    <li class="login-menu"><a href="${pageContext.request.contextPath}/login.me">LOGIN</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>
  </header>
  <script>
    document.addEventListener('DOMContentLoaded', function() {
        const welcomeTextElement = document.getElementById('welcomeText');
        const originalText = welcomeTextElement.innerHTML;
        const alternateText = 'MYPAGE';
        let isOriginalText = true;

        setInterval(() => {
            welcomeTextElement.style.opacity = 0; // 투명도 설정
            setTimeout(() => {
                welcomeTextElement.innerHTML = isOriginalText ? alternateText : originalText;
                welcomeTextElement.style.opacity = 1; // 투명도 복원
                isOriginalText = !isOriginalText;
            }, 500); // 투명도가 변경되는 시간과 일치하게 설정
        }, 2000);
    });
  </script>
</body>
</html>