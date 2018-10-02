package org.springframework.property;

import java.util.Collection;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PropertyRepository extends CrudRepository<Property, Integer>{
    Collection<Property> findall();
    Collection<Property> findById(@Param("id_property") int id);
    Property save(Property property);
}