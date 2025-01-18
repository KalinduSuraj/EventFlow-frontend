// Full updated EventService class
package com.example.eventflowfrontend.services;

import com.example.eventflowfrontend.DTO.EventDTO;
import com.example.eventflowfrontend.DTO.EventType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
import java.util.List;

public class EventService {

    private static final String BASE_URL = "http://be.eventsflow.online:8081/api/event"; // Replace with your API base URL
    private final HttpClient httpClient;
    private final ObjectMapper objectMapper;

    public EventService() {
        this.httpClient = HttpClient.newHttpClient();
        this.objectMapper = new ObjectMapper(); // Used to convert Java objects to JSON and vice versa
        objectMapper.registerModule(new JavaTimeModule());
    }

    // Fetch all events by type
    public List<EventDTO> getAllEvents(EventType type) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + type.name()))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of EventDTOs
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.registerModule(new JavaTimeModule()); // Register the JSR310 module

            // Convert the JSON response to a list of EventDTOs
            return Arrays.asList(objectMapper.readValue(response.body(), EventDTO[].class));
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch events", e);
        }
    }

    // Get a specific event by ID
    public EventDTO getEventById(int eID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + eID))
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

            // Convert the JSON response to a list of EventDTOs
            ObjectMapper objectMapper = new ObjectMapper();
            objectMapper.registerModule(new JavaTimeModule()); // Register the JSR310 module

            return objectMapper.readValue(response.body(), EventDTO.class);
        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch event by ID", e);
        }
    }

    // Create a new event
    public void createEvent(EventDTO event, EventType type) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(event);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + type.name()))
                    .POST(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200 && response.statusCode() != 201) {
                throw new RuntimeException("Failed to create event: " + response.body());
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to create event", e);
        }
    }

    // Update an existing event
    public void updateEvent(int eID, EventDTO event) {
        try {
            String jsonRequest = objectMapper.writeValueAsString(event);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + eID))
                    .PUT(HttpRequest.BodyPublishers.ofString(jsonRequest))
                    .header("Content-Type", "application/json")
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to update event");
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to update event: "+e.getMessage(), e);
        }
    }

    // Assign an announcement to an event
    public void assignAnnouncement(int eID, int aID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/assign/" + eID + "/" + aID))
                    .PUT(HttpRequest.BodyPublishers.noBody())
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to assign announcement: " + response.body());
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to assign announcement", e);
        }
    }

    // Unassign an announcement from an event
    public void unassignAnnouncement(int eID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/unassign/" + eID))
                    .PUT(HttpRequest.BodyPublishers.noBody())
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200) {
                throw new RuntimeException("Failed to unassign announcement: " + response.body());
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to unassign announcement", e);
        }
    }

    // Delete an event
    public void deleteEvent(int eID) {
        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(new URI(BASE_URL + "/" + eID))
                    .DELETE()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            if (response.statusCode() != 200 ) {
                throw new RuntimeException("Failed to delete event: " + response.body());
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to delete event", e);
        }
    }
}
