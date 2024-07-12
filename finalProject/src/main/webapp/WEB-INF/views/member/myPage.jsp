<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Raleway:wght@300;400;500&display=swap');

        body {
            background-color: #f5f5f5;
            font-family: 'Raleway', sans-serif;
            margin: 0;
            padding: 0;
        }

        .header {
            position: fixed;
            top: 0;
            width: 100%;
            background-color: #333;
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

        .sidebar {
            background-color: #ffffff;
            color: #333;
            width: 220px;
            height: calc(100vh - 80px); /* 헤더 높이만큼 빼줌 */
            position: fixed;
            top: 80px; /* 헤더 높이 */
            left: 0;
            padding: 20px;
            box-sizing: border-box;
            font-family: 'Raleway', sans-serif;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            overflow-y: auto;
        }

        .sidebar a {
            color: #333;
            text-decoration: none;
            display: block;
            margin: 30px 0; /* 사이 간격을 넓히기 위해 30px로 설정 */
            font-size: 16px;
            transition: background-color 0.3s ease, padding-left 0.3s ease;
        }

        .sidebar a:hover {
            background-color: #f0f0f0;
            padding-left: 10px;
        }

        .container {
            margin-left: 240px;
            padding: 20px;
            padding-bottom: 60px; /* 푸터를 침범하지 않도록 추가 패딩 */
            box-sizing: border-box;
            min-height: calc(100vh - 80px); /* 헤더 높이만큼 빼줌 */
        }

        .content {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            margin: 20px auto;
            font-family: 'Playfair Display', serif;
        }

        .content h2 {
            font-size: 36px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .info-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .info-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            font-size: 14px;
            color: #555;
        }

        .info-group span {
            display: block;
            padding: 10px;
            width: 100%;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
            box-sizing: border-box;
            font-size: 16px;
            color: #333;
        }

        .btns {
            text-align: center;
            margin-top: 30px;
        }

        .btns button {
            padding: 12px 24px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 0 10px;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .btns button:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">
            <p>${loginUser.memberNick}</p>
        </div>
       <a href="${pageContext.request.contextPath}/mypage.me">로그인 정보</a>
        <a href="${pageContext.request.contextPath}/v1/review/reply/scrap.me">즐겨찾기</a>
        <a href="${pageContext.request.contextPath}/update.me">내 정보 수정</a>
        <a href="${pageContext.request.contextPath}/myReviews.me">내가 쓴 리뷰</a>
        <a href="${pageContext.request.contextPath}/myPosts.me">내가 작성한 글</a>
        <a href="${pageContext.request.contextPath}/statistics.me">통계</a>
        <a href="${pageContext.request.contextPath}/deleteMember.me">회원탈퇴</a>
    </div>
    <div class="container">
        <div class="content">
            <h2><c:out value="${loginUser.memberNick}"/>님의 정보</h2>
            <div class="info-group">
                <label for="enrollMemberId">아이디</label>
                <span id="enrollMemberId">${loginUser.memberId}</span>
            </div>
            <div class="info-group">
                <label for="memberNick">닉네임</label>
                <span id="memberNick">${loginUser.memberNick}</span>
            </div>
            <div class="info-group">
                <label for="birthDate">생년월일</label>
                <span id="birthDate">${loginUser.birthDate}</span>
            </div>
            <div class="info-group">
                <label for="email">이메일</label>
                <span id="email">${loginUser.email}</span>
            </div>
            <div class="info-group">
                <label for="gender">성별</label>
                <span id="gender">${loginUser.gender == 'male' ? '남자' : '여자'}</span>
            </div>
            <div class="info-group">
                <label for="enrollDate">가입 날짜</label>
                <span id="enrollDate"><fmt:formatDate value="${loginUser.enrollDate}" pattern="yyyy-MM-dd"/></span>
            </div>
            <div class="info-group">
                <label for="status">상태</label>
                <span id="status">${loginUser.status}</span>
            </div>
            <div class="btns">
                <form id="updateForm" action="${pageContext.request.contextPath}/update.me" method="get">
                    <button type="submit">정보 수정</button>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
