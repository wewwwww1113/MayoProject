<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
    src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
body {
    background-color: #e3f2fd; /* Soft blue background */
    font-family: Arial, sans-serif;
}

.content {
    background-color: #ffffff; /* White content background */
    width: 80%;
    margin: auto;
    border-radius: 8px;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
    padding: 20px;
}

.innerOuter {
    border: 1px solid #ced4da; /* Light gray border */
    width: 80%;
    margin: auto;
    padding: 5% 10%;
    background-color: #f8f9fa; /* Very light gray background */
    border-radius: 8px;
}

h2 {
    color: #0275d8; /* Soft blue for the title */
    text-align: center;
}

#boardList {
    text-align: center;
    margin-top: 20px;
}

#boardList>tbody>tr:hover {
    cursor: pointer;
    background-color: #e9ecef; /* Light gray hover effect */
}

#boardList th, #boardList td {
    padding: 12px;
    text-align: center;
    vertical-align: middle;
}

#pagingArea {
    width: fit-content;
    margin: auto;
}

.page-link {
    color: #0275d8; /* Soft blue for pagination */
}

.page-link:hover {
    background-color: #0275d8; /* Blue background on hover */
    color: #fff; /* White text on hover */
}

.page-item.disabled .page-link {
    color: #6c757d; /* Gray for disabled links */
}

#searchForm {
    width: 80%;
    margin: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
}

#searchForm>* {
    margin: 5px;
}

.select {
    width: 20%;
}

.text {
    width: 50%;
}

.searchBtn {
    width: 20%;
    background-color: #0275d8; /* Soft blue button */
    color: #fff; /* White text */
}

.searchBtn:hover {
    background-color: #025aa5; /* Darker blue on hover */
}

.btn-secondary {
    background-color: #0275d8; /* Soft blue button */
    border-color: #0275d8;
}

.btn-secondary:hover {
    background-color: #025aa5; /* Darker blue on hover */
    border-color: #025aa5;
}

.btn-secondary:focus, .btn-secondary.focus {
    box-shadow: 0 0 0 0.2rem rgba(2, 117, 216, .5);
}
.nine h1 {
  text-align:center; font-size:50px; text-transform:uppercase; color:#222; letter-spacing:1px;
  font-family:"Playfair Display", serif; font-weight:400;
}
.nine h1 span {
  margin-top: 5px;
    font-size:15px; color:#444; word-spacing:1px; font-weight:normal; letter-spacing:2px;
    text-transform: uppercase; font-family:"Raleway", sans-serif; font-weight:500;

    display: grid;
    grid-template-columns: 1fr max-content 1fr;
    grid-template-rows: 27px 0;
    grid-gap: 20px;
    align-items: center;
}

.nine h1 span:after,.nine h1 span:before {
    content: " ";
    display: block;
    border-bottom: 1px solid #ccc;
    border-top: 1px solid #ccc;
    height: 5px;
  background-color:#f8f8f8;
}
</style>
</head>
<body>

    <%@include file="../common/header.jsp"%>

   
   <div class="nine">
		<h1>
			BOARD <span>자유 게시판</span>
		</h1>
	</div>
   
    <div class="content">
        <br> <br>
        <div class="innerOuter" style="padding: 5% 10%;">
            
           
            <br>
            <!-- 로그인 후 상태일 경우만 보여지는 글쓰기 버튼 -->
            <c:if test="${not empty loginUser}">
                <a class="btn btn-secondary" style="float: right;" href="insert.fr">글쓰기</a>
            </c:if>
            <br> <br>

            <div class="category-area">
                <select id="categoryNo">
                    <option value="0">전체</option>
                    <option value="1">일상</option>
                    <option value="2">질문</option>
                    <option value="3">공유</option>
                </select>
            </div>

            <table id="boardList" class="table table-hover" align="center">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>카테고리</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>조회수</th>
                        <th>작성일</th>
                        <th>첨부파일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan='7'>조회된 게시글이 없습니다.</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list}" var="b">
                                <tr>
                                    <td>${b.boardNo }</td>
                                    <td>${b.categoryName}</td>
                                    <td>${b.boardTitle }</td>
                                    <td>${b.boardWriter }</td>
                                    <td>${b.count }</td>
                                    <td>${b.createDate }</td>
                                    <td><c:if test="${not empty b.originName}">
                                            ★
                                        </c:if></td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
            <br>

            <script>
                // 글을 클릭했을 때 해당 글을 상세보기 할 수 있는 함수 작성 
                $(function() {
                    $("#boardList tbody>tr").click(function() {
                        // 글번호 추출
                        var bno = $(this).children().first().text();
                        location.href = "detail.fr?boardNo=" + bno;
                    });
                });

                // 카테고리 선택 시 이벤트 처리
                $(function() {
                    $('#categoryNo').on('change', function() {
                        var categoryNo = $(this).val();
                        location.href = 'category.fr?categoryNo=' + categoryNo + '&currentPage=1';
                    });
                });

                // 검색 버튼 클릭 시 이벤트 처리
                $(function() {
                    $('#searchBtn').on('click', function() {
                        var searchContent = $('input[name=keyword]').val();
                        var searchOption = $('#searchOption').val();

                        location.href = 'search.fr?searchOption=' + searchOption + '&searchContent=' + searchContent + '&currentPage=1';
                    });
                });
            </script>

            <div id="pagingArea">
                <ul class="pagination">
                    <c:choose>
                        <c:when test="${pi.currentPage eq 1 }">
                            <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="list.fr?currentPage=${pi.currentPage-1}">Previous</a></li>
                        </c:otherwise>
                    </c:choose>
                    <c:forEach begin="${pi.startPage }" end="${pi.endPage }" var="p">
                        <li class="page-item"><a class="page-link" href="list.fr?currentPage=${p}">${p}</a></li>
                    </c:forEach>
                    <c:choose>
                        <c:when test="${pi.currentPage eq pi.maxPage }">
                            <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="list.fr?currentPage=${pi.currentPage+1}">Next</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>

            <br clear="both"> <br>

            <form id="searchForm" action="" align="center">
                <div class="select">
                    <select id="searchOption" name="searchOption">
                        <option value="writer">작성자</option>
                        <option value="title">제목</option>
                    </select>
                </div>
                <div class="text">
                    <input type="text" class="form-control" name="keyword">
                </div>
                <button class="btn btn-success" id="searchBtn" type="button">검색</button>
            </form>
            <br> <br>
        </div>
        <br> <br>
    </div>

    <jsp:include page="../common/footer.jsp" />

</body>
</html>