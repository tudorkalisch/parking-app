package com.parkingpp.parkingppbackend.service;

import com.parkingpp.parkingppbackend.dao.UserDataAccessService;
import com.parkingpp.parkingppbackend.model.User;
import javassist.bytecode.DuplicateMemberException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.naming.AuthenticationException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

@Service
public class UserService {
    UserDataAccessService userDao;

    @Autowired
    public void setUserService(UserDataAccessService userDao) {
        this.userDao = userDao;
    }

    public boolean register(User user) throws DuplicateMemberException {
        List<User> users = new ArrayList<>();
        userDao.findAll().forEach(users::add);

        AtomicReference<User> foundUser = new AtomicReference<>();
        users.forEach(u -> {
            if(u.getUsername().equals(user.getUsername()) && user.getPassword().equals(u.getPassword())) {
                foundUser.set(u);
            }
        });

        if(foundUser.get() != null) {
            throw new DuplicateMemberException("User already registered");
        }

        userDao.save(user);
        return true;
    }

    public User login(User user) throws AuthenticationException {
        List<User> users = new ArrayList<>();
        userDao.findAll().forEach(users::add);

        AtomicReference<User> foundUser = new AtomicReference<>();
        users.forEach(u -> {
            if(u.getUsername().equals(user.getUsername()) && user.getPassword().equals(u.getPassword())) {
                foundUser.set(u);
            }
        });

        if(foundUser.get() == null) {
            throw new AuthenticationException("Login unsuccesful");
        }

        return foundUser.get();
    }}
