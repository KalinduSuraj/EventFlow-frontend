// Full EventController with enhanced functionality
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

@WebServlet(name = "EventController", urlPatterns = {
        "/display_workshop",
        "/display_interview",
        "/updateEvent",
        "/addWorkshop",
        "/addInterview",
        "/updateEvent",
        "/deleteEvent",
        "/assignAnnouncement",
        "/unassignAnnouncement"
})
public class EventController extends HttpServlet {

    private final EventService eventService = new EventService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/display_workshop":
                try {
                    List<EventDTO> workshops = eventService.getAllEvents(EventType.workshop);
                    request.setAttribute("workshops", workshops);
                    request.getRequestDispatcher("event/manage_workshop.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load workshops.");
                    request.getRequestDispatcher("event/manage_workshop.jsp").forward(request, response);
                }
                break;

            case "/display_interview":
                try {
                    List<EventDTO> interviews = eventService.getAllEvents(EventType.interview);
                    request.setAttribute("interviews", interviews);
                    request.getRequestDispatcher("event/teacher_interview.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load interviews.");
                    request.getRequestDispatcher("event/teacher_interview.jsp").forward(request, response);
                }
                break;

            case "/updateEvent":
                int eID = Integer.parseInt(request.getParameter("id"));
                EventDTO eventDTO = eventService.getEventById(eID);
                request.setAttribute("event", eventDTO);
                request.getRequestDispatcher("event/update_event.jsp").forward(request, response);
                break;

            case "/addWorkshop":
                request.getRequestDispatcher("event/create_workshop.jsp").forward(request, response);
                break;

            case "/addInterview":
                request.getRequestDispatcher("event/create_interview.jsp").forward(request, response);
                break;

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        int eID = 0;

        if ("/updateEvent".equals(path)) {
            eID = Integer.parseInt(request.getParameter("id"));
        }

        try {
            switch (path) {
                case "/addWorkshop":
                    handleAddWorkshop(request, response);
                    break;

                case "/addInterview":
                    handleAddInterview(request, response);
                    break;

                case "/updateEvent":
                    EventDTO updatedEvent = new EventDTO();
                    updatedEvent.setTitle(request.getParameter("title"));
                    updatedEvent.setDescription(request.getParameter("description"));
                    updatedEvent.setStartDateTime(LocalDateTime.parse(request.getParameter("scheduled_datetime")));
                    System.out.println(updatedEvent);
                    eventService.updateEvent(eID, updatedEvent);
                    request.setAttribute("message", "Event updated successfully.");
                    response.sendRedirect("updateEvent?id=" + eID);
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
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);


            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            response.sendRedirect("error.jsp");
        }

    }

    private void handleAddWorkshop(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Collecting form data
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String startDateTime = request.getParameter("startDateTime");
            String createdBy = request.getParameter("createdBy");

            // Parsing and validating data
            LocalDateTime parsedStartDateTime = LocalDateTime.parse(startDateTime);
            int parsedCreatedBy = Integer.parseInt(createdBy);

            // Creating the EventDTO
            EventDTO newWorkshop = new EventDTO();
            newWorkshop.setTitle(title);
            newWorkshop.setDescription(description);
            newWorkshop.setStartDateTime(parsedStartDateTime);
            newWorkshop.setCreatedBy(parsedCreatedBy);

            // Saving the event using EventService
            eventService.createEvent(newWorkshop, EventType.workshop);

            // Redirecting to display workshops page
            response.sendRedirect("display_workshop?type=workshop");
        } catch (Exception e) {
            throw new ServletException("Failed to add workshop: " + e.getMessage(), e);
        }
    }

    private void handleAddInterview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Collecting form data
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String startDateTime = request.getParameter("startDateTime");
            String createdBy = request.getParameter("createdBy");

            // Parsing and validating data
            LocalDateTime parsedStartDateTime = LocalDateTime.parse(startDateTime);
            int parsedCreatedBy = Integer.parseInt(createdBy);

            // Creating the EventDTO
            EventDTO newInterview = new EventDTO();
            newInterview.setTitle(title);
            newInterview.setDescription(description);
            newInterview.setStartDateTime(parsedStartDateTime);
            newInterview.setCreatedBy(parsedCreatedBy);

            // Saving the event using EventService
            eventService.createEvent(newInterview, EventType.interview);

            // Redirecting to display interviews page
            response.sendRedirect("display_interview?type=interview");
        } catch (Exception e) {
            throw new ServletException("Failed to add interview: " + e.getMessage(), e);
        }
    }
}
