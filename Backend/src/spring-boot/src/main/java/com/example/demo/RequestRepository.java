package com.example.demo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface RequestRepository {
    public void save(Request request);

    @Query("select r from Request r where r.id_request = :id_request")
    @Transactional(readOnly = true)
    public User findByID(@Param("id_request") Integer id_request);

}
