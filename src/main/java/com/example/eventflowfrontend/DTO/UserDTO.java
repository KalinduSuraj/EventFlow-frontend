package com.example.eventflowfrontend.DTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor @NoArgsConstructor
public class UserDTO {
    private Integer uID;
    private String name;
    private String email;
    private String mobile;
    private String nic;
    private String password;
    private String role;
    private Boolean isActive;
    private Integer createdBy;
}
