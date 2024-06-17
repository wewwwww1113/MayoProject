<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
    // 요청으로부터 비밀번호를 가져옵니다.
    String password = request.getParameter("password");

    // 비밀번호 유효성 검사 패턴: 영문, 숫자를 포함한 4~10글자
    String pattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{4,10}$";

    // 유효성 검사 수행
    boolean isValid = password != null && password.matches(pattern);

    // 결과를 클라이언트에 전송
    response.setContentType("text/plain");
    response.getWriter().write(isValid ? "valid" : "invalid");
%>
</body>
</html>