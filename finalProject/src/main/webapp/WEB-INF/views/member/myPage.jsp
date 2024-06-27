<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>
    <style>
        body {
            background-color: #e0f7fa;
            font-family: Arial, sans-serif;
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
        .sidebar {
            background-color: #003366;
            color: white;
            width: 200px;
            height: 100vh;
            position: fixed;
            top: 110px;
            left: 0;
            padding: 20px;
            box-sizing: border-box;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            margin: 50px 0;
        }
        .container {
            margin-left: 220px;
            padding: 20px;
        }
        .content {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
        }
        .content h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .info-group {
            margin-bottom: 15px;
            text-align: center;
        }
        .info-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .info-group span {
            display: block;
            padding: 10px;
            width: 100%; /* 동일한 크기 */
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
            box-sizing: border-box; /* 패딩과 보더 포함한 크기 계산 */
        }
        .btns {
            text-align: center;
            margin-top: 20px;
        }
        .btns button {
            padding: 10px 20px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 0 10px;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">
            <p>${loginUser.memberNick}</p>
        </div>
        <a href="${pageContext.request.contextPath}/mypage.me">로그인 정보</a>
        <a href="${pageContext.request.contextPath}/favorites.me">즐겨찾기</a>
        <a href="${pageContext.request.contextPath}/update.me">내 정보 수정</a>
        <a href="${pageContext.request.contextPath}/myReviews.me">내가 쓴 리뷰</a>
        <a href="${pageContext.request.contextPath}/myPosts.me">내가 작성한 글</a>
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

    <%@ include file="../common/footer.jsp" %>
</body>
</html>
