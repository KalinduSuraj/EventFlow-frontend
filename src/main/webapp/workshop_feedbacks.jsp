<%--
  Created by IntelliJ IDEA.
  User: gavee liyanage
  Date: 1/15/2025
  Time: 12:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Interview List</title>
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
           class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
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

<div class="container mx-auto p-6">
  <div class="mb-6 py-5">
    <h1 class="text-3xl font-semibold text-gray-800 text-center">workshops List</h1>
  </div>

  <table class="min-w-full table-auto bg-white border-collapse shadow-lg rounded-lg pb-3">
    <thead class="bg-blue-200 text-gray-700">
    <tr>
      <th class="px-6 py-4 text-left">Title</th>
      <th class="px-6 py-4 text-left">Description</th>
      <th class="px-6 py-4 text-left">Scheduled Date</th>
      <th class="px-6 py-4 text-left">Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
      List<JSONObject> workshops = (List<JSONObject>) request.getAttribute("workshops");
      if (workshops != null && !workshops.isEmpty()) {
        for (JSONObject workshop : workshops) {
    %>
    <tr class="bg-white hover:bg-gray-50">
      <td class="px-6 py-4 text-sm font-medium text-gray-800"><%= workshop.optString("title", "N/A") %></td>
      <td class="px-6 py-4 text-sm text-gray-600"><%= workshop.optString("description", "N/A") %></td>
      <td class="px-6 py-4 text-sm text-gray-600"><%= workshop.optString("startDateTime", "N/A") %></td>
      <td class="px-6 py-4 text-sm">
        <div class="flex space-x-4">
          <button class="text-green-600 hover:text-green-800 font-medium" onclick="window.location.href='individual_feedback.jsp?id=<%= workshop.optInt("createdBy") %>'"> Select </button>

        </div>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="4" class="px-6 py-4 text-center text-gray-600">No interviews available</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
</body>
</html>

