package com.example.eventflowfrontend.DTO;
import lombok.Data;

@Data
public class UserDTO {
    private Integer uID;
    private String name;
    private String email;
    private String mobile;
    private String nic;
    private String password;

    private Boolean isActive;
    private Integer createdBy;
}