package org.springframework.landlord;

import javax.persistence.*;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotEmpty;
import org.springframework.core.style.ToStringCreator;

@Entity
@Table(name = "landlord")
public class Landlord{
    @Id
    @GeneratedValue(strategy = GenerationType.Identity)
    @Column(name = id_landlord)
    private Integer id;

    @NotEmpty
    @Column(name = address)
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