package com.example.demo;

import javax.persistence.*;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotEmpty;
import org.springframework.core.style.ToStringCreator;
import org.springframework.stereotype.Component;

@Component
@Entity
@Table(name = "tenant")
public class Tenant {
    @Id
    @Column(name = "id_tenant")
    private Integer id_tenant;

    @Column(name = "landlord")
    private Integer landlord;

    @Column(name = "residence")
    private Integer residence;

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

    public Integer getResidence(){
        return this.residence;
    }

    public void setResidence(Integer residence){
        this.residence = residence;
    }

    public Integer getMonthlyRent() {
        return monthly_rent;
    }

    public void setMonthlyRent(Integer monthly_rent) {
        this.monthly_rent = monthly_rent;
    }

}