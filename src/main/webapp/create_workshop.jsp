<%@ page import="java.io.*, java.net.*, javax.servlet.*, javax.servlet.http.*, org.json.JSONObject" %>
<%
  String responseMessage = null;
  String responseStatus = null;

  if ("POST".equalsIgnoreCase(request.getMethod())) {
    // Get form parameters
    String batchName = request.getParameter("batchName");
    String commonEmail = request.getParameter("commonEmail");
    String createdBy = request.getParameter("createdBy");

    // Prepare data as JSON
    JSONObject batchData = new JSONObject();
    batchData.put("batchName", batchName);
    batchData.put("commonEmail", commonEmail);
    batchData.put("createdBy", createdBy);

    // Create connection to API
    try {
      URL url = new URL("https://virtserver.swaggerhub.com/ANUSHIDESILVA28/EAD2/1.0.0");
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("POST");
      conn.setRequestProperty("Content-Type", "application/json");
      conn.setDoOutput(true);

      try (OutputStream os = conn.getOutputStream()) {
        byte[] input = batchData.toString().getBytes("utf-8");
        os.write(input, 0, input.length);
      }

      int responseCode = conn.getResponseCode();

      if (responseCode == HttpURLConnection.HTTP_OK) {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
          StringBuilder apiResponse = new StringBuilder();
          String responseLine;
          while ((responseLine = br.readLine()) != null) {
            apiResponse.append(responseLine.trim());
          }
          JSONObject jsonResponse = new JSONObject(response.toString());
          responseMessage = jsonResponse.getString("message");
          responseStatus = "success";
        }
      } else {
        responseMessage = "Failed to create batch.";
        responseStatus = "error";
      }

    } catch (IOException e) {
      responseMessage = "Error: " + e.getMessage();
      responseStatus = "error";
    }
  }
%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="https://cdn.tailwindcss.com"></script>
  <title>Create New Batch</title>
</head>
<body class="bg-white flex items-center justify-center min-h-screen">

<!-- Navbar -->
<nav class="bg-blue-200 shadow-md fixed top-0 w-full z-10">
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
    <div class="flex justify-between h-16">
      <!-- Left Nav -->
      <div class="flex-shrink-0 flex items-center space-x-4">
        <a href="teacher_dashboard.jsp"
           class="text-gray-600 hover:text-white px-3 py-2
                  <%= request.getRequestURI().contains("teacher_dashboard.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
          Workshop
        </a>
        <a href="teacher_interview.jsp"
           class="text-gray-600 hover:text-sky-700 px-3 py-2
                  <%= request.getRequestURI().contains("teacher_interview.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
          Interview
        </a>
        <a href="teacher_announcement.jsp"
           class="text-gray-600 hover:text-sky-700 px-3 py-2
                  <%= request.getRequestURI().contains("teacher_announcement.jsp") ? "bg-sky-700 text-white rounded" : "" %>">
          Announcement
        </a>
      </div>

      <!-- Right Nav -->
      <div class="flex items-center">
        <a href="#" class="text-sky-800 font-semibold text-lg px-3 py-2"> EventFlow </a>
      </div>
    </div>
  </div>
</nav>

<!-- Form Box -->
<div class="bg-blue-200 shadow-lg rounded-lg p-8 max-w-md w-full mt-16">
  <h2 class="text-2xl font-bold text-center mb-4 py-3">Create New Batch</h2>

  <% if (responseMessage != null) { %>
  <div class="mb-4 text-center <%= "success".equals(responseStatus) ? "text-green-500" : "text-red-500" %>">
    <%= responseMessage %>
  </div>
  <% } %>

  <form id="batchForm" class="space-y-3">
    <div>
      <label for="batchName" class="block text-sm font-medium text-gray-700 py-2">Batch Name</label>
      <input type="text" id="batchName" name="batchName" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3" placeholder="Batch A" required>
    </div>
    <div>
      <label for="commonEmail" class="block text-sm font-medium text-gray-700 py-2">Email Address</label>
      <input type="email" id="commonEmail" name="commonEmail" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3 pb-2" placeholder="batchA@example.com" required>
    </div>

    <!-- Buttons Section -->
    <div class="space-y-10">
      <!-- Spacer between inputs and buttons -->
      <div></div>

      <div class="flex space-x-4">
        <button type="submit" class="w-1/2 bg-blue-700 text-white py-2 px-4 rounded-lg hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
          Save
        </button>

        <a href="manage_workshop.jsp"
           class="w-1/2 bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 text-center">
          Cancel
        </a>
      </div>
    </div>

  </form>
  <div id="responseMessage" class="mt-4 text-center text-sm"></div>
</div>


</body>
</html>


