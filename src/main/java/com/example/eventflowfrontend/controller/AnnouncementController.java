package com.example.eventflowfrontend.controller;

import com.example.eventflowfrontend.DTO.AnnouncementDTO;
import com.example.eventflowfrontend.services.AnnouncementService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AnnouncementController", urlPatterns = {
        "/viewAnnouncementsByUser",
        "/addAnnouncement",

})
public class AnnouncementController extends HttpServlet {

    private final AnnouncementService announcementService = new AnnouncementService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        String message = null;

        try {
            switch (path) {
                case "/viewAnnouncementsByUser":
                    int userID = Integer.parseInt(request.getParameter("uid"));
                    List<AnnouncementDTO> announcements = announcementService.getAnnouncementsByUserID(userID);
                    request.setAttribute("announcements", announcements);
                    request.getRequestDispatcher("announcement/manage_announcements.jsp").forward(request, response);
                    break;

                case "/addAnnouncement":
                    request.getRequestDispatcher("announcement/create_announcement.jsp").forward(request, response);
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
                case "/addAnnouncement":
                    handleAddAnnouncement(request, response);
                    break;



                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<script>alert('An error occurred: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='error.jsp';</script>");
        }
    }

    private void handleAddAnnouncement(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Validate input parameters
            if (request.getParameter("subject") == null || request.getParameter("message") == null || request.getParameter("createdBy") == null) {
                throw new IllegalArgumentException("Invalid input: Missing required fields.");
            }

            // Create the announcement DTO
            AnnouncementDTO announcement = createAnnouncementFromRequest(request);

            // Call the service to create the announcement
            announcementService.createAnnouncement(announcement);

            // If successful, redirect with a success message
            response.getWriter().println("<script>alert('Announcement added successfully.'); window.location.href='viewAnnouncementsByUser?uid=" + announcement.getCreatedBy() + "';</script>");
        } catch (IllegalArgumentException e) {
            response.getWriter().println("<script>alert('Input validation error: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='announcement/create_announcement.jsp';</script>");
        } catch (Exception e) {
            // Log the stack trace for debugging
            e.printStackTrace();

            // Show a detailed error message
            response.getWriter().println("<script>alert('Failed to add announcement: " + e.getMessage().replace("'", "\\'") + "'); window.location.href='announcement/create_announcement.jsp';</script>");
        }
    }


    private AnnouncementDTO createAnnouncementFromRequest(HttpServletRequest request) {
        AnnouncementDTO announcement = new AnnouncementDTO();
        announcement.setSubject(request.getParameter("subject"));
        announcement.setMessage(request.getParameter("message"));
        announcement.setCreatedBy(Long.parseLong(request.getParameter("createdBy")));
        return announcement;
    }
}
