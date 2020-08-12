package com.parkingpp.parkingppbackend.dao;

import com.parkingpp.parkingppbackend.model.User;
import org.springframework.data.repository.CrudRepository;

import java.util.UUID;

public interface UserDataAccessService extends CrudRepository<User, UUID> {
}
