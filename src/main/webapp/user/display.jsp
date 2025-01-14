<%@ page import="com.example.eventflowfrontend.DTO.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16 items-center">
            <!-- Left Side (Empty or You can add links here if needed) -->
            <div class="flex items-center">
                <!-- You can add nav links here -->
            </div>

            <!-- Right Side (EventFlow Logo) -->
            <div class="flex items-center ml-auto">
                <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2">EventFlow</a>
            </div>
        </div>
    </div>
</nav>

<!--addUser?createdBy=7-->
<!-- Main Content -->
<!-- Main Content -->
<div class="max-w-6xl mx-auto py-12">
    <!-- Center Aligned Heading -->
    <h1 class="text-4xl mb-8 text-sky-900 font-semibold font-sans text-center">Admin</h1>

    <!-- Left Aligned Button Below the Heading -->
    <a href="addUser.jsp" class="bg-blue-500 text-white px-4 py-2 rounded ">Add User</a>
</div>



<table class="table-auto border-collapse border border-gray-300 w-full text-sm">
    <thead>
    <tr>
        <th class="border border-gray-300 px-4 py-2">Id</th>
        <th class="border border-gray-300 px-4 py-2">Name</th>
        <th class="border border-gray-300 px-4 py-2">Email</th>
        <th class="border border-gray-300 px-4 py-2">NIC</th>
        <th class="border border-gray-300 px-4 py-2">Password</th>
        <th class="border border-gray-300 px-4 py-2">Mobile</th>
        <th class="border border-gray-300 px-4 py-2">CreatedBy</th>
        <th class="border border-gray-300 px-4 py-2">Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
        if (users != null && !users.isEmpty()) {
            for (UserDTO user : users) {
    %>
    <tr>
        <td class="border border-gray-300 px-4 py-2"><%=user.getUID()%></td>
        <td class="border border-gray-300 px-4 py-2"><%=user.getName()%></td>
        <td class="border border-gray-300 px-4 py-2"><%=user.getEmail()%></td>
        <td class="border border-gray-300 px-4 py-2"><%=user.getNic()%></td>
        <td class="border border-gray-300 px-4 py-2">******</td> <!-- Masked Password -->
        <td class="border border-gray-300 px-4 py-2"><%=user.getMobile()%></td>
        <td class="border border-gray-300 px-4 py-2"><%=user.getCreatedBy()%></td>
        <td class="border border-gray-300 px-4 py-2 text-center">
            <!-- Update and Delete buttons side by side with inline-block and margin -->
            <a href="updateUser?uid=<%=user.getUID()%>"
               class="bg-yellow-500 text-white px-2 py-1 rounded hover:bg-yellow-600 transition duration-200 inline-block mr-2">
                Update
            </a>
            <a href="deleteUser?uid=<%=user.getUID()%>"
               class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600 transition duration-200 inline-block">
                Delete
            </a>
        </td>


    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="8" class="text-center border border-gray-300 px-4 py-2">No Users Found</td>
    </tr>
    <% } %>
    </tbody>
</table>

</body>
</html>
