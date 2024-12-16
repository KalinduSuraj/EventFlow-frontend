<%--
  Created by IntelliJ IDEA.
  User: gavee liyanage
  Date: 16-Dec-24
  Time: 9:54 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In Form</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <meta http-equiv="refresh" content="120"/>
</head>

<body class="bg-gray-100">

<!-- Main Container -->
<div class="flex justify-center items-center min-h-screen">
    <!-- Login Container -->
    <div class="flex flex-row-reverse bg-white rounded-lg shadow-lg w-3/4 lg:w-2/3 min-h-[500px]">

        <!-- Login Form Section -->
        <div class="w-full lg:w-1/2 p-8 flex items-center">
            <div class="w-full">
                <h2 class="text-2xl font-bold text-gray-700 text-center mb-6"> Sign In </h2>

                <!-- Login Form -->
                <form action="Login.jsp" method="POST" class="space-y-4">

                    <!-- Username Input -->
                    <div>
                        <input
                                type="text"
                                name="username"
                                placeholder="Username"
                                required
                                class="w-full px-4 py-2 border rounded-md text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500"
                        >
                    </div>

                    <!-- Password Input -->
                    <div>
                        <input
                                type="password"
                                name="password"
                                placeholder="Password"
                                required
                                class="w-full px-4 py-2 border rounded-md text-gray-700 focus:outline-none focus:ring-2 focus:ring-blue-500"
                        >
                    </div>

                    <!-- Login Button -->
                    <button
                            type="submit"
                            class="w-full bg-blue-500 text-white py-2 rounded-md hover:bg-blue-600 transition duration-200"
                    >
                        Login
                    </button>
                </form>
            </div>
        </div>

        <!-- Illustration Section -->
        <div class="hidden lg:block w-1/2 bg-gray-200 rounded-r-lg">
            <img
                    src="image/log_1.jpg"
                    alt="Illustration"
                    class="w-full h-full object-cover rounded-r-lg"
            >
        </div>
    </div>
</div>

<!-- Placeholder for API Integration
<script>
    // Example: Call API to fetch data
    async function callApi() {
        try {
            const response = await fetch('https://api.example.com/data');
            const data = await response.json();
            console.log('API Response:', data);
        } catch (error) {
            console.error('Error fetching API:', error);
        }
    }

    // Call API on page load
    callApi();
</script> -->

</body>
</html>


