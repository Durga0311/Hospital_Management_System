package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

public class AdminTable {
    public static void main(String[] args) {
        Connection con = null;
        Statement stmt = null;

        try {
            // Step 1: Load Oracle JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Step 2: Connect to Database
            // Replace your_username and your_password with actual credentials
            con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe",
                    "System",
                    "Durga@0311");

            // Step 3: Create SQL statement
            String createTableSQL = "CREATE TABLE ADMIN ("
                    
                    + "full_name VARCHAR2(50), " 
                    + "EMAIL VARCHAR2(100) UNIQUE NOT NULL, "
                    + "PHONE VARCHAR2(15) NOT NULL, "
                    + "GENDER VARCHAR2(10) NOT NULL, "
                    + "dob DATE, " 
                    + "PASSWORD VARCHAR2(100) NOT NULL"
                    + ")";

            // Step 4: Execute statement
            stmt = con.createStatement();
            stmt.executeUpdate(createTableSQL);

            System.out.println("✅ Admin table created successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (stmt != null) stmt.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
