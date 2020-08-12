package com.parkingpp.parkingppbackend.dao;

import com.parkingpp.parkingppbackend.model.Location;
import org.springframework.data.repository.CrudRepository;

import java.util.UUID;

public interface LocationDataAccessService extends CrudRepository<Location, UUID> {
}
