<%@ page import="com.example.eventflowfrontend.DTO.BatchDTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Batch Management</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between h-16 items-center">
            <div class="flex items-center"></div>
            <div class="flex items-center ml-auto">
                <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2">EventFlow</a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="max-w-6xl mx-auto py-12">
    <!-- Center Aligned Heading -->
    <h1 class="text-4xl mb-8 text-sky-900 font-semibold font-sans text-center">Batch Management</h1>

    <!-- Left Aligned Button Below the Heading -->
    <a href="addBatch.jsp" class="bg-blue-500 text-white px-4 py-2 rounded mb-8 inline-block">Add Batch</a>
</div>

<!-- Batch Table -->
<table class="table-auto border-collapse border border-gray-300 w-full text-sm">
    <thead>
    <tr>
        <th class="border border-gray-300 px-4 py-2">Batch Name</th>
        <th class="border border-gray-300 px-4 py-2">Common Email</th>
        <th class="border border-gray-300 px-4 py-2">Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<BatchDTO> batches = (List<BatchDTO>) request.getAttribute("batches");
        if (batches != null && !batches.isEmpty()) {
            for (BatchDTO batch : batches) {
    %>
    <tr>
        <td class="border border-gray-300 px-4 py-2"><%=batch.getBatchName()%></td>
        <td class="border border-gray-300 px-4 py-2"><%=batch.getCommonEmail()%></td>
        <td class="border border-gray-300 px-4 py-2 text-center">
            <!-- Update, Delete, and Assign buttons -->
            <a href="updateBatch?batchId=<%=batch.getBatchId()%>"
               class="bg-yellow-500 text-white px-2 py-1 rounded hover:bg-yellow-600 transition duration-200 inline-block mr-2">
                Update
            </a>
            <a href="deleteBatch?batchId=<%=batch.getBatchId()%>"
               class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600 transition duration-200 inline-block mr-2">
                Delete
            </a>
            <a href="assignStudents?batchId=<%=batch.getBatchId()%>"
               class="bg-green-500 text-white px-2 py-1 rounded hover:bg-green-600 transition duration-200 inline-block">
                Assign
            </a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="3" class="text-center border border-gray-300 px-4 py-2">No Batches Found</td>
    </tr>
    <% } %>
    </tbody>
</table>

</body>
</html>
