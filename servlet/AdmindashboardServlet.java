package com.servlet;



import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.model.Appointment;

@WebServlet("/adminDashboard")
public class AdmindashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    private static final String DB_USER = "System";
    private static final String DB_PASSWORD = "Durga@0311";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Appointment> appointments = new ArrayList<>();

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "SELECT * FROM APPOINTMENTS ORDER BY APPOINTMENT_DATE DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Appointment appt = new Appointment();
                
                appt.setPatientName(rs.getString("PATIENT_NAME"));
                appt.setPatientEmail(rs.getString("PATIENT_EMAIL"));
                appt.setDoctorName(rs.getString("DOCTOR_NAME"));
                appt.setAppointmentDate(rs.getDate("APPOINTMENT_DATE"));
                appt.setAppointmentTime(rs.getString("APPOINTMENT_TIME"));
                appt.setSpecialization(rs.getString("SPECIALIZATION"));
                appointments.add(appt);
            }
            rs.close();
            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("appointments", appointments);
        RequestDispatcher rd = request.getRequestDispatcher("adminDashboard.jsp");
        rd.forward(request, response);
    }
}
