package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import io.micrometer.core.instrument.util.MediaType;

@RestController
class LandlordController{

	@Autowired
    private LandlordRepository landlord;

    public LandlordController(LandlordRepository landlord){
        this.landlord = landlord;
    }
    
    @RequestMapping(method = RequestMethod.POST, path = "/landlord/update", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody Landlord updateLandlord(@RequestBody Landlord landlord){
    	if(this.landlord.findLandlordByID(landlord.getIdLandlord()) == null){
    		return null;
    	}else{
    		this.landlord.save(landlord);
    		return landlord;
    	}
    }
}