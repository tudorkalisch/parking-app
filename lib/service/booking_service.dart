import 'dart:core';

import 'package:parking_app/domain/booking.dart';

class BookingService {
  List<Booking> bookings = [
    Booking(
        "1", "Location", DateTime.now(), DateTime.now().add(Duration(hours: 4)))
  ];

  BookingService();

  List<Booking> getBookings() {
    return this.bookings;
  }

  void addBooking(Booking booking) {
    this.bookings.add(booking);
  }
}
