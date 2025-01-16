package com.example.eventflowfrontend.services;

import com.example.eventflowfrontend.DTO.AttendanceDTO;
import com.example.eventflowfrontend.DTO.BatchDTO;
import com.example.eventflowfrontend.services.BatchService;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
import java.util.List;

public class BatchService {

    private static final String BASE_URL = "http://be.eventsflow.online:8081/api/batches";
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;

    public BatchService() {
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper();
    }

    public List<BatchDTO> findAll() {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return Arrays.asList(objectMapper.readValue(response.body(), BatchDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch all batches", e);
        }
    }

    public BatchDTO findById(Long id) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + id))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            return objectMapper.readValue(response.body(), BatchDTO.class);
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch batch by ID", e);
        }
    }

    public void create(BatchDTO batchDTO) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(batchDTO);

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
            throw new RuntimeException("Failed to create batch", e);
        }
    }

    public void update(Long id, BatchDTO batchDTO) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(batchDTO);

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
            throw new RuntimeException("Failed to update batch", e);
        }
    }

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
            throw new RuntimeException("Failed to delete batch", e);
        }
    }

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
                throw new RuntimeException("Failed to assign user to batch");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to assign user to batch", e);
        }
    }

    public void unassignUser(Long id) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assign/" + id))
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to unassign user from batch");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to unassign user from batch", e);
        }
    }
}
