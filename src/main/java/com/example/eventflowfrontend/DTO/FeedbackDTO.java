package com.example.eventflowfrontend.DTO;
import lombok.Data;

import java.time.LocalDateTime;
@Data
public class FeedbackDTO {
    private Integer fID;
    private String feedback;
    private FeedbackType feedbackType;
    private LocalDateTime createdDateTime;
}