<%--
  Created by IntelliJ IDEA.
  User: gavee liyanage
  Date: 1/14/2025
  Time: 2:57 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*, java.io.*" %>

<%
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Announcement</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-blue-50 p-6">
<div class="max-w-xl mx-auto bg-blue-200 shadow-lg  p-6">
    <h1 class="text-2xl font-bold mb-4 text-center">Create Announcement</h1>
    <form action="/addAnnouncement" method="POST">
        <div class="mb-4">
            <label for="subject" class="block font-medium">Subject</label>
            <input type="text" id="subject" name="subject" class="w-full border rounded px-4 py-3" required>
        </div>
        <div class="mb-4">
            <label for="message" class="block font-medium">Message</label>
            <textarea id="message" name="message" rows="4" class="w-full border rounded px-4 py-3" required></textarea>
        </div>
        <div class="mb-4">
            <label for="createdBy" class="block font-medium">Created By</label>
            <input type="number" id="createdBy" name="createdBy" class="w-full border rounded px-4 py-3" required>
        </div>
        <div class="mb-4">
            <label for="batchIds" class="block font-medium">Batch IDs (Comma Separated)</label>
            <input type="text" id="batchIds" name="batchIds" class="w-full border rounded px-4 py-3">
        </div>
        <div class="mb-4">
            <label for="studentIds" class="block font-medium">Student IDs (Comma Separated)</label>
            <input type="text" id="studentIds" name="studentIds" class="w-full border rounded px-4 py-3">
        </div>
        <div>
            <button type="submit" class="w-1/2 bg-blue-700 text-white py-2 px-4 rounded-lg hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                Add Announcement
            </button>
            <a href="/displayAnnouncements" class="w-1/2 bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 text-center">
                Cancel
            </a>
        </div>
    </form>
    <c:if test="${not empty message}">
        <div class="mt-4 text-red-500">${message}</div>
    </c:if>
</div>
</body>
</html>
</body>
</html>

