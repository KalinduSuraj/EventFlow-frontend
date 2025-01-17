package com.example.eventflowfrontend.DTO;

import lombok.Data;

@Data
public class BatchDTO {
    private Integer bID;
    private String batchName;
    private String commonEmail;

    public Object getBatchId() {
        return null;
    }
}