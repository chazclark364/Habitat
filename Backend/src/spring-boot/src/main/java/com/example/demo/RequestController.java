package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import io.micrometer.core.instrument.util.MediaType;
import java.util.Collection;

@RestController
public class RequestController {

    @Autowired
    private RequestRepository request;
    @Autowired
    private UserRepository users;


    public RequestController(RequestRepository request){
        this.request = request;
    }
    
    @RequestMapping(path = "/request/{id_request}", method = RequestMethod.GET)
    public @ResponseBody Request getRequest(@PathVariable("id_request") Integer id_request, Model model){
    	Request request = this.request.findRequestByID(id_request);
        model.addAttribute(request);
        return request;
    }
    
    //NEEDS DATE FUNCTIONALITY
    @RequestMapping(method = RequestMethod.POST, path = "/request/new", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody Request createRequest(@RequestBody Request request){
    	this.request.save(request);
        return request;
    }
    
    @RequestMapping(method = RequestMethod.POST, path = "/request/update", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody Request updateRequest(@RequestBody Request request){
    	if(this.request.findRequestByID(request.getIdRequest()) == null){
    		return null;
    	}else{
    		this.request.save(request);
    		return request;
    	}
    }
    
    @RequestMapping(path = "/users/{id_users}/requests", method = RequestMethod.GET)
    public @ResponseBody Collection<Request> getUserRequests(@PathVariable("id_users") Integer id_users, Model model){
    	
    	Collection<Request> requests = null;
    	String type = this.users.findByID(id_users).getUserType();
    	
    	if(type.equalsIgnoreCase("tenant")){
    		requests = this.request.findRequestByRequestee(id_users);
    		model.addAttribute(requests);
    	}
    	else if(type.equalsIgnoreCase("landlord")){
    		requests = this.request.findRequestByLandlord(id_users);
    		model.addAttribute(requests);
    	}
    	else if(type.equalsIgnoreCase("worker")){
    		requests = this.request.findRequestByWorker(id_users);
    		model.addAttribute(requests);
    	}
    	
        return requests;
    	
    }

    
}
