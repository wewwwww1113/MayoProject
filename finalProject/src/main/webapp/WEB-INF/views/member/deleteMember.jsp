<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
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
            max-width: 600px;
            margin: 0 auto;
            font-family: 'Playfair Display', serif;
        }

        .content h2 {
            font-size: 36px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: center;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        .form-group input {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 0 auto;
            display: block;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .button-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }

        .submit-button {
            background-color: #333; /* 검정색 배경 */
            color: white; /* 흰색 글자 */
        }

        .submit-button:hover {
            background-color: #555;
        }

        .cancel-button {
            background-color: #ffc107;
            color: white;
        }

        .cancel-button:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="profile">
            <p>${loginUser.memberNick}</p>
        </div>
        <a href="${pageContext.request.contextPath}/mypage.me">Login Info</a>
        <a href="${pageContext.request.contextPath}/v1/review/reply/scrap">Favorites</a>
        <a href="${pageContext.request.contextPath}/update.me">Update Info</a>
        <a href="${pageContext.request.contextPath}/myReviews.me">My Reviews</a>
        <a href="${pageContext.request.contextPath}/myPosts.me">My Posts</a>
        <a href="${pageContext.request.contextPath}/statistics.me">Statistics</a>
        <a href="${pageContext.request.contextPath}/deleteMember.me">Delete Account</a>
    </div>

    <div class="container">
        <div class="content">
            <h2>회원 탈퇴</h2>
            <c:if test="${not empty error}">
                <p style="color:red;">${error}</p>
            </c:if>
            <form id="deleteForm" action="${pageContext.request.contextPath}/deleteAccount.me" method="post">
                <div class="form-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="memberPwd" placeholder="비밀번호를 입력하세요" required>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">비밀번호 확인</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
                </div>
                <div class="button-container">
                    <button type="button" class="submit-button" onclick="confirmDelete()">회원 탈퇴</button>
                    <button type="button" class="cancel-button" onclick="location.href='cancel.page'">취소</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function confirmDelete() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            
            if (password === confirmPassword) {
                if (confirm("정말 삭제하시겠습니까?")) {
                    document.getElementById("deleteForm").submit();
                }
            } else {
                alert("비밀번호가 일치하지 않습니다.");
            }
        }
    </script>
</body>
</html>
