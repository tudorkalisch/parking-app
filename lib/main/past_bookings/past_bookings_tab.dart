import 'package:parking_app/di/service_locator.dart';
import 'package:parking_app/main/booked/booking_card.dart';
import 'package:parking_app/service/booking_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking_app/domain/booking.dart';

// ignore: must_be_immutable
class PastBookingTab extends StatefulWidget {
  BookingService bookingService;

  PastBookingTab() {
    this.bookingService = locator<BookingService>();
  }

  @override
  _PastBookingTabState createState() => _PastBookingTabState(bookingService);
}

class _PastBookingTabState extends State<PastBookingTab>
    with WidgetsBindingObserver {
  BookingService bookingsService;
  List<Booking> _bookings = List.empty();

  _PastBookingTabState(this.bookingsService);

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    bookingsService.getPastBookings().then((bookings) => setState(() {
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
