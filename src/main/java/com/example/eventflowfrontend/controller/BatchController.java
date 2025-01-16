package com.example.eventflowfrontend.controller;

import com.example.eventflowfrontend.DTO.AttendanceDTO;
import com.example.eventflowfrontend.DTO.BatchDTO;
import com.example.eventflowfrontend.DTO.EventDTO;
import com.example.eventflowfrontend.services.BatchService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BatchController", urlPatterns = {"/displayBatches", "/updateBatch", "/deleteBatch", "/addBatch", "/assignUser", "/unassignUser"})
public class BatchController extends HttpServlet {

    private final BatchService batchService = new BatchService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getServletPath().equals("/displayBatches")) {
            List<BatchDTO> batchDTOS = batchService.findAll();
            request.setAttribute("batches", batchDTOS);
            request.getRequestDispatcher("batch/displayBatches.jsp").forward(request, response);
        }

        if (request.getServletPath().equals("/updateBatch")) {
            Long batchId = Long.parseLong(request.getParameter("bID"));
            BatchDTO batchDTO = batchService.findById(batchId);
            request.setAttribute("batch", batchDTO);
            request.getRequestDispatcher("batch/updateBatch.jsp").forward(request, response);
        }

        if (request.getServletPath().equals("/deleteBatch")) {
            Long batchId = Long.parseLong(request.getParameter("bID"));
            batchService.delete(batchId);
            List<BatchDTO> batchDTOS = batchService.findAll();
            request.setAttribute("batches", batchDTOS);
            request.getRequestDispatcher("batch/displayBatches.jsp").forward(request, response);
        }

        if (request.getServletPath().equals("/addBatch")) {
            request.getRequestDispatcher("batch/addBatch.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action.equals("update")) {
            BatchDTO batchDTO = new BatchDTO();
            batchDTO.setBID(Integer.valueOf(request.getParameter("bID")));
            batchDTO.setBatchName(request.getParameter("batchName"));
            batchDTO.setCommonEmail(request.getParameter("commonEmail"));

            try {
                batchService.update(Long.valueOf(batchDTO.getBID()), batchDTO);
                request.setAttribute("message", "Batch updated successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to update batch.");
            }
            request.getRequestDispatcher("batch/updateBatch.jsp").forward(request, response);
        }

        if (action.equals("add")) {
            BatchDTO batchDTO = new BatchDTO();
            batchDTO.setBatchName(request.getParameter("batchName"));
            batchDTO.setCommonEmail(request.getParameter("commonEmail"));

            try {
                batchService.create(batchDTO);
                request.setAttribute("message", "Batch added successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to add batch.");
            }
            request.getRequestDispatcher("batch/addBatch.jsp").forward(request, response);
        }

        if (action.equals("assignUser")) {
            Long batchId = Long.parseLong(request.getParameter("bID"));
            AttendanceDTO attendanceDTO = new AttendanceDTO();
            //attendanceDTO.setUserID(Integer.parseInt(request.getParameter("userID")));

            try {
                batchService.assignUser(batchId, attendanceDTO);
                request.setAttribute("message", "User assigned successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to assign user.");
            }
            request.getRequestDispatcher("batch/assignUser.jsp").forward(request, response);
        }

        if (action.equals("unassignUser")) {
            Long userId = Long.parseLong(request.getParameter("userID"));

            try {
                batchService.unassignUser(userId);
                request.setAttribute("message", "User unassigned successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to unassign user.");
            }
            request.getRequestDispatcher("batch/unassignUser.jsp").forward(request, response);
        }
    }
}
