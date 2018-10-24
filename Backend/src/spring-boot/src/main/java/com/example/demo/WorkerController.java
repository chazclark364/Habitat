package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import io.micrometer.core.instrument.util.MediaType;

@RestController
class WorkerController{
    
    @Autowired
    private WorkerRepository worker;

    public WorkerController(WorkerRepository worker){
        this.worker = worker;
    }
	
	@RequestMapping(method = RequestMethod.POST, path = "/worker/update", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody Worker updateRequest(@RequestBody Worker worker){
    	if(this.worker.findWorkerByID(worker.getIdWorker()) == null){
    		return null;
    	}else{
    		this.worker.save(worker);
    		return worker;
    	}
    }
}