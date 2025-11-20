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
import javax.servlet.http.HttpSession;

@WebServlet("/deleteAppointment")
public class DeleteAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String patientName = (String) session.getAttribute("patientName");
        String patientEmail = (String) session.getAttribute("patientEmail");
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        
        System.out.println("Deleting appointment ID: " + appointmentId + " for patient: " + patientName);
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            // Load Oracle driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // Connect to database
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "Durga@0311");
            
            // Delete appointment - ensure it belongs to the logged-in patient
            String sql = "DELETE FROM SYSTEM.APPOINTMENTS WHERE ID = ? AND PATIENT_NAME = ? AND PATIENT_EMAIL = ?";
            
            ps = conn.prepareStatement(sql);
            ps.setInt(1, appointmentId);
            ps.setString(2, patientName);
            ps.setString(3, patientEmail);
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                System.out.println("Appointment deleted successfully!");
                request.setAttribute("deleteSuccess", "Appointment deleted successfully!");
            } else {
                System.out.println("No appointment found or you don't have permission to delete it.");
                request.setAttribute("error", "Appointment not found or you don't have permission to delete it.");
            }
            
            // Redirect back to appointments
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error deleting appointment: " + e.getMessage());
            request.setAttribute("error", "Error deleting appointment: " + e.getMessage());
            request.getRequestDispatcher("myAppointments").forward(request, response);
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}