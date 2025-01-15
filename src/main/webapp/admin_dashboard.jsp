<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <!-- Left Nav -->
            <div class="flex-shrink-0 flex items-center space-x-4">
                <a href="admin_dashboard.jsp" class="text-gray-600 hover:text-white px-3 py-2 px-4 <%=request.getRequestURI().contains("admin_dashboard.jsp") ? "bg-sky-700 text-white rounded" :""%>"> Home</a>

            </div>

            <!-- Right Nav -->
            <div class="flex items-center">
                <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2">EventFlow</a>
                <a href="update_profile.jsp" class="flex items-center cursor-pointer">
                    <img src="image/profile1.jpg" alt="Profile" class="w-10 h-10 rounded-full border-2 border-sky-500 hover:border-sky-500 hover:border-sky-700">
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="max-w-6xl mx-auto text-center py-12">
    <h1 class="text-4xl mb-8 text-sky-900 font-semibold font-sans">Welcome To EventFlow</h1>

    <!-- Grid Layout -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-8 py-4">
        <!-- Manage Card -->
        <div class="ease-in transform hover:scale-110 transition duration-100 bg-blue-200 p-6 rounded-lg shadow-md hover:shadow-lg">
            <img src="image/users.jpg" alt="user image" class="w-40 h-32 mx-auto shadow-md mb-4">
            <h3 class="text-lg font-bold text-gray-800">Manage Users</h3>
            <p class="text-gray-600">Manage user Information</p>
            <a href="manage_users.jsp">
            <button class="ease-in transform hover:scale-115 transition duration-100 bg-sky-700 hover:bg-sky-500 text-white py-2 px-4 rounded m-6 inline">
                View
            </button>
            </a>
        </div>

        <!-- Batches Card -->
        <div class="ease-in transform hover:scale-110 transition duration-100 bg-blue-200 p-6 rounded-lg shadow-md hover:shadow-lg transition">
            <img src="image/batches.jpg" alt="batch image" class="w-40 h-32 mx-auto shadow-md mb-4">
            <h3 class="text-lg font-bold text-gray-800">Create Batches</h3>
            <p class="text-gray-600">Create batches, Assign students & Assign teachers</p>
            <a href="displayBatch.jsp">
            <button class="ease-in transform hover:scale-115 transition duration-100 bg-sky-700 hover:bg-sky-500 text-white py-2 px-4 rounded m-6 inline">
                View
            </button>
            </a>
        </div>

        <!-- Attendance Card -->
        <div class="ease-in transform hover:scale-110 transition duration-100 bg-blue-200 p-6 rounded-lg shadow-md hover:shadow-lg transition">
            <img src="image/attendance.jpg" alt="Attendance" class="w-40 h-32 mx-auto shadow-md mb-4">
            <h3 class="text-lg font-bold text-gray-800">Attendance</h3>
            <p class="text-gray-600">Marks attendance for participated events</p>
            <a href="attendance.jsp">
            <button class="ease-in transform hover:scale-115 transition duration-100 bg-sky-700 hover:bg-sky-500 text-white py-2 px-4 rounded m-6 inline">
                View
            </button>
            </a>
        </div>
    </div>
</div>

<!-- API Call Example -->
<!--<script>
    document.addEventListener('DOMContentLoaded', function () {
        fetch('https://api.example.com/data') // Replace with your API endpoint
            .then(response => response.json())
            .then(data => {
                console.log('API Response:', data);
                // You can dynamically update UI here based on API data
            })
            .catch(error => console.error('Error fetching data:', error));
    });
</script>-->
</body>
</html>
