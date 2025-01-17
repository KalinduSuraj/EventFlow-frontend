<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.HttpURLConnection, java.net.URL, java.io.BufferedReader, java.io.InputStreamReader" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Announcements Page</title>
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

                <a href="../event/teacher_interview.jsp"
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
        <h1 class="text-3xl font-semibold text-gray-800 text-center">Announcements List</h1>
    </div>
    <div class="text-left mb-4 py-5 flex items-center space-x-4">
        <!-- Create Workshop Button -->
        <button class="bg-red-600 text-white font-bold py-2 px-4 rounded hover:bg-red-800"
                onclick="window.location.href='create_announcement.jsp'">
            Create Announcement
        </button>

        <!-- Search Bar and Search Button -->
        <input type="text" id="searchBar" placeholder="Search announcements..."
               class="border border-gray-300 rounded-lg py-2 px-4 w-1/3"
               oninput="filterAnnouncements()" />

        <button class="bg-blue-600 text-white font-bold py-2 px-4 rounded hover:bg-blue-800"
                onclick="searchAnnouncements()">
            Search
        </button>
    </div>

    <table class="min-w-full table-auto bg-white border-collapse shadow-lg rounded-lg pb-3">
        <thead class="bg-blue-200 text-gray-700">
        <tr>
            <th class="px-6 py-4 text-left">Subject</th>
            <th class="px-6 py-4 text-left">Message</th>
            <th class="px-6 py-4 text-left">Created By</th>
            <th class="px-6 py-4 text-left">Batches</th>
            <th class="px-6 py-4 text-left">Students</th>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                // Replace with actual user ID dynamically as needed
                int userId = 10;
                String apiUrl = "https://virtserver.swaggerhub.com/created_by/" + userId;

                // Making the API request to fetch announcements
                URL url = new URL(apiUrl);
                HttpURLConnection connection = (HttpURLConnection) url.openConnection();
                connection.setRequestMethod("GET");
                connection.setRequestProperty("Accept", "application/json");

                int responseCode = connection.getResponseCode();
                if (responseCode == 200) {
                    BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                    String inputLine;
                    StringBuilder apiResponse = new StringBuilder();

                    while ((inputLine = in.readLine()) != null) {
                        apiResponse.append(inputLine);
                    }
                    in.close();

                    // Parse JSON response
                    JSONArray announcements = new JSONArray(apiResponse.toString());
                    for (int i = 0; i < announcements.length(); i++) {
                        JSONObject announcement = announcements.getJSONObject(i);
                        int announcementId = announcement.getInt("id");

                        // Fetch assigned batches for this announcement
                        String batchesApiUrl = "https://virtserver.swaggerhub.com/assigned/batch/" + announcementId;
                        HttpURLConnection batchesConnection = (HttpURLConnection) new URL(batchesApiUrl).openConnection();
                        batchesConnection.setRequestMethod("GET");
                        batchesConnection.setRequestProperty("Accept", "application/json");

                        StringBuilder batchesResponse = new StringBuilder();
                        if (batchesConnection.getResponseCode() == 200) {
                            BufferedReader batchReader = new BufferedReader(new InputStreamReader(batchesConnection.getInputStream()));
                            while ((inputLine = batchReader.readLine()) != null) {
                                batchesResponse.append(inputLine);
                            }
                            batchReader.close();
                        }

                        // Fetch assigned students for this announcement
                        String studentsApiUrl = "https://virtserver.swaggerhub.com/assigned/student/" + announcementId;
                        HttpURLConnection studentsConnection = (HttpURLConnection) new URL(studentsApiUrl).openConnection();
                        studentsConnection.setRequestMethod("GET");
                        studentsConnection.setRequestProperty("Accept", "application/json");

                        StringBuilder studentsResponse = new StringBuilder();
                        if (studentsConnection.getResponseCode() == 200) {
                            BufferedReader studentReader = new BufferedReader(new InputStreamReader(studentsConnection.getInputStream()));
                            while ((inputLine = studentReader.readLine()) != null) {
                                studentsResponse.append(inputLine);
                            }
                            studentReader.close();
                        }

                        // Parse batches and students data
                        JSONArray batches = new JSONArray(batchesResponse.toString());
                        JSONArray students = new JSONArray(studentsResponse.toString());

        %>
        <tr class="bg-white hover:bg-gray-50">
            <td class="px-6 py-4 text-sm font-medium text-gray-800"><%= announcement.optString("subject", "N/A") %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= announcement.optString("message", "N/A") %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= announcement.optInt("createdBy", 0) %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= batches.toString() %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= students.toString() %></td>
        </tr>
        <%
            }
        } else if (responseCode == 404) {
        %>
        <tr>
            <td colspan="5" class="px-6 py-4 text-center text-gray-600">No announcements available</td>
        </tr>
        <%
        } else {
        %>
        <tr>
            <td colspan="5" class="px-6 py-4 text-center text-red-600">Error fetching announcements</td>
        </tr>
        <%
            }
            connection.disconnect();
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
</div>

<script>
    function searchAnnouncements() {
        // Get the value from the search bar
        let searchText = document.getElementById('searchBar').value.toLowerCase();

        // Get all table rows
        let rows = document.querySelectorAll('table tbody tr');

        // Loop through all rows and hide the ones that don't match the search text
        rows.forEach(row => {
            let subject = row.cells[0].textContent.toLowerCase();
            let message = row.cells[1].textContent.toLowerCase();

            // Check if either the subject or message contains the search text
            if (subject.includes(searchText) || message.includes(searchText)) {
                row.style.display = '';  // Show row
            } else {
                row.style.display = 'none';  // Hide row
            }
        });
    }
</script>

</body>
</html>
