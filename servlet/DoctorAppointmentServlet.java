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

@WebServlet("/doctorAppointments")
public class DoctorAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String doctorName = (String) session.getAttribute("doctorName");
        String doctorEmail = (String) session.getAttribute("doctorEmail");

        // Validate login session
        if (doctorName == null || doctorEmail == null) {
            response.sendRedirect("doctorLogin.jsp");
            return;
        }

        System.out.println("Fetching appointments for Doctor: " + doctorName + " (" + doctorEmail + ")");

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

            // Query: Get all appointments assigned to this doctor
            String sql = "SELECT ID, PATIENT_NAME, PATIENT_EMAIL, DOCTOR_NAME, SPECIALIZATION, " +
                         "APPOINTMENT_DATE, APPOINTMENT_TIME " +
                         "FROM SYSTEM.APPOINTMENTS " +
                         "WHERE DOCTOR_NAME = ? " +
                         "ORDER BY APPOINTMENT_DATE DESC, APPOINTMENT_TIME DESC";

            ps = conn.prepareStatement(sql);
            ps.setString(1, doctorName);

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

            System.out.println("Found " + appointments.size() + " appointments for Dr. " + doctorName);

            // If a delete message exists
            String deleteSuccess = (String) request.getAttribute("deleteSuccess");
            if (deleteSuccess != null) {
                request.setAttribute("deleteSuccess", deleteSuccess);
            }

            // Set appointment list in request scope
            request.setAttribute("appointments", appointments);
            

            // Forward to doctor dashboard JSP
            request.getRequestDispatcher("DoctorDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error fetching doctor appointments: " + e.getMessage());
            request.setAttribute("error", "Error fetching appointments: " + e.getMessage());
            request.getRequestDispatcher("DoctorDashboard.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
