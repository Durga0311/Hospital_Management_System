package com.servlet;



import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/register")  // This should match the form's action attribute
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Database connection details
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "System";
    private static final String DB_PASSWORD = "Durga@0311";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Read form parameters
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String gender = request.getParameter("gender");
            String dobStr = request.getParameter("dob");
            java.sql.Date dob = java.sql.Date.valueOf(dobStr);
            String email = request.getParameter("email");
            String contact = request.getParameter("contact");
            String emergencyContact = request.getParameter("emergencyContact");
            String street = request.getParameter("street");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zipCode = request.getParameter("zipCode");
            String bloodType = request.getParameter("bloodType");
            String primaryDoctor = request.getParameter("primaryDoctor");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Create connection
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // SQL insert statement
            
            String sql = "INSERT INTO patients (id, first_name, last_name, gender, dob, email, contact, emergency_contact, street, city, state, zip_code, blood_type, primary_doctor, username, password) "
                    + "VALUES (patient_seq.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement stmt = conn.prepareStatement(sql);

            // Set parameters
            stmt.setString(1, firstName);
            stmt.setString(2, lastName);
            stmt.setString(3, gender);
            stmt.setDate(4, dob);
            stmt.setString(5, email);
            stmt.setString(6, contact);
            stmt.setString(7, emergencyContact);
            stmt.setString(8, street);
            stmt.setString(9, city);
            stmt.setString(10, state);
            stmt.setString(11, zipCode);
            stmt.setString(12, bloodType);
            stmt.setString(13, primaryDoctor);
            stmt.setString(14, username);
            stmt.setString(15, password);

            // Execute the insert
            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                response.setContentType("text/html");
                response.getWriter().println("<script>alert('Registration Successful'); window.location='index.html';</script>");
            } else {
                response.getWriter().println("Error occurred during registration.");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Exception: " + e.getMessage());
        }
    }
}
