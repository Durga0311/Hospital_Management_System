package com.servlet;

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
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "System";
    private static final String DB_PASSWORD = "Durga@0311";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("patientEmail");
        String password = request.getParameter("patientPassword");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Query to check if the user exists with the provided credentials
            String sql = "SELECT * FROM patients WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // User exists, create session
                HttpSession session = request.getSession();
                session.setAttribute("patientEmail", rs.getString("email")); // store only email for session tracking
                session.setAttribute("patientName", rs.getString("first_name") + " " + rs.getString("last_name"));
                session.setAttribute("Gender", rs.getString("gender"));
                session.setAttribute("dob", rs.getDate("dob"));
                session.setAttribute("contact", rs.getString("contact"));
                session.setAttribute("emergencyContact", rs.getString("emergency_contact"));
                session.setAttribute("street", rs.getString("street"));
                session.setAttribute("city", rs.getString("city"));
                session.setAttribute("state", rs.getString("state"));
                session.setAttribute("zipCode", rs.getString("zip_code"));
                session.setAttribute("bloodType", rs.getString("blood_type"));
                session.setAttribute("primaryDoctor", rs.getString("primary_doctor"));

                // Redirect to dashboard
                response.sendRedirect("dashboard.jsp");
            } else {
                // Invalid login
                response.sendRedirect("index.html?error=invalid");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
