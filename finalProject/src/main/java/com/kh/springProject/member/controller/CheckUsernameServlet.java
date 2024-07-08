package com.kh.springProject.member.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/checkUsername")
public class CheckUsernameServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String responseMessage = "unavailable";

        if (username != null && !username.trim().isEmpty()) {
            try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "MAYO", "MAYO");
                 PreparedStatement pstmt = conn.prepareStatement("SELECT COUNT(*) FROM MEMBER WHERE MEMBER_ID = ?")) {

                Class.forName("oracle.jdbc.driver.OracleDriver");

                pstmt.setString(1, username);
                try (ResultSet rs = pstmt.executeQuery()) {
                    if (rs.next() && rs.getInt(1) == 0) {
                        responseMessage = "available";
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        response.setContentType("text/plain");
        response.getWriter().write(responseMessage);
    }
}