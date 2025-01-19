<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*, java.io.*" %>
<%@ page import="com.example.eventflowfrontend.DTO.AnnouncementDTO" %>
<%
    Integer aID = Integer.parseInt(request.getParameter("aID"));
    String message = (String) request.getAttribute("message");
    Integer responseCode = (Integer) request.getAttribute("responseCode");
    AnnouncementDTO announcement = (AnnouncementDTO) request.getAttribute("announcement");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Update Announcement</title>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">

<!-- Form Container -->
<div class="bg-white shadow-md rounded-lg p-8 max-w-lg w-full">
    <h1 class="text-2xl font-bold text-gray-800 mb-4 text-center">Update Announcement</h1>

    <!-- Response Message -->
    <% if (message != null) { %>
    <div id="responseMessage" class="text-center
            <%= responseCode == 200 ? "text-green-500" : responseCode == 400 ? "text-red-500" : "text-gray-500" %> text-sm mb-4">
        <%= message %>
    </div>
    <% } %>

    <form action="/updateAnnouncement" method="post" class="space-y-4">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="aID" value="<%= announcement.getAID() %>">

        <div>
            <label for="subject" class="block text-sm font-medium text-gray-700">Subject</label>
            <input type="text" id="subject" name="subject" value="<%= announcement.getSubject() %>"
                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-2 px-3"
                   required>
        </div>

        <div>
            <label for="message" class="block text-sm font-medium text-gray-700">Message</label>
            <textarea id="message" name="message" rows="5"
                      class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-2 px-3"
                      required><%= announcement.getMessage() %></textarea>
        </div>

        <div>
            <label for="batchIds" class="block text-sm font-medium text-gray-700">Batches</label>
            <select id="batchIds" name="batchIds" multiple
                    class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-2 px-3">
                <% for (Integer batch : announcement.getBatches()) { %>
                <option value="<%= batch %>" selected><%= batch %></option>
                <% } %>
                <!-- Additional options -->
                <option value="100">Batch 100</option>
                <option value="101">Batch 101</option>
            </select>
        </div>

        <div>
            <label for="studentIds" class="block text-sm font-medium text-gray-700">Students</label>
            <select id="studentIds" name="studentIds" multiple
                    class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-2 px-3">
                <% for (Integer student : announcement.getStudents()) { %>
                <option value="<%= student %>" selected><%= student %></option>
                <% } %>
                <!-- Additional options -->
                <option value="200">Student 200</option>
                <option value="201">Student 201</option>
            </select>
        </div>

        <div>
            <label for="createdBy" class="block text-sm font-medium text-gray-700">Created By</label>
            <input type="number" id="createdBy" name="createdBy" value="<%= announcement.getCreatedBy() %>"
                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-2 px-3"
                   readonly>
        </div>

        <!-- Buttons -->
        <div class="flex justify-between">
            <button type="submit" class="bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                Update
            </button>
            <a href="/displayAnnouncements"
               class="bg-gray-500 text-white py-2 px-4 rounded-md hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2">
                Cancel
            </a>
        </div>
    </form>
</div>

</body>
</html>
