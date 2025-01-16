<%--
  Created by IntelliJ IDEA.
  User: gavee liyanage
  Date: 16-Dec-24
  Time: 10:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Workshop Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-blue-50 text-gray-800">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <!-- Left Nav -->
            <div class="flex-shrink-0 flex items-center space-x-4">

                <a href="teacher_dashboard.jsp"
                   class="text-gray-600 hover:text-white px-3 py-2 px-4
                          <%= request.getRequestURI().contains("teacher_dashboard.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
                    Workshop
                </a>

                <a href="event/teacher_interview.jsp"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
                          <%= request.getRequestURI().contains("teacher_interview.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
                    Interview
                </a>

                <a href="teacher_announcement.jsp"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
                          <%= request.getRequestURI().contains("teacher_announcement.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
                    Announcement
                </a>
            </div>

            <!-- Right Nav -->
            <div class="flex items-center">
                <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2"> EventFlow </a>

                
            </div>
        </div>
    </div>
</nav>


<!-- Main Content -->
<div class="max-w-6xl mx-auto text-center py-12 ">
    <h1 class="text-4xl mb-8 text-sky-900 font-semibold font-sans ">Welcome To EventFlow</h1>

    <!-- Grid Layout -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8 py-4">
        <!-- Manage Card -->
        <div class="ease-in transform hover:scale-110 transition duration-100 bg-blue-200 p-6 rounded-lg shadow-md hover:shadow-lg ">
            <img src="image/workshop.jpeg" alt="workshop" class="w-40 h-32 mx-auto shadow-md mb-4">
            <h3 class="text-lg font-bold text-gray-800">Manage</h3>
            <p class="text-gray-600">Manage Workshops </p>
                <button class="ease-in transform hover:scale-115 transition duration-100 bg-sky-700 hover:bg-sky-500 text-white py-2 px-4 rounded m-6 inline"
                        onclick="window.location.href='display_workshop?type=workshop'">
                View </button>
        </div>

        <!-- Feedback Card -->
        <div class="ease-in transform hover:scale-110 transition duration-100 bg-blue-200 p-6 rounded-lg shadow-md hover:shadow-lg transition">
            <img src="image/feedback.jpg" alt="Feedback" class="w-40 h-32 mx-auto shadow-md mb-4">
            <h3 class="text-lg font-bold text-gray-800"> Feedback </h3>
            <p class="text-gray-600"> Give Feedback & Points </p>
            <button class="ease-in transform hover:scale-115 transition duration-100 bg-sky-700 hover:bg-sky-500 text-white py-2 px-4 rounded m-6 inline">
                View </button>
        </div>

        <!-- Profile Card -->
        <div class="ease-in transform hover:scale-110 transition duration-100 bg-blue-200 p-6 rounded-lg shadow-md hover:shadow-lg transition">
            <img src="image/profile_update.jpeg" alt="Attendance" class="w-40 h-32 mx-auto shadow-md mb-4">
            <h3 class="text-lg font-bold text-gray-800"> Profile Update </h3>
            <p class="text-gray-600"> Edit your profile </p>
            <button class="ease-in transform hover:scale-115 transition duration-100 bg-sky-700 hover:bg-sky-500 text-white py-2 px-4 rounded m-6 inline">
                View </button>
        </div>
    </div>
</div>

</body>
</html>

