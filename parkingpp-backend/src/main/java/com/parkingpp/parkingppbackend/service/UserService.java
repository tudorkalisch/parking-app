package com.parkingpp.parkingppbackend.service;

import com.parkingpp.parkingppbackend.dao.UserDao;
import com.parkingpp.parkingppbackend.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    private final UserDao userDao;

    @Autowired
    public UserService(@Qualifier("userDao") UserDao userDao) {
        this.userDao = userDao;
    }

    public int addUser(User user) {
        return userDao.insertUser(user);
    }

    public List<User> getUsers() {
        return userDao.getUsers();
    }
}
