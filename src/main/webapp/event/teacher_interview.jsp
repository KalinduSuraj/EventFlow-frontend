<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.eventflowfrontend.DTO.EventDTO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Interview Page</title>
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

                <a href="teacher_announcement.jsp" class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4 <%= request.getRequestURI().contains("teacher_announcement.jsp") ? "bg-sky-700 text-white rounded" : "" %>">Announcement</a>
            </div>

            <!-- Right Nav -->
            <div class="flex items-center">
                <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2">EventFlow</a>
            </div>
        </div>
    </div>
</nav>

<div class="container mx-auto p-6">
    <div class="mb-6 py-5">
        <h1 class="text-3xl font-semibold text-gray-800 text-center">Interview List</h1>
    </div>
    <div class="text-left mb-4 py-5">
        <button class="bg-red-600 text-white font-bold py-2 px-4 rounded hover:bg-red-800"
                onclick="window.location.href='addInterview?createdBy=10'">Create Interview
        </button>
    </div>
    <table class="min-w-full table-auto bg-white border-collapse shadow-lg rounded-lg pb-3">
        <thead class="bg-blue-200 text-gray-700">
        <tr>
            <th class="px-6 py-4 text-left">Title</th>
            <th class="px-6 py-4 text-left">Description</th>
            <th class="px-6 py-4 text-left">Start Date</th>
            <th class="px-6 py-4 text-left">Announcement</th>
            <th class="px-6 py-4 text-left">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                List<EventDTO> interviews = (List<EventDTO>) request.getAttribute("interviews");
                if (interviews != null && !interviews.isEmpty()) {
                    for (EventDTO interview:interviews) {
        %>
        <tr class="bg-white hover:bg-gray-50">
            <td class="px-6 py-4 text-sm font-medium text-gray-800"><%= interview.getTitle() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= interview.getDescription() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= interview.getStartDateTime() %></td>
            <td class="px-6 py-4 text-sm text-gray-600">
                <% if (interview.getAID() == null) { %>
                <button class="bg-white text-blue-800 font-medium px-3 py-1 rounded hover:bg-blue-100"
                        onclick="window.location.href='addAnnouncement?eID=<%= interview.getEID() %>'">
                    Create Announcement
                </button>
                <% } else { %>
                <span><%= interview.getAID() %></span>
                <% } %>
            </td>
            <td class="px-6 py-4 text-sm">
                <div class="flex space-x-4">
                    <button class="text-green-600 hover:text-green-800 font-medium"
                            onclick="window.location.href='updateEvent?id=<%= interview.getEID() %>&type=workshop'">Edit</button>
                    <button class="text-red-600 hover:text-red-800 font-medium"
                            onclick="if(confirm('Are you sure you want to delete this workshop?'))
                                    window.location.href='deleteEvent?id=<%= interview.getEID() %>'">
                        Delete
                    </button>
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
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <tr>
            <td colspan="4" class="px-6 py-4 text-center text-red-600">Error loading interviews</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
