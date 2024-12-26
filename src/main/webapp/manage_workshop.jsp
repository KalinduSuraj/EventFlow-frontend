<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.JSONArray, org.json.JSONObject" %>

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
        <h1 class="text-3xl font-semibold text-gray-800 text-center">Workshop List</h1>
    </div>
    <div class="text-left mb-4 py-5">
        <a href="create_workshop.jsp" class="bg-red-500 text-white px-6 py-3 rounded shadow hover:bg-red-700">Create Workshop</a>
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
            String apiUrl = "http://virtserver.swaggerhub.com/ANUSHIDESILVA28/EAD2/1.0.0";
            String jsonResponse = "";

            try {
                // Fetch the API response
                java.net.URL url = new java.net.URL(apiUrl);
                java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Accept", "application/json");

                if (conn.getResponseCode() == 200) {
                    java.io.BufferedReader br = new java.io.BufferedReader(new java.io.InputStreamReader(conn.getInputStream()));
                    StringBuilder sb = new StringBuilder();
                    String line;
                    while ((line = br.readLine()) != null) {
                        sb.append(line);
                    }
                    br.close();
                    jsonResponse = sb.toString();
                } else {
                    throw new RuntimeException("HTTP error code: " + conn.getResponseCode());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            // Parse JSON and render the table
            try {
                if (!jsonResponse.trim().isEmpty() && jsonResponse.startsWith("[")) {
                    JSONArray events = new JSONArray(jsonResponse);
                    for (int i = 0; i < events.length(); i++) {
                        JSONObject event = events.getJSONObject(i);
        %>
        <tr class="bg-white hover:bg-gray-50">
            <td class="px-6 py-4 text-sm font-medium text-gray-800"><%= event.optString("title", "N/A") %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= event.optString("description", "N/A") %></td>
            <td class="px-6 py-4 text-sm text-gray-600"><%= event.optString("scheduled_datetime", "N/A") %></td>
            <td class="px-6 py-4 text-sm">
                <div class="flex space-x-4">
                    <a href="update_workshop.jsp?eID=<%= event.optInt("eID", 0) %>" class="text-green-600 hover:text-green-800 font-medium">Update</a>
                    <a href="deactivate_workshop.jsp?eID=<%= event.optInt("eID", 0) %>" class="text-red-600 hover:text-red-800 font-medium">Deactivate</a>
                </div>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="px-6 py-4 text-center text-gray-600">No workshops available</td>
        </tr>
        <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        %>
        <tr>
            <td colspan="4" class="px-6 py-4 text-center text-red-600">Error loading workshops</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>