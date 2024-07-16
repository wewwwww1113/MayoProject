<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
.content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        #enrollForm>table {width:100%;}
        #enrollForm>table * {margin:5px;}
        
        .btn-update {
	background-color: grey;
	color: #fff; /* 글자색 흰색 */
	border: none; /* 테두리 없음 */
}


#contentArea{
   margin-top:-30px;

}


   

.btn-delete {
	background-color: black;
	color: #fff; /* 글자색 흰색 */
	border: none; /* 테두리 없음 */
}
    </style>
</head>
<body>

	<%@include file="../common/header.jsp"%>

	<div class="content">
		<br>
		<br>
		<div class="innerOuter">
			<h2>게시글 작성하기</h2>
			<br>

			<form id="enrollForm" method="post" action="insert.fr" enctype="multipart/form-data">
    <table align="center">
        <tr>
            <th width="70">카테고리</th>
            <td width="70">
                <select name="categoryNo">
                    <c:forEach var="c" items="${cgList}">
                        <option value="${c.categoryNo}">${c.categoryName}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <th><label for="title">제목</label></th>
            <td><input type="text" id="title" class="form-control" name="boardTitle" required></td>
        </tr>
        <tr>
            <th><label for="writer">작성자</label></th>
            <td><input type="text" id="writer" class="form-control" value="${loginUser.memberId}" name="boardWriter" readonly></td>
        </tr>
        <tr>
            <th><label for="upfile">첨부파일</label></th>
            <td><input type="file" id="upfile" class="form-control-file border" name="upfile"></td>
        </tr>
        <tr>
            <th><label for="content">내용</label></th>
            <td><textarea id="content" class="form-control" rows="10" style="resize:none;" name="boardContent" required></textarea></td>
        </tr>
    </table>
    <br>

				<div align="center">
					<button type="submit" class="btn btn-update">등록하기</button>
					<button type="reset" class="btn btn-delete">취소하기</button>
				</div>
			</form>

		</div>
		<br>
		<br>

	</div>
	

	<jsp:include page="../common/footer.jsp" />


</body>
</html>