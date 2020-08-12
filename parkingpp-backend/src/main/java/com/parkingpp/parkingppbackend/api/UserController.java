package com.parkingpp.parkingppbackend.api;

import com.parkingpp.parkingppbackend.model.User;
import com.parkingpp.parkingppbackend.service.UserService;
import javassist.bytecode.DuplicateMemberException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.naming.AuthenticationException;

@RequestMapping("api/v1/user")
@RestController
public class UserController {
    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @PostMapping(value = "/register")
    public ResponseEntity<String> register(@RequestBody User user) {
        try {
            userService.register(user);
        } catch (DuplicateMemberException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.CONFLICT).build();
        }
        return ResponseEntity.ok().build();
    }

    @PostMapping(value = "/login")
    public ResponseEntity<String> login(@RequestBody User user) {

        try {
            return ResponseEntity.ok(userService.login(user).getId().toString());
        } catch (AuthenticationException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }


    }
}
