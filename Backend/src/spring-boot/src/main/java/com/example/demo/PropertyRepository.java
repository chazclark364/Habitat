package com.example.demo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import java.util.Collection;


public interface PropertyRepository extends Repository<Property, Integer>{
    
	Property save(Property property);
    
	@Query("select p from Property p")
    @Transactional(readOnly = true)
    public Collection<Property> findAllProperties();
	
	
	@Query("select p from Property p where p.id_property = :id_property")
    @Transactional(readOnly = true)
    public Property findProperty(@Param("id_property") Integer id_property);
	
	@Query("select p from Property p where p.landlord = :id_landlord")
    @Transactional(readOnly = true)
    public Collection<Property> findPropertyByLandlord(@Param("id_landlord") Integer id_landlord);
	
}