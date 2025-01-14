package com.example.eventflowfrontend.DTO;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class EventDTO {
    private Integer eID;
    private String title;
    private String description;
    private LocalDateTime startDateTime;
    private EventType eventType;
    private Boolean isActive;
    private Integer createdBy;
    private Integer aID;
}


