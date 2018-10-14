package org.springframework.tenant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
class TenantController{
    @Autowired
    private final TenantRepository tenants;

    @Autowired
    public TenantController(TenantRepository habitat) {
        this.tenants = habitat;
    }

    /*
    @PostMapping("/users/tenant/save")
    public String saveTenant(){

    }*/

    /*@GetMapping("/users/tenant/{id_tenant}")
    public String getTenant(@PathVariable("id_tenant") int id_tenant){
        Tenant tenant = this.tenants.findById(id_tenant);
    }*/

}