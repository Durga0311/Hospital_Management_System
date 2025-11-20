<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Care - Doctor Registered Successfully</title>
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
            background-image: url('Home.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            min-height: 100vh;
        }

        /* Animated gradient overlay */
        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(26, 77, 179, 0.85) 0%, rgba(45, 224, 188, 0.85) 100%);
            z-index: -1;
            animation: gradientShift 15s ease infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Navbar Styles */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 0 5%;
            height: 13vh;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 1000;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(10px);
        }
        
        .logo {
            font-family: 'Arial', sans-serif;
            font-weight: bold;
            font-size: 28px;
            color: #1A4DB3;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 10px;
            transition: transform 0.3s ease;
        }
        
        .logo:hover {
            transform: scale(1.03);
        }
        
        .logo img {
            height: 65px;
            transition: all 0.3s ease;
        }
        
        .nav-links {
            display: flex;
            align-items: center;
            transition: right 0.4s ease;
        }
        
        .nav-links a:not(.login) {
            color: #1A4DB3;
            padding: 14px 20px;
            text-decoration: none;
            text-align: center;
            font-size: 18px;
            font-weight: 500;
            position: relative;
            transition: all 0.3s ease;
        }
        
        .nav-links a:not(.login)::after {
            content: "";
            position: absolute;
            left: 50%;
            bottom: 5px;
            width: 0;
            height: 2px;
            background-color: #2de0bc;
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }
        
        .nav-links a:not(.login):hover {
            color: #2de0bc;
            transform: translateY(-2px);
        }

        .nav-links a:not(.login):hover::after {
            width: 70%;
        }
        
        .login {
            border-radius: 40px;
            background-color: #2de0bc;
            color: white;
            padding: 12px 25px;
            text-decoration: none;
            text-align: center;
            font-size: 18px;
            font-weight: 500;
            margin-left: 15px;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 4px 10px rgba(45, 224, 188, 0.3);
        }
        
        .login:hover {
            background-color: #1fd4b0;
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 6px 15px rgba(45, 224, 188, 0.4);
        }
        
        .hamburger {
            display: none;
            cursor: pointer;
            flex-direction: column;
            justify-content: space-around;
            width: 30px;
            height: 25px;
            z-index: 1001;
        }
        
        .hamburger div {
            width: 30px;
            height: 3px;
            background-color: #1A4DB3;
            border-radius: 3px;
            transition: all 0.3s ease;
        }

        /* Hamburger animation */
        .hamburger.active div:nth-child(1) {
            transform: rotate(45deg) translate(5px, 8px);
        }

        .hamburger.active div:nth-child(2) {
            opacity: 0;
        }

        .hamburger.active div:nth-child(3) {
            transform: rotate(-45deg) translate(5px, -8px);
        }

        /* Success Dialog Styles */
        .success-container {
            max-width: 500px;
            margin: 150px auto 50px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            backdrop-filter: blur(10px);
            animation: formAppear 0.8s ease-out forwards;
            opacity: 0;
            transform: translateY(20px);
            text-align: center;
        }

        @keyframes formAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.25);
        }
        
        .success-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .success-header h1 {
            color: #1A4DB3;
            font-size: 2.2rem;
            margin-bottom: 10px;
            position: relative;
            display: inline-block;
        }
        
        .success-header h1::after {
            content: "";
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 60px;
            height: 4px;
            background-color: #2de0bc;
            border-radius: 2px;
        }
        
        .success-icon {
            font-size: 80px;
            color: #2de0bc;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        .success-message {
            color: #666;
            margin-top: 15px;
            font-size: 18px;
            line-height: 1.6;
        }
        
        .success-details {
            background: rgba(26, 77, 179, 0.05);
            border-radius: 10px;
            padding: 20px;
            margin: 25px 0;
            text-align: left;
            border-left: 4px solid #2de0bc;
        }
        
        .success-details h3 {
            color: #1A4DB3;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }
        
        .success-details p {
            margin-bottom: 10px;
            color: #555;
        }
        
        .success-details strong {
            color: #1A4DB3;
        }
        
        .btn-home {
            display: inline-block;
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #1A4DB3 0%, #2de0bc 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 5px 15px rgba(26, 77, 179, 0.3);
            position: relative;
            overflow: hidden;
            text-decoration: none;
            text-align: center;
        }
        
        .btn-home::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: 0.5s;
        }
        
        .btn-home:hover::before {
            left: 100%;
        }
        
        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(26, 77, 179, 0.4);
        }
        
        .btn-home:active {
            transform: translateY(0);
            box-shadow: 0 3px 10px rgba(26, 77, 179, 0.3);
        }
        
        .next-steps {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e1e5eb;
        }
        
        .next-steps h3 {
            color: #1A4DB3;
            margin-bottom: 15px;
            font-size: 1.2rem;
        }
        
        .next-steps ul {
            text-align: left;
            color: #666;
            margin-left: 20px;
            margin-bottom: 20px;
        }
        
        .next-steps li {
            margin-bottom: 8px;
        }
        
        /* Responsive Styles */
        @media (max-width: 992px) {
            .nav-links a:not(.login) {
                padding: 14px 15px;
                font-size: 17px;
            }
            
            .login {
                padding: 10px 20px;
                font-size: 17px;
            }
        }
        
        @media (max-width: 768px) {
            .hamburger {
                display: flex;
            }
            
            .nav-links {
                position: fixed;
                top: 13vh;
                right: -100%;
                height: 87vh;
                background: rgba(255, 255, 255, 0.98);
                flex-direction: column;
                width: 70%;
                align-items: center;
                justify-content: flex-start;
                padding-top: 50px;
                box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
                backdrop-filter: blur(10px);
            }
            
            .nav-links.active {
                right: 0;
            }
            
            .nav-links a:not(.login) {
                margin: 15px 0;
                font-size: 20px;
            }
            
            .success-container {
                margin: 130px 20px 40px;
                padding: 30px;
            }
        }
        
        @media (max-width: 576px) {
            .logo {
                font-size: 22px;
            }
            
            .logo img {
                height: 55px;
            }
            
            .success-container {
                padding: 25px 20px;
            }
            
            .success-header h1 {
                font-size: 1.8rem;
            }
            
            .success-icon {
                font-size: 60px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar">
        <div class="logo">
            <img src="logo.png" alt="Medical Care Logo">Medical Care
        </div>
        <div class="nav-links">
            <a href="index.html">Home</a>
            <a href="index.html#features">Services</a>
            <a href="index.html">About</a>
            <a href="index.html#contact">Contact Us</a>
            <a href="index.html" class="login">Login</a>
        </div>
        <div class="hamburger" id="hamburger">
            <div></div>
            <div></div>
            <div></div>
        </div>
    </nav>

    <!-- Success Dialog -->
    <div class="success-container">
        <div class="success-header">
            <div class="success-icon">
                <i class="fas fa-check-circle"></i>
            </div>
            <h1> Registered Successfully!</h1>
            <p class="success-message">Thank you for joining Medical Care as a healthcare professional. Your registration has been completed successfully.</p>
        </div>
        
        
        
        
        
        <a href="index.html" class="btn-home">
            <span>Back to Home</span>
        </a>
    </div>

    <script>
        // Mobile Navigation Toggle
        const hamburger = document.getElementById('hamburger');
        const navLinks = document.querySelector('.nav-links');

        hamburger.addEventListener('click', () => {
            navLinks.classList.toggle('active');
            hamburger.classList.toggle('active');
        });

        // Navbar Scroll Effect
        window.addEventListener('scroll', () => {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.style.height = '10vh';
                navbar.style.boxShadow = '0 4px 15px rgba(0, 0, 0, 0.2)';
            } else {
                navbar.style.height = '13vh';
                navbar.style.boxShadow = '0 4px 10px rgba(0, 0, 0, 0.1)';
            }
        });

        
    </script>
</body>
</html>