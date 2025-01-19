<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*, java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <title>Create Announcement</title>
</head>
<body class="bg-white flex items-center justify-center min-h-screen">

<!-- Form Box -->
<div class="bg-blue-200 shadow-lg rounded-lg p-8 max-w-md w-full mt-16">
    <h2 class="text-2xl font-bold text-center mb-4 py-3">Create Announcement</h2>

    <!-- Response Message -->
    <div id="responseMessage" class="text-center text-sm mb-4"></div>

    <form id="announcementForm" action="addAnnouncement" method="post" class="space-y-3">
        <input type="hidden" name="action" value="create"/>
        <input type="hidden" name="createdBy" value="<%= request.getParameter("createdBy") %>"/>
        <input type="hidden" name="id" value="<%="aID"%>"/>

        <div>
            <label for="subject" class="block text-sm font-medium text-gray-700 py-2">Subject</label>
            <input type="text" id="subject" name="subject" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3" placeholder="Enter the subject" required>
        </div>

        <div>
            <label for="message" class="block text-sm font-medium text-gray-700 py-2">Message</label>
            <textarea id="message" name="message" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3" placeholder="Enter your message here" required></textarea>
        </div>

        <div>
            <label for="batches" class="block text-sm font-medium text-gray-700 py-2">Batches (comma-separated IDs)</label>
            <input type="text" id="batches" name="batches" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3" placeholder="1,2,3" />
        </div>
        <div>
            <label for="students" class="block text-sm font-medium text-gray-700 py-2">Students (comma-separated IDs)</label>
            <input type="text" id="students" name="students" class="mt-1 block w-full border-gray-800 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500 sm:text-sm py-3" placeholder="12,13,14" />
        </div>


        <!-- Buttons Section -->
        <div class="space-y-10">
            <div class="flex space-x-4">
                <button type="submit" class="w-1/2 bg-blue-700 text-white py-2 px-4 rounded-lg hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2">
                    Save
                </button>

                <a href="event/display_workshop"
                   class="w-1/2 bg-gray-500 text-white py-2 px-4 rounded-lg hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-gray-500 focus:ring-offset-2 text-center">
                    Cancel
                </a>
            </div>
        </div>
    </form>
</div>
<script>
    document.getElementById('saveButton').addEventListener('click', function () {
        // Collect form data
        const subject = document.getElementById('subject').value;
        const message = document.getElementById('message').value;
        const createdBy = document.getElementById('createdBy').value;

        // Parse batch and student IDs into arrays
        const batches = document.getElementById('batches').value
            .split(',')
            .map(id => id.trim()) // Remove extra whitespace
            .filter(id => id !== ''); // Remove empty entries

        const students = document.getElementById('students').value
            .split(',')
            .map(id => id.trim())
            .filter(id => id !== '');

        // Prepare the data object
        const data = {
            subject,
            message,
            createdBy,
            batches: batches.length ? batches.map(id => parseInt(id)) : [], // Convert to numbers
            students: students.length ? students.map(id => parseInt(id)) : []
        };

        // Send POST request
        fetch('/api/announcements', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data),
        })
            .then(response => {
                if (!response.ok) {
                    return response.text().then(errorMessage => {
                        throw new Error(errorMessage);
                    });
                }
                return response.json();
            })
            .then(responseData => {
                alert('Announcement created successfully!');
                window.location.href = '/viewAnnouncementsByUser?uid=' + createdBy;
            })
            .catch(error => {
                document.getElementById('responseMessage').innerText = `Error: ${error.message}`;
                document.getElementById('responseMessage').classList.add('text-red-600');
            });
    });
</script>

</body>
</html>
