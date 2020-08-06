package com.parkingpp.parkingppbackend.dao;

import com.parkingpp.parkingppbackend.model.Booking;
import org.springframework.data.repository.CrudRepository;

public interface BookingDataAccessService extends CrudRepository<Booking, Long> {
}
