package com.parkingpp.parkingppbackend.api;

import com.parkingpp.parkingppbackend.model.Booking;
import com.parkingpp.parkingppbackend.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RequestMapping("api/v1/booking")
@RestController
public class BookingController {
    private BookingService bookingService;

    @Autowired
    public void setBookingService(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @PostMapping(value = "/add")
    public void addBooking(@RequestHeader("user_id") UUID userId, @RequestBody Booking booking) {
        booking.setUserId(userId);

        bookingService.addBooking(booking);
    }

    @GetMapping(value = "/all")
    public List<Booking> getBookings(@RequestHeader("user_id") UUID userId) {
        return bookingService.getBookings(userId);
    }
}
