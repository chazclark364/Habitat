package com.example.demo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import java.util.Collection;


public interface RequestRepository extends Repository<Request, Integer>{
    public void save(Request request);
    
    //public void update(Request request);

    @Query("select r from Request r where r.id_request = :id_request")
    @Transactional(readOnly = true)
    public Request findRequestByID(@Param("id_request") Integer id_request);
    
    @Query("select r from Request r where r.requestee = :id_users")
    @Transactional(readOnly = true)
    public Collection<Request> findRequestByRequestee(@Param("id_users") Integer id_users);
    
    @Query("select r from Request r where r.landlord = :id_users")
    @Transactional(readOnly = true)
    public Collection<Request> findRequestByLandlord(@Param("id_users") Integer id_users);
    
    @Query("select r from Request r where r.worker = :id_users")
    @Transactional(readOnly = true)
    public Collection<Request> findRequestByWorker(@Param("id_users") Integer id_users);

}
