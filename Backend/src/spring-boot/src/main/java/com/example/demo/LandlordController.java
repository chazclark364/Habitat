package com.example.demo;

import java.util.Collection;

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
    
    @RequestMapping(path = "/landlords/all", method = RequestMethod.GET)
    public @ResponseBody Collection<Landlord> getAllLandlords(Model model){
    	Collection<Landlord> landlordList = this.landlord.findAllLandlords();
        model.addAttribute(landlordList);
        return landlordList;
    }
}