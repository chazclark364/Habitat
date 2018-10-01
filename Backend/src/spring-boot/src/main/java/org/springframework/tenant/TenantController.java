package org.springframework.tenant;

import java.util.Collection;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TenantRepository extends CrudRepository<Tenant, Integer>{
    Collection<Tenant> findall();
    Collection<Tenant> findById(@Param("id") int id);
    Tenant save(Tenant tenant);
}