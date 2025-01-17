<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.eventflowfrontend.DTO.AnnouncementDTO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Announcements</title>
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
        <h1 class="text-3xl font-semibold text-gray-800 text-center">Manage Announcements</h1>
    </div>
    <!-- Success/Error Message -->
    <c:if test="${not empty message}">
        <div class="bg-blue-100 text-blue-800 px-4 py-3 rounded mb-4">${message}</div>
    </c:if>
    <!-- Add New Announcement Button -->
    <div class="text-left mb-4 py-5">
        <button class="bg-red-600 text-white font-bold py-2 px-4 rounded hover:bg-red-800"
                onclick="window.location.href='addAnnouncement?createdBy=10'">Create Announcement
        </button>

        <div class="relative inline-block text-left ml-4">
            <button class="bg-gray-200 text-gray-800 font-semibold py-2 px-4 rounded hover:bg-gray-300 focus:outline-none" onclick="toggleDropdown()">
                More Actions
                <svg class="w-5 h-5 inline-block ml-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" d="M5.293 6.293a1 1 0 011.414 0L10 9.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"/>
                </svg>
            </button>
            <!-- Dropdown Content -->
            <div id="dropdownMenu" class="dropdown-content absolute right-0 mt-2 w-48 bg-white border border-gray-300 rounded-md shadow-lg z-10 hidden">
                <a href="viewAnnouncementsByUser?uid=10" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">View by User</a>
                <a href="viewAssignedBatches?aid=1" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">View Assigned Batches</a>
                <a href="viewAssignedStudents?aid=1" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">View Assigned Students</a>
                <a href="viewAssignedAnnouncementsByStudent?uid=8" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">View by Students</a>
                <a href="viewAssignedAnnouncementsByBatch?bID=1" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">View by Batches</a>
            </div>
        </div>
    </div>
    <!-- Announcements Table -->
    <table class="min-w-full table-auto bg-white border-collapse shadow-lg rounded-lg pb-3">
        <thead class="bg-blue-200 text-gray-700">
        <tr>
            <th class="px-6 py-4 text-left">Subject</th>
            <th class="px-6 py-4 text-left">Message</th>
            <th class="px-6 py-4 text-left">Created By</th>
            <th class="px-6 py-4 text-left">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                List<AnnouncementDTO> announcements = (List<AnnouncementDTO>) request.getAttribute("announcements");
                if (announcements != null && !announcements.isEmpty()) {
                    for (AnnouncementDTO announcement : announcements) {
        %>
        <tr class="bg-white hover:bg-gray-50">
            <td class="px-6 py-4 text-sm font-medium text-gray-800"><%= announcement.getAID() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= announcement.getSubject() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= announcement.getMessage() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= announcement.getCreatedBy() %></td>
            <td class="px-6 py-4 text-sm">
                <div class="flex space-x-4">
                    <button class="text-green-600 hover:text-green-800 font-medium"
                            onclick="window.location.href='/viewAnnouncement?id=<%= announcement.getAID() %>'">View</button>
                    <button class="text-blue-600 hover:text-blue-800 font-medium"
                            onclick="window.location.href='/updateAnnouncement?id=<%= announcement.getAID() %>'">Edit</button>
                    <button class="text-red-600 hover:text-red-800 font-medium"
                            onclick="window.location.href='/deleteAnnouncement?id=<%= announcement.getAID() %>'">Delete</button>
                </div>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="5" class="px-6 py-4 text-center text-gray-600">No announcements available</td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <tr>
            <td colspan="5" class="px-6 py-4 text-center text-red-600">Error loading announcements</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById('dropdownMenu');
            dropdown.classList.toggle('hidden');
        }
    </script>
</div>
</body>
</html>

