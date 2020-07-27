package com.parkingpp.parkingppbackend.dao;

import com.parkingpp.parkingppbackend.model.User;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Repository("userDao")
public class UserDataAccessService implements UserDao {
    private static List<User> DB = new ArrayList<>();

    @Override
    public int insertUser(UUID id, User user) {
        DB.add(new User(id, user.getName()));
        return 0;
    }

    @Override
    public List<User> getUsers() {
        return DB;
    }
}
