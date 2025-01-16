<%--
  Created by IntelliJ IDEA.
  User: gavee liyanage
  Date: 1/15/2025
  Time: 12:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: gavee liyanage
  Date: 1/15/2025
  Time: 8:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>
<%@ page import="java.util.List" %>

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
           class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
                          <%= request.getRequestURI().contains("teacher_dashboard.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
          Workshop
        </a>
        <a href="teacher_interview.jsp"
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
    <h1 class="text-3xl font-semibold text-gray-800 text-center">Workshop Participants</h1>
  </div>
  <div class="text-left mb-4 py-5">
    <button class="bg-red-600 text-white font-bold py-2 px-4 rounded hover:bg-red-800"
            onclick="window.location.href='group_feedbacks.jsp'">Create Group Feedbacks
    </button>
  </div>
  <table class="min-w-full table-auto bg-white border-collapse shadow-lg rounded-lg">
    <thead class="bg-blue-200 text-gray-700">
    <tr>
      <th class="px-6 py-4 text-left">Stu Name</th>
      <th class="px-6 py-4 text-left">Email</th>
      <th class="px-6 py-4 text-left">Batch</th>
      <th class="px-6 py-4 text-left">Feedback</th>
      <th class="px-6 py-4 text-left">Points</th>
      <th class="px-6 py-4 text-left">Action</th>
    </tr>
    </thead>
    <tbody>
    <%
      try {
        List<JSONObject> participants = (List<JSONObject>) request.getAttribute("participants");
        if (participants != null && !participants.isEmpty()) {
          for (JSONObject participant : participants) {
    %>
    <tr class="bg-white hover:bg-gray-50">
      <td class="px-6 py-4 text-sm font-medium text-gray-800"><%= participant.optString("stuName", "N/A") %></td>
      <td class="px-6 py-4 text-sm text-gray-600"><%= participant.optString("email", "N/A") %></td>
      <td class="px-6 py-4 text-sm text-gray-600"><%= participant.optString("batch", "N/A") %></td>
      <td class="px-6 py-4 text-sm text-gray-600">
        <input type="text" class="border border-gray-300 rounded w-full px-2 py-1" placeholder="Feedback">
      </td>
      <td class="px-6 py-4 text-sm text-gray-600">
        <input type="number" class="border border-gray-300 rounded w-full px-2 py-1" placeholder="Points">
      </td>
      <td class="px-6 py-4 text-sm">
        <button class="bg-green-600 text-white font-bold py-2 px-4 rounded hover:bg-green-800">
          Submit
        </button>
      </td>
    </tr>
    <%
      }
    } else {
    %>
    <tr>
      <td colspan="6" class="px-6 py-4 text-center text-gray-600">No participants available</td>
    </tr>
    <%
      }
    } catch (Exception e) {
      e.printStackTrace();
    %>
    <tr>
      <td colspan="6" class="px-6 py-4 text-center text-red-600">Error loading participants</td>
    </tr>
    <%
      }
    %>
    </tbody>
  </table>
</div>
</body>
</html>


