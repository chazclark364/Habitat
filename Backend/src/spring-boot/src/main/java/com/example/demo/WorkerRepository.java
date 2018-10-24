package com.example.demo;

import java.util.Collection;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface WorkerRepository extends CrudRepository<Worker, Integer>{
    Collection<Worker> findall();
    Collection<Worker> findById(@Param("id_worker") int id);
    Worker save(Worker worker);
}