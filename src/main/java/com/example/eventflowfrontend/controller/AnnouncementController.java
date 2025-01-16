package com.example.eventflowfrontend.controller;

import com.example.eventflowfrontend.DTO.AnnouncementDTO;
import com.example.eventflowfrontend.services.AnnouncementService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name ="AnnouncementController", urlPatterns = {"/displayAnnouncements", "/viewAnnouncement", "/updateAnnouncement", "/deleteAnnouncement", "/addAnnouncement"})
public class AnnouncementController extends HttpServlet {

    private final AnnouncementService announcementService = new AnnouncementService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getServletPath().equals("/displayAnnouncements")) {
            List<AnnouncementDTO> announcementDTOS = announcementService.getAnnouncementsByUserId(1); // Replace with the actual user ID
            request.setAttribute("announcements", announcementDTOS);
            request.getRequestDispatcher("announcement/display.jsp").forward(request, response);
        }

        if (request.getServletPath().equals("/viewAnnouncement")) {
            int aID = Integer.parseInt(request.getParameter("aID"));
            AnnouncementDTO announcementDTO = announcementService.getAnnouncementById(aID);
            request.setAttribute("announcement", announcementDTO);
            request.getRequestDispatcher("announcement/view.jsp").forward(request, response);
        }

        if (request.getServletPath().equals("/updateAnnouncement")) {
            int aID = Integer.parseInt(request.getParameter("aID"));
            AnnouncementDTO announcementDTO = announcementService.getAnnouncementById(aID);
            request.setAttribute("announcement", announcementDTO);
            request.getRequestDispatcher("announcement/update.jsp").forward(request, response);
        }

        if (request.getServletPath().equals("/deleteAnnouncement")) {
            int aID = Integer.parseInt(request.getParameter("aID"));
            announcementService.deleteAnnouncement(aID);
            List<AnnouncementDTO> announcementDTOS = announcementService.getAnnouncementsByUserId(1); // Replace with the actual user ID
            request.setAttribute("announcements", announcementDTOS);
            request.getRequestDispatcher("announcement/display.jsp").forward(request, response);
        }

        if (request.getServletPath().equals("/addAnnouncement")) {
            request.getRequestDispatcher("announcement/add.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("update")) {
            AnnouncementDTO announcementDTO = new AnnouncementDTO();
            announcementDTO.setAID(Integer.valueOf(request.getParameter("aID")));
            announcementDTO.setSubject(request.getParameter("subject")); // Corrected to 'subject'
            announcementDTO.setMessage(request.getParameter("message"));
            announcementDTO.setCreatedBy(Long.valueOf(request.getParameter("createdBy")));

            // Parse batches and students (ArrayLists of Integers)
            String[] batchIds = request.getParameterValues("batchIds");
            ArrayList<Integer> batches = new ArrayList<>();
            for (String batchId : batchIds) {
                batches.add(Integer.valueOf(batchId));
            }
            announcementDTO.setBatches(batches);

            String[] studentIds = request.getParameterValues("studentIds");
            ArrayList<Integer> students = new ArrayList<>();
            for (String studentId : studentIds) {
                students.add(Integer.valueOf(studentId));
            }
            announcementDTO.setStudents(students);

            try {
                announcementService.updateAnnouncement(announcementDTO);
                request.setAttribute("message", "Announcement updated successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to update announcement.");
            }
            request.getRequestDispatcher("announcement/update.jsp").forward(request, response);
        }

        if (action.equals("add")) {
            AnnouncementDTO announcementDTO = new AnnouncementDTO();
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");
            String createdByStr = request.getParameter("createdBy");

            // Validate required fields
            if (subject == null || subject.trim().isEmpty() ||
                    message == null || message.trim().isEmpty() ||
                    createdByStr == null || createdByStr.trim().isEmpty()) {
                request.setAttribute("message", "All fields are required.");
                request.getRequestDispatcher("announcement/add.jsp").forward(request, response);
                return;
            }

            // Populate AnnouncementDTO
            announcementDTO.setSubject(subject);
            announcementDTO.setMessage(message);
            announcementDTO.setCreatedBy(Long.valueOf(createdByStr));

            // Parse batches and students (ArrayLists of Integers)
            String[] batchIds = request.getParameterValues("batchIds");
            ArrayList<Integer> batches = new ArrayList<>();
            for (String batchId : batchIds) {
                batches.add(Integer.valueOf(batchId));
            }
            announcementDTO.setBatches(batches);

            String[] studentIds = request.getParameterValues("studentIds");
            ArrayList<Integer> students = new ArrayList<>();
            for (String studentId : studentIds) {
                students.add(Integer.valueOf(studentId));
            }
            announcementDTO.setStudents(students);

            try {
                announcementService.addAnnouncement(announcementDTO);
                request.setAttribute("message", "Announcement added successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to add announcement.");
            }
            request.getRequestDispatcher("announcement/add.jsp").forward(request, response);
        }
    }
}
