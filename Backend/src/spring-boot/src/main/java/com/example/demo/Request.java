package com.example.demo;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;
import java.io.Serializable;
import java.time.LocalDate;

@Component
@Table(name = "request")
@Entity
public class Request {
    @Id
    @Column(name = "id_request")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id_request;

    @Column(name = "title")
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "date_requested")
    private DateTimeFormat date_requested;

    @Column(name = "requestee")
    private String requestee;

    @Column(name = "landlord")
    private String landlord;

    @Column(name = "worker")
    private String worker;

    @Column(name = "status")
    private String status;

    public Integer getIdRequest() {
        return id_request;
    }

    public String getTitle(){
        return title;
    }

    public String getDescription(){
        return description;
    }

    public DateTimeFormat getDateRequested(){
        return date_requested;
    }

    public String getRequestee(){
        return requestee;
    }

    public String getLandlord(){
        return landlord;
    }

    public String getWorker(){
        return worker;
    }

    public String getStatus(){
        return status;
    }


    public void setIdRequest(Integer id_request) {
        this.id_request = id_request;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setDateRequested(DateTimeFormat date_requested) {
        this.date_requested = date_requested;
    }

    public void setRequestee(String requestee) {
        this.requestee = requestee;
    }

    public void setLandlord(String landlord) {
        this.landlord = landlord;
    }

    public void setWorker(String worker) {
        this.worker = worker;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
