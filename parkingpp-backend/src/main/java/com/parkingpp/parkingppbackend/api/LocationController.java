package com.parkingpp.parkingppbackend.api;

import com.parkingpp.parkingppbackend.model.Booking;
import com.parkingpp.parkingppbackend.model.Location;
import com.parkingpp.parkingppbackend.service.BookingService;
import com.parkingpp.parkingppbackend.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("api/v1/location")
@RestController
public class LocationController {
    private final LocationService locationService;

    @Autowired
    public LocationController(LocationService locationService) {
        this.locationService = locationService;
    }

    @PostMapping(value = "/add")
    public void addLocation(@RequestBody Location location) {
        locationService.addLocation(location);
    }

    @GetMapping(value = "/all")
    public List<Location> getLocations() {
        return locationService.getLocations();
    }
}
