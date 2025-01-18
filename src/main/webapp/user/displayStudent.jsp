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
<body class="bg-gray-100 text-gray-800">

<!-- Navbar -->
<nav class="bg-blue-600 p-4 text-white">
  <div class="container mx-auto flex justify-between items-center">
    <h1 class="text-lg font-bold">User Management System</h1>
    <div>
      <a href="/home" class="px-4 py-2 hover:bg-blue-500 rounded">Home</a>
      <a href="/logout" class="px-4 py-2 hover:bg-blue-500 rounded">Logout</a>
    </div>
  </div>
</nav>

<!-- Main Content -->
<div class="container mx-auto my-8">
  <div class="flex justify-between items-center mb-6">
    <h2 class="text-2xl font-semibold">User Management</h2>
    <button onclick="window.location.href='addUser?createdBy=7'"
            class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded">
      Add User
    </button>
  </div>

  <!-- User Table -->
  <div class="overflow-x-auto">
    <table class="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
      <thead class="bg-gray-200">
      <tr>
        <th class="py-2 px-4 text-left">Id</th>
        <th class="py-2 px-4 text-left">Name</th>
        <th class="py-2 px-4 text-left">Email</th>
        <th class="py-2 px-4 text-left">NIC</th>
        <th class="py-2 px-4 text-left">Mobile</th>
        <th class="py-2 px-4 text-left">CreatedBy</th>
        <th class="py-2 px-4 text-center">Actions</th>
      </tr>
      </thead>
      <tbody>
      <%
        List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
        if (users != null) {
          for (UserDTO user : users) {
      %>
      <tr class="border-b border-gray-200 hover:bg-gray-100">
        <td class="py-2 px-4"><%=user.getUID()%></td>
        <td class="py-2 px-4"><%=user.getName()%></td>
        <td class="py-2 px-4"><%=user.getEmail()%></td>
        <td class="py-2 px-4"><%=user.getNic()%></td>
        <td class="py-2 px-4"><%=user.getMobile()%></td>
        <td class="py-2 px-4"><%=user.getCreatedBy()%></td>
        <td class="py-2 px-4 flex justify-center space-x-2">
          <button onclick="window.location.href='updateUser?uid=<%=user.getUID()%>'"
                  class="bg-blue-500 hover:bg-blue-600 text-white px-4 py-1 rounded">
            Edit
          </button>
          <button onclick="window.location.href='deleteUser?uid=<%=user.getUID()%>&type=student'"
                  class="bg-red-500 hover:bg-red-600 text-white px-4 py-1 rounded">
            Delete
          </button>
        </td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="7" class="text-center py-4 text-gray-500">No users found</td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
