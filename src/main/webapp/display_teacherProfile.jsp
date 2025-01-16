<%--
  Created by IntelliJ IDEA.
  User: gavee liyanage
  Date: 1/15/2025
  Time: 11:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="org.json.JSONObject" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        async function fetchUserData() {
            const apiUrl = "{{host}}/api/portfolios/by_user/8";
            try {
                const response = await fetch(apiUrl, { method: 'GET', headers: { 'Accept': 'application/json' } });
                if (!response.ok) {
                    throw new Error(`Failed to fetch data from API. HTTP Code: ${response.status}`);
                }
                const user = await response.json();
                document.getElementById('displayName').value = user.displayName;
                document.getElementById('description').value = user.description;
                document.getElementById('technologies').value = user.technologies;
                document.getElementById('githubUsername').value = user.githubUsername;
                document.getElementById('linkedinUsername').value = user.linkedinUsername;
            } catch (error) {
                document.getElementById('errorMessage').innerText = `Error fetching user details: ${error.message}`;
            }
        }

        window.onload = fetchUserData;
    </script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
<div class="bg-white p-6 rounded shadow-md w-full max-w-lg">
    <h1 class="text-2xl font-bold mb-4 text-center">User Profile</h1>

    <p id="errorMessage" class="text-red-500 mb-4"></p>
    <form action="displayUserProfile" method="post" class="space-y-4">
        <input type="hidden" name="action" value="display"/>
        <div>
            <label for="displayName" class="block text-sm font-medium text-gray-700">Display Name:</label>
            <input type="text" id="displayName" name="displayName" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"/>
        </div>
        <div>
            <label for="description" class="block text-sm font-medium text-gray-700">Description:</label>
            <textarea id="description" name="description" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"></textarea>
        </div>
        <div>
            <label for="technologies" class="block text-sm font-medium text-gray-700">Technologies:</label>
            <input type="text" id="technologies" name="technologies" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"/>
        </div>
        <div>
            <label for="githubUsername" class="block text-sm font-medium text-gray-700">GitHub Username:</label>
            <input type="text" id="githubUsername" name="githubUsername" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"/>
        </div>
        <div>
            <label for="linkedinUsername" class="block text-sm font-medium text-gray-700">LinkedIn Username:</label>
            <input type="text" id="linkedinUsername" name="linkedinUsername" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500"/>
        </div>
        <div>
            <button type="submit" class="w-full bg-indigo-600 text-white py-2 px-4 rounded-md hover:bg-indigo-700" onclick="window.location.href='update_teacherProfile.jsp?id=8'">Edit</button>
        </div>
    </form>
</div>
</body>
</html>
