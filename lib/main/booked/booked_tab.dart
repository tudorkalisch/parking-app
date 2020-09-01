import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/service/booking_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/domain/booking.dart';

import 'booking_card.dart';

// ignore: must_be_immutable
class BookedTab extends StatefulWidget {
  BookingService bookingService;

  BookedTab() {
    this.bookingService = locator<BookingService>();
  }

  @override
  _BookedTabState createState() => _BookedTabState(bookingService);
}

class _BookedTabState extends State<BookedTab> with WidgetsBindingObserver {
  BookingService bookingsService;
  List<Booking> _bookings = List.empty();

  _BookedTabState(this.bookingsService);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    bookingsService.getFutureBookings().then((bookings) => setState(() {
          _bookings = bookings;
        }));
    super.initState();
  }

  void logData(dynamic detailsResponse) {
    print(detailsResponse.toString());
  }

  void logError(var error) {
    print(error);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      bookingsService.getFutureBookings().then((value) => setState(() {
            _bookings = value;
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _bookings.map((element) => BookingCard(element)).toList(),
    );
  }
}
