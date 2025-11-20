<%@ page import="java.util.List" %>
<%@ page import="com.model.Appointment" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Care - Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Global Styles */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body, html {
            margin: 0;
            padding: 0;
            scroll-behavior: smooth;
            overflow-x: hidden;
            background-color: #f5f7fa;
            color: #333;
            height: 100%;
        }

        /* Dashboard Layout */
        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        /* Side Navigation */
        .sidenav {
            width: 260px;
            background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%);
            color: white;
            height: 100vh;
            position: fixed;
            overflow-y: auto;
            transition: all 0.3s ease;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            z-index: 100;
        }

        .sidenav-header {
            padding: 25px 20px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidenav-header img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 15px;
        }

        .sidenav-header h3 {
            font-size: 18px;
            margin-bottom: 5px;
        }

        .sidenav-header p {
            font-size: 14px;
            opacity: 0.8;
        }

        .sidenav-menu {
            padding: 20px 0;
        }

        .sidenav-menu ul {
            list-style: none;
        }

        .sidenav-menu li {
            margin-bottom: 5px;
        }

        .sidenav-menu a {
            display: flex;
            align-items: center;
            padding: 15px 25px;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .sidenav-menu a:hover, .sidenav-menu a.active {
            background: rgba(255, 255, 255, 0.1);
            border-left: 4px solid #2de0bc;
            padding-left: 30px;
        }

        .sidenav-menu i {
            margin-right: 15px;
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        /* Main Content Area */
        .main-content {
            flex: 1;
            margin-left: 260px;
            padding: 30px;
            transition: all 0.3s ease;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e1e5eb;
        }

        .dashboard-header h1 {
            color: #1A4DB3;
            font-size: 28px;
        }

        .welcome-box {
            background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .welcome-box h2 {
            margin-bottom: 10px;
            font-size: 24px;
        }

        /* Profile Section */
        .profile-section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .section-title {
            color: #1A4DB3;
            font-size: 24px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f1f1f1;
            display: flex;
            align-items: center;
        }

        .section-title i {
            margin-right: 15px;
            font-size: 28px;
        }

        .profile-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
        }

        .detail-card {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #2de0bc;
        }

        .detail-card h3 {
            color: #1A4DB3;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }

        .detail-card h3 i {
            margin-right: 10px;
            font-size: 20px;
        }

        .detail-card p {
            font-size: 18px;
            color: #555;
            margin-bottom: 10px;
        }

        /* Appointments Section */
        .appointments-section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            display: none;
        }

        .appointment-card {
            display: flex;
            background: #f9f9f9;
            border-radius: 8px;
            overflow: hidden;
            margin-bottom: 20px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
        }

        .appointment-date {
            background: #1A4DB3;
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-width: 100px;
        }

        .appointment-date .day {
            font-size: 28px;
            font-weight: bold;
            line-height: 1;
        }

        .appointment-date .month {
            font-size: 16px;
            text-transform: uppercase;
        }

        .appointment-info {
            padding: 20px;
            flex: 1;
        }

        .appointment-info h3 {
            color: #1A4DB3;
            margin-bottom: 10px;
        }

        .appointment-info p {
            color: #666;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
        }

        .appointment-info i {
            margin-right: 10px;
            color: #2de0bc;
        }

        .appointment-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn {
            padding: 10px 15px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: #2de0bc;
            color: white;
        }

        .btn-primary:hover {
            background: #1fd4b0;
            transform: translateY(-2px);
        }

        .btn-outline {
            background: transparent;
            border: 1px solid #1A4DB3;
            color: #1A4DB3;
        }

        .btn-outline:hover {
            background: #1A4DB3;
            color: white;
        }

        /* Book Appointment Section */
        .book-appointment-section {
            background: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
            display: none;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: 500;
        }

        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 1px solid #e1e5eb;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            border-color: #1A4DB3;
            box-shadow: 0 0 0 3px rgba(26, 77, 179, 0.2);
            outline: none;
        }

        .form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        /* Responsive Styles */
        @media (max-width: 992px) {
            .sidenav {
                width: 220px;
            }
            
            .main-content {
                margin-left: 220px;
            }
        }

        @media (max-width: 768px) {
            .dashboard-container {
                flex-direction: column;
            }
            
            .sidenav {
                width: 100%;
                height: auto;
                position: relative;
            }
            
            .sidenav-menu {
                padding: 10px 0;
            }
            
            .sidenav-menu ul {
                display: flex;
                overflow-x: auto;
            }
            
            .sidenav-menu li {
                margin-bottom: 0;
                flex-shrink: 0;
            }
            
            .sidenav-menu a {
                padding: 15px 20px;
                border-left: none;
                border-bottom: 4px solid transparent;
            }
            
            .sidenav-menu a:hover, .sidenav-menu a.active {
                border-left: none;
                border-bottom: 4px solid #2de0bc;
                padding-left: 20px;
            }
            
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            
            .profile-details {
                grid-template-columns: 1fr;
            }
        }
        
        .btn-danger {
    background: #ff4757;
    color: white;
    border: none;
    padding: 8px 12px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 12px;
    transition: all 0.3s ease;
}

.btn-danger:hover {
    background: #ff3742;
    transform: translateY(-1px);
    box-shadow: 0 2px 5px rgba(255, 71, 87, 0.3);
}

.btn-danger:disabled {
    background: #ccc;
    cursor: not-allowed;
    transform: none;
    box-shadow: none;
}

/* Loading spinner */
.fa-spin {
    animation: fa-spin 1s infinite linear;
}

@keyframes fa-spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

        /* Toggle button for mobile */
        .menu-toggle {
            display: none;
            background: #1A4DB3;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            font-size: 24px;
            cursor: pointer;
            margin-bottom: 20px;
        }

        @media (max-width: 768px) {
            .menu-toggle {
                display: block;
            }
            
            .sidenav {
                display: none;
            }
            
            .sidenav.active {
                display: block;
            }
        }

        /* Logout confirmation */
        .logout-confirm {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .logout-modal {
            background: white;
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 5px 30px rgba(0, 0, 0, 0.2);
        }

        .logout-modal h3 {
            color: #1A4DB3;
            margin-bottom: 15px;
        }

        .logout-modal p {
            margin-bottom: 25px;
            color: #666;
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn-cancel {
            background: #f1f1f1;
            color: #333;
        }

        .btn-cancel:hover {
            background: #e1e5eb;
        }

        .btn-logout {
            background: #ff4757;
            color: white;
        }

        .btn-logout:hover {
            background: #ff3742;
        }
        
        
         .appointment-form, .confirmation-box {
            max-width: 500px;
            margin: 20px auto;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
       
        /* Doctor Table Styles */
        .doctor-table-container {
            background: white;
            border-radius: 10px;
            padding: 30px;
            
            margin-bottom: 30px;
        }

        .doctor-table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        .doctor-table th, .doctor-table td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        .doctor-table th {
            background-color: #f4f4f4;
            color: #1A4DB3;
        }

        .doctor-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .doctor-table tr:hover {
            background-color: #f1f1f1;
        }
        
        .hidden {
            display: none;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Side Navigation -->
        <div class="sidenav" id="sidenav">
            <!-- <div class="sidenav-header">
                <img src="https://via.placeholder.com/80x80/1A4DB3/FFFFFF?text=U" alt="User Profile">
                <h3>Satish Kumar</h3>
                <p>Patient</p>
            </div> -->
            
            <div class="sidenav-menu">
                <ul>
                    <li><a href="#" class="active" onclick="showSection('profile')"><i class="fas fa-user"></i> Profile</a></li>
                    <li><a href="#" onclick="showSection('appointments')"><i class="fas fa-calendar-check"></i> My Appointments</a></li>
                    <li><a href="#" onclick="showSection('book-appointment')"><i class="fas fa-calendar-plus"></i> Book Appointment</a></li>
                    <li><a href="#" onclick="confirmLogout()"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <button class="menu-toggle" onclick="toggleSidenav()"><i class="fas fa-bars"></i></button>
            
            <div class="dashboard-header">
                <h1>Patient Dashboard</h1>
                <p id="current-date">
                <%
                java.util.Date today = new java.util.Date();
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("EEEE, MMMM d, yyyy");
                out.print(sdf.format(today));
                %></p>
            </div>
            
            <div class="welcome-box">
                <h2>Welcome, ${sessionScope.patientName}!</h2>
                <p>We're here to help you manage your health and appointments.</p>
            </div>
            
            <!-- Profile Section -->
            <div class="profile-section" id="profile-section">
                <h2 class="section-title"><i class="fas fa-user"></i> Personal Information</h2>
                
                <div class="profile-details">
                <%@ page import="java.text.SimpleDateFormat" %>
                <%
                java.sql.Date dob = (java.sql.Date) session.getAttribute("dob");
                String formattedDob = "";
                if (dob != null) {
                formattedDob = new SimpleDateFormat("dd-MM-yyyy").format(dob);
                }
                %>
                    <div class="detail-card">
                        <h3><i class="fas fa-user-circle"></i> Basic Info</h3>
                        <p><strong>Name:</strong> ${sessionScope.patientName}</p>
                        <p><strong>Gender:</strong> ${sessionScope.Gender}</p>
                        <p><strong>Date of Birth:</strong> <%= formattedDob %></p>
                    </div>
                    
                    <div class="detail-card">
                        <h3><i class="fas fa-address-card"></i> Contact Details</h3>
                        <p><strong>Email:</strong> ${sessionScope.patientEmail}</p>
                        <p><strong>Phone:</strong> ${sessionScope.contact}</p>
                        <p><strong>Emergency Contact:</strong> ${sessionScope.emergencyContact}</p>
                    </div>
                    
                    <div class="detail-card">
                        <h3><i class="fas fa-map-marker-alt"></i> Address</h3>
                        <p><strong>Street:</strong> ${sessionScope.street}</p>
                        <p><strong>City:</strong> ${sessionScope.city}</p>
                        <p><strong>State:</strong>  ${sessionScope.state}</p>
                        <p><strong>ZIP Code:</strong> ${sessionScope.zipCode}</p>
                    </div>
                    
                    <div class="detail-card">
                        <h3><i class="fas fa-stethoscope"></i> Medical Info</h3>
                        <p><strong>Blood Type:</strong> ${sessionScope.bloodType}</p>
                        <p><strong>Primary Care Physician:</strong> ${sessionScope.primaryDoctor}</p>
                        <p><strong>Last Visit:</strong> August 12, 2023</p>
                    </div>
                </div>
            </div>
            
            <!-- Appointments Section -->
<div class="appointments-section" id="appointments-section">
    <h2 class="section-title"><i class="fas fa-calendar-check"></i> My Appointments</h2>
    
    <!-- Refresh button -->
    <div style="margin-bottom: 20px;">
        <button class="btn btn-primary" onclick="refreshAppointments()">
            <i class="fas fa-sync-alt"></i> Refresh Appointments
        </button>
    </div>
    
    <%
        List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
        String error = (String) request.getAttribute("error");
        String deleteSuccess = (String) request.getAttribute("deleteSuccess");
        
        if (error != null) {
    %>
        <div class="error-message" style="color: red; margin-bottom: 20px; padding: 15px; background: #ffe6e6; border-radius: 5px;">
            <i class="fas fa-exclamation-triangle"></i> <%= error %>
        </div>
    <%
        }
        
        if (deleteSuccess != null) {
    %>
        <div class="success-message" style="color: green; margin-bottom: 20px; padding: 15px; background: #e6ffe6; border-radius: 5px;">
            <i class="fas fa-check-circle"></i> <%= deleteSuccess %>
        </div>
    <%
        }
        
        if (appointments == null) {
            // First time loading the section - show loading state
    %>
        <div style="text-align: center; padding: 40px;">
            <p>Click "Refresh Appointments" to load your appointments</p>
        </div>
    <%
        } else if (appointments.isEmpty()) {
    %>
        <div class="no-appointments" style="text-align: center; padding: 40px;">
            <i class="fas fa-calendar-times" style="font-size: 48px; color: #ccc; margin-bottom: 15px;"></i>
            <h3 style="color: #666;">No Appointments Found</h3>
            <p style="color: #888;">You haven't booked any appointments yet.</p>
            <button class="btn btn-primary" onclick="showSection('book-appointment')">
                <i class="fas fa-calendar-plus"></i> Book Your First Appointment
            </button>
        </div>
    <%
        } else {
    %>
        <div class="appointments-table">
            <table style="width: 100%; border-collapse: collapse; background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                <thead style="background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%); color: white;">
                    <tr>
                        <th style="padding: 15px; text-align: left;">Doctor</th>
                        <th style="padding: 15px; text-align: left;">Specialization</th>
                        <th style="padding: 15px; text-align: left;">Date</th>
                        <th style="padding: 15px; text-align: left;">Time</th>
                        <th style="padding: 15px; text-align: left;">Status</th>
                        <th style="padding: 15px; text-align: center;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Appointment appt : appointments) {
                            // Format the date
                            java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("EEE, MMM d, yyyy");
                            String formattedDate = dateFormat.format(appt.getAppointmentDate());
                            
                            // Format the time
                            String time = appt.getAppointmentTime();
                            String formattedTime = time;
                            if (time != null && time.contains(":")) {
                                try {
                                    String[] timeParts = time.split(":");
                                    int hour = Integer.parseInt(timeParts[0]);
                                    String period = hour >= 12 ? "PM" : "AM";
                                    hour = hour > 12 ? hour - 12 : hour;
                                    hour = hour == 0 ? 12 : hour;
                                    formattedTime = hour + ":" + timeParts[1] + " " + period;
                                } catch (Exception e) {
                                    // If parsing fails, use original time
                                }
                            }
                    %>
                    <tr style="border-bottom: 1px solid #eee; transition: background 0.3s;">
                        <td style="padding: 15px;">
                            <strong style="color: #1A4DB3;"><%= appt.getDoctorName() %></strong>
                        </td>
                        <td style="padding: 15px; color: #555;"><%= appt.getSpecialization() %></td>
                        <td style="padding: 15px; color: #555;"><%= formattedDate %></td>
                        <td style="padding: 15px; color: #555;"><%= formattedTime %></td>
                        <td style="padding: 15px;">
                            <span class="status-badge" style="background: #2de0bc; color: white; padding: 5px 15px; border-radius: 20px; font-size: 12px; font-weight: 500;">
                                Confirmed
                            </span>
                        </td>
                        <td style="padding: 15px; text-align: center;">
                            <button class="btn btn-danger" onclick="deleteAppointment(<%= appt.getId() %>, '<%= appt.getDoctorName() %>', '<%= formattedDate %>', '<%= formattedTime %>')" 
                                    style="background: #ff4757; color: white; border: none; padding: 8px 12px; border-radius: 4px; cursor: pointer; font-size: 12px;">
                                <i class="fas fa-trash"></i> Delete
                            </button>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            
            <div style="margin-top: 15px; color: #666; font-size: 14px; text-align: center;">
                <i class="fas fa-info-circle"></i> Showing <%= appointments.size() %> appointment(s)
            </div>
        </div>
    <%
        }
    %>
</div>
            
        <!-- Book Appointment Section -->
         <div class="book-appointment-section" id="book-appointment-section" >
         <h2 class="section-title"><i class="fas fa-calendar-plus"></i> Book Appointment</h2>
                <div class="doctor-table-container" id="doctor-table-section">
        <h3 style="color: #1A4DB3; margin-bottom: 15px;">Available Doctors</h3>
        <table class="doctor-table">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Specialization</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="doctor-list">
                <tr>
                    <td>Dr. Sathish</td>
                    <td>Cardiologist</td>
                    <td><button class="btn btn-primary" onclick="bookAppointment('Dr. Sathish', 'Cardiologist')">Book</button></td>
                </tr>
                <tr>
                    <td>Dr. Shilpa</td>
                    <td>Radiologist</td>
                    <td><button class="btn btn-primary" onclick="bookAppointment('Dr. Shilpa', 'Radiologist')">Book</button></td>
                </tr>
                <tr>
                    <td>Dr. Teju</td>
                    <td>Psychiatrist</td>
                    <td><button class="btn btn-primary" onclick="bookAppointment('Dr. Teju', 'Psychiatrist')">Book</button></td>
                </tr>
                <tr>
                    <td>Dr. Nilah</td>
                    <td>Neurologist</td>
                    <td><button class="btn btn-primary" onclick="bookAppointment('Dr. Nilah', 'Neurologist')">Book</button></td>
                </tr>
            </tbody>
        </table>
    </div>
    </div>

    <!-- Appointment Form -->
    <div class="appointment-form hidden" id="appointment-form-section">
        <h3 style="color: #1A4DB3; margin-bottom: 15px;">Book Appointment with <span id="selected-doctor"></span></h3>
        <form id="appointment-form"  action="bookAppointment" method="post">
            <input type="hidden" id="doctor-name" name="doctorName">
            <input type="hidden" id="doctor-specialization" name="specialization">
           <div class="form-group">
            <label for="date">Select Date:</label>
            <input type="date" id="date" name="appointmentDate" required>
          </div>
            
            <div class="form-group">
                <label for="time">Select Time:</label><br>
                <select id="time" name="appointmentTime" required>
                    <option value="">Select Time</option>
                    <option value="09:00">9:00 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="14:00">2:00 PM</option>
                    <option value="15:00">3:00 PM</option>
                    <option value="16:00">4:00 PM</option>
                </select>
            </div>
            <br>
            <button type="submit" class="btn btn-primary" onclick="showConfirmationBox()">Confirm Appointment</button>
        </form>
    </div>

    <!-- Confirmation Box -->
<div class="confirmation-box hidden" 
     id="confirmation-section">
    <h3 style="color: #1A4DB3; margin-bottom: 15px;">Appointment Confirmed!</h3>
    <p><strong>Doctor:</strong> <%= request.getAttribute("doctorName") %></p>
    <p><strong>Specialization:</strong> <%= request.getAttribute("specialization") %></p>
    <p><strong>Date:</strong> <%= request.getAttribute("appointmentDate") %></p>
    <p><strong>Time:</strong> <%= request.getAttribute("appointmentTime") %></p>
    <button class="btn btn-primary" onclick="backToDoctors()">Go Back</button>
</div>
    

    <!-- Logout Confirmation Modal -->
    <div class="logout-confirm" id="logout-confirm">
        <div class="logout-modal">
            <h3>Confirm Logout</h3>
            <p>Are you sure you want to logout from your account?</p>
            <div class="modal-buttons">
                <button class="btn btn-cancel" onclick="cancelLogout()">Cancel</button>
                <button class="btn btn-logout" onclick="logout()">Logout</button>
            </div>
        </div>
    </div>

    <script>
        // Set current date
        const now = new Date();
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        document.getElementById('current-date').textContent = now.toLocaleDateString('en-US', options);
        
        // Show/hide sidenav on mobile
        function toggleSidenav() {
            const sidenav = document.getElementById('sidenav');
            sidenav.classList.toggle('active');
        }
        
        
     // Logout functions
        function confirmLogout() {
        	const logoutModal = document.getElementById("logout-confirm");
            logoutModal.style.display = "flex";
        }
        
        function cancelLogout() {
            document.getElementById('logout-confirm').style.display = 'none';
        }
        
        function logout() {
            //alert('Logging out...');
            // In a real application, this would redirect to logout URL
            window.location.href = 'index.html';
        }
        
        
     // Function to refresh appointments
        function refreshAppointments() {
            window.location.href = 'myAppointments?section=appointments';
        }

        
        // Show selected section
        function showSection(section) {
            // Hide all sections
            document.getElementById('profile-section').style.display = 'none';
            document.getElementById('appointments-section').style.display = 'none';
            document.getElementById('book-appointment-section').style.display = 'none';
            
            // Remove active class from all links
            const links = document.querySelectorAll('.sidenav-menu a');
            links.forEach(link => link.classList.remove('active'));
            
            // Show selected section and set active link
            if (section === 'profile') {
                document.getElementById('profile-section').style.display = 'block';
                links[0].classList.add('active');
            } else if (section === 'appointments') {
                document.getElementById('appointments-section').style.display = 'block';
                links[1].classList.add('active');
                // Auto-refresh appointments when section is shown
                //refreshAppointments();
            } else if (section === 'book-appointment') {
                document.getElementById('book-appointment-section').style.display = 'block';
                links[2].classList.add('active');
            }
            
            // On mobile, hide sidenav after selection
            if (window.innerWidth <= 768) {
                document.getElementById('sidenav').classList.remove('active');
            }
        }
        
        
     // Function to delete appointment with confirmation
        function deleteAppointment(appointmentId, doctorName, date, time) {
            if (confirm(`Are you sure you want to delete your appointment with ${doctorName} on ${date} at ${time}?`)) {
                // Show loading state
                const deleteBtn = event.target;
                const originalText = deleteBtn.innerHTML;
                deleteBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Deleting...';
                deleteBtn.disabled = true;
                
                // Create form to submit delete request
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'deleteAppointment';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'appointmentId';
                input.value = appointmentId;
                
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }

        // Function to refresh appointments
        function refreshAppointments() {
            window.location.href = 'myAppointments';
        }
        
        
    

    
       
     
        // Form submission
        //document.getElementById('appointment-form').addEventListener('submit', function(e) {
            //e.preventDefault();
            //alert('Appointment booking request submitted!');
        //});
            // In a real application, this would send data to the server
        
        
        
        
        //book appointment
        
         function bookAppointment(name, specialization) {
            document.getElementById('doctor-table-section').classList.add('hidden');
            document.getElementById('appointment-form-section').classList.remove('hidden');
            document.getElementById('selected-doctor').innerText = name;
            document.getElementById('doctor-name').value = name;
            document.getElementById('doctor-specialization').value = specialization;
        }

        //conform appointment
    function confirmAppointment(event) {
    

    const form = document.getElementById('appointment-form');
    const formData = new FormData(form);

    fetch('bookAppointment', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(data => {
        
        document.getElementById('appointment-form-section').classList.add('hidden');
        document.getElementById('confirmation-section').classList.remove('hidden');

        document.getElementById('conf-doctor').textContent = formData.get('doctorName');
        document.getElementById('conf-specialization').textContent = formData.get('specialization');
        document.getElementById('conf-date').textContent = formData.get('appointmentDate');
        document.getElementById('conf-time').textContent = formData.get('appointmentTime');
    })
    .catch(error => console.error('Error:', error));
}
        
        
    function showConfirmationBox() {
        // hide doctor table & form
        document.getElementById('doctor-table-section').classList.add('hidden');
        

        // show confirmation box
        document.getElementById('confirmation-section').classList.remove('hidden');
        
        

        // fill details from form fields
        document.getElementById('confirm-doctor').innerText = document.getElementById('doctor-name').value;
        document.getElementById('confirm-specialization').innerText = document.getElementById('doctor-specialization').value;
        document.getElementById('confirm-date').innerText = document.getElementById('appointment-date').value;
        document.getElementById('confirm-time').innerText = document.getElementById('appointment-time').value;
    }



        function backToDoctors() {
            document.getElementById('confirmation-section').classList.add('hidden');
            document.getElementById('doctor-table-section').classList.remove('hidden');
        }
    </script>
</body>
</html>