<%@ page import="com.example.eventflowfrontend.DTO.UserDTO" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 1/5/2025
  Time: 11:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>User Management</title>
</head>
<body>
<h1>User Management</h1>
<button onclick="window.location.href='addUser?createdBy=7'">Add User</button>
<table border="1">
  <thead>
  <tr>
    <th>Id</th>
    <th>Name</th>
    <th>Email</th>
    <th>NIC</th>
    <th>Mobile</th>
    <th>CreatedBy</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>

  <%
    List<UserDTO> users = (List<UserDTO>) request.getAttribute("users");
    System.out.println(users);
    System.out.println("users");
    if (users != null) {
      for (UserDTO user : users) {
  %>
  <tr>
    <td><%=user.getUID()%></td>
    <td><%=user.getName()%></td>
    <td><%=user.getEmail()%></td>
    <td><%=user.getNic()%></td>
    <td><%=user.getMobile()%></td>
    <td><%=user.getCreatedBy()%></td>
    <td>
      <button onclick="window.location.href='updateUser?uid=<%=user.getUID()%>'">Edit</button>
      <button onclick="window.location.href='deleteUser?uid=<%=user.getUID()%>'">Delete</button>
    </td>
  </tr>
  <%
      }
    }
  %>
  </tbody>
</table>
</body>
</html>
