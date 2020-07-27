package com.parkingpp.parkingppbackend.api;

import com.parkingpp.parkingppbackend.model.User;
import com.parkingpp.parkingppbackend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("api/v1/users")
@RestController
public class UserController {
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping(value = "/add")
    public void addUser(@RequestBody User user) {
        userService.addUser(user);
    }

    @GetMapping(value = "/all")
    public List<User> getUsers() {
        return userService.getUsers();
    }
}
