package com.example.eventflowfrontend.services;

import com.example.eventflowfrontend.DTO.AnnouncementDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
import java.util.List;

public class AnnouncementService {

    private static final String BASE_URL = "http://be.eventsflow.online:8081/api/announcements"; // Replace with your API base URL
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;

    public AnnouncementService() {
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper(); // Used to convert Java objects to JSON and vice versa
    }

    // Fetch all announcements created by a specific user (UID)
    public List<AnnouncementDTO> getAnnouncementsByUserID(int uid) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/created_by/" + uid))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of AnnouncementDTOs
            objectMapper.registerModule(new JavaTimeModule()); // Register the JSR310 module
            return Arrays.asList(objectMapper.readValue(response.body(), AnnouncementDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch announcements by user ID", e);
        }
    }

    // Fetch a specific announcement by its ID
    public AnnouncementDTO getAnnouncementById(int aid) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + aid))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to an AnnouncementDTO
            objectMapper.registerModule(new JavaTimeModule()); // Register the JSR310 module
            return objectMapper.readValue(response.body(), AnnouncementDTO.class);
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch announcement by ID", e);
        }
    }

    // Create a new announcement
    public void createAnnouncement(AnnouncementDTO announcement) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(announcement);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to create announcement");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to create announcement", e);
        }
    }

    // Fetch all batches assigned to an announcement
    public List<Integer> getAssignedBatches(int aid) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assigned/batch/" + aid))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of batch IDs
            return Arrays.asList(objectMapper.readValue(response.body(), Integer[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch assigned batches", e);
        }
    }

    // Fetch all students assigned to an announcement
    public List<Integer> getAssignedStudents(int aid) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assigned/student/" + aid))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of student IDs
            return Arrays.asList(objectMapper.readValue(response.body(), Integer[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch assigned students", e);
        }
    }

    // Fetch all announcements assigned to a student (UID)
    public List<AnnouncementDTO> getAssignedAnnouncementsByStudent(int uid) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assigned/announcement/student/" + uid))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of AnnouncementDTOs
            return Arrays.asList(objectMapper.readValue(response.body(), AnnouncementDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch assigned announcements by student", e);
        }
    }

    // Fetch all announcements assigned to a specific batch (bID)
    public List<AnnouncementDTO> getAssignedAnnouncementsByBatch(int bID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assigned/announcement/batch/" + bID))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of AnnouncementDTOs
            return Arrays.asList(objectMapper.readValue(response.body(), AnnouncementDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch assigned announcements by batch", e);
        }
    }
}
