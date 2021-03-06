package com.example.demo;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;
import java.io.Serializable;
import java.util.Date;
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

    @Column(name = "requestee")
    private Integer requestee;

    @Column(name = "landlord")
    private Integer landlord;

    @Column(name = "worker")
    private Integer worker;

    @Column(name = "status")
    private String status;

    @Column(name = "last_updated")
    private Integer last_updated; 
    
    public Integer getIdRequest() {
        return id_request;
    }

    public String getTitle(){
        return title;
    }

    public String getDescription(){
        return description;
    }

    public Integer getRequestee(){
        return requestee;
    }

    public Integer getLandlord(){
        return landlord;
    }

    public Integer getWorker(){
        return worker;
    }

    public String getStatus(){
        return status;
    }

    public Integer getLastUpdated(){
    	return last_updated;
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

    public void setRequestee(Integer requestee) {
        this.requestee = requestee;
    }

    public void setLandlord(Integer landlord) {
        this.landlord = landlord;
    }

    public void setWorker(Integer worker) {
        this.worker = worker;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public void setLastUpdated(Integer last_updated){
    	this.last_updated = last_updated;
    }
}
