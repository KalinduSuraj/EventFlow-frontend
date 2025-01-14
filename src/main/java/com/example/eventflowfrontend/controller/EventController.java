package com.example.eventflowfrontend.controller;

import com.example.eventflowfrontend.DTO.EventDTO;
import com.example.eventflowfrontend.DTO.EventType;
import com.example.eventflowfrontend.services.EventService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(name = "EventController", urlPatterns = {"/events", "/eventDetails", "/createEvent", "/updateEvent", "/deleteEvent", "/assignAnnouncement", "/unassignAnnouncement"})
public class EventController extends HttpServlet {

    private final EventService eventService = new EventService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/events":
                String type = request.getParameter("type"); // "interview" or "workshop"
                EventType eventType = EventType.valueOf(type.toUpperCase());
                List<EventDTO> events = eventService.getAllEvents(eventType);
                request.setAttribute("events", events);
                request.getRequestDispatcher("event/display.jsp").forward(request, response);
                break;

            case "/eventDetails":
                int eID = Integer.parseInt(request.getParameter("eID"));
                EventDTO event = eventService.getEventById(eID);
                request.setAttribute("event", event);
                request.getRequestDispatcher("event/details.jsp").forward(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "create":
                    EventDTO newEvent = createEventFromRequest(request);
                    String type = request.getParameter("type");
                    EventType eventType = EventType.valueOf(type.toUpperCase());
                    eventService.createEvent(newEvent, eventType);
                    request.setAttribute("message", "Event created successfully.");
                    break;

                case "update":
                    int eID = Integer.parseInt(request.getParameter("eID"));
                    EventDTO updatedEvent = createEventFromRequest(request);
                    eventService.updateEvent(eID, updatedEvent);
                    request.setAttribute("message", "Event updated successfully.");
                    break;

                case "delete":
                    eID = Integer.parseInt(request.getParameter("eID"));
                    eventService.deleteEvent(eID);
                    request.setAttribute("message", "Event deleted successfully.");
                    break;

                case "assignAnnouncement":
                    eID = Integer.parseInt(request.getParameter("eID"));
                    int aID = Integer.parseInt(request.getParameter("aID"));
                    eventService.assignAnnouncement(eID, aID);
                    request.setAttribute("message", "Announcement assigned successfully.");
                    break;

                case "unassignAnnouncement":
                    eID = Integer.parseInt(request.getParameter("eID"));
                    eventService.unassignAnnouncement(eID);
                    request.setAttribute("message", "Announcement unassigned successfully.");
                    break;

                default:
                    request.setAttribute("message", "Invalid action.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "An error occurred: " + e.getMessage());
        }

        request.getRequestDispatcher("event/message.jsp").forward(request, response);
    }

    private EventDTO createEventFromRequest(HttpServletRequest request) {
        EventDTO event = new EventDTO();
        event.setTitle(request.getParameter("title"));
        event.setDescription(request.getParameter("description"));
        event.setStartDateTime(LocalDateTime.parse(request.getParameter("startDateTime")));
        event.setEventType(EventType.valueOf(request.getParameter("eventType").toUpperCase()));
        event.setIsActive(Boolean.parseBoolean(request.getParameter("isActive")));
        event.setCreatedBy(Integer.parseInt(request.getParameter("createdBy")));
        return event;
    }
}

