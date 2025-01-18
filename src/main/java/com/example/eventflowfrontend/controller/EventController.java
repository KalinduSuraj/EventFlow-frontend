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
        "/deleteEvent",
        "/assignAnnouncement",
        "/unassignAnnouncement"
})
public class EventController extends HttpServlet {

    private final EventService eventService = new EventService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String message = null;

        try {
            switch (path) {
                case "/display_workshop":
                    List<EventDTO> workshops = eventService.getAllEvents(EventType.workshop);
                    request.setAttribute("workshops", workshops);
                    request.getRequestDispatcher("event/manage_workshop.jsp").forward(request, response);
                    break;

                case "/display_interview":
                    List<EventDTO> interviews = eventService.getAllEvents(EventType.interview);
                    request.setAttribute("interviews", interviews);
                    request.getRequestDispatcher("event/teacher_interview.jsp").forward(request, response);
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

                case "/deleteEvent":
                    int eventIdToDelete = Integer.parseInt(request.getParameter("id"));
                    String eventType = request.getParameter("type");

                    eventService.deleteEvent(eventIdToDelete);

                    message = "Event deleted successfully.";

                    String redirectPage = "display_workshop";
                    if ("interview".equalsIgnoreCase(eventType)) {
                        redirectPage = "display_interview";
                    }

                    response.getWriter().println("<script>alert('" + message + "'); window.location.href='" + redirectPage + "';</script>");
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='error.jsp';</script>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String message = null;

        try {
            switch (path) {
                case "/addWorkshop":
                    handleAddWorkshop(request, response);
                    break;

                case "/addInterview":
                    handleAddInterview(request, response);
                    break;

                case "/updateEvent":
                    int eID = Integer.parseInt(request.getParameter("id"));
                    EventDTO updatedEvent = new EventDTO();
                    updatedEvent.setTitle(request.getParameter("title"));
                    updatedEvent.setDescription(request.getParameter("description"));
                    updatedEvent.setStartDateTime(LocalDateTime.parse(request.getParameter("scheduled_datetime")));
                    eventService.updateEvent(eID, updatedEvent);
                    message = "Event updated successfully.";
                    response.getWriter().println("<script>alert('" + message + "'); window.location.href='updateEvent?id=" + eID + "';</script>");
                    break;

                case "/assignAnnouncement":
                    int eventId = Integer.parseInt(request.getParameter("eID"));
                    int announcementId = Integer.parseInt(request.getParameter("aID"));
                    eventService.assignAnnouncement(eventId, announcementId);
                    message = "Announcement assigned successfully.";
                    response.getWriter().println("<script>alert('" + message + "'); window.location.href='assignAnnouncement';</script>");
                    break;

                case "/unassignAnnouncement":
                    int eIDUnassign = Integer.parseInt(request.getParameter("eID"));
                    eventService.unassignAnnouncement(eIDUnassign);
                    message = "Announcement unassigned successfully.";
                    response.getWriter().println("<script>alert('" + message + "'); window.location.href='unassignAnnouncement';</script>");
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='error.jsp';</script>");
        }
    }

    private void handleAddWorkshop(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String startDateTime = request.getParameter("startDateTime");
            String createdBy = request.getParameter("createdBy");

            LocalDateTime parsedStartDateTime = LocalDateTime.parse(startDateTime);
            int parsedCreatedBy = Integer.parseInt(createdBy);

            EventDTO newWorkshop = new EventDTO();
            newWorkshop.setTitle(title);
            newWorkshop.setDescription(description);
            newWorkshop.setStartDateTime(parsedStartDateTime);
            newWorkshop.setCreatedBy(parsedCreatedBy);

            eventService.createEvent(newWorkshop, EventType.workshop);

            response.getWriter().println("<script>alert('Workshop added successfully.'); window.location.href='display_workshop?type=workshop';</script>");
        } catch (Exception e) {
            response.getWriter().println("<script>alert('Failed to add workshop: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='event/create_workshop.jsp';</script>");
        }
    }

    private void handleAddInterview(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String startDateTime = request.getParameter("startDateTime");
            String createdBy = request.getParameter("createdBy");

            LocalDateTime parsedStartDateTime = LocalDateTime.parse(startDateTime);
            int parsedCreatedBy = Integer.parseInt(createdBy);

            EventDTO newInterview = new EventDTO();
            newInterview.setTitle(title);
            newInterview.setDescription(description);
            newInterview.setStartDateTime(parsedStartDateTime);
            newInterview.setCreatedBy(parsedCreatedBy);

            eventService.createEvent(newInterview, EventType.interview);

            response.getWriter().println("<script>alert('Interview added successfully.'); window.location.href='display_interview?type=interview';</script>");
        } catch (Exception e) {
            response.getWriter().println("<script>alert('Failed to add interview: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='event/create_interview.jsp';</script>");
        }
    }
}
