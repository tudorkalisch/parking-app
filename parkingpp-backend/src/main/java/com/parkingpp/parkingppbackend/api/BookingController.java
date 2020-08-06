package com.parkingpp.parkingppbackend.api;

import com.parkingpp.parkingppbackend.model.Booking;
import com.parkingpp.parkingppbackend.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("api/v1/booking")
@RestController
public class BookingController {
    private BookingService bookingService;

    @Autowired
    public void setBookingService(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @PostMapping(value = "/add")
    public void addBooking(@RequestBody Booking booking) {
        bookingService.addBooking(booking);
    }

    @GetMapping(value = "/all")
    public List<Booking> getBookings() {
        return bookingService.getBookings();
    }
}
