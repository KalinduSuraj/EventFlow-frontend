package com.example.eventflowfrontend.services;

import com.example.eventflowfrontend.DTO.BatchDTO;
import com.example.eventflowfrontend.DTO.AttendanceDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
import java.util.List;

public class BatchService {

    private static final String BASE_URL = "http://be.eventflow.online:8081/api/batches"; // Adjust the URL as needed
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;

    public BatchService() {
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper();
    }

    // Fetch all batches
    public List<BatchDTO> getAllBatches() {
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

    // Get batch by ID
    public BatchDTO getBatchById(int batchId) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + batchId))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return objectMapper.readValue(response.body(), BatchDTO.class);
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch batch by ID", e);
        }
    }

    // Create a new batch
    public void createBatch(BatchDTO batch) {
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
    public void updateBatch(BatchDTO batch) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(batch);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + batch.getBID()))
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
    public void deleteBatch(int batchId) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + batchId))
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

    // Assign a student to a batch
    public void assignStudentToBatch(int batchId, AttendanceDTO attendanceDTO) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(attendanceDTO);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assign/" + batchId))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to assign student to batch");
            }
        } catch (Exception e) {
            throw new RuntimeException("Student assignment failed", e);
        }
    }

    // Unassign a student from a batch
    public void unassignStudentFromBatch(int studentId) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assign/" + studentId))
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to unassign student from batch");
            }
        } catch (Exception e) {
            throw new RuntimeException("Unassign student failed", e);
        }
    }
}
