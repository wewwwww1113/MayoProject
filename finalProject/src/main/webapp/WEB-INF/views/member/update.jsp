<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
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
            max-width: 600px; /* 바 크기 줄이기 */
            margin: 0 auto; /* 가운데 맞춤 */
        }
        .content h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: center; /* 추가: 텍스트 가운데 정렬 */
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 0 auto; /* 추가: 가운데 정렬 */
            display: block; /* 추가: 블록 요소로 변경 */
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .form-group input[type="radio"] {
            width: auto;
            margin-right: 10px;
        }
        .btns {
            text-align: center;
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
            <h2>내 정보 수정</h2>
            <form id="updateForm" action="update.me" method="post">
                <div class="form-group">
                    <label for="enrollMemberId">아이디</label>
                    <input type="text" id="enrollMemberId" name="memberId" class="form-control" value="${loginUser.memberId}" readonly>
                </div>
                <div class="form-group">
                    <label for="memberNick">닉네임</label>
                    <input type="text" id="memberNick" name="memberNick" class="form-control" value="${loginUser.memberNick}">
                </div>
                <div class="form-group">
                    <label for="birthDate">생년월일</label>
                    <input type="text" id="birthDate" name="birthDate" class="form-control" value="${loginUser.birthDate}" placeholder="YYYYMMDD">
                </div>
                <div class="form-group">
                    <label for="email">이메일</label>
                    <input type="text" id="email" name="email" class="form-control" value="${loginUser.email}">
                    <span>@</span>
                    <select id="email-domain" name="email-domain" required>
                        <option value="naver.com">naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="outlook.com">outlook.com</option>
                        <option value="nate.com">nate.com</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>성별</label>
                    <input type="radio" id="male" value="M" name="gender" ${loginUser.gender == 'M' ? 'checked' : ''}>
                    <label for="male">남자</label>
                    <input type="radio" id="female" value="F" name="gender" ${loginUser.gender == 'F' ? 'checked' : ''}>
                    <label for="female">여자</label>
                </div>
                <div class="btns">
                    <button type="submit">정보수정</button>
                    <button type="button" onclick="confirmDelete()">회원탈퇴</button>
                </div>
            </form>

            <!-- 회원탈퇴를 위한 폼 추가 -->
            <form id="deleteForm" action="deleteAccount.me" method="post">
                <input type="hidden" name="memberId" value="${loginUser.memberId}">
            </form>
        </div>
    </div>
    
    <script>
        function confirmDelete() {
            if (confirm("정말로 회원탈퇴를 하시겠습니까?")) {
                document.getElementById("deleteForm").submit();
            }
        }
        
        $(function(){
            var gender = "${loginUser.gender}";
            if(gender != "") {
                $("input[value=" + gender + "]").attr("checked", true);
            }
        });
    </script>
    
    </div>
    </div>
    </div>

    <%@ include file="../common/footer.jsp" %>
</body>
</html>
