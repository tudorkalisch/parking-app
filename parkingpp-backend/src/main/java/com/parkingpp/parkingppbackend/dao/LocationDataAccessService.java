package com.parkingpp.parkingppbackend.dao;

import com.parkingpp.parkingppbackend.model.Location;
import org.springframework.data.repository.CrudRepository;

public interface LocationDataAccessService extends CrudRepository<Location, Long> {
}
