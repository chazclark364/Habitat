package com.example.demo;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name = "worker")
public class Worker{
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name = "id_worker")
    private Integer id_worker;

    @Column(name = "company")
    private String company;

    public Integer getIdWorker() {
        return id_worker;
    }

    public void setIdWorker(Integer id_worker) {
        this.id_worker = id_worker;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }
}