package com.parkingpp.parkingppbackend.service;

import com.parkingpp.parkingppbackend.dao.BookingDataAccessService;
import com.parkingpp.parkingppbackend.dao.LocationDataAccessService;
import com.parkingpp.parkingppbackend.model.Booking;
import com.parkingpp.parkingppbackend.model.Location;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class LocationService {
    LocationDataAccessService locationDao;

    @Autowired
    public void setLocationService(LocationDataAccessService locationDao) {
        this.locationDao = locationDao;
    }

    public void addLocation(Location location) {
        locationDao.save(location);
    }

    public List<Location> getLocations() {
        List<Location> locations = new ArrayList<>();
        locationDao.findAll().forEach(locations::add);
        return locations;
    }
}
