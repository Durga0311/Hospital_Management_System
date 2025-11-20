package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class Patient {
    public static void main(String[] args) {
        String url = "jdbc:oracle:thin:@localhost:1521:xe"; // Oracle connection URL
        String user = "System";                             // Oracle user
        String password = "Durga@0311";                     // Oracle password

        // SQL statement to create the table
        String createTableSQL = "CREATE TABLE patients (" +
                "id NUMBER PRIMARY KEY, " +
                "first_name VARCHAR2(50), " +
                "last_name VARCHAR2(50), " +
                "gender VARCHAR2(10), " +
                "dob DATE, " +
                "email VARCHAR2(100) UNIQUE, " +
                "contact VARCHAR2(15), " +
                "emergency_contact VARCHAR2(15), " +
                "street VARCHAR2(100), " +
                "city VARCHAR2(50), " +
                "state VARCHAR2(50), " +
                "zip_code VARCHAR2(10), " +
                "blood_type VARCHAR2(5), " +
                "primary_doctor VARCHAR2(100), " +
                "username VARCHAR2(50) UNIQUE, " +
                "password VARCHAR2(100)" +
                ")";

        // SQL statement to create the sequence
        String createSequenceSQL = "CREATE SEQUENCE patient_seq " +
                "START WITH 1 " +
                "INCREMENT BY 1 " +
                "NOCACHE " +
                "NOCYCLE";

        // SQL statement to create the trigger
        String createTriggerSQL = "CREATE OR REPLACE TRIGGER patient_id_trigger " +
                "BEFORE INSERT ON patients " +
                "FOR EACH ROW " +
                "BEGIN " +
                "    IF :NEW.id IS NULL THEN " +
                "        SELECT patient_seq.NEXTVAL INTO :NEW.id FROM dual; " +
                "    END IF; " +
                "END;";

        try {
            // Load the Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish the connection
            Connection conn = DriverManager.getConnection(url, user, password);

            // Create a statement
            Statement stmt = conn.createStatement();

            // Execute the table creation
            stmt.executeUpdate(createTableSQL);
            System.out.println("Table 'patients' created successfully!");

            // Execute the sequence creation
            stmt.executeUpdate(createSequenceSQL);
            System.out.println("Sequence 'patient_seq' created successfully!");

            // Execute the trigger creation
            stmt.executeUpdate(createTriggerSQL);
            System.out.println("Trigger 'patient_id_trigger' created successfully!");

            // Clean up
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
