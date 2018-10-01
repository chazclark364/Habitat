package org.springframework.landlord;

import java.util.Collection;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LandlordRepository extends CrudRepository<Landlord, Integer>{
    Collection<Landlord> findall();
    Collection<Landlord> findById(@Param("id_landlord") int id);
    Landlord save(Landlord landlord);
}