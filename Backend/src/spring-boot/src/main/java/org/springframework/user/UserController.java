package org.springframework.user;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import io.micrometer.core.instrument.util.MediaType;

@RestController
public class UserController {

    @Autowired
    private UserRepository users;

    public UserController(UserRepository users){
        this.users = users;
    }


    @RequestMapping(path = "/test", method = RequestMethod.GET)
    @ResponseBody //tells the get method to return the string in a response body (json)
    public String initUser(){

        return "Hey testing";

    }



    @RequestMapping(method = RequestMethod.POST, path = "/users/new", consumes = MediaType.APPLICATION_JSON)
    public String createUser(@RequestBody User user){
        user.setUserType("tenant");
        users.save(user);
        return "User created";

    }
}
