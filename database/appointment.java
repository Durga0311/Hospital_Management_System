package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class appointment {
    public static void main(String[] args) {
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; 
        String user = "System";                             
        String password = "Durga@0311";  

        // Table creation without IDENTITY
        String createTableSQL = "CREATE TABLE appointments ("
                + "id NUMBER PRIMARY KEY, "
                + "patient_name VARCHAR2(100), "
                + "patient_email VARCHAR2(100), "
                + "doctor_name VARCHAR2(100), "
                + "specialization VARCHAR2(100), "
                + "appointment_date DATE, "
                + "appointment_time VARCHAR2(10))";

        // Sequence for auto-increment
        String createSeqSQL = "CREATE SEQUENCE appointments_seq START WITH 1 INCREMENT BY 1";

        // Trigger to auto-fill id using sequence
        String createTriggerSQL =
                "CREATE OR REPLACE TRIGGER appointments_trigger "
              + "BEFORE INSERT ON appointments "
              + "FOR EACH ROW "
              + "BEGIN "
              + "   SELECT appointments_seq.NEXTVAL INTO :new.id FROM dual; "
              + "END;";

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();

            stmt.executeUpdate(createTableSQL);
            stmt.executeUpdate(createSeqSQL);
            stmt.executeUpdate(createTriggerSQL);

            System.out.println("Table 'appointments' created successfully with sequence & trigger!");

            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
