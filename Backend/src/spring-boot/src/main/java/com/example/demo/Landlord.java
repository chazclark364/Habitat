package com.example.demo;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name = "landlord")
public class Landlord{
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id_landlord")
    private Integer id;

    @NotEmpty
    //@Column(name = address)
    private String address;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}