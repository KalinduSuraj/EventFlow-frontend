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

@WebServlet(name = "EventController", urlPatterns = {"/display_workshop","/display_interview", "/updateEvent", "/addWorkshop", "/updateEvent", "/deleteEvent", "/assignAnnouncement", "/unassignAnnouncement"})
public class EventController extends HttpServlet {

    private final EventService eventService = new EventService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/display_workshop":
                try {
                    String type = request.getParameter("type");
                    if ("workshop".equals(type)) {
                        List<EventDTO> events = eventService.getAllEvents(EventType.workshop);
                        request.setAttribute("workshops", events);
                        request.getRequestDispatcher("event/manage_workshop.jsp").forward(request, response);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load workshops.");
                    request.getRequestDispatcher("event/manage_workshop.jsp").forward(request, response);
                }
                break;

            case "/display_interview":
                try {
                    String type = request.getParameter("type");
                    if ("interview".equals(type)) {
                        List<EventDTO> events = eventService.getAllEvents(EventType.interview);
                        request.setAttribute("interviews", events);
                        request.getRequestDispatcher("event/teacher_interview.jsp").forward(request, response);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load interviews.");
                    request.getRequestDispatcher("event/teacher_interview.jsp").forward(request, response);
                }
                break;


            case "/updateEvent":
                int eID = Integer.parseInt(request.getParameter("id"));
                String type = request.getParameter("type");
                if (type.equals("workshop")) {
                    EventDTO event = eventService.getEventById(eID);
                    request.setAttribute("workshop", event);
                    request.getRequestDispatcher("event/update_event.jsp").forward(request, response);
                }

                break;
            case "/addWorkshop":
                request.getRequestDispatcher("event/create_workshop.jsp").forward(request, response);


            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println(action);
        try {
            switch (action) {
                case "create":
                    System.out.println("hello");
                    EventDTO newEvent = createEventFromRequest(request);
                    String type = request.getParameter("type");
                    if (type.equals("workshop")) {
                        eventService.createEvent(newEvent, EventType.workshop);
                        request.setAttribute("message", "Event created successfully.");
                        request.getRequestDispatcher("event/create_workshop.jsp").forward(request, response);
                    }
                    break;

                case "update":
                    int eID = Integer.parseInt(request.getParameter("id"));
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
            //request.getRequestDispatcher("event/manage_workshop.jsp").forward(request, response);
            System.out.println(e.getMessage());
        }


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

