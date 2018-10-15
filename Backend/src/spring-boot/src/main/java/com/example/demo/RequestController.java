package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import io.micrometer.core.instrument.util.MediaType;

@RestController
public class RequestController {

    @Autowired
    private RequestRepository request;

    public RequestController(RequestRepository request){
        this.request = request;
    }
    
    @RequestMapping(path = "/request/{id_request}", method = RequestMethod.GET)
    public @ResponseBody Request getRequest(@PathVariable("id_request") Integer id_request, Model model){
    	Request request = this.request.findRequestByID(id_request);
        model.addAttribute(request);
        return request;
    }
    
    @RequestMapping(method = RequestMethod.POST, path = "/request/new", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody Request createRequest(@RequestBody Request request){
    	this.request.save(request);
        return request;
    }
    
}
