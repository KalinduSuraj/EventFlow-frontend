package com.example.eventflowfrontend.services.;

import com.example.eventflowfrontend.DTO.BatchDTO;
import com.example.eventflowfrontend.services.BatchService;
import com.example.eventflowfrontend.services.AnnouncementService;
import com.example.eventflowfrontend.services.EventService;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
import java.util.List;

public class BatchService {

    private static final String BASE_URL = "http://be.eventsflow.online:8081/api/batches"; // Replace with your API base URL
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;

    public BatchService() {
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper(); // Used to convert Java objects to JSON and vice versa
    }

    // Create a new batch
    public void create(BatchDTO batch) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(batch);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to create batch");
            }
        } catch (Exception e) {
            throw new RuntimeException("Batch creation failed", e);
        }
    }

    // Update an existing batch
    public void update(Long id, BatchDTO updatedBatch) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(updatedBatch);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + id))
                    .PUT(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to update batch");
            }
        } catch (Exception e) {
            throw new RuntimeException("Batch update failed", e);
        }
    }

    // Delete a batch
    public void delete(Long id) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + id))
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to delete batch");
            }
        } catch (Exception e) {
            throw new RuntimeException("Batch deletion failed", e);
        }
    }

    // Assign a user to a batch
    public void assignUser(Long bID, AttendanceDTO attendanceDTO) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(attendanceDTO);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assign/" + bID))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to assign user");
            }
        } catch (Exception e) {
            throw new RuntimeException("User assignment failed", e);
        }
    }

    // Unassign a user from a batch
    public void unassignUser(Long id) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assign/" + id))
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to unassign user");
            }
        } catch (Exception e) {
            throw new RuntimeException("User unassignment failed", e);
        }
    }

    // Fetch all batches
    public List<BatchDTO> findAll() {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return Arrays.asList(objectMapper.readValue(response.body(), BatchDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch batches", e);
        }
    }

    // Fetch a batch by ID
    public BatchDTO findById(Long id) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + id))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return objectMapper.readValue(response.body(), BatchDTO.class);
        } catch (Exception e) {
            throw new RuntimeException("Batch not found", e);
        }
    }

    // Fetch users by batch ID
    public List<Object> findUsersByBatch(Long bID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/allStudents/" + bID))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return Arrays.asList(objectMapper.readValue(response.body(), Object[].class));
        } catch (Exception e) {
            throw new RuntimeException("Batch not found", e);
        }
    }

    // Fetch batches by user ID
    public List<Object> findBatchesByUser(Long uID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/allBatches/" + uID))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return Arrays.asList(objectMapper.readValue(response.body(), Object[].class));
        } catch (Exception e) {
            throw new RuntimeException("User not found", e);
        }
    }
}
