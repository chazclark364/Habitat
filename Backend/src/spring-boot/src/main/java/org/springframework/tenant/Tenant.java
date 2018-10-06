package org.springframework.tenant;

import javax.persistence.*;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotEmpty;
import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name = "tenant")
public class Tenant {
    @Id
    @Column(name = "id_tenant")
    private Integer id;

    @NotEmpty
    @Column(name = "landlord")
    private String landlord;

    @NotEmpty
    @Column(name = "residence")
    private String residence;

    @NotEmpty
    @Column(name = "monthly_rent")
    private Integer monthly_rent;

    public Integer getId(){
        return id;
    }

    public void setId(Integer id){
        this.id = id;
    }

    public boolean isNew(){
        return this.id == null;
    }

    public String getLandlord(){
        return this.landlord;
    }

    public void setLandlord(String landlord){
        this.landlord = landlord;
    }

    public String getResidence(){
        return this.residence;
    }

    public void setResidence(){
        this.residence = residence;
    }

    public Integer getMonthly_rent() {
        return monthly_rent;
    }

    public void setMonthly_rent(Integer monthly_rent) {
        this.monthly_rent = monthly_rent;
    }

    /*@Override
    public String toString(){
        return new ToStringCreator(this)
                .append("id", this.getId()).append("new", this.isNew())
                .append("landlord", this.getLandlord())
                .append("residence", this.getResidence())
    }*/
}