<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    String username = request.getParameter("username");
    String responseMessage = "unavailable";

    if (username != null && !username.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // 데이터베이스 연결 설정
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "MAYO", "MAYO");

            // 사용자 이름 중복 확인 쿼리
            String sql = "SELECT COUNT(*) FROM MEMBER WHERE MEMBER_ID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) == 0) {
                responseMessage = "available";
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    response.setContentType("text/plain");
    PrintWriter out = response.getWriter();
    out.write(responseMessage);
    out.flush();
    out.close();
%>
