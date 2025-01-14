<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*, java.io.*" %>
<%@ page import="org.json.JSONObject" %>
<%
    Integer eID = Integer.parseInt(request.getParameter("eID"));
    String message = (String) request.getAttribute("message");
    Integer responseCode = (Integer) request.getAttribute("responseCode");
    JSONObject event = (JSONObject) request.getAttribute("event");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Update Workshop</title>
</head>
<body class="bg-white flex items-center justify-center min-h-screen">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md fixed top-0 w-full z-10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
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

            <div class="flex items-center">
                <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2"> EventFlow </a>
            </div>
        </div>
    </div>
</nav>

<!-- Form Box -->
<div class="bg-blue-200 shadow-lg rounded-lg p-8 max-w-md w-full mt-16">
    <h2 class="text-2xl font-bold text-center mb-4 py-3">Update Workshop</h2>

    <!-- Response Message -->
    <% if (message != null) { %>
    <div id="responseMessage" class="text-center
            <%= responseCode == 200 ? "text-green-500" : responseCode == 400 ? "text-red-500" : responseCode == 404 ? "text-yellow-500" : "text-gray-500" %> text-sm mb-4">
        <%= message %>
    </div>
    <% } %>

    <form id="updateWorkshopForm" action="/event/<%= eID %>" method="post" class="space-y-3">
        <input type="hidden" name="_method" value="PUT">

        <div>
            <label for="title" class="block text-sm font-medium text-gray-700 py-2">Workshop Title</label>
            <input type="text" id="title" name="title" value="<%= event.optString("title") %>"
                   class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3"
                   required>
        </div>

        <div>
            <label for="description" class="block text-sm font-medium text-gray-700 py-2">Description</label>
            <textarea id="description" name="description"
                      class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3"
                      required><%= event.optString("description") %></textarea>
        </div>

        <div>
            <label for="startDateTime" class="block text-sm font-medium text-gray-700 py-2">Start Date & Time</label>
            <input type="datetime-local" id="startDateTime" name="scheduled_datetime"
                   value="<%= event.optString("scheduled_datetime") %>"
                   class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3"
                   required>
        </div>

        <input type="hidden" name="is_active" value="true">

        <!-- Buttons Section -->
        <div class="space-y-10">
            <div class="flex space-x-4">
                <button type="submit" class="w-1/2 bg-blue-700 text-white py-2 px-4 rounded-lg hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                    Update
                </button>

                <a href="manage_workshop.jsp"
                   class="w-1/2 bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 text-center">
                    Cancel
                </a>
            </div>
        </div>
    </form>
</div>

</body>
</html>