package com.example.eventflowfrontend.services;

import com.example.eventflowfrontend.DTO.AddIndividualFeedbackRequestDTO;
import com.example.eventflowfrontend.DTO.FeedbackDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
import java.util.List;

public class FeedbackService {


    private static final String BASE_URL = "http://your-backend-url.com/api/feedback"; // Replace with your actual API base URL
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;

    public FeedbackService() {
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper(); // Used to convert Java objects to JSON and vice versa
    }

    // Create individual feedback
    public void createIndividualFeedback(AddIndividualFeedbackRequestDTO addIndividualFeedbackRequest) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(addIndividualFeedbackRequest);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/create/individual"))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to create individual feedback");
            }
        } catch (Exception e) {
            throw new RuntimeException("Error creating individual feedback", e);
        }
    }

    // Create group feedback
    public void createGroupFeedback(FeedbackDTO feedbackDTO, Integer eID) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(feedbackDTO);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/create/group/" + eID))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to create group feedback");
            }
        } catch (Exception e) {
            throw new RuntimeException("Error creating group feedback", e);
        }
    }

    // Update feedback
    public void update(Integer fID, FeedbackDTO feedbackDTO) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(feedbackDTO);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/update/" + fID))
                    .PUT(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to update feedback");
            }
        } catch (Exception e) {
            throw new RuntimeException("Error updating feedback", e);
        }
    }

    // Get feedback by feedback ID
    public FeedbackDTO getFeedback(Integer fID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + fID))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            return objectMapper.readValue(response.body(), FeedbackDTO.class);
        } catch (Exception e) {
            throw new RuntimeException("Failed to get feedback by ID", e);
        }
    }

    // Get feedback by event ID and user ID
    public List<FeedbackDTO> getAllFeedbackByeIDAnd_uID(Integer eID, Integer uID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + eID + "/" + uID))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of FeedbackDTO
            return Arrays.asList(objectMapper.readValue(response.body(), FeedbackDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to get feedback by event ID and user ID", e);
        }
    }
}

