package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import io.micrometer.core.instrument.util.MediaType;


public class UserController {

    @Autowired
    private UserRepository users;

    public UserController(UserRepository user){
        this.users = user;
    }

    @RequestMapping(method = RequestMethod.POST, path = "/users/new", consumes = MediaType.APPLICATION_JSON)
    public String createUser(@RequestBody User user){

        this.users.save(user);
        return "User created";

    }

    @RequestMapping(path = "/users/{id_users}", method = RequestMethod.GET)
    public @ResponseBody User getUserProfile(@PathVariable("id_users") Integer id_users, Model model){
        User user = this.users.findByID(id_users);
        model.addAttribute(user);
        return user;
    }

    @RequestMapping(path = "/login", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON)
    public @ResponseBody User getUserFromLogin(@RequestBody User user){
        try {
            User loginAttempt = this.users.findByEmail(user.getEmail());
            if (user.getPassword() == loginAttempt.getPassword()) {
                return loginAttempt;
            } else {
                return null;
            }
        }catch (Exception e){
            return null;
        }
    }

}
