package com.example.eventflowfrontend.controller;

import com.example.eventflowfrontend.DTO.AttendanceDTO;
import com.example.eventflowfrontend.services.AttendanceService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/attendance")
public class AttendanceController extends HttpServlet {

    private final AttendanceService attendanceService;

    public AttendanceController() {
        this.attendanceService = new AttendanceService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "markAttendance":
                    markAttendance(request, response);
                    break;
                case "updateAttendance":
                    updateAttendance(request, response);
                    break;
                case "deleteAttendance":
                    deleteAttendance(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "getAttendance":
                    getAttendance(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void markAttendance(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String[] studentIds = request.getParameterValues("students");

        AttendanceDTO attendanceDTO = new AttendanceDTO();
        for (String studentId : studentIds) {
            attendanceDTO.getStudents().add(Long.parseLong(studentId));
        }

        attendanceService.markAttendance(eventId, attendanceDTO);
        response.getWriter().write("Attendance marked successfully");
    }

    private void getAttendance(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        AttendanceDTO attendance = attendanceService.getAttendance(eventId);
        response.setContentType("application/json");
        response.getWriter().write(attendance.toString());
    }

    private void updateAttendance(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int studentEventId = Integer.parseInt(request.getParameter("studentEventId"));
        int points = Integer.parseInt(request.getParameter("points"));

        attendanceService.updateAttendance(studentEventId, points);
        response.getWriter().write("Attendance updated successfully");
    }

    private void deleteAttendance(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int studentEventId = Integer.parseInt(request.getParameter("studentEventId"));

        attendanceService.deleteAttendance(studentEventId);
        response.getWriter().write("Attendance deleted successfully");
    }
}
