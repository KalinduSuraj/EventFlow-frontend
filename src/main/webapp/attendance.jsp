<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance</title>
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
                <a href="manage_users.jsp" class="text-gray-600 hover:text-white px-3 py-2 px-4 <%=request.getRequestURI().contains("manage_users.jsp") ? "bg-sky-700 text-white rounded" :""%>"> Manage Users</a>
                <a href="admin_dashboard.jsp" class="text-gray-600 hover:text-white px-3 py-2 px-4 <%=request.getRequestURI().contains("admin_dashboard.jsp") ? "bg-sky-700 text-white rounded" :""%>"> Home</a>
            </div>

            <!-- Right Nav -->
            <div class="flex items-center">
                <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2">EventFlow</a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="max-w-6xl mx-auto text-center py-12">
    <h1 class="text-4xl mb-8 text-sky-900 font-semibold font-sans">Attendance Mark</h1>

    <!-- Attendance Form -->
    <form action="attendance" method="POST" class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
        <input type="hidden" name="action" value="markAttendance" />
        <div class="mb-4">
            <label for="eventId" class="block text-gray-700 text-sm font-bold mb-2">Event ID</label>
            <input type="number" id="eventId" name="eventId" placeholder="Enter Event ID"
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="mb-4">
            <label for="studentId" class="block text-gray-700 text-sm font-bold mb-2">Student ID</label>
            <input type="number" id="studentId" name="students" placeholder="Enter Student ID"
                   class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
        </div>
        <div class="flex items-center justify-between">
            <button type="submit" class="bg-sky-700 hover:bg-sky-800 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">
                Add
            </button>
        </div>
    </form>
</div>

</body>
</html>
