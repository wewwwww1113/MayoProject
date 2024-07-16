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
   h1 {
            position: relative;
            padding: 0;
            margin: 0;
            font-family: "Raleway", sans-serif;
            font-weight: 300;
            font-size: 40px;
            color: #080808;
            transition: all 0.4s ease 0s;
        }
        h1 span {
            display: block;
            font-size: 0.5em;
            line-height: 1.3;
        }
        h1 em {
            font-style: normal;
            font-weight: 600;
        }

        .nine h1 {
            text-align: center;
            font-size: 50px;
            text-transform: uppercase;
            color: #222;
            letter-spacing: 1px;
            font-family: "Playfair Display", serif;
            font-weight: 400;
        }
        .nine h1 span {
            margin-top: 5px;
            font-size: 15px;
            color: #444;
            word-spacing: 1px;
            font-weight: normal;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-family: "Raleway", sans-serif;
            font-weight: 500;
            display: grid;
            grid-template-columns: 1fr max-content 1fr;
            grid-template-rows: 27px 0;
            grid-gap: 20px;
            align-items: center;
        }
        .nine h1 span:after, .nine h1 span:before {
            content: " ";
            display: block;
            border-bottom: 1px solid #ccc;
            border-top: 1px solid #ccc;
            height: 5px;
            background-color: #f8f8f8;
        }
        
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Body styling */
body {
    font-family: 'Helvetica Neue', Arial, sans-serif;
    font-size: 16px;
    line-height: 1.6;
    color: #444;
    background-color: #f4f4f9;
    margin: 0;
    padding: 0;
}

/* Content area styling */
.content {
    max-width: 1200px;
    margin: 2rem auto;
    padding: 2rem;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Inner content styling */
.innerOuter {
    margin-top : -200px; 
    padding: 5% 10%;
}

/* Button styling */
.btn {
    display: inline-block;
    padding: 0.75rem 1.25rem;
    font-size: 1rem;
    text-align: center;
    text-decoration: none;
    border-radius: 4px;
    transition: background-color 0.3s ease;
    
}

.btn-secondary {

    margin-top : 20px;
    background-color: white;
    color: black;
    border: 1px solid #6c757d;
    padding : 8px 5px;
} 

.btn-secondary:hover {
    background-color: black;
    border-color: #5a6268;
}

/* Category select box styling */
.category-area {
    margin-bottom: 1rem;
}

#categoryNo {
    padding: 0.5rem;
    font-size: 1rem;
    border: 1px solid #6c757d;
    border-radius: 4px;
    background-color: while;
    
}

/* Table styling */
.table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 1rem;
    
}

.table th, .table td {
    padding: 0.75rem;
    text-align: center;
    border: 1px solid #dee2e6;
    font-family: "Raleway", sans-serif;
    font-weight: 300;
    
}

.table thead th {
    background-color: 
#DDDDDD;
    font-weight: bold;
}

.table tbody tr:hover {
    background-color: #f1f3f5;
}

.table tbody tr {
    cursor: pointer;
     background-color: while;
}

/* Pagination styling */
.pagination {
    display: flex;
    justify-content: center;
    list-style: none;
    padding: 1rem 0;
    color : balck;
    
}

.page-item {
    margin: 0 0.25rem;
    
}

.page-link {
    display: block;
    padding: 0.5rem 0.75rem;
    border: 1px solid #dee2e6;
    border-radius: 4px;
    color: black;
    text-decoration: none;

}

.page-link:hover {
    background-color: #e9ecef;
}

/* Search form styling */
#searchForm {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: -40px;
    color: black;
}

#searchForm .select,
#searchForm .text {
    margin-right: 0.5rem;
}

#searchForm .form-control {
    padding: 0.5rem;
    font-size: 1rem;
    border: 1px solid #6c757d;
    border-radius: 4px;
}

#searchForm .btn-success {
    background-color: black;
    color: #fff;
    border: 1px solid #28a745;
     display: block;
      border-radius: 0.25rem;
       text-align: center;
         padding: 0.5rem 1rem;
    font-size: 1rem;
    
}

#searchForm .btn-success:hover {
    background-color: #218838;
    border-color: #218838;
}
</style>
</head>
<body>

    <%@include file="../common/header.jsp"%>

 
   
   <div class="nine">
        <br> 
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