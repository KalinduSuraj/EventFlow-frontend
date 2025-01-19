package com.example.eventflowfrontend.controller;

import com.example.eventflowfrontend.DTO.BatchDTO;
import com.example.eventflowfrontend.DTO.AttendanceDTO;
import com.example.eventflowfrontend.services.BatchService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "BatchController", urlPatterns = {
        "/displayBatches",
        "/updateBatch",
        "/deleteBatch",
        "/addBatch",
        "/assignStudent",
        "/unassignStudent"
})
public class BatchController extends HttpServlet {

    private final BatchService batchService = new BatchService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Display all batches
        if (request.getServletPath().equals("/displayBatches")) {
            List<BatchDTO> batchList = batchService.getAllBatches();
            request.setAttribute("batches", batchList);
            request.getRequestDispatcher("batch/displayBatches.jsp").forward(request, response);
        }

        // Update batch (load batch details)
        if (request.getServletPath().equals("/updateBatch")) {
            int batchId = Integer.parseInt(request.getParameter("bID"));
            BatchDTO batch = batchService.getBatchById(batchId);
            request.setAttribute("batch", batch);
            request.getRequestDispatcher("batch/updateBatch.jsp").forward(request, response);
        }

        // Delete batch
        if (request.getServletPath().equals("/deleteBatch")) {
            int batchId = Integer.parseInt(request.getParameter("bID"));
            batchService.deleteBatch(batchId);
            List<BatchDTO> batchList = batchService.getAllBatches();
            request.setAttribute("batches", batchList);
            request.getRequestDispatcher("batch/displayBatches.jsp").forward(request, response);
        }

        // Add batch page redirection
        if (request.getServletPath().equals("/addBatch")) {
            request.getRequestDispatcher("batch/addBatch.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        // Update an existing batch
        if (action.equals("update")) {
            BatchDTO batchDTO = new BatchDTO();
            batchDTO.setBID(Integer.parseInt(request.getParameter("bID")));
            batchDTO.setBatchName(request.getParameter("batchName"));
            batchDTO.setCommonEmail(request.getParameter("commonEmail"));

            try {
                batchService.updateBatch(batchDTO);
                request.setAttribute("message", "Batch updated successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to update batch.");
            }

            request.getRequestDispatcher("batch/updateBatch.jsp").forward(request, response);
        }

        // Add a new batch
        if (action.equals("add")) {
            BatchDTO batchDTO = new BatchDTO();
            batchDTO.setBatchName(request.getParameter("batchName"));
            batchDTO.setCommonEmail(request.getParameter("commonEmail"));

            try {
                batchService.createBatch(batchDTO);
                request.setAttribute("message", "Batch created successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to create batch.");
            }

            request.getRequestDispatcher("batch/addBatch.jsp").forward(request, response);
        }

        // Assign a student to a batch
        if (action.equals("assignStudent")) {
            int batchId = Integer.parseInt(request.getParameter("bID"));
            AttendanceDTO attendanceDTO = new AttendanceDTO();
            //attendanceDTO.setStudentId(Integer.parseInt(request.getParameter("studentId")));


            try {
                batchService.assignStudentToBatch(batchId, attendanceDTO);
                request.setAttribute("message", "Student assigned successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to assign student.");
            }

            request.getRequestDispatcher("batch/displayBatches.jsp").forward(request, response);
        }

        // Unassign a student from a batch
        if (action.equals("unassignStudent")) {
            int studentId = Integer.parseInt(request.getParameter("studentId"));

            try {
                batchService.unassignStudentFromBatch(studentId);
                request.setAttribute("message", "Student unassigned successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to unassign student.");
            }

            request.getRequestDispatcher("batch/displayBatches.jsp").forward(request, response);
        }
    }
}
