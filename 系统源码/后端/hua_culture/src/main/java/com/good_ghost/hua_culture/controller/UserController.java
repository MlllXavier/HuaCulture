package com.good_ghost.hua_culture.controller;

import com.good_ghost.hua_culture.entity.User;
import com.good_ghost.hua_culture.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/getAll")
    public List<User> getAll(){
        return userService.getAll();
    }

    @RequestMapping("/getById")
    public User getById(int id){

        User user = userService.getById(id);

        if(user == null){
            return null;
        }else{
            return user;
        }

    }

    @RequestMapping("/addUser")
    public void addUser(HttpServletRequest request){
        userService.addUser(request);
    }

}
