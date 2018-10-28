package com.example.demo;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

@Component
@Entity
@Table(name = "landlord")
public class Landlord{
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id_landlord")
    private Integer id_landlord;

    @Column(name = "address")
    private String address;

    public Integer getIdLandlord() {
        return id_landlord;
    }

    public void setIdLandlord(Integer id_landlord) {
        this.id_landlord = id_landlord;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}