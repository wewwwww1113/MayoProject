<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Favorites</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Raleway:wght@300;400;500&display=swap');

        body {
            background-color: #f5f5f5;
            font-family: 'Raleway', sans-serif;
            margin: 0;
            padding: 0;
            padding-bottom: 60px; /* 추가: 푸터를 침범하지 않도록 하기 위해 */
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
            transition: background-color 0.3s ease;
        }

        .scrap-item button:hover {
            background-color: #d32f2f;
        }
        
          .starReview {
            font-size: 36px; /* 원하는 크기로 조정 */
            cursor: pointer;
            transition: color 0.3s; /* 색상 변화 애니메이션 */
        }

        .starReview:hover {
            color: gold; /* 마우스 호버 시 색상 변경 */
        }

        .starReview {
            font-size: 36px; /* 원하는 크기로 조정 */
            cursor: pointer;
            transition: color 0.3s; /* 색상 변화 애니메이션 */
        }

        .starReview:hover {
            color: gold; /* 마우스 호버 시 색상 변경 */
        }

        /* 삭제 버튼 스타일 */
        .delete-button {
            font-size: 36px;
            cursor: pointer;
            transition: color 0.3s;
            color: gold;
            background-color: white;
            border: none;
        }

        .delete-button:hover {
            color: gold;
        }

        .footer {
            position: relative;
            z-index: 1;
            
            
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
            <h2>Favorites List</h2>
            <ul class="scrap-list">
                <c:forEach var="scrap" items="${scrapList}">
                    <li class="scrap-item">
                        <div>
                            <h3>${scrap.toiletName}</h3>
                            <p>${scrap.toiletAddress}</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/v1/review/reply/deleteScrap" method="post" onsubmit="return confirmDelete()">
                            <input type="hidden" name="scrapNo" value="${scrap.scrapNo}">
                            <button type="submit" class="delete-button">&#x2605;</button>
                        </form>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>

    <script>
        function confirmDelete() {
            return confirm("정말 즐겨찾기에서 삭제하시겠습니까?");
        }
    </script>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>
