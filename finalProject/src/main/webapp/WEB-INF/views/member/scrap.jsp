<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>즐겨찾기</title>
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
            max-width: 800px;
            margin: 0 auto;
        }
        .content h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .scrap-list {
            list-style: none;
            padding: 0;
        }
        .scrap-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #ccc;
        }
        .scrap-item:last-child {
            border-bottom: none;
        }
        .scrap-item h3 {
            margin: 0;
            font-size: 18px;
        }
        .scrap-item p {
            margin: 5px 0 0;
            font-size: 14px;
        }
        .scrap-item button {
            padding: 5px 10px;
            background-color: #f44336;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">
            <p>${loginUser.memberNick}</p>
        </div>
        <a href="${pageContext.request.contextPath}/mypage.me">로그인 정보</a>
        <a href="${pageContext.request.contextPath}/scrap.me">즐겨찾기</a>
        <a href="${pageContext.request.contextPath}/update.me">내 정보 수정</a>
        <a href="${pageContext.request.contextPath}/myReviews.me">내가 쓴 리뷰</a>
        <a href="${pageContext.request.contextPath}/myPosts.me">내가 작성한 글</a>
        <a href="${pageContext.request.contextPath}/statistics.me">통계</a>
        <a href="${pageContext.request.contextPath}/deleteMember.me">회원탈퇴</a>
    </div>
    <div class="container">
        <div class="content">
            <h2>즐겨찾기 목록</h2>
            <ul class="scrap-list">
                <c:forEach var="scrap" items="${scrapList}">
                    <li class="scrap-item">
                        <div>
                            <h3>${scrap.toiletName}</h3>
                            <p>${scrap.toiletAddress}</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/deleteScrap.me" method="post">
                            <input type="hidden" name="scrapNo" value="${scrap.scrapNo}">
                            <button type="submit">삭제</button>
                        </form>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>
