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
        "/addAnnouncement",
        "/viewAnnouncement",
        "/viewAnnouncementsByUser",
        "/viewAssignedBatches",
        "/viewAssignedStudents",
        "/viewAssignedAnnouncementsByStudent",
        "/viewAssignedAnnouncementsByBatch"
})
public class AnnouncementController extends HttpServlet {

    private final AnnouncementService announcementService = new AnnouncementService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        switch (path) {
            case "/viewAnnouncement":
                try {
                    int aID = Integer.parseInt(request.getParameter("aID"));
                    if ("announcement".equals(aID)) {
                        AnnouncementDTO announcement = announcementService.getAnnouncementById(aID);
                        request.setAttribute("announcement", announcement);
                        request.getRequestDispatcher("announcement/manage_announcement.jsp").forward(request, response);

                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load announcement.");
                    request.getRequestDispatcher("announcement/manage_announcement.jsp").forward(request, response);
                }
                break;

            case "/viewAnnouncementsByUser":
                try {
                    int userID = Integer.parseInt(request.getParameter("uid"));
                    List<AnnouncementDTO> announcements = announcementService.getAnnouncementsByUserID(userID);
                    request.setAttribute("announcements", announcements);
                    request.getRequestDispatcher("announcement/view_announcements_by_user.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load announcements by user.");
                    request.getRequestDispatcher("announcement/view_announcements_by_user.jsp").forward(request, response);
                }
                break;

            case "/viewAssignedBatches":
                try {
                    int aID = Integer.parseInt(request.getParameter("aid"));
                    List<Integer> batches = announcementService.getAssignedBatches(aID);
                    request.setAttribute("batches", batches);
                    request.getRequestDispatcher("announcement/view_assigned_batches.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load assigned batches.");
                    request.getRequestDispatcher("announcement/view_assigned_batches.jsp").forward(request, response);
                }
                break;

            case "/viewAssignedStudents":
                try {
                    int aID = Integer.parseInt(request.getParameter("aID"));
                    List<Integer> students = announcementService.getAssignedStudents(aID);
                    request.setAttribute("students", students);
                    request.getRequestDispatcher("announcement/view_assigned_students.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load assigned students.");
                    request.getRequestDispatcher("announcement/view_assigned_students.jsp").forward(request, response);
                }
                break;

            case "/viewAssignedAnnouncementsByStudent":
                try {
                    int uid = Integer.parseInt(request.getParameter("uid"));
                    List<AnnouncementDTO> announcements = announcementService.getAssignedAnnouncementsByStudent(uid);
                    request.setAttribute("assignedAnnouncements", announcements);
                    request.getRequestDispatcher("announcement/view_announcements_by_student.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load assigned announcements by student.");
                    request.getRequestDispatcher("announcement/view_announcements_by_student.jsp").forward(request, response);
                }
                break;

            case "/viewAssignedAnnouncementsByBatch":
                try {
                    int bID = Integer.parseInt(request.getParameter("bID"));
                    List<AnnouncementDTO> announcements = announcementService.getAssignedAnnouncementsByBatch(bID);
                    request.setAttribute("assignedAnnouncements", announcements);
                    request.getRequestDispatcher("announcement/view_announcements_by_batch.jsp").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Failed to load assigned announcements by batch.");
                    request.getRequestDispatcher("announcement/view_announcements_by_batch.jsp").forward(request, response);
                }
                break;
            case "/addAnnouncement":
                request.getRequestDispatcher("event/create_workshop.jsp").forward(request, response);
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
                case "addAnnouncement":
                    AnnouncementDTO newAnnouncement = createAnnouncementFromRequest(request);
                    announcementService.createAnnouncement(newAnnouncement);
                    request.setAttribute("message", "Announcement created successfully.");
                    request.getRequestDispatcher("announcement/create_announcement.jsp").forward(request, response);
                    break;

                default:
                    request.setAttribute("message", "Invalid action.");
            }
        } catch (Exception e) {
            request.setAttribute("message", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("announcement/create_announcement.jsp").forward(request, response);
        }
    }

    private AnnouncementDTO createAnnouncementFromRequest(HttpServletRequest request) {
        AnnouncementDTO announcement = new AnnouncementDTO();
        announcement.setSubject(request.getParameter("subject"));
        announcement.setMessage(request.getParameter("message"));
        announcement.setCreatedBy(Long.parseLong(request.getParameter("createdBy")));
        // Parse and set batches and students if available in the request
        return announcement;
    }
}
