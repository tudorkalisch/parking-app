package com.parkingpp.parkingppbackend.service;

import com.parkingpp.parkingppbackend.dao.BookingDataAccessService;
import com.parkingpp.parkingppbackend.model.Booking;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class BookingService {
    private final BookingDataAccessService bookingDao;

    @Autowired
    public BookingService(BookingDataAccessService bookingDao) {
        this.bookingDao = bookingDao;
    }

    public void addBooking(Booking booking) {
        bookingDao.save(booking);
    }

    public List<Booking> getBookings() {
        List<Booking> bookings = new ArrayList<>();
        bookingDao.findAll().forEach(bookings::add);
        return bookings;
    }
}
