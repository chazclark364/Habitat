package com.example.demo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface WorkerRepository extends Repository<Worker, Integer>{
    public void save(Worker worker);
    
    @Query("select w from Worker w where w.id_worker = :id_worker")
    @Transactional(readOnly = true)
    public Worker findWorkerByID(@Param("id_worker") Integer id_worker);
}