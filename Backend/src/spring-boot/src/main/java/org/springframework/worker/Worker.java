package org.springframework.worker;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name = "worker")
public class Worker{
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id_worker")
    private Integer id;

    @NotEmpty
    @Column(name = "company")
    private String company;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    /*@Override
    public String toString(){
        return new ToStringCreator(this)
                .append("id", this.getId()).append("new", this.isNew())
                .append("company", this.getCompany())
    }*/
}