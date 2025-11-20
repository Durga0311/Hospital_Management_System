package com.servlet;

import com.model.Appointment;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/myAppointments")
public class AppointmentsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String patientName = (String) session.getAttribute("patientName");
        String patientEmail = (String) session.getAttribute("patientEmail");
        
        System.out.println("Fetching appointments for: " + patientName + " (" + patientEmail + ")");
        
        List<Appointment> appointments = new ArrayList<>();
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            // Load Oracle driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // Connect to database
            conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "System", "Durga@0311");
            
            // Query to get appointments for specific patient
            String sql = "SELECT ID, PATIENT_NAME, PATIENT_EMAIL, DOCTOR_NAME, SPECIALIZATION, " +
                        "APPOINTMENT_DATE, APPOINTMENT_TIME " +
                        "FROM SYSTEM.APPOINTMENTS " +
                        "WHERE PATIENT_NAME = ? AND PATIENT_EMAIL = ? " +
                        "ORDER BY APPOINTMENT_DATE DESC, APPOINTMENT_TIME DESC";
            
            ps = conn.prepareStatement(sql);
            ps.setString(1, patientName);
            ps.setString(2, patientEmail);
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Appointment appointment = new Appointment();
                appointment.setId(rs.getInt("ID"));
                appointment.setPatientName(rs.getString("PATIENT_NAME"));
                appointment.setPatientEmail(rs.getString("PATIENT_EMAIL"));
                appointment.setDoctorName(rs.getString("DOCTOR_NAME"));
                appointment.setSpecialization(rs.getString("SPECIALIZATION"));
                appointment.setAppointmentDate(rs.getDate("APPOINTMENT_DATE"));
                appointment.setAppointmentTime(rs.getString("APPOINTMENT_TIME"));
                
                appointments.add(appointment);
            }
            
            System.out.println("Found " + appointments.size() + " appointments");
            
         // In the doGet method, after getting appointments:
            String deleteSuccess = (String) request.getAttribute("deleteSuccess");
            if (deleteSuccess != null) {
                request.setAttribute("deleteSuccess", deleteSuccess);
            }
            
            // Set appointments in request attribute
            request.setAttribute("appointments", appointments);
            
            // Forward to dashboard
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error fetching appointments: " + e.getMessage());
            request.setAttribute("error", "Error fetching appointments: " + e.getMessage());
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}