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
	
	@RequestMapping(path = "/properties/all", method = RequestMethod.GET)
    public @ResponseBody Collection<Property> getAllProperties(Model model){
    	Collection<Property> propertyList = this.properties.findAllProperties();;
        model.addAttribute(propertyList);
        return propertyList;
    }
	
	
	@RequestMapping(path = "/properties/{id_property}", method = RequestMethod.GET)
    public @ResponseBody Property getProperty(@PathVariable("id_property") Integer id_property, Model model){
    	Property property = this.properties.findProperty(id_property);
        model.addAttribute(property);
        return property;
    }
	
	@RequestMapping(path = "/properties/landlord/{id_landlord}", method = RequestMethod.GET)
	public @ResponseBody Collection<Property> getLandlordsProperties(@PathVariable("id_landlord") Integer id_landlord, Model model){
		Collection<Property> landlordProperties = this.properties.findPropertyByLandlord(id_landlord);
		return landlordProperties;
	}
	
	@RequestMapping(path = "/properties/vacant", method = RequestMethod.GET)
	public @ResponseBody Collection<Property> getVacantProperties(Model model){
		Collection<Property> landlordProperties = this.properties.findPropertyByLivingStatus("vacant");
		return landlordProperties;
	}
	
	@RequestMapping(method = RequestMethod.POST, path = "/properties/update/{id_property}", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody Property updateProperty(@RequestBody Property property, @PathVariable("id_property") Integer id_property){
		if(this.properties.findProperty(property.getIdProperty()) == null){
    		return null;
    	}else{
    		this.properties.save(property);
    		return property;
    	}
	}
    
}