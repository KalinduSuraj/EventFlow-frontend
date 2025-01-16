package com.example.eventflowfrontend.DTO;
import lombok.Data;

import java.util.ArrayList;

@Data
public class AddIndividualFeedbackRequestDTO {
    private ArrayList<IndividualFeedbackDTO> individualFeedbackDTOS;
}
