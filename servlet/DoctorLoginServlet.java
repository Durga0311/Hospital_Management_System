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
import javax.servlet.*;

@WebServlet("/doctorLogin")
public class DoctorLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "System";
    private static final String DB_PASSWORD = "Durga@0311";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("doctorEmail");
        String password = request.getParameter("doctorPassword");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // Query to check if the doctor exists with the provided credentials
            String sql = "SELECT * FROM doctor WHERE email=? AND password=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Doctor exists, create session
                HttpSession session = request.getSession();
                session.setAttribute("doctorEmail", rs.getString("EMAIL"));
                session.setAttribute("doctorName", rs.getString("first_name") + " " + rs.getString("last_name"));
                session.setAttribute("specialization", rs.getString("specialization"));
                session.setAttribute("gender", rs.getString("gender"));
                session.setAttribute("dob", rs.getDate("dob"));
                session.setAttribute("PHONE", rs.getString("PHONE"));
                session.setAttribute("Experience", rs.getInt("experience"));
               
                

                // Redirect to doctor dashboard
                response.sendRedirect("doctorAppointments");
            } else {
                // Invalid login
                request.setAttribute("error","Invalid email or password!");
                RequestDispatcher rd = request.getRequestDispatcher("doctorLogin.jsp");
                rd.forward( request, response);
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