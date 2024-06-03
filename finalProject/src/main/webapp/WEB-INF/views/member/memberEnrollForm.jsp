<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<%@include file="../common/header.jsp" %>
	
	
	
	<div class="content">
		<br> <br>
		<div class="innerOuter">
			<h2>회원가입</h2>
			<br>
			
			<form action="insert.me" method="post">
				<div class="form-group">
					<label for="enrollUserId">* ID</label>
					<input type="text" id="enrollUserId" name="userId" class="form-control"> <br>
					
					<label for="enrollUserPwd">* PASSWORD</label>
					<input type="password" id="enrollUserPwd" name="userPwd" class="form-control"> <br>
					
					<label for="checkPwd">* PASSWORD CHECK</label>
					<input type="password" id="pwdCheck" class="form-control"> <br>
					
					<label for="userName">* NAME</label>
					<input type="text" id="userName" name="userName" class="form-control"> <br>
					
					<label for="email"> &nbsp; EMAIL</label>
					<input type="email" id="email" name="email" class="form-control"> <br>
					
					<label for="age"> &nbsp; AGE</label>
					<input type="number" id="age" name="age" class="form-control"> <br>
					
					<label for="phone"> &nbsp; PHONE</label>
					<input type="tel" id="phone" name="phone" class="form-control" placeholder="(-)없이 입력"> <br>
					
					<label for="address"> &nbsp; ADDRESS</label>
					<input type="text" id="address" name="address" class="form-control"> <br>
					
					<label for=""> &nbsp; GENDER</label> &nbsp;&nbsp;
					<input type="radio" id="male" value="M" name="gender" checked>
					<label for="male">남자</label> &nbsp;&nbsp;
					<input type="radio" id="female" value="F" name="gender">
					<label for="female">여자</label> &nbsp;&nbsp;
				</div>
				<div class="btns" align="center">
					<button type="submit" class="btn btn-primary">회원가입</button>
					<button type="reset" class="btn btn-danger">초기화</button>
				</div>
			</form>
		
		
		</div>
	</div>
	
	
	
	<%@include file="../common/footer.jsp" %>
</body>
</html>