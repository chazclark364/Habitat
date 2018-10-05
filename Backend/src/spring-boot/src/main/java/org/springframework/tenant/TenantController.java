package org.springframework.tenant;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

@RestController
class TenantController{
    @Autowired
    private final TenantRepository tenants;
    private final Logger logger = LoggerFactory.getLogger(TenantController.class);

    @Autowired
    public TenantController(TenantRepository habitat) {
        this.tenants = habitat;
    }

    @PostMapping("/users/tenant/save")
    public String saveTenant(){

    }

    /*@GetMapping("/users/tenant/{id_tenant}"")
    public String getTenant(@PathVariable("id_tenant") int id_tenant){
        Tenant tenant = this.tenants.findById(id_tenant);
    }*/

}