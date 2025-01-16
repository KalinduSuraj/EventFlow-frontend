package com.example.eventflowfrontend.controller;

import com.example.eventflowfrontend.DTO.AddIndividualFeedbackRequestDTO;
import com.example.eventflowfrontend.DTO.FeedbackDTO;
import com.example.eventflowfrontend.DTO.FeedbackType;
import com.example.eventflowfrontend.services.FeedbackService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "FeedbackController", urlPatterns = {"/createIndividualFeedback", "/createGroupFeedback", "/updateFeedback", "/viewFeedback", "/viewFeedbackByEventUser"})
public class FeedbackController extends HttpServlet {

    private final FeedbackService feedbackService = new FeedbackService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getServletPath().equals("/viewFeedback")) {
            int fID = Integer.parseInt(request.getParameter("fID"));
            FeedbackDTO feedbackDTO = feedbackService.getFeedback(fID);
            request.setAttribute("feedback", feedbackDTO);
            request.getRequestDispatcher("feedback/viewFeedback.jsp").forward(request, response);
        }

        if (request.getServletPath().equals("/viewFeedbackByEventUser")) {
            int eID = Integer.parseInt(request.getParameter("eID"));
            int uID = Integer.parseInt(request.getParameter("uID"));
            List<FeedbackDTO> feedbackList = feedbackService.getAllFeedbackByeIDAnd_uID(eID, uID);
            request.setAttribute("feedbacks", feedbackList);
            request.getRequestDispatcher("feedback/viewFeedbackByEventUser.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("createIndividualFeedback")) {
            String feedback = request.getParameter("feedback");
            String feedbackType = request.getParameter("feedbackType");

            AddIndividualFeedbackRequestDTO individualFeedbackRequest = new AddIndividualFeedbackRequestDTO();
            //individualFeedbackRequest.setFeedback(feedback);
            //individualFeedbackRequest.setFeedbackType(feedbackType);

            try {
                feedbackService.createIndividualFeedback(individualFeedbackRequest);
                request.setAttribute("message", "Individual feedback created successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to create individual feedback.");
            }
            request.getRequestDispatcher("feedback/createIndividualFeedback.jsp").forward(request, response);
        }

        if (action.equals("createGroupFeedback")) {
            Integer eID = Integer.valueOf(request.getParameter("eID"));
            String feedback = request.getParameter("feedback");
            String feedbackType = request.getParameter("feedbackType");

            FeedbackDTO feedbackDTO = new FeedbackDTO();
            feedbackDTO.setFeedback(feedback);
            feedbackDTO.setFeedbackType(FeedbackType.valueOf(feedbackType));

            try {
                feedbackService.createGroupFeedback(feedbackDTO, eID);
                request.setAttribute("message", "Group feedback created successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to create group feedback.");
            }
            request.getRequestDispatcher("feedback/createGroupFeedback.jsp").forward(request, response);
        }

        if (action.equals("updateFeedback")) {
            Integer fID = Integer.valueOf(request.getParameter("fID"));
            String feedback = request.getParameter("feedback");
            String feedbackType = request.getParameter("feedbackType");

            FeedbackDTO feedbackDTO = new FeedbackDTO();
            feedbackDTO.setFeedback(feedback);
            feedbackDTO.setFeedbackType(FeedbackType.valueOf(feedbackType));

            try {
                feedbackService.update(fID, feedbackDTO);
                request.setAttribute("message", "Feedback updated successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to update feedback.");
            }
            request.getRequestDispatcher("feedback/updateFeedback.jsp").forward(request, response);
        }
    }
}
