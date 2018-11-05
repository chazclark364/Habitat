package com.example.demo;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import io.micrometer.core.instrument.util.MediaType;


@RestController
public class UserController {

    @Autowired
    private UserRepository users;
    @Autowired
    private TenantRepository tenants;
    @Autowired
    private LandlordRepository landlords;
    @Autowired
    private WorkerRepository workers;


    public UserController(UserRepository user){
        this.users = user;
    }

    @RequestMapping(method = RequestMethod.POST, path = "/users/new", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody User createUser(@RequestBody User user){
    	String email = user.getEmail();
    	if(!(email.contains("@"))){
    		return null;
    	}else if(this.users.findByEmail(email) == null){
    		this.users.save(user);
    		
    		if(user.getUserType().equalsIgnoreCase("tenant")){
    			Tenant tenant = new Tenant();
    			tenant.setIdTenant(user.getIdUsers());
    			this.tenants.save(tenant);
    		}
    		else if(user.getUserType().equalsIgnoreCase("landlord")){
    			Landlord landlord = new Landlord();
    			landlord.setIdLandlord(user.getIdUsers());
    			this.landlords.save(landlord);
    		}
    		else if(user.getUserType().equalsIgnoreCase("worker")){
    			Worker worker = new Worker();
    			worker.setIdWorker(user.getIdUsers());
    			this.workers.save(worker);
    		}
    		
            return user;
    	}else{
    		return null;
    	}

    }
     
    @RequestMapping(method = RequestMethod.POST, path = "/users/update", consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody User updateUser(@RequestBody User user){
    	if(this.users.findByID(user.getIdUsers()) == null){
    		return null;
    	}else{
    		this.users.save(user);
    		return user;
    	}
    }

    @RequestMapping(path = "/users/{id_users}", method = RequestMethod.GET)
    public @ResponseBody User getUserProfile(@PathVariable("id_users") Integer id_users, Model model){
    	User user = this.users.findByID(id_users);
        model.addAttribute(user);
        return user;
    }

    @RequestMapping(path = "/users/all", method = RequestMethod.GET)
    public @ResponseBody Collection<User> getAllUsers(Model model){
    	Collection<User> userList = this.users.findAllUsers();
        model.addAttribute(userList);
        return userList;
    }
    
    @RequestMapping(path = "/login", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody User getUserFromLogin(@RequestBody User user){
    	String email = user.getEmail();
    	String password = user.getPassword();
    	User databaseUser;
    	if(this.users.findByEmail(email) == null){
    		return null;
    	}else{
    		databaseUser = this.users.findByEmail(email);
    	}
    	String databasePassword = databaseUser.getPassword();
    	if(password.equals(databasePassword)){
    		return databaseUser;
    	}else{
    		return null;
    	}
    }

    
}
