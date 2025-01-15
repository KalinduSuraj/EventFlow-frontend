package com.example.eventflowfrontend.services;

import com.example.eventflowfrontend.DTO.UserDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
import java.util.List;


public class UserService {

    private static final String BASE_URL = "http://be.eventsflow.online:8081/api/users"; // Replace with your API base URL
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;

    public UserService() {
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper(); // Used to convert Java objects to JSON and vice versa
    }

    // Fetch all users from the backend
    public List<UserDTO> getAllUsers(String type) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + type))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of RecordDTOs
            return Arrays.asList(objectMapper.readValue(response.body(), UserDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch users", e);
        }
    }

    // Get a specific user by ID from the backend
    public UserDTO getUserById(int id) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + id))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a RecordDTO
            return objectMapper.readValue(response.body(), UserDTO.class);
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch user by ID", e);
        }
    }

    // Add a new user via the backend API
    public void addUser(String type,UserDTO user) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(user);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/create/" + type))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();
            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to add user");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new RuntimeException("Failed to add user", e);
        }
    }

    // Update an existing user via the backend API
    public void updateUser(UserDTO user) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(user);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + user.getUID()))
                    .PUT(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to update user");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to update user", e);
        }
    }

    // Delete a user from the backend via the API
    public void deleteUser(int uid) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + uid))
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to delete user");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete user", e);
        }
    }
}

