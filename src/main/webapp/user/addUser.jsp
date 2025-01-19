<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add User</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-900">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16">
            <!-- Left Nav -->
            <div class="flex-shrink-0 flex items-center space-x-4">

            </div>

            <!-- Right Nav -->
            <div class="flex items-center">
                <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2">EventFlow</a>

            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mx-auto my-10 max-w-lg bg-white p-8 rounded-lg shadow-lg">
    <h1 class="text-2xl font-bold mb-6 text-center text-blue-600">Add New User</h1>

    <% String message = (String) request.getAttribute("message"); %>
    <% if (message != null) { %>
    <p class="text-green-600 text-center mb-4"><%= message %></p>
    <% } %>

    <form action="addUser" method="post" class="space-y-4">
        <%
            String createdBy = request.getParameter("createdBy");
        %>
        <input type="hidden" name="action" value="add"/>
        <input type="hidden" name="createdBy" value="<%=createdBy%>"/>

        <!-- Name Field -->
        <label class="block">
            <span class="text-gray-700">Name:</span>
            <input type="text" name="name" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
        </label>

        <!-- Mobile Field -->
        <label class="block">
            <span class="text-gray-700">Mobile:</span>
            <input type="text" name="mobile" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
        </label>

        <!-- NIC Field -->
        <label class="block">
            <span class="text-gray-700">NIC:</span>
            <input type="text" name="nic" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
        </label>

        <!-- Email Field -->
        <label class="block">
            <span class="text-gray-700">Email:</span>
            <input type="email" name="email" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
        </label>

        <!-- Password Field -->
        <label class="block">
            <span class="text-gray-700">Password:</span>
            <input type="password" name="password" required
                   class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
        </label>

        <!-- Role Dropdown -->
        <label class="block">
            <span class="text-gray-700">Role:</span>
            <select name="role" required
                    class="mt-1 block w-full p-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500">
                <option value="admin">Admin</option>
                <option value="lecturer">Lecturer</option>
                <option value="student">Student</option>
            </select>
        </label>

        <!-- Submit Button -->
        <div class="flex justify-center mt-6">
            <button type="submit"
                    class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition duration-300">
                Add User
            </button>
        </div>
    </form>
</div>

</body>
</html>
