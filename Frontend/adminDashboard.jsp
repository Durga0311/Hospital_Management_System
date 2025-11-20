<%@ page import="java.util.*,com.model.Appointment" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Appointments</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: #f5f7fa;
            color: #333;
            padding: 20px;
        }
        h1 {
            text-align: center;
            color: #1A4DB3;
            font-size: 32px;
            margin-bottom: 30px;
        }
        .dashboard-container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 25px 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        }
        .appointments-table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-top: 20px;
        }
        .appointments-table thead {
            background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%);
            color: white;
        }
        .appointments-table th, .appointments-table td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        .appointments-table tr:hover {
            background-color: rgba(26,77,179,0.05);
        }
        .refresh-btn {
            background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%);
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 500;
            cursor: pointer;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        .refresh-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(26,77,179,0.4);
        }
        
         .logout-section {
            text-align: center;
            margin-top: 40px;
        }
        .logout-section form {
            display: inline;
        }
        .logout-section button {
            background-color: #ff4b5c;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s;
        }
        .logout-section button:hover {
            background-color: #e84150;
            transform: translateY(-2px);
        }
        
        @media (max-width: 768px) {
            .dashboard-container { padding: 15px; }
            .appointments-table th, .appointments-table td { padding: 10px; font-size: 14px; }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h1>All Appointments</h1>

        <button class="refresh-btn" onclick="location.reload();">
            <i class="fas fa-sync-alt"></i> Refresh Appointments
        </button>

        <table class="appointments-table">
            <thead>
                <tr>
                    <th>Patient Name</th>
                    <th>Patient Email</th>
                    <th>Doctor Name</th>
                    <th>Doctor Specialization</th>
                    <th>Date</th>
                    <th>Time Slot</th>
                </tr>
            </thead>
            <tbody>
            <%
                List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
                if (appointments != null && !appointments.isEmpty()) {
                    for (Appointment appt : appointments) {
            %>
                <tr>
                    <td><%= appt.getPatientName() %></td>
                    <td><%= appt.getPatientEmail() %></td>
                    <td><%= appt.getDoctorName() %></td>
                    <td><%= appt.getSpecialization() %></td>
                    <td><%= appt.getAppointmentDate() %></td>
                    <td><%= appt.getAppointmentTime() %></td>
                </tr>
                
                
            <%
                    }
                } else {
            %>
                <tr>
                    <td colspan="6" style="text-align:center; color:#666;">No appointments found.</td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
        
        <!--  Logout Section at Bottom -->
        <div class="logout-section">
            <form action="logout" method="get">
                <button type="submit"><i class="fas fa-sign-out-alt"></i> Logout</button>
            </form>
        </div>
    
    </div>
</body>
</html>
