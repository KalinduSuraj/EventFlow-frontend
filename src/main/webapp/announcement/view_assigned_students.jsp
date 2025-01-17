<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assigned Students</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-blue-50 text-gray-800">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <!-- Left Nav -->
            <div class="flex-shrink-0 flex items-center space-x-4">

                <a href="#"
                   onclick="window.location.href='display_workshop?type=workshop'"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
                        <%= request.getRequestURI().contains("display_workshop?type=workshop") ? "bg-sky-700 text-white rounded" : "" %>">
                    Workshop
                </a>

                <a href="#"
                   onclick="window.location.href='display_interview?type=interview'"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
                      <%= request.getRequestURI().contains("display_interview?type=interview") ? "bg-sky-700 text-white rounded" : "" %>">
                    Interview
                </a>

                <a href="#"
                   onclick="window.location.href='viewAnnouncement?'"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
                      <%= request.getRequestURI().contains("viewAnnouncement?") ? "bg-sky-700 text-white rounded" : "" %>">
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

<div class="container mx-auto p-6">
    <div class="mb-6 py-5">
        <h1 class="text-3xl font-semibold text-gray-800 text-center">Students Assigned to Announcement</h1>
    </div>
    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="bg-red-100 text-red-800 px-4 py-3 rounded mb-4">${error}</div>
    </c:if>

    <!-- Students Table -->
    <c:if test="${not empty students}">
        <table class="min-w-full table-auto bg-white border-collapse shadow-lg rounded-lg">
            <thead class="bg-blue-200 text-gray-700">
            <tr>
                <th class="px-6 py-4 text-left">#</th>
                <th class="px-6 py-4 text-left">Student ID</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="student" items="${students}" varStatus="status">
                <tr class="bg-white hover:bg-gray-50">
                    <td class="px-6 py-4 text-sm font-medium text-gray-800">${status.index + 1}</td>
                    <td class="px-6 py-4 text-sm text-gray-600">${student}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>

    <!-- Message if no students are assigned -->
    <c:if test="${empty students}">
        <p class="text-center text-gray-600">No students are assigned to this announcement.</p>
    </c:if>
</div>

</body>
</html>
