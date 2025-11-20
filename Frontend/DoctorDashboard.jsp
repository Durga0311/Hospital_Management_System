<%@ page import="java.util.List" %>
<%@ page import="com.model.Appointment" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

    if (session.getAttribute("doctorName") == null) {
        response.sendRedirect("doctorLogin.jsp");
        return;
    }

    List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    String doctorName = (String) session.getAttribute("doctorName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Care - Doctor Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0; padding: 0; box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        body {
            background-color: #f5f7fa;
            color: #333;
        }
        .dashboard-container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e1e5eb;
        }
        .dashboard-header h1 { color: #1A4DB3; font-size: 28px; }
        .welcome-box {
            background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .welcome-box h2 { margin-bottom: 10px; font-size: 24px; }

        .section-title {
            color: #1A4DB3;
            font-size: 24px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f1f1;
            display: flex;
            align-items: center;
        }
        .section-title i { margin-right: 15px; font-size: 28px; }

        .appointments-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .appointments-table thead {
            background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%);
            color: white;
        }
        .appointments-table th, .appointments-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .appointments-table tr:hover { background-color: rgba(26,77,179,0.05); }

        .btn {
            padding: 8px 12px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            transition: all 0.3s;
        }
        .btn-danger {
            background: #ff4757; color: white;
        }
        .btn-danger:hover {
            background: #ff3742;
            transform: translateY(-1px);
        }
        .refresh-btn {
            background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%);
            color: white; border: none;
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
            .dashboard-container { margin: 15px; padding: 20px; }
            .appointments-table th, .appointments-table td { padding: 10px; }
        }
    </style>
</head>

<body>
    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>Doctor Dashboard</h1>
            <p id="current-date"></p>
        </div>

        <div class="welcome-box">
            <h2>Welcome, <%= doctorName %></h2>
            <p>Manage your patient appointments and schedules efficiently.</p>
        </div>

        <div class="appointments-section" id="appointments-section">
            <h2 class="section-title"><i class="fas fa-calendar-check"></i> Patient Appointments</h2>

            <button class="refresh-btn" onclick="location.reload();">
                <i class="fas fa-sync-alt"></i> Refresh Appointments
            </button>

            <table class="appointments-table">
                <thead>
                    <tr>
                        <th>Patient Name</th>
                        <th>Email</th>
                        <th>Appointment Date</th>
                        <th>Appointment Time</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    if (appointments != null && !appointments.isEmpty()) {
                        for (Appointment a : appointments) {
                %>
                    <tr>
                        <td><%= a.getPatientName() %></td>
                        <td><%= a.getPatientEmail() %></td>
                        <td><%= a.getAppointmentDate() %></td>
                        <td><%= a.getAppointmentTime() %></td>
                        <td>
                            <form action="deleteAppointment" method="post" style="display:inline;">
                                <input type="hidden" name="appointmentId" value="<%= a.getId() %>">
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr><td colspan="5" style="text-align:center; color:#666;">No Appointments Found</td></tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <!--  Logout Section at Bottom -->
        <div class="logout-section">
            <form action="logout" method="get">
                <button type="submit"><i class="fas fa-sign-out-alt"></i> Logout</button>
            </form>
        </div>
    </div>

    <script>
        // Set current date
        const now = new Date();
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        document.getElementById('current-date').textContent = now.toLocaleDateString('en-US', options);
    </script>
</body>
</html>
