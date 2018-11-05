package com.example.demo;

import java.util.Collection;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

public interface LandlordRepository extends Repository<Landlord, Integer>{
    public void save(Landlord landlord);
    
    @Query("select l from Landlord l where l.id_landlord = :id_landlord")
    @Transactional(readOnly = true)
    public Landlord findLandlordByID(@Param("id_landlord") Integer id_landlord);
    
    @Query("select l from Landlord l")
    @Transactional(readOnly = true)
    public Collection<Landlord> findAllLandlords();
}