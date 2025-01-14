<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Admin</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gray-100 text-gray-800">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16 items-center">
            <div></div>
            <a href="#" class="text-sky-800 font-semibold text-lg">EventFlow</a>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="max-w-lg mx-auto py-12">
    <h1 class="text-4xl mb-8 text-sky-900 font-semibold text-center">Create New Admin</h1>

    <!-- Success Message -->
    <% String message = (String) request.getAttribute("message"); %>
    <% if (message != null) { %>
    <p class="text-green-600 text-center font-medium"><%= message %></p>
    <% } %>

    <!-- Form with hover effect -->
    <form action="addUser" method="post" class="bg-white shadow-lg rounded-lg px-8 pt-6 pb-8 space-y-6">

        <!-- Hidden Inputs -->
        <%
            String createdBy = request.getParameter("createdBy") != null ? request.getParameter("createdBy") : "7";
        %>
        <input type="hidden" name="createdBy" value="<%= createdBy %>">
        <input type="hidden" name="action" value="add">

        <!-- Name Field -->
        <div>
            <label for="name" class="block text-sm font-semibold mb-2">Name</label>
            <input type="text" name="name" id="name" placeholder="Enter full name"
                   class="w-full border rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-400
                   transform hover:scale-105 transition duration-300 ease-in-out"/>
        </div>

        <!-- Mobile Field -->
        <div>
            <label for="mobile" class="block text-sm font-semibold mb-2">Mobile</label>
            <input type="text" name="mobile" id="mobile" placeholder="Enter mobile number"
                   class="w-full border rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-400
                   transform hover:scale-105 transition duration-300 ease-in-out"/>
        </div>

        <!-- NIC Field -->
        <div>
            <label for="nic" class="block text-sm font-semibold mb-2">NIC</label>
            <input type="text" name="nic" id="nic" placeholder="Enter NIC"
                   class="w-full border rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-400
                   transform hover:scale-105 transition duration-300 ease-in-out"/>
        </div>

        <!-- Email Field -->
        <div>
            <label for="email" class="block text-sm font-semibold mb-2">Email</label>
            <input type="email" name="email" id="email" placeholder="Enter email address"
                   class="w-full border rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-400
                   transform hover:scale-105 transition duration-300 ease-in-out"/>
        </div>

        <!-- Password Field -->
        <div>
            <label for="password" class="block text-sm font-semibold mb-2">Password</label>
            <input type="password" name="password" id="password" placeholder="Enter password"
                   class="w-full border rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-400
                   transform hover:scale-105 transition duration-300 ease-in-out"/>
        </div>

        <!-- Role Dropdown -->
        <div>
            <label for="role" class="block text-sm font-semibold mb-2">Role</label>
            <select name="role" id="role"
                    class="w-full border rounded-lg p-3 focus:outline-none focus:ring-2 focus:ring-blue-400
                    transform hover:scale-105 transition duration-300 ease-in-out">
                <option value="admin">Admin</option>
                <option value="lecturer">Lecturer</option>
                <option value="student">Student</option>
            </select>
        </div>

        <!-- Submit Button with Hover Animation -->
        <div class="flex justify-center">
            <button type="submit"
                    class="w-full bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold
                    hover:bg-blue-700 transform hover:scale-105 transition duration-300 ease-in-out focus:ring-2 focus:ring-blue-400">
                Add User
            </button>
        </div>
    </form>
</div>

</body>
</html>
