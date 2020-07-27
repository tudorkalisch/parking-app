package com.parkingpp.parkingppbackend.dao;

import com.parkingpp.parkingppbackend.model.User;

import java.util.List;
import java.util.UUID;

public interface UserDao {
    int insertUser(UUID id, User user);

    List<User> getUsers();

    default int insertUser(User user) {
        UUID id = UUID.randomUUID();
        return insertUser(id, user);
    }
}
