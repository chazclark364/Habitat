package com.example.demo;

import javax.persistence.*;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotEmpty;
import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name = "property")
public class Property{
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id_property")
    private Integer id;

    @Column(name = "landlord")
    private Integer landlord;

    @Column(name = "living_status")
    private String living_status;

    @Column(name = "address")
    private String address;

    @Column(name = "worker")
    private Integer worker;

    @Column(name = "rent_due_date")
    private String rent_due_date; 
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getLandlord() {
        return landlord;
    }

    public void setLandlord(Integer landlord) {
        this.landlord = landlord;
    }

    public String getLivingStatus() {
        return living_status;
    }

    public void setLivingStatus(String living_status) {
        this.living_status = living_status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getWorker() {
        return worker;
    }

    public void setWorker(Integer worker) {
        this.worker = worker;
    }

    public String getRentDueDate() {
        return rent_due_date;
    }

    public void setRentDueDate(String rent_due_date) {
        this.rent_due_date = rent_due_date;
    }
}