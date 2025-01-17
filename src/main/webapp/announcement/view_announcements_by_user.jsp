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
                <a href="../teacher_dashboard.jsp"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
                          <%= request.getRequestURI().contains("teacher_dashboard.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
                    Workshop
                </a>

                <a href="teacher_interview.jsp"
                   class="text-gray-600 hover:text-sky-700 px-3 py-2 px-4
                          <%= request.getRequestURI().contains("teacher_interview.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
                    Interview
                </a>

                <a href="../announcement/teacher_announcement.jsp"
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
        <h1 class="text-3xl font-semibold text-gray-800 text-center">Manage Announcements</h1>
    </div>
    <!-- Success/Error Message -->
    <c:if test="${not empty message}">
        <div class="bg-blue-100 text-blue-800 px-4 py-3 rounded mb-4">${message}</div>
    </c:if>

    <!-- Announcements Table -->
    <table class="min-w-full table-auto bg-white border-collapse shadow-lg rounded-lg pb-3">
        <thead class="bg-blue-200 text-gray-700">
        <tr>
            <th class="px-6 py-4 text-left">Subject</th>
            <th class="px-6 py-4 text-left">Message</th>
            <th class="px-6 py-4 text-left">Created By</th>
            <th class="px-6 py-4 text-left">Batches</th>
            <th class="px-6 py-4 text-left">Students</th>
            <th class="px-6 py-4 text-left">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                // Fetch announcements from the service (using controller logic)
                int uid = 10;
                List<AnnouncementDTO> announcements = (List<AnnouncementDTO>) request.getAttribute("announcements");

                if (announcements != null && !announcements.isEmpty()) {
                    for (AnnouncementDTO announcement : announcements) {
                        String subject = announcement.getSubject();
                        String message = announcement.getMessage();
                        Long createdBy = announcement.getCreatedBy();
                        List<Integer> batches = announcement.getBatches();
                        List<Integer> students = announcement.getStudents();
                        String aid = announcement.getAID();
        %>
        <tr class="bg-white hover:bg-gray-50">
            <td class="px-6 py-4 text-sm font-medium text-gray-800"><%= announcement.getSubject() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= announcement.getMessage() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= announcement.getCreatedBy() %></td>
            <td class="px-6 py-4 text-sm text-gray-600">
                <%= String.join(", ", batches.stream().map(String::valueOf).toArray(String[]::new)) %>
            </td>
            <td class="px-6 py-4 text-sm text-gray-600">
                <%= String.join(", ", students.stream().map(String::valueOf).toArray(String[]::new)) %>
            </td>
            <td class="px-6 py-4 text-sm">
                <div class="flex space-x-4">
                    <button class="text-blue-600 hover:text-blue-800 font-medium"
                            onclick="window.location.href='/updateAnnouncement?id=<%= aid %>'">Edit</button>
                    <button class="text-red-600 hover:text-red-800 font-medium"
                            onclick="window.location.href='/deleteAnnouncement?id=<%= aid %>'">Delete</button>
                </div>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6" class="px-6 py-4 text-center text-gray-600">No announcements available</td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <tr>
            <td colspan="6" class="px-6 py-4 text-center text-red-600">Error loading announcements</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>

</div>
</body>
</html>

