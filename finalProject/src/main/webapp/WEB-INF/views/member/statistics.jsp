<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>통계</title>
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
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            flex-wrap: wrap;
        }
        .content h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
            width: 100%;
        }
        .chart-container {
            width: 100%;
            margin-bottom: 20px;
        }
        .half-width {
            width: 48%;
            margin: 1%;
        }
        .info-group {
            margin-bottom: 15px;
        }
        .info-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .info-group span {
            display: block;
            padding: 10px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table th, table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
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
        .search-box input[type="text"] {
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
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var ctx = document.getElementById('visitorChart').getContext('2d');
            var visitorChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['2022-07-01', '2022-07-02', '2022-07-03', '2022-07-04', '2022-07-05', '2022-07-06', '2022-07-07'],
                    datasets: [{
                        label: '방문자 수',
                        data: [12, 19, 3, 5, 2, 3, 10],
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderColor: 'rgba(255, 99, 132, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
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
            <h2>통계</h2>
            <div class="chart-container">
                <canvas id="visitorChart"></canvas>
            </div>
            <div class="half-width">
                <h3>내가 쓴 리뷰</h3>
                <table>
                    <thead>
                        <tr>
                            <th>화장실 번호</th>
                            <th>내용</th>
                            <th>작성일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="review" items="${reviewList}">
                            <tr>
                               <td>${review.toiletName}</td>
	                            <td>${review.content}</td>
	                            <td>${review.createTime}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty reviewList}">
                            <tr>
                                <td colspan="3">작성한 리뷰가 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
                <div class="pagination">
                    <c:if test="${pi.startPage > 1}">
                        <a href="${pageContext.request.contextPath}/statistics.me?currentPage=1">&lt;&lt;</a>
                        <a href="${pageContext.request.contextPath}/statistics.me?currentPage=${pi.startPage - 1}">&lt;</a>
                    </c:if>
                    <c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="i">
                        <a href="${pageContext.request.contextPath}/statistics.me?currentPage=${i}" class="${pi.currentPage == i ? 'active' : ''}">${i}</a>
                    </c:forEach>
                    <c:if test="${pi.endPage < pi.maxPage}">
                        <a href="${pageContext.request.contextPath}/statistics.me?currentPage=${pi.endPage + 1}">&gt;</a>
                        <a href="${pageContext.request.contextPath}/statistics.me?currentPage=${pi.maxPage}">&gt;&gt;</a>
                    </c:if>
                </div>
            </div>
            <div class="half-width">
                <h3>내가 쓴 글</h3>
                <div class="info-group">
                    <label>글 1</label>
                    <span>글 내용 1</span>
                </div>
                <div class="info-group">
                    <label>글 2</label>
                    <span>글 내용 2</span>
                </div>
                <!-- 더 많은 글을 추가할 수 있습니다 -->
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>
