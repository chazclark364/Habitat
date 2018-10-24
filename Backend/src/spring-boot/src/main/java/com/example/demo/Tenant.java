package com.example.demo;

import javax.persistence.*;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotEmpty;
import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name = "tenant")
public class Tenant {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id_tenant")
    private Integer id_tenant;

    @NotEmpty
    @Column(name = "landlord")
    private Integer landlord;

    @NotEmpty
    @Column(name = "residence")
    private String residence;

    @NotEmpty
    @Column(name = "monthly_rent")
    private Integer monthly_rent;

    public Integer getIdTenant(){
        return id_tenant;
    }

    public void setIdTenant(Integer id_tenant){
        this.id_tenant = id_tenant;
    }

    public Integer getLandlord(){
        return this.landlord;
    }

    public void setLandlord(Integer landlord){
        this.landlord = landlord;
    }

    public String getResidence(){
        return this.residence;
    }

    public void setResidence(String residence){
        this.residence = residence;
    }

    public Integer getMonthlyRent() {
        return monthly_rent;
    }

    public void setMonthlyRent(Integer monthly_rent) {
        this.monthly_rent = monthly_rent;
    }

}