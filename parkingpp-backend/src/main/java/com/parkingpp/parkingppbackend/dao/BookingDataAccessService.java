package com.parkingpp.parkingppbackend.dao;

import com.parkingpp.parkingppbackend.model.Booking;
import org.springframework.data.repository.CrudRepository;

import java.util.UUID;

public interface BookingDataAccessService extends CrudRepository<Booking, UUID> {
}
