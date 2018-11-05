package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import io.micrometer.core.instrument.util.MediaType;

@RestController
class TenantController{
    
	@Autowired
    private final TenantRepository tenant;

    public TenantController(TenantRepository tenant) {
        this.tenant = tenant;
    }

    @RequestMapping(method = RequestMethod.POST, path = "/tenant/update", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody Tenant updateTenant(@RequestBody Tenant tenant){
    	if(this.tenant.findTenantByID(tenant.getIdTenant()) == null){
    		return null;
    	}else{
    		this.tenant.save(tenant);
    		return tenant;
    	}
    }
    
    @RequestMapping(path = "/tenant/{id_tenant}", method = RequestMethod.GET)
    public @ResponseBody Tenant getTenantProfile(@PathVariable("id_tenant") Integer id_tenant, Model model){
    	Tenant tenant = this.tenant.findTenantByID(id_tenant);
        model.addAttribute(tenant);
        return tenant;
    }
}