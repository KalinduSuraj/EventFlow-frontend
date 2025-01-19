<%@ page import="com.example.eventflowfrontend.DTO.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

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
<div class="max-w-6xl mx-auto text-center py-12">
    <h1 class="text-4xl mb-8 text-sky-900 font-semibold font-sans">Admin Management</h1>

        <button onclick="window.location.href='addUser?createdBy=7'"
                class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
            Add User
        </button>
    </div>

    <table class="table-auto w-full bg-white shadow-md rounded border-collapse">
        <thead class="bg-gray-200">
        <tr>
            <th class="px-4 py-2 border">Id</th>
            <th class="px-4 py-2 border">Name</th>
            <th class="px-4 py-2 border">Email</th>
            <th class="px-4 py-2 border">NIC</th>
            <th class="px-4 py-2 border">Mobile</th>
            <th class="px-4 py-2 border">CreatedBy</th>
            <th class="px-4 py-2 border">Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
            if (users != null) {
                for (UserDTO user : users) {
        %>
        <tr class="hover:bg-gray-100">
            <td class="px-4 py-2 border"><%=user.getUID()%></td>
            <td class="px-4 py-2 border"><%=user.getName()%></td>
            <td class="px-4 py-2 border"><%=user.getEmail()%></td>
            <td class="px-4 py-2 border"><%=user.getNic()%></td>
            <td class="px-4 py-2 border"><%=user.getMobile()%></td>
            <td class="px-4 py-2 border"><%=user.getCreatedBy()%></td>
            <td class="px-4 py-2 border flex space-x-2">
                <button onclick="window.location.href='updateUser?uid=<%=user.getUID()%>'"
                        class="bg-blue-500 text-white px-2 py-1 rounded hover:bg-blue-600">
                    Edit
                </button>
                <button onclick="window.location.href='deleteUser?uid=<%=user.getUID()%>&type=admin'"
                        class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600">
                    Delete
                </button>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>