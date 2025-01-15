<%@ page import="com.example.eventflowfrontend.DTO.UserDTO" %><%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 1/5/2025
  Time: 12:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>update user</title>
</head>
<body>
<h1>Update User</h1>
<form action="updateUser" method="post">
    <%
        Integer uid = Integer.parseInt(request.getParameter("uid"));
        UserDTO user = (UserDTO) request.getAttribute("user");
    %>
    <% String message = (String) request.getAttribute("message"); %>
    <% if (message != null) { %>
    <p style="color: green;"><%= message %></p>
    <% } %>
    <input type="hidden" name="action" value="update"/>
    <input type="hidden" name="uid" value="<%=uid%>"/>
    <table>
        <tr>
            <td>Name:</td>
            <td><input type="text" name="name" value="<%=user.getName()%>"/></td>
        </tr>
        <tr>
            <td>Mobile:</td>
            <td><input type="text" name="mobile" value="<%=user.getMobile()%>"/></td>
        </tr>
        <tr>
            <td>NIC:</td>
            <td><input type="text" name="nic" value="<%=user.getNic()%>"/></td>
        </tr>
        <tr>
            <td>email:</td>
            <td><input type="email" name="email" value="<%=user.getEmail()%>"/></td>
        </tr>
        <tr>
            <td>password:</td>
            <td><input type="password" name="password"/></td>
        <tr>
            <td></td>
            <td><input type="submit" value="Update-User"/></td>
        </tr>
    </table>
</form>
</body>
</html>
