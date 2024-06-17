<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
    String username = request.getParameter("username");
    List<String> existingUsernames = Arrays.asList("user1", "user2", "user3"); // 예제 사용자 이름 목록

    String responseMessage = "unavailable";
    if (username != null && !username.trim().isEmpty() && !existingUsernames.contains(username)) {
        responseMessage = "available";
    }

    response.setContentType("text/plain");
    PrintWriter outPrintWriter = response.getWriter();
    outPrintWriter.write(responseMessage);
    outPrintWriter.flush();
    outPrintWriter.close();
%>