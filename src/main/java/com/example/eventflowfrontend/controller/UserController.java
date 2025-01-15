package com.example.eventflowfrontend.controller;

import com.example.eventflowfrontend.DTO.UserDTO;
import com.example.eventflowfrontend.services.EventService;
import com.example.eventflowfrontend.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name ="UserController" , urlPatterns = {"/displayStudent","/updateUser","/deleteUser","/addUser"})
public class UserController extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getServletPath().equals("/displayStudent")) {
            List<UserDTO> userDTOS = userService.getAllUsers("students");
            request.setAttribute("users",userDTOS);
            request.getRequestDispatcher("user/displayStudent.jsp").forward(request,response);
        }

        if (request.getServletPath().equals("/updateUser")) {
            int uid = Integer.parseInt(request.getParameter("uid"));
            UserDTO userDTO = userService.getUserById(uid);
            request.setAttribute("user",userDTO);
            request.getRequestDispatcher("user/updateUser.jsp").forward(request,response);
        }

        if(request.getServletPath().equals("/deleteUser")){
            int uid = Integer.parseInt(request.getParameter("uid"));
            userService.deleteUser(uid);
            List<UserDTO> userDTOS = userService.getAllUsers("students");
            request.setAttribute("users",userDTOS);
            request.getRequestDispatcher("user/displayStudent.jsp").forward(request,response);
        }

        if(request.getServletPath().equals("/addUser")){
            request.getRequestDispatcher("user/addUser.jsp").forward(request,response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action.equals("update")) {
            UserDTO userDTO = new UserDTO();
            userDTO.setUID(Integer.valueOf(request.getParameter("uid")));
            userDTO.setName(request.getParameter("name"));
            userDTO.setMobile(request.getParameter("mobile"));
            userDTO.setNic(request.getParameter("nic"));
            userDTO.setEmail(request.getParameter("email"));
            userDTO.setPassword(request.getParameter("password"));
            try {
                userService.updateUser(userDTO);
                request.setAttribute("message", "User updated successfully.");
            } catch (Exception e) {
                request.setAttribute("message", "Failed to update user.");
            }
            UserDTO user = userService.getUserById(userDTO.getUID());
            System.out.println(user);
            request.getRequestDispatcher("user/updateUser.jsp").forward(request, response);
        }



        if (action.equals("add")) {
            UserDTO userDTO = new UserDTO();
            String name = request.getParameter("name");
            String mobile = request.getParameter("mobile");
            String nic = request.getParameter("nic");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String createdByStr = request.getParameter("createdBy");
            String role = request.getParameter("role");

            // Validate required fields
            if (name == null || name.trim().isEmpty() ||
                    mobile == null || mobile.trim().isEmpty() ||
                    nic == null || nic.trim().isEmpty() ||
                    email == null || email.trim().isEmpty() ||
                    password == null || password.trim().isEmpty() ||
                    createdByStr == null || createdByStr.trim().isEmpty() ||
                    role == null || role.trim().isEmpty()) {

                request.setAttribute("message", "All fields are required.");
                request.getRequestDispatcher("user/addUser.jsp").forward(request, response);
                return;
            }

            // Populate UserDTO
            userDTO.setName(name);
            userDTO.setMobile(mobile);
            userDTO.setNic(nic);
            userDTO.setEmail(email);
            userDTO.setPassword(password);
            userDTO.setCreatedBy(Integer.valueOf(createdByStr));

            try {
                userService.addUser(role, userDTO);
                request.setAttribute("message", "User added successfully.");
            } catch (Exception e) {
                System.out.println(e.getMessage());
                request.setAttribute("message", "Failed to add user.");
            }
            request.getRequestDispatcher("user/addUser.jsp").forward(request, response);
        }

    }
}

