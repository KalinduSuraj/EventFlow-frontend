<%--
  Created by IntelliJ IDEA.
  User: gavee liyanage
  Date: 13-Jan-25
  Time: 2:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*, java.io.*" %>
<%@ page import="org.json.JSONObject" %>
<%
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Create New Interview</title>
</head>
<body class="bg-white flex items-center justify-center min-h-screen">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md fixed top-0 w-full z-10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <!-- Left Nav -->
            <div class="flex-shrink-0 flex items-center space-x-4">
                <a href="teacher_dashboard.jsp"
                   class="text-gray-600 hover:text-white px-3 py-2
                  <%= request.getRequestURI().contains("teacher_dashboard.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
                    Workshop
                </a>
                <a href="teacher_interview.jsp"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2
                  <%= request.getRequestURI().contains("teacher_interview.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
                    Interview
                </a>
                <a href="teacher_announcement.jsp"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2
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

<!-- Form Box -->
<div class="bg-blue-200 shadow-lg rounded-lg p-8 max-w-md w-full mt-16">
    <h2 class="text-2xl font-bold text-center mb-4 py-3">Create New Interview</h2>

    <!-- Response Message -->
    <div id="responseMessage" class="text-center text-sm mb-4"></div>

    <form id="interviewForm" action="/interview" method="post" class="space-y-3">
        <div>
            <label for="title" class="block text-sm font-medium text-gray-700 py-2">Interview Title</label>
            <input type="text" id="title" name="title" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3" placeholder="Interview for Web Developer" required>
        </div>

        <div>
            <label for="description" class="block text-sm font-medium text-gray-700 py-2">Description</label>
            <textarea id="description" name="description" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3" placeholder="Conducting interviews for the Web Developer role." required></textarea>
        </div>

        <div>
            <label for="startDateTime" class="block text-sm font-medium text-gray-700 py-2">Start Date & Time</label>
            <input type="datetime-local" id="startDateTime" name="startDateTime" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3" required>
        </div>

        <input type="hidden" name="createdBy" value="<%= request.getParameter("createdBy") %>"/>

        <!-- Buttons Section -->
        <div class="space-y-10">
            <div class="flex space-x-4">
                <button type="submit" class="w-1/2 bg-blue-700 text-white py-2 px-4 rounded-lg hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                    Save
                </button>

                <a href="manage_interview.jsp"
                   class="w-1/2 bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 text-center">
                    Cancel
                </a>
            </div>
        </div>
    </form>
</div>

<script>
    document.getElementById('interviewForm').addEventListener('submit', async (event) => {
        // Prevent default form submission
        event.preventDefault();

        const form = document.getElementById('interviewForm');
        const formData = new FormData(form);
        const data = Object.fromEntries(formData.entries());

        try {
            const response = await fetch('/interview', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data),
            });

            const result = await response.json();

            const responseMessage = document.getElementById('responseMessage');
            if (response.ok) {
                responseMessage.textContent = result.message;
                responseMessage.className = 'text-green-500';
            } else {
                responseMessage.textContent = result.message || 'An error occurred.';
                responseMessage.className = 'text-red-500';
            }
        } catch (error) {
            const responseMessage = document.getElementById('responseMessage');
            responseMessage.textContent = 'Failed to connect to the server.';
            responseMessage.className = 'text-red-500';
        }
    });
</script>


</body>
</html>


