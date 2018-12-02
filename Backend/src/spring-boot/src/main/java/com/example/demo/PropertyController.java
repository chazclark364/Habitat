package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import io.micrometer.core.instrument.util.MediaType;
import java.util.Collection;

@RestController
class PropertyController{
	
	@Autowired
	private PropertyRepository properties;
	@Autowired
	private LandlordRepository landlord;
	
	public PropertyController(PropertyRepository property){
		this.properties = property;
	}
	
	@RequestMapping(method = RequestMethod.POST, path = "/property/new", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody Property createProperty(@RequestBody Property property){
		
		if(this.landlord.findLandlordByID(property.getLandlord()) != null){
			this.properties.save(property);
			return property;
		}
		else{
			return null;
		}
	
    }
}