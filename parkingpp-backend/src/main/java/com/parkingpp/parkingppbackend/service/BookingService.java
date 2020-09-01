package com.parkingpp.parkingppbackend.service;

import com.parkingpp.parkingppbackend.dao.BookingDataAccessService;
import com.parkingpp.parkingppbackend.model.Booking;
import net.glxn.qrgen.javase.QRCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.UUID;

@Service
public class BookingService {
    private BookingDataAccessService bookingDao;

    public static String generateQRCodeImage(String barcodeText) {
        ByteArrayOutputStream stream = QRCode
                .from(barcodeText)
                .withSize(250, 250)
                .stream();
        ByteArrayInputStream bis = new ByteArrayInputStream(stream.toByteArray());
        String QR = Base64.getEncoder().encodeToString(bis.readAllBytes());
        return QR;
    }

    @Autowired
    public void setLocationService(BookingDataAccessService bookingDao) {
        this.bookingDao = bookingDao;
    }

    public void addBooking(Booking booking) {
        bookingDao.save(booking);
    }

    public List<Booking> getBookings(UUID userId) {
        List<Booking> bookings = new ArrayList<>();
        bookingDao.findAll().forEach(booking -> {
            if (booking.getUserId() != null && booking.getUserId().equals(userId)) {
                booking.setQR(generateQRCodeImage(booking.toString()));
                bookings.add(booking);
            }
        });
        return bookings;
    }
}
