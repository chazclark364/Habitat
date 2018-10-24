package com.example.demo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;


public interface TenantRepository extends Repository<Tenant, Integer>{
	public void save(Tenant tenant);
	
    @Query("select t from Tenant t where t.id_tenant = :id_tenant")
    @Transactional(readOnly = true)
    public Tenant findTenantByID(@Param("id_tenant") Integer id_tenant);
	
}