<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Create New Batch</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-900">

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
<div class="container mx-auto my-10 max-w-lg bg-white p-8 rounded-lg shadow-lg">
  <h1 class="text-2xl font-bold mb-6 text-center text-blue-600">Create New Batch</h1>

  <!-- Display Messages -->
  <% String message = (String) request.getAttribute("message"); %>
  <% if (message != null) { %>
  <p class="<%= message.contains("successfully") ? "text-green-600" : "text-red-600" %> text-center mb-4">
    <%= message %>
  </p>
  <% } %>

  <!-- Add Batch Form -->
  <form action="addBatch" method="post" class="space-y-4">
    <input type="hidden" name="action" value="add"/>

    <!-- Batch Name Field -->
    <label class="block">
      <span class="text-gray-700">Batch Name:</span>
      <input type="text" name="batchName" required
             class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
    </label>

    <!-- Common Email Field -->
    <label class="block">
      <span class="text-gray-700">Common Email:</span>
      <input type="email" name="commonEmail" required
             class="mt-1 block w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"/>
    </label>

    <!-- Submit Button -->
    <div class="flex justify-center mt-6">
      <button type="submit"
              class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition duration-300">
        Create Batch
      </button>
    </div>
  </form>
</div>

</body>
</html>
