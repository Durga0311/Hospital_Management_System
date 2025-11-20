package com.database;

import java.sql.*;
import java.util.*;

import com.model.Appointment;

public class AppointmentDAO {
    public static List<Appointment> getAppointmentsByPatient(String patientName) {
        List<Appointment> appointments = new ArrayList<>();
        try {
        	Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "System", "Durga@0311");

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM appointments WHERE patient_name = ?"
            );
            ps.setString(1, patientName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Appointment appt = new Appointment();
                appt.setDoctorName(rs.getString("doctor_name"));
                appt.setPatientName(rs.getString("patient_name"));
                appt.setPatientName(rs.getString("patient_email"));
                appt.setSpecialization(rs.getString("specialization"));
                appt.setAppointmentDate(rs.getDate("appointment_date"));
                appt.setAppointmentTime(rs.getString("appointment_time"));
                appointments.add(appt);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return appointments;
    }
}
