package com.example.eventflowfrontend.services;

import com.example.eventflowfrontend.DTO.AttendanceDTO;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

public class AttendanceService {

    private static final String BASE_URL = "http://be.eventsflow.online:8081/api/event"; // Replace with your API base URL
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;

    public AttendanceService() {
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper(); // Used for JSON serialization/deserialization
    }

    // Mark attendance for a specific event
    public void markAttendance(int eventId, AttendanceDTO attendanceDTO) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(attendanceDTO);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/attendance/" + eventId))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to mark attendance: " + response.body());
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to mark attendance", e);
        }
    }

    // Fetch attendance for a specific event
    public AttendanceDTO getAttendance(int eventId) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/attendance/event/" + eventId))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                return objectMapper.readValue(response.body(), AttendanceDTO.class);
            } else {
                throw new RuntimeException("Failed to fetch attendance: " + response.body());
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch attendance", e);
        }
    }

    // Update attendance points for a specific student in an event
    public void updateAttendance(int studentEventId, int points) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/attendance/" + studentEventId + "/" + points))
                    .PUT(HttpRequest.BodyPublishers.noBody())
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to update attendance: " + response.body());
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to update attendance", e);
        }
    }

    // Delete attendance for a specific student in an event
    public void deleteAttendance(int studentEventId) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/attendance/" + studentEventId))
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to delete attendance: " + response.body());
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete attendance", e);
        }
    }
}
