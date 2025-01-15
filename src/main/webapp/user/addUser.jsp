<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 1/5/2025
  Time: 12:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add User</title>
</head>
<body>
<h1>Add User</h1>
<% String message = (String) request.getAttribute("message"); %>
<% if (message != null) { %>
<p style="color: green;"><%= message %></p>
<% } %>
<form action="addUser" method="post">
    <%
        String createdBy = request.getParameter("createdBy");
    %>
    <input type="hidden" name="action" value="add"/>
    <input type="hidden" name="createdBy" value="<%=createdBy%>"/>
    <table>
        <tr>
            <td>Name:</td>
            <td><input type="text" name="name"/></td>
        </tr>
        <tr>
            <td>Mobile:</td>
            <td><input type="text" name="mobile"/></td>
        </tr>
        <tr>
            <td>NIC:</td>
            <td><input type="text" name="nic"/></td>
        </tr>
        <tr>
            <td>email:</td>
            <td><input type="email" name="email"/></td>
        </tr>
        <tr>
            <td>password:</td>
            <td><input type="password" name="password"/></td>
        </tr>
        <tr>
            <td>Role:</td>
            <td>
                <select name="role">
                    <option value="admin">Admin</option>
                    <option value="lecturer">lecturer</option>
                    <option value="student">Student</option>
                </select>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="Add-User"/></td>
        </tr>
    </table>
</form>
</body>
</html>
