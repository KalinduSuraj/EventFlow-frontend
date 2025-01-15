package com.example.eventflowfrontend.services;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
//import org.json.*;

public class InterviewService extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // URL of the API endpoint
        String apiUrl = "{{host}}/api/event/interview";  // Replace {{host}} with your actual host URL
        StringBuilder responseContent = new StringBuilder();

        try {
            // Creating a URL object and open connection
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            // Read the response from the API
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            while ((inputLine = in.readLine()) != null) {
                responseContent.append(inputLine);
            }
            in.close();

            // Set the API response as an attribute in the request
            request.setAttribute("apiResponse", responseContent.toString());
        } catch (Exception e) {
            // Handle exceptions (e.g., network errors)
            e.printStackTrace();
            request.setAttribute("apiResponse", "Error loading data");
        }

        // Forward the request to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("/teacher_interview.jsp");
        dispatcher.forward(request, response);
    }
}

