package com.servlet;



import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/DoctorRegisterServlet")
public class DoctorRegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "System";
    private static final String DB_PASSWORD = "Durga@0311";
    
    

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    try {
    	Class.forName("oracle.jdbc.driver.OracleDriver");
        PrintWriter out = response.getWriter();

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dobStr = request.getParameter("dob");
        java.sql.Date dob = java.sql.Date.valueOf(dobStr);
        String specialization = request.getParameter("specialization");
        
        String experience = request.getParameter("experience");
 
        String password = request.getParameter("password");

     
      

        
            // Create connection
            
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            
        String sql = "INSERT INTO DOCTOR (first_name, last_name, EMAIL, PHONE, GENDER, DOB, SPECIALIZATION, EXPERIENCE, PASSWORD) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            
        PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, phone);
            ps.setString(5, gender);
            ps.setDate(6, dob);
            ps.setString(7, specialization);
            ps.setString(8, experience);
            ps.setString(9, password);

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Redirect to confirmation page
                response.sendRedirect("register_success.jsp");
            } else {
                out.println("<h3 style='color:red;'>Registration failed. Please try again.</h3>");
            }
            
            ps.close();
            conn.close(); 
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h3 style='color:red;'>Error:  " + e.getMessage() +"</h3>");
        } 
    }   
}

