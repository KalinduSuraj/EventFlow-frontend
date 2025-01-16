<%@ page import="com.example.eventflowfrontend.DTO.UserDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Navbar -->
<nav class="bg-blue-600 p-4 text-white shadow-lg">
    <div class="container mx-auto flex justify-between items-center">
        <h1 class="text-lg font-bold">User Management System</h1>
        <div>
            <a href="/home" class="px-4 py-2 hover:bg-blue-500 rounded">Home</a>
            <a href="/logout" class="px-4 py-2 hover:bg-blue-500 rounded">Logout</a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mx-auto my-10 max-w-lg bg-white p-8 rounded-lg shadow-lg">
    <h1 class="text-2xl font-bold mb-6 text-center text-blue-600">Update User</h1>

    <%
        Integer uid = Integer.parseInt(request.getParameter("uid"));
        UserDTO user = (UserDTO) request.getAttribute("user");
        String message = (String) request.getAttribute("message");
    %>
    <% if (message != null) { %>
    <p class="text-green-600 text-center mb-4"><%= message %></p>
    <% } %>

    <!-- Update User Form -->
    <form action="updateUser" method="post" class="space-y-4">
        <input type="hidden" name="action" value="update"/>
        <input type="hidden" name="uid" value="<%=uid%>"/>

        <!-- Name Field -->
        <label class="block">
            <span class="text-gray-700">Name:</span>
            <input type="text" name="name" value="<%=user.getName()%>" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-300 transform hover:scale-105"/>
        </label>

        <!-- Mobile Field -->
        <label class="block">
            <span class="text-gray-700">Mobile:</span>
            <input type="text" name="mobile" value="<%=user.getMobile()%>" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-300 transform hover:scale-105"/>
        </label>

        <!-- NIC Field -->
        <label class="block">
            <span class="text-gray-700">NIC:</span>
            <input type="text" name="nic" value="<%=user.getNic()%>" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-300 transform hover:scale-105"/>
        </label>

        <!-- Email Field -->
        <label class="block">
            <span class="text-gray-700">Email:</span>
            <input type="email" name="email" value="<%=user.getEmail()%>" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-300 transform hover:scale-105"/>
        </label>

        <!-- Password Field -->
        <label class="block">
            <span class="text-gray-700">Password (Leave blank to keep current password):</span>
            <input type="password" name="password"
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 transition duration-300 transform hover:scale-105"/>
        </label>

        <!-- Submit Button -->
        <div class="flex justify-center mt-6">
            <button type="submit"
                    class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition duration-300">
                Update User
            </button>
        </div>
    </form>
</div>

</body>
</html>
