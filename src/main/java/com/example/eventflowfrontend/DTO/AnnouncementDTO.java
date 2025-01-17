package com.example.eventflowfrontend.DTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class AnnouncementDTO {
    private Integer aID;
    private String subject;
    private String message;
    private Long createdBy;
    private ArrayList<Integer> batches;
    private ArrayList<Integer> students;

    public String getAID() {
        return aID.toString();
    }
}