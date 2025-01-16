<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>EventsFlow - Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: #fff;
            font-family: Arial, sans-serif;

            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Ensures the body takes the full viewport height */
            margin: 0; /* Removes default margin */
        }
        .container {
            margin-top: 100px;
            text-align: center;
        }
        h1 {
            font-weight: bold;
            margin-bottom: 20px;
        }
        .btn-custom {
            background-color: #fff;
            color: #2575fc;
            border: none;
            font-size: 18px;
            padding: 10px 20px;
            margin: 10px;
            border-radius: 25px;
            transition: 0.3s;
        }
        .btn-custom:hover {
            background-color: #2575fc;
            color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }
        footer {
            background-color: #000;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            font-size: 14px;
            position: sticky;
            bottom: 0;
            width: 100%;
            margin-top: auto;
        }

    </style>
</head>
<body>
<div class="container">
    <h1>Welcome to EventsFlow</h1>
    <p>Your one-stop solution for event management.</p>
    <div>
        <a href="Login.jsp" class="btn btn-custom">Login</a>
        <a href="teacher_dashboard.jsp" class="btn btn-custom">Teacher Dashboard</a>
        <a href="admin_dashboard.jsp" class="btn btn-custom">Admin Dashboard</a>
        <a href="displayStudent" class="btn btn-custom">displayStudent</a><br>
        <a href="displayLecturer" class="btn btn-custom">displayLecturer</a><br>
        <a href="displayAdmin" class="btn btn-custom">displayAdmin</a>
<%--        <a href="admin_dashboard.jsp" class="btn btn-custom">Admin Dashboard</a>--%>
    </div>
</div>
<footer>
    <p>&copy; 2025 EventsFlow. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>