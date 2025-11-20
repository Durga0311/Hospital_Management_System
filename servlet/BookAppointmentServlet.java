//package com.servlet;
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.DriverManager;
//import java.sql.PreparedStatement;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//@WebServlet("/bookAppointment")
//public class BookAppointmentServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        
//        HttpSession session = request.getSession();
//        String patientName = (String) session.getAttribute("patientName");
//        String patientEmail = (String) session.getAttribute("patientEmail");
//
//        String doctorName = request.getParameter("doctorName");
//        String specialization = request.getParameter("specialization");
//        String appointmentDate = request.getParameter("appointmentDate");
//        String appointmentTime = request.getParameter("appointmentTime");
//
//        System.out.println("DEBUG → patientName=" + patientName 
//                         + ", patientEmail=" + patientEmail
//                         + ", doctor=" + doctorName
//                         + ", specialization=" + specialization
//                         + ", date=" + appointmentDate
//                         + ", time=" + appointmentTime);
//
//        try {
//            Class.forName("oracle.jdbc.driver.OracleDriver");
//            Connection conn = DriverManager.getConnection(
//                "jdbc:oracle:thin:@localhost:1521:xe", "System", "Durga@0311");
//
//            String sql = "INSERT INTO appointments "
//                       + "(patient_name, patient_email, doctor_name, specialization, appointment_date, appointment_time) "
//                       + "VALUES (?, ?, ?, ?, ?, ?)";
//
//            PreparedStatement ps = conn.prepareStatement(sql);
//            ps.setString(1, patientName);
//            ps.setString(2, patientEmail);
//            ps.setString(3, doctorName);
//            ps.setString(4, specialization);
//            ps.setString(5, appointmentDate);
//            ps.setString(6, appointmentTime);
//
//            int rows = ps.executeUpdate();
//            System.out.println("Inserted rows: " + rows);
//
//            ps.close();
//            conn.close();
//
//            if (rows > 0) {
//                session.setAttribute("message", "Appointment booked successfully!");
//                response.sendRedirect("appointments"); // go to servlet that loads list
//            } else {
//                response.getWriter().println("Failed to insert appointment.");
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            response.getWriter().println("Error: " + e.getMessage());
//        }
//    }
//}


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

@WebServlet("/bookAppointment")
public class BookAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    	// 2️⃣ Get patient details from session (assuming user logged in)
    	HttpSession session = request.getSession();
    	String patientName = (String) session.getAttribute("patientName");
    	String patientEmail = (String) session.getAttribute("patientEmail");


        // 1️⃣ Get form values
        String doctorName = request.getParameter("doctorName");
        String specialization = request.getParameter("specialization");
        String appointmentDate = request.getParameter("appointmentDate"); // yyyy-MM-dd
        String appointmentTime = request.getParameter("appointmentTime");

        
        
        try {
            // 3️⃣ Connect to Oracle SYSTEM schema
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "Durga@0311");
            conn.setAutoCommit(true);
            
            System.out.println("Patient: " + patientName + ", Email: " + patientEmail);
            System.out.println("Doctor: " + doctorName + ", Specialization: " + specialization);
            System.out.println("Date: " + appointmentDate + ", Time: " + appointmentTime);

            // 4️⃣ Insert into APPOINTMENTS
            String sql = "INSERT INTO SYSTEM.APPOINTMENTS " +
                    "(PATIENT_NAME, PATIENT_EMAIL, DOCTOR_NAME, SPECIALIZATION, APPOINTMENT_DATE, APPOINTMENT_TIME) " +
                    "VALUES (?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, patientName);
            ps.setString(2, patientEmail);
            ps.setString(3, doctorName);
            ps.setString(4, specialization);
            ps.setString(5, appointmentDate); // date as string
            ps.setString(6, appointmentTime); // time as string

            ps.executeUpdate();

            conn.close();

            // 5️⃣ Redirect or show confirmation
            //response.sendRedirect("dashboard.jsp?msg=Appointment+Booked");
            request.setAttribute("section", "confirmation");
            request.setAttribute("doctorName", doctorName);
            request.setAttribute("specialization", specialization);
            request.setAttribute("appointmentDate", appointmentDate);
            request.setAttribute("appointmentTime", appointmentTime);
            

            response.sendRedirect("dashboard.jsp?section=book-appointment&booking=success&doctor=" + 
                    java.net.URLEncoder.encode(doctorName, "UTF-8") + 
                    "&specialization=" + java.net.URLEncoder.encode(specialization, "UTF-8") +
                    "&date=" + appointmentDate + "&time=" + appointmentTime);



            


        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?section=book-appointment&booking=error");
        }
    }
}
