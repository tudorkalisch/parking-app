import 'package:flutter/services.dart';
import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/service/booking_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/domain/booking.dart';

// ignore: must_be_immutable
class AvailableTab extends StatelessWidget {
  List<Booking> bookings;
  BookingService bookingService;

  AvailableTab() {
    this.bookingService = locator<BookingService>();
    this.bookings = bookingService.getBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bookingService
          .getBookings()
          .map((element) => Card(
              elevation: 4.0,
              margin: EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              element.location,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 16.0),
                            )),
                          ],
                        )),
                  ],
                ),
              )))
          .toList(),
    );
  }
}
