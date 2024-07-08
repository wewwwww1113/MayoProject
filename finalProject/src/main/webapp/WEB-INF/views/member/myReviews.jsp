<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내가 쓴 리뷰</title>
    <style>
        body {
            background-color: #e0f7fa;
            font-family: Arial, sans-serif;
            margin: 0;
            padding-top: 60px;
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
            top: 110px; /* Adjusted to not overlap with header */
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
            max-width: 1000px;
            margin: 0 auto;
        }
        .content h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table th, table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
            cursor: pointer;
        }
        table th {
            background-color: #f2f2f2;
        }
        .pagination {
            text-align: center;
        }
        .pagination a {
            display: inline-block;
            padding: 10px 15px;
            margin: 0 5px;
            border: 1px solid #ccc;
            text-decoration: none;
            color: #333;
        }
        .pagination a.active {
            background-color: #333;
            color: white;
            border: 1px solid #333;
        }
        .pagination a:hover {
            background-color: #ddd;
        }
        .search-box {
            text-align: right;
            margin-bottom: 20px;
        }
        .search-box select, .search-box input[type="text"] {
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .search-box button {
            padding: 5px 10px;
            border: none;
            background-color: #333;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .delete-button {
            display: block;
            margin: 20px 0;
            padding: 10px 20px;
            background-color: #d9534f;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            float: left;
        }
        .delete-button:hover {
            background-color: #c9302c;
        }
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            text-align: center;
        }
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
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
            <h2><c:out value="${loginUser.memberNick}"/>님이 쓴 리뷰</h2>
            <div class="search-box">
                <form action="${pageContext.request.contextPath}/myReviews.me" method="get">
                    <select name="searchType">
                        <option value="toiletName">화장실 이름</option>
                        <option value="reviewContent">내용</option>
                    </select>
                    <input type="text" name="searchKeyword" placeholder="검색어" value="${searchKeyword}">
                    <button type="submit">검색</button>
                </form>
            </div>
            <form id="deleteForm" action="${pageContext.request.contextPath}/deleteReview.me" method="post" onsubmit="return checkSelection()">
                <button type="button" class="delete-button" onclick="deleteSelected()">리뷰 삭제</button>
                <table>
                    <thead>
                        <tr>
                            <th><input type="checkbox" onclick="toggleSelectAll(this)"></th>
                            <th>화장실 이름</th>
                            <th>내용</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="review" items="${reviewList}">
                            <tr>
                                <td><input type="checkbox" name="selectedReviews" value="${review.reviewReplyKey}"></td>
                                <td>${review.toiletName}</td>
                                <td>${review.content}</td>
                                <td>${review.createTime}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty reviewList}">
                            <tr>
                                <td colspan="4">작성한 리뷰가 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </form>
            <div class="pagination">
                <c:if test="${pi.startPage > 1}">
                    <a href="${pageContext.request.contextPath}/myReviews.me?currentPage=1">&lt;&lt;</a>
                    <a href="${pageContext.request.contextPath}/myReviews.me?currentPage=${pi.startPage - 1}">&lt;</a>
                </c:if>
                <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="i">
                    <a href="${pageContext.request.contextPath}/myReviews.me?currentPage=${i}" class="${pi.currentPage == i ? 'active' : ''}">${i}</a>
                </c:forEach>
                <c:if test="${pi.endPage < pi.maxPage}">
                    <a href="${pageContext.request.contextPath}/myReviews.me?currentPage=${pi.endPage + 1}">&gt;</a>
                    <a href="${pageContext.request.contextPath}/myReviews.me?currentPage=${pi.maxPage}">&gt;&gt;</a>
                </c:if>
            </div>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>

    <!-- 선택된 리뷰가 없을 때 보여주는 모달 -->
    <div id="alertModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <p>선택된 리뷰가 없습니다.</p>
        </div>
    </div>

    <script>
        function toggleSelectAll(source) {
            checkboxes = document.getElementsByName('selectedReviews');
            for(var i=0, n=checkboxes.length; i<n; i++) {
                checkboxes[i].checked = source.checked;
            }
        }

        function deleteSelected() {
            var checkboxes = document.getElementsByName('selectedReviews');
            var isSelected = false;
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    isSelected = true;
                    break;
                }
            }
            if (isSelected) {
                document.getElementById('deleteForm').submit();
            } else {
                showModal();
            }
        }

        function checkSelection() {
            var checkboxes = document.getElementsByName('selectedReviews');
            var isSelected = false;
            for (var i = 0; i < checkboxes.length; i++) {
                if (checkboxes[i].checked) {
                    isSelected = true;
                    break;
                }
            }
            if (!isSelected) {
                showModal();
                return false;
            }
            return true;
        }

        function showModal() {
            var modal = document.getElementById("alertModal");
            modal.style.display = "block";
        }

        function closeModal() {
            var modal = document.getElementById("alertModal");
            modal.style.display = "none";
        }

        window.onclick = function(event) {
            var modal = document.getElementById("alertModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>
