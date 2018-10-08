package org.springframework.property;

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

    @NotEmpty
    @Column(name = "landlord")
    private String landlord;

    @NotEmpty
    @Column(name = "living_status")
    private String living_status;

    @NotEmpty
    @Column(name = "address")
    private String address;

    @NotEmpty
    @Column(name = "worker")
    private String worker;

    @NotEmpty
    @Column(name = "rent_due_date")
    private String rent_due_date; //UNSURE ON DATA TYPE //TODO

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLandlord() {
        return landlord;
    }

    public void setLandlord(String landlord) {
        this.landlord = landlord;
    }

    public String getLiving_status() {
        return living_status;
    }

    public void setLiving_status(String living_status) {
        this.living_status = living_status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getWorker() {
        return worker;
    }

    public void setWorker(String worker) {
        this.worker = worker;
    }

    public String getRent_due_date() {
        return rent_due_date;
    }

    public void setRent_due_date(String rent_due_date) {
        this.rent_due_date = rent_due_date;
    }
}