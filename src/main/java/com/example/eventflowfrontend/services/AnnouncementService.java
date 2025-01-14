package com.example.eventflowfrontend.services;

import com.example.eventflowfrontend.DTO.AnnouncementDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

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

    // Fetch all announcements created by a specific user
    public List<AnnouncementDTO> getAnnouncementsByUserId(int uid) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/created_by/" + uid))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of AnnouncementDTOs
            return Arrays.asList(objectMapper.readValue(response.body(), AnnouncementDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch announcements by user ID", e);
        }
    }

    // Get a specific announcement by its ID
    public AnnouncementDTO getAnnouncementById(int aID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + aID))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to an AnnouncementDTO
            return objectMapper.readValue(response.body(), AnnouncementDTO.class);
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch announcement by ID", e);
        }
    }

    // Add a new announcement via the backend API
    public void addAnnouncement(AnnouncementDTO announcementDTO) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(announcementDTO);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to add announcement");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to add announcement", e);
        }
    }

    // Get all announcements assigned to a specific batch
    public List<AnnouncementDTO> getAnnouncementsByBatchId(int batchId) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assigned/announcement/batch/" + batchId))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of AnnouncementDTOs
            return Arrays.asList(objectMapper.readValue(response.body(), AnnouncementDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch announcements by batch ID", e);
        }
    }

    // Get all announcements assigned to a specific student
    public List<AnnouncementDTO> getAnnouncementsByStudentId(int studentId) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assigned/announcement/student/" + studentId))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of AnnouncementDTOs
            return Arrays.asList(objectMapper.readValue(response.body(), AnnouncementDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch announcements by student ID", e);
        }
    }

    // Update an existing announcement via the backend API
    public void updateAnnouncement(AnnouncementDTO announcementDTO) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(announcementDTO);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + announcementDTO.getAID()))
                    .PUT(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to update announcement");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to update announcement", e);
        }
    }

    // Delete an announcement from the backend via the API
    public void deleteAnnouncement(int aID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + aID))
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to delete announcement");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete announcement", e);
        }
    }
}
