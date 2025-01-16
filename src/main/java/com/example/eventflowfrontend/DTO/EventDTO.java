package com.example.eventflowfrontend.DTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor

    public class EventDTO {
        private Integer eID;
        private String title;
        private String description;
        private LocalDateTime startDateTime;
        private EventType eventType;
        private Boolean isActive;
        private Integer group_fID;
        private Integer createdBy;
        private Integer aID;
    }


